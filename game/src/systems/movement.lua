local entityManager = require("src.managers.entities").getInstance()
local unitHashGrid = require("src.utilities.unitHashGrid").getInstance()
local CollisionUtils = require("src.utilities.collisions")

-- Handles the movement phase of the game, iterating through entities and applying movement logic such as position updates and collision detection.
local MovementSystem = {}

--- Iterate through units and apply movement logic.
--- @param dt number -- The delta time since the last update, used for frame-independent movement calculations.
--- @param Map Map -- The current map of the world, used for pathfinding and boundary checks.
function MovementSystem:Update(dt, Map)
	local units = entityManager:GetUnits()
	local projectiles = entityManager:GetProjectiles()

	-- 1. Avoidance- and movement logic for all units
	for _, unit in ipairs(units) do
		if unit:GetAvoidancePoint() then
			local collides, obstacle = self:UnitCollides(unit)
			if not collides then
				unit:MoveToAvoidancePoint(dt)
			else
				if obstacle then
					self:SetAvoidancePoint(unit, obstacle)
				end
			end
		elseif unit:GetTarget() then
			if not unit:IsTargetInRange() then
				local collides, obstacle = self:UnitCollides(unit)
				if not collides then
					unit:MoveToTarget(dt)
				else
					if obstacle then
						self:SetAvoidancePoint(unit, obstacle)
					end
				end
			end
		else
			if unit:GetPath() then
				local collides, obstacle = self:UnitCollides(unit)
				if not collides then
					unit:MoveAlongPath(dt)
				else
					if obstacle then
						self:SetAvoidancePoint(unit, obstacle)
					end
				end
			else
				local closestPath = Map:GetClosestPath(unit.Position.X, unit.Position.Y)
				if closestPath then
					unit:SetPath(closestPath)
				end
			end
		end
	end

	for _, projectile in ipairs(projectiles) do
		projectile:MoveToTarget(dt)
	end

	-- 2. global Push-Logic: Push units that are still colliding after movement, repeat 3 times to resolve chains of collisions
	for i = 1, 3 do
		for _, unit in ipairs(units) do
			self:PushUnitsRecursive(unit)
		end
	end
end

---Checks if a unit would collide with another object
---@param Object Unit
---@return boolean collides -- Returns true if the unit collides with another object, false otherwise.
---@return Object | nil otherObject -- Returns the object that the unit collides with, or nil if no collision occurs.
function MovementSystem:UnitCollides(Object)
	local entitiesInMovementRange = unitHashGrid:GetEntitiesInMovementDirection(Object)
	for _, otherUnit in ipairs(entitiesInMovementRange) do
		if otherUnit ~= Object then
			if otherUnit:IsInstanceOf("Unit") then
				local collides = CollisionUtils.CirclesOverlap(
					Object.Position.X, Object.Position.Y, Object.Size,
					otherUnit.Position.X, otherUnit.Position.Y, otherUnit.Size
				)
				if collides then
					return true, otherUnit
				end
			elseif otherUnit:IsInstanceOf("Structure") then
				local collides = CollisionUtils.CircleIntersectsRect(
					Object.Position.X, Object.Position.Y, Object.Size,
					otherUnit.Position.X - otherUnit.Size / 2, otherUnit.Position.Y - otherUnit.Size / 2,
					otherUnit.Size, otherUnit.Size
				)
				if collides then
					return true, otherUnit
				end
			end
		end
	end
	return false, nil
end

--- Sets an avoidance point for the unit to move towards in order to avoid a collision with an obstacle.
---@param Object Unit
---@param Obstacle Object -- The object that the unit collided with
function MovementSystem:SetAvoidancePoint(Object, Obstacle)
	-- Movement direction of the unit (should be normalized)
	local moveDir = Object:GetMovementDirection()
	local moveDirX, moveDirY = moveDir.X or 1, moveDir.Y or 0
	local ux, uy = Object.Position.X, Object.Position.Y
	-- Vector from obstacle to unit
	local ox, oy = Obstacle.Position.X, Obstacle.Position.Y
	local toObstacleX, toObstacleY = ox - ux, oy - uy
	-- Orthogonal vector to movement direction (sideways)
	local orthoX, orthoY = -moveDirY, moveDirX
	-- Decide whether to go left or right around the obstacle (depending on the position of the obstacle)
	local side = toObstacleX * orthoX + toObstacleY * orthoY
	if side < 0 then orthoX, orthoY = -orthoX, -orthoY end
	-- Avoidance point: slightly in the movement direction plus sideways offset
	local avoidanceDist = (Object.Size or 1) + (Obstacle.Size or 1) + 10
	local ax = ux + moveDirX * avoidanceDist + orthoX * avoidanceDist
	local ay = uy + moveDirY * avoidanceDist + orthoY * avoidanceDist
	Object.AvoidancePoint = { X = ax, Y = ay }
end

--- Recursive push logic: Pushes a unit and all units that are blocked by it
---@param Object Unit
---@param visited Unit | nil -- Set of already pushed units (to prevent infinite loops)
function MovementSystem:PushUnitsRecursive(Object, visited)
	visited = visited or {}
	if visited[Object] then return end
	visited[Object] = true
	local entities = unitHashGrid:GetEntitiesInRadius(Object.Position, (Object.Size or 1) * 2 + 2)
	for _, other in ipairs(entities) do
		if other ~= Object and other.Position and other:IsInstanceOf("Unit") then
			---@cast other Unit
			local dx = Object.Position.X - other.Position.X
			local dy = Object.Position.Y - other.Position.Y
			local dist = math.sqrt(dx*dx + dy*dy)
			local sizeA = Object.Size or 1
			local sizeB = other.Size or 1
			local minDist = sizeA + sizeB
			if dist > 0 and dist < minDist then
				local overlap = minDist - dist
				-- Push proportions based on size, push factor increased
				local total = sizeA + sizeB
				local pushA = (sizeB / total) * overlap * 1.2
				local pushB = (sizeA / total) * overlap * 1.2
				local nx, ny = dx / dist, dy / dist
				-- Random component (jitter)
				local jitterX = (math.random() - 0.5) * 0.2 * overlap
				local jitterY = (math.random() - 0.5) * 0.2 * overlap
				Object.Position.X = Object.Position.X + nx * pushA + jitterX
				Object.Position.Y = Object.Position.Y + ny * pushA + jitterY
				other.Position.X = other.Position.X - nx * pushB - jitterX
				other.Position.Y = other.Position.Y - ny * pushB - jitterY
				self:PushUnitsRecursive(other, visited)
			end
		end
	end
end

return MovementSystem
