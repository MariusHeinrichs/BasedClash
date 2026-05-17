--- Archer class, represents an archer unit in the game.

local RangeUnit = require("src.objects.units.rangeUnit")
local UnitStats = require("src.data.unitStats").RangeUnits.Archer

--- @class Archer : RangeUnit
local Archer = {}
Archer.__index = Archer

setmetatable(Archer, { __index = RangeUnit })

--- Creates a new Archer.
--- @param PlayerID number | nil -- The ID of the player controlling the archer.
--- @return Archer
function Archer:new(PlayerID)
	local newArcher = RangeUnit.new(self,
		"Archer",
		UnitStats.MaxHealth,
		UnitStats.Projectile,
		UnitStats.AttackSpeed,
		UnitStats.AttackRange,
		UnitStats.AggroRange,
		UnitStats.TargetPriority,
		UnitStats.Armor,
		UnitStats.ArmorType,
		UnitStats.MovementSpeed,
		UnitStats.Size,
		UnitStats.IsFlying,
		UnitStats.Bounty,
		PlayerID
	)
	return newArcher
end

return Archer
