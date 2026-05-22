local EntityManager = require("src.managers.entities").getInstance()
local SpatialHashGrid = require("src.utilities.spatialHashGrid").getInstance()
local ResourceManager = require("src.managers.resources").getInstance()
local MeleeUnit = require("src.objects.units.meleeUnit")
local RangeUnit = require("src.objects.units.rangeUnit")

-- Handles the combat phase of the game, iterating through entities and applying combat logic such as damage and health updates.
local CombatSystem = {}

function CombatSystem:Update(dt)
	self:AttackPhase(dt)
	self:CleanupPhase()
end

--- Trigger attacks from units, projectiles and structures
function CombatSystem:AttackPhase(dt)
	local units = EntityManager:GetUnits()
	local structures = EntityManager:GetStructures()
	local projectiles = EntityManager:GetProjectiles()

	for _, unit in ipairs(units) do
		if unit.Target then
			if unit:IsInstanceOf(MeleeUnit) then
				--- trigger the unit's attack logic, which will apply damage to its target and update health values accordingly.
				unit:Attack(dt)
			end
			if unit:IsInstanceOf(RangeUnit) then
				--- trigger the unit's attack logic, which will create a projectile that moves towards the target and applies damage upon impact.
				local projectile = unit:Attack(dt)
				if projectile then
					EntityManager:SetProjectile(projectile)
				end
			end
		end
	end

	for _, projectile in ipairs(projectiles) do
		--- Check if the projectile has reached its target and apply damage if so, then remove the projectile from the game.
		if projectile:HasReachedTarget() then
			projectile:Attack()
			self:ApplyProjectileSplash(projectile)
		end
	end
end

--- Removes any entities that have been reduced to 0 or less health during the attack phase, ensuring that the game state remains accurate and up-to-date.
function CombatSystem:CleanupPhase()
	local units = EntityManager:GetUnits()
	local structures = EntityManager:GetStructures()
	local projectiles = EntityManager:GetProjectiles()

	for _, structure in ipairs(structures) do
		if structure.Health <= 0 then
			-- Before removing the structure, we need to substract its income bonus from the player's resources to ensure that the player's income is updated correctly after losing the structure.
			ResourceManager:SubstractPlayerIncome(structure.PlayerID, structure.IncomeBonus)
			EntityManager:RemoveStructure(structure)
		end
	end
	for _, unit in ipairs(units) do
		if unit.Health <= 0 then
			EntityManager:RemoveUnit(unit)
		end
	end
	for _, projectile in ipairs(projectiles) do
		if projectile:HasReachedTarget() then
			EntityManager:RemoveProjectile(projectile)
		end
	end
end

--- Apply splash to surounding units and structures
--- @param projectile Projectile --- The projectile that has hit its target and is applying splash damage to nearby units and structures.
function CombatSystem:ApplyProjectileSplash(projectile)
	--- find surounding units and structures within the projectile's splash radius and apply damage based on the projectile's SplashDamageMultiplier
	if projectile.SplashRadius > 0 then
		local nearbyEntities = SpatialHashGrid:GetEntitiesInRadius(projectile.Position, projectile.SplashRadius)
		for _, entity in ipairs(nearbyEntities) do
			if entity ~= projectile.Target then
				if entity.PlayerID ~= projectile.Source.PlayerID then
					--- apply splash damage to the entity based on the projectile's damage and splash damage multiplier, reducing its health accordingly.
					local splashDamage = projectile.Damage * projectile.SplashDamageMultiplier
					entity:TakeDamage(splashDamage)
				end
			end
		end
	end
end

return CombatSystem
