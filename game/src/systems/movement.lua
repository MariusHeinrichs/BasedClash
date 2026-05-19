local entityManager = require("src.managers.entities").getInstance()

-- Handles the movement phase of the game, iterating through entities and applying movement logic such as position updates and collision detection.
local MovementSystem = {}

--- Iterate through units and apply movement logic.
function MovementSystem:Update(dt)
	local units = entityManager:GetUnits()
	local projectiles = entityManager:GetProjectiles()

	for _, unit in ipairs(units) do
		if not unit:IsTargetInRange() then
			unit:MoveToTarget(dt)
		end
	end

	for _, projectile in ipairs(projectiles) do
		projectile:MoveToTarget(dt)
	end
end



return MovementSystem
