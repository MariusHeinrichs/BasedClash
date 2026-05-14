--- RangeUnit class, representing a ranged unit in the game.

local Unit = require("src.objects.units.unit")

---@class RangeUnit : Unit
local RangeUnit = {}
RangeUnit.__index = RangeUnit

setmetatable(RangeUnit, { __index = Unit })

--- Creates a new RangeUnit.
--- @generic T : RangeUnit
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
function RangeUnit:new(Name, MaxHealth, Damage, DamageType, AttackSpeed, AttackRange, AggroRange, TargetPriority, Armor,
					   ArmorType, MovementSpeed, Size, IsFlying, Bounty, PlayerID)
	local newRangeUnit = Unit.new(self, Name, MaxHealth, Damage, DamageType, AttackSpeed, AttackRange, AggroRange,
		TargetPriority, Armor,
		ArmorType, MovementSpeed, Size, IsFlying, Bounty, PlayerID)
	return newRangeUnit
end
