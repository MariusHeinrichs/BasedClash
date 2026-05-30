local entityManager = require("src.managers.entities").getInstance()
local resourceManager = require("src.managers.resources").getInstance()
local effectManager = require("src.managers.effectManager").getInstance()

local CleanUpSystem = {}

function CleanUpSystem:Update(dt)
	self:CleanUpProjectiles()
	self:CleanUpUnits()
	self:CleanUpStructures()
	self:CleanUpDoTs()
end

function CleanUpSystem:CleanUpProjectiles()
	local projectiles = entityManager:GetProjectiles()
	for _, projectile in ipairs(projectiles) do
		if projectile:HasReachedTarget() then
			entityManager:RemoveProjectile(projectile)
		end
	end
end

function CleanUpSystem:CleanUpUnits()
	local units = entityManager:GetUnits()
	for _, unit in ipairs(units) do
		if unit.Health <= 0 then
			entityManager:RemoveUnit(unit)
		end
	end
end

function CleanUpSystem:CleanUpStructures()
	local structures = entityManager:GetStructures()
	for _, structure in ipairs(structures) do
		if structure.Health <= 0 then
			-- Before removing the structure, we need to substract its income bonus from the player's resources to ensure that the player's income is updated correctly after losing the structure.
			resourceManager:SubstractPlayerIncome(structure.PlayerID, structure.IncomeBonus)
			entityManager:RemoveStructure(structure)
		end
	end
end

function CleanUpSystem:CleanUpDoTs()
	for _, unit in ipairs(entityManager:GetUnits()) do
		for _, dot in ipairs(unit:GetDoTs()) do
			if dot:IsExpired() then
				unit:RemoveDoT(dot)
				effectManager:RemoveEffect(dot)
			end
		end
	end
	for _, structure in ipairs(entityManager:GetStructures()) do
		for _, dot in ipairs(structure:GetDoTs()) do
			if dot:IsExpired() then
				structure:RemoveDoT(dot)
				effectManager:RemoveEffect(dot)
			end
		end
	end
	--- Ensure we have no lingering effects without targets, which can happen if an effect's target dies but the effect itself isn't properly removed.
	for _, effect in pairs(effectManager:GetEffects()) do
		if effect.Target == nil then
			effectManager:RemoveEffect(effect)
		end
		if effect.Target and effect.Target.Health <= 0 then
			effect.Target = nil
			effectManager:RemoveEffect(effect)
		end
	end
end

return CleanUpSystem
