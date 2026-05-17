local entityManager = require("src.managers.entities").getInstance()
local spatialHashGrid = require("src.utilities.spatialHashGrid").getInstance()

-- Handles the targeting phase of the game, iterating through units, structures and applying targeting logic such as selecting targets based on priority and range.
local TargetingSystem = {}

-- Iterate through units and structures and apply targeting logic.
function TargetingSystem:Update(dt)
	local units = entityManager:GetUnits()
	local structures = entityManager:GetStructures()

	for _, unit in ipairs(units) do
		unit:SetTarget(self:GetClosestTarget(unit))
	end

	for _, structure in ipairs(structures) do
		structure:SetTarget(self:GetClosestTarget(structure))
	end
end

--- Searches for the closest available target, taking into account the Aggro Range and its Priorities.
--- @param Object Unit | Structure -- The unit or structure for which to find a target.
--- @return Unit | Structure | nil
function TargetingSystem:GetClosestTarget(Object)
	local target = spatialHashGrid:FindClosestEnemyInAggroRange(Object)

	return target
end

return TargetingSystem
