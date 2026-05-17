local entityManager = require("src.managers.entities").getInstance()
local spatialHashGrid = require("src.utilities.spatialHashGrid").getInstance()

-- Handles the targeting phase of the game, iterating through units, structures and applying targeting logic such as selecting targets based on priority and range.
local TargetingSystem = {}

-- Iterate through units and structures and apply targeting logic.
function TargetingSystem:Update(dt)
	local units = entityManager:GetUnits()
	local structures = entityManager:GetStructures()

	for _, unit in ipairs(units) do
		unit:SetTarget(spatialHashGrid:FindClosestEnemyInAggroRange(unit))
	end

	for _, structure in ipairs(structures) do
		structure:SetTarget(spatialHashGrid:FindClosestEnemyInAggroRange(structure))
	end
end

return TargetingSystem
