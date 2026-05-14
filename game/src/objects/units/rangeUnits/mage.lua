--- Mage class, represents a mage unit in the game.

local RangeUnit = require("src.objects.units.rangeUnit")
local UnitConstants = require("src.enums.entities")

--- @class Mage : RangeUnit
local Mage = {}
Mage.__index = Mage

setmetatable(Mage, { __index = RangeUnit })

--- Creates a new Mage.
--- @param Name string | nil -- The name of the mage.
--- @param PlayerID number | nil -- The ID of the player controlling the mage.
--- @return Mage
function Mage:new(Name, PlayerID)
	local newMage = RangeUnit.new(self,
		Name or "Mage",
		30,
		UnitConstants.ProjectileTypes.FIREBALL,
		0.3,
		0.25,
		1,
		UnitConstants.TargetPriorities.Unit,
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

function Mage:Draw()

end

return Mage
