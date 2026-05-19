local entityManager = require("src.managers.entities").getInstance()
local MeleeUnit = require("src.objects.units.meleeUnit")
local RangeUnit = require("src.objects.units.rangeUnit")

-- Handles the combat phase of the game, iterating through entities and applying combat logic such as damage and health updates.
local CombatSystem = {}

function CombatSystem:Update(dt)
	local units = entityManager:GetUnits()
	local structures = entityManager:GetStructures()
	local projectiles = entityManager:GetProjectiles()

	for _, unit in ipairs(units) do
		if unit.Target then
			if unit:IsInstanceOf(MeleeUnit) then
				--- trigger the unit's attack logic, which will apply damage to its target and update health values accordingly.
				local targetKilled = unit:Attack(dt)
			end
			if unit:IsInstanceOf(RangeUnit) then
				--- trigger the unit's attack logic, which will create a projectile that moves towards the target and applies damage upon impact.
				local projectile = unit:Attack(dt)
				if projectile then
					entityManager:SetProjectile(projectile)
				end
			end
		end
	end

	for _, projectile in ipairs(projectiles) do
		--- Check if the projectile has reached its target and apply damage if so, then remove the projectile from the game.
		-- if projectile:HasReachedTarget() then
		-- 	local targetKilled = projectile:Attack()
		-- 	entityManager:RemoveProjectile(projectile)
		-- end
	end
end

return CombatSystem
