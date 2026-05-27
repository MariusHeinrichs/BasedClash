--- Mage class, represents a mage unit in the game.

local RangeUnit = require("src.objects.units.rangeUnit")
local UnitStats = require("src.data.unitStats").RangeUnits.Mage
local HealAbility = require("src.objects.abilities.heal")

--- @class Mage : RangeUnit
local Mage = {}
Mage.__index = Mage
Mage.__type = "Mage"

setmetatable(Mage, { __index = RangeUnit })

--- Creates a new Mage.
--- @param PlayerID number | nil -- The ID of the player controlling the mage.
--- @return Mage
function Mage:new(PlayerID)
	local newMage = RangeUnit.new(self,
		"Mage",
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
	-- Add the Heal ability to the mage's abilities list
	table.insert(newMage:GetAbilities(), HealAbility:new("Heal", newMage))
	return newMage
end

return Mage
