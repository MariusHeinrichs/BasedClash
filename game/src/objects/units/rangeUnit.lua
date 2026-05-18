--- RangeUnit class, representing a ranged unit in the game.

local Unit = require("src.objects.units.unit")
local EntityEnums = require("src.enums.entities")

---@class RangeUnit : Unit
---@field Projectile EntityEnums.ProjectileTypes -- The projectile used by the ranged unit.
local RangeUnit = {}
RangeUnit.__index = RangeUnit

setmetatable(RangeUnit, { __index = Unit })

--- Creates a new RangeUnit.
--- @generic T : RangeUnit
--- @param Name string | nil -- The name of the unit.
--- @param MaxHealth number | nil -- The maximum health of the unit.
--- @param Projectile EntityEnums.ProjectileTypes | nil -- The projectile used by the unit.
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
function RangeUnit:new(Name, MaxHealth, Projectile, AttackSpeed, AttackRange, AggroRange, TargetPriority, Armor,
					   ArmorType, MovementSpeed, Size, IsFlying, Bounty, PlayerID)
	local newRangeUnit = Unit.new(self,
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
	newRangeUnit.Projectile = Projectile or EntityEnums.ProjectileTypes.ARROW
	return newRangeUnit
end

--- Attacks the current target, fireing a projectile at it.
function RangeUnit:Attack(dt)
	-- Ranged attack logic will be implemented here, such as creating a projectile and launching it towards the target.
end

return RangeUnit
