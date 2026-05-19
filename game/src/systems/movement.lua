local entityManager = require("src.managers.entities").getInstance()

-- Handles the movement phase of the game, iterating through entities and applying movement logic such as position updates and collision detection.
local MovementSystem = {}

--- Iterate through units and apply movement logic.
function MovementSystem:Update(dt)
	local units = entityManager:GetUnits()

	for _, unit in ipairs(units) do
		if not unit:IsTargetInRange() then
			unit:MoveToTarget(dt)
		end
	end
end



return MovementSystem
