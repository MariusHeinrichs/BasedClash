local entityManager = require("src.managers.entities").getInstance()
local MeleeUnit = require("src.objects.units.meleeUnit")
local RangeUnit = require("src.objects.units.rangeUnit")
local EntityEnums = require("src.enums.entities")

-- Handles the combat phase of the game, iterating through entities and applying combat logic such as damage and health updates.
local CombatSystem = {}

function CombatSystem:Update(dt)
	local units = entityManager:GetUnits()
	local structures = entityManager:GetStructures()

	for _, unit in ipairs(units) do
		if unit.Target then
			if unit:IsInstanceOf(MeleeUnit) then
				---@cast unit MeleeUnit
				self:MeleeAttack(unit, dt)
			elseif unit:IsInstanceOf(RangeUnit) then
				---@cast unit RangeUnit
				-- Range attack logic would go here, but is currently not implemented.
				-- self:RangeAttack(unit, dt)
				-- For now, we can just trigger the attack animation and sound without applying damage.
			end
		end
	end
end

--- Executes an attack for a given unit, applying damage to its target.
--- @param Unit MeleeUnit -- The unit that is performing the attack.
--- @param dt number -- The delta time since the last update, used for timing attacks based on attack speed.
function CombatSystem:MeleeAttack(Unit, dt)
	-- No target to attack.
	if not Unit.Target then
		return
	end
	-- Check if enough time has elapsed since the last attack.
	Unit.AttackTimer = (Unit.AttackTimer or 0) + dt
	if Unit.AttackTimer < Unit.AttackSpeed then
		return
	end
	-- Check if the target is still in attack range.
	if not Unit:IsTargetInRange() then
		return
	end
	Unit.AttackTimer = 0
	-- Calculate damage considering armor and armor type of the target, and damage type of the attacker.
	local targetArmor = Unit.Target.Armor or 0
	local targetArmorType = Unit.Target.ArmorType or EntityEnums.ArmorTypes.LEATHER
	local damageMultiplier = EntityEnums.DamageMultipliers[Unit.DamageType][targetArmorType] or 1
	local effectiveDamage = math.max(0, Unit.Damage * damageMultiplier - targetArmor)
	--- Trigger attack, no logic just for visual effects and sounds.
	Unit:Attack(dt)
	--- Apply damage to the target and check if it died.
	local dead = Unit.Target:TakeDamage(effectiveDamage)
	-- Target is dead
	if dead then
		Unit.Target = nil
	end
end

function CombatSystem:RangeAttack(Unit, dt)
	-- Range attack logic would go here, but is currently not implemented.
end

return CombatSystem
