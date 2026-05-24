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

	for _, unit in ipairs(units) do
		if unit:GetTarget() then
			-- If the unit has a target, move towards it if it's not in range.
			if not unit:IsTargetInRange() then
				--- Before we move to the target, we need to do a collision check to see if the path to the target is clear. If it's not, we need to find an alternative path.
				if not self:UnitCollides(unit) then
					unit:MoveToTarget(dt)
				else
					print("lel")
				end
			end
		else
			if unit:GetPath() then
				-- Unit has no target, it should move along the path.
				-- before we move along the path, we need to do a collision check to see if the path is still clear. If it's not, we need to find an alternative path.
				if not self:UnitCollides(unit) then
					unit:MoveAlongPath(dt)
				else
					print("lel")
				end
			else
				-- If the unit has no path, we look for the closest path and set it as the current path for the unit.
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
end

---Checks if a unit would collide with another object
---@param Object Unit
---@return boolean collides -- Returns true if the unit collides with another object, false otherwise.
function MovementSystem:UnitCollides(Object)
	local entitiesInMovementRange = unitHashGrid:GetEntitiesInRadius({ X = Object.Position.X, Y = Object.Position.Y },
		Object.MovementSpeed + 5)
	for _, otherUnit in ipairs(entitiesInMovementRange) do
		if otherUnit ~= Object then
			if otherUnit:IsInstanceOf("Unit") then
				local collides = CollisionUtils.CirclesOverlap(
					Object.Position.X, Object.Position.Y, Object.Size,
					otherUnit.Position.X, otherUnit.Position.Y, otherUnit.Size
				)
				if collides then
					return true
				end
			elseif otherUnit:IsInstanceOf("Structure") then
				local collides = CollisionUtils.CircleIntersectsRect(
					Object.Position.X, Object.Position.Y, Object.Size,
					otherUnit.Position.X - otherUnit.Size / 2, otherUnit.Position.Y - otherUnit.Size / 2,
					otherUnit.Size, otherUnit.Size
				)
				if collides then
					return true
				end
			end
		end
	end
	return false
end

return MovementSystem
