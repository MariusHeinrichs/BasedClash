--- MeleeUnit class, representing a melee unit in the game.

local Unit = require("src.objects.units.unit")
local EntityEnums = require("src.enums.entities")

---@class MeleeUnit : Unit
---@field Damage number -- The damage dealt by the melee unit.
---@field DamageType EntityEnums.DamageTypes -- The type of damage dealt by the melee unit.
local MeleeUnit = {}
MeleeUnit.__index = MeleeUnit

setmetatable(MeleeUnit, { __index = Unit })

--- Creates a new melee unit.
--- @generic T : MeleeUnit
--- @param Name string | nil -- The name of the unit.
--- @param MaxHealth number | nil -- The maximum health of the unit.
--- @param Damage number | nil -- The damage dealt by the unit.
--- @param DamageType EntityEnums.DamageTypes | nil -- The type of damage dealt by the unit.
--- @param AttackSpeed number | nil -- The attack speed of the unit.
--- @param AttackRange number | nil -- The attack range of the unit.
--- @param AggroRange number | nil -- The aggro range of the unit.
--- @param TargetPriority EntityEnums.TargetPriorities | nil -- The target priority of the unit.
--- @param Armor number | nil -- The armor value of the unit.
--- @param ArmorType EntityEnums.ArmorTypes | nil -- The type of armor of the unit.
--- @param MovementSpeed number | nil -- The movement speed of the unit.
--- @param Size number | nil -- The size of the unit.
--- @param IsFlying boolean | nil -- Whether the unit is flying.
--- @param Bounty number | nil -- The bounty awarded for defeating the unit.
--- @param PlayerID number | nil -- The ID of the player controlling the unit.
--- @return T
function MeleeUnit:new(Name, MaxHealth, Damage, DamageType, AttackSpeed, AttackRange, AggroRange, TargetPriority, Armor,
					   ArmorType, MovementSpeed, Size, IsFlying, Bounty, PlayerID)
	local newMeleeUnit = Unit.new(self,
		Name,
		MaxHealth,
		AttackSpeed,
		AttackRange,
		AggroRange,
		TargetPriority,
		Armor,
		ArmorType,
		MovementSpeed,
		Size,
		IsFlying,
		Bounty,
		PlayerID)
	newMeleeUnit.Damage = Damage or 10
	newMeleeUnit.DamageType = DamageType or EntityEnums.DamageTypes.PHYSICAL
	return newMeleeUnit
end

--- Executes an attack, applying damage to its target.
--- @param dt number -- The delta time since the last update, used for timing attacks based on attack speed.
--- @return boolean | nil targetKilled -- Returns true if the attack killed the target, false otherwise.
function MeleeUnit:Attack(dt)
	-- No target to attack.
	if not self.Target then
		return
	end
	-- Check if enough time has elapsed since the last attack.
	self.AttackTimer = (self.AttackTimer or 0) + dt
	if self.AttackTimer < self.AttackSpeed then
		return
	end
	-- Check if the target is still in attack range.
	if not self:IsTargetInRange() then
		return
	end
	self.AttackTimer = 0
	-- Calculate damage considering armor and armor type of the target, and damage type of the attacker.
	local targetArmor = self.Target.Armor or 0
	local targetArmorType = self.Target.ArmorType or EntityEnums.ArmorTypes.LEATHER
	local damageMultiplier = EntityEnums.DamageMultipliers[self.DamageType][targetArmorType] or 1
	local effectiveDamage = math.max(0, self.Damage * damageMultiplier - targetArmor)
	--- Apply damage to the target and check if it died.
	local dead = self.Target:TakeDamage(effectiveDamage)
	-- Target is dead
	if dead then
		self.Target = nil
	end
	return dead
end

return MeleeUnit
