local entityManager = require("src.managers.entities").getInstance()

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
				unit:MoveToTarget(dt)
			end
		else
			if unit:GetPath() then
				-- Unit has no target, it should move along the path.
				unit:MoveAlongPath(dt)
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

return MovementSystem
