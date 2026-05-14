--- MeleeUnit class, representing a melee unit in the game.

local Unit = require("src.objects.units.unit")

---@class MeleeUnit : Unit
local MeleeUnit = {}
MeleeUnit.__index = MeleeUnit

setmetatable(MeleeUnit, { __index = Unit })

--- Creates a new melee unit.
--- @generic T : MeleeUnit
--- @param Name string | nil
--- @param MaxHealth number | nil
--- @param Damage number | nil
--- @param DamageType EntityEnums.DamageTypes | nil
--- @param AttackSpeed number | nil
--- @param AttackRange number | nil
--- @param AggroRange number | nil
--- @param TargetPriority EntityEnums.TargetPriorities | nil
--- @param Armor number | nil
--- @param ArmorType EntityEnums.ArmorTypes | nil
--- @param MovementSpeed number | nil
--- @param Size number | nil
--- @param IsFlying boolean | nil
--- @param Bounty number | nil
--- @param PlayerID number | nil
--- @return T
function MeleeUnit:new(Name, MaxHealth, Damage, DamageType, AttackSpeed, AttackRange, AggroRange, TargetPriority, Armor,
					   ArmorType, MovementSpeed, Size, IsFlying, Bounty, PlayerID)
	local newMeleeUnit = Unit.new(self, Name, MaxHealth, Damage, DamageType, AttackSpeed, AttackRange, AggroRange,
		TargetPriority, Armor,
		ArmorType, MovementSpeed, Size, IsFlying, Bounty, PlayerID)
	return newMeleeUnit
end

return MeleeUnit
