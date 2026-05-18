local entityManager = require("src.managers.entities").getInstance()

-- Handles the combat phase of the game, iterating through entities and applying combat logic such as damage and health updates.
local CombatSystem = {}

function CombatSystem:Update(dt)
	local units = entityManager:GetUnits()
	local structures = entityManager:GetStructures()

	for _, unit in ipairs(units) do
		if unit.Target then
			unit:Attack(dt)
		end
	end
end

return CombatSystem
