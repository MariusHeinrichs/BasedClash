--- Mage class, represents a mage unit in the game.

local RangeUnit = require("src.objects.units.rangeUnit")
local UnitConstants = require("src.enums.entities")

--- @class Mage : RangeUnit
local Mage = {}
Mage.__index = Mage

setmetatable(Mage, { __index = RangeUnit })

--- Creates a new Mage.
--- @param PlayerID number | nil -- The ID of the player controlling the mage.
--- @return Mage
function Mage:new(PlayerID)
	local newMage = RangeUnit.new(self,
		"Mage",
		30,
		UnitConstants.ProjectileTypes.FIREBALL,
		0.3,
		0.25,
		1,
		UnitConstants.TargetPriorities.UNIT,
		1,
		UnitConstants.ArmorTypes.LEATHER,
		10,
		2,
		false,
		7,
		PlayerID
	)
	return newMage
end

return Mage
