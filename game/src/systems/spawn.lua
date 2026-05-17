local entityManager = require("src.managers.entities").getInstance()

-- Handles the spawn phase of the game, iterating through entities and applying spawn logic such as creating new entities.
local SpawnSystem = {}

-- Iterate through structures and apply spawn logic.
function SpawnSystem:Update(dt)
	local structures = entityManager:GetStructures()
	for _, structure in ipairs(structures) do
		if structure.Spawn then
			local spawnedUnits = structure:Spawn(dt)

			if spawnedUnits then
				for _, unit in ipairs(spawnedUnits) do
					entityManager:SetUnit(unit)
				end
			end
		end
	end
end

return SpawnSystem
