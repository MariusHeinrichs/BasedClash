--- Archer class, represents an archer unit in the game.

local RangeUnit = require("src.objects.units.rangeUnit")
local UnitConstants = require("src.enums.entities")

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
		40,
		UnitConstants.ProjectileTypes.ARROW,
		0.5,
		0.25,
		0.75,
		UnitConstants.TargetPriorities.UNIT,
		2,
		UnitConstants.ArmorTypes.LEATHER,
		10,
		2,
		false,
		4,
		PlayerID
	)
	return newArcher
end

return Archer
