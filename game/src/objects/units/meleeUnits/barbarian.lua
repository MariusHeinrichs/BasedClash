--- Barbarian class, represents a barbarian unit in the game.

local MeleeUnit = require("src.objects.units.meleeUnit")
local UnitConstants = require("src.enums.entities")

--- @class Barbarian : MeleeUnit
local Barbarian = {}
Barbarian.__index = Barbarian

setmetatable(Barbarian, { __index = MeleeUnit })

--- Creates a new Barbarian.
--- @param Name string | nil -- The name of the barbarian.
--- @param PlayerID number | nil -- The ID of the player controlling the barbarian.
--- @return Barbarian
function Barbarian:new(Name, PlayerID)
	local newBarbarian = MeleeUnit.new(self,
		Name or "Barbarian",
		50,
		15,
		UnitConstants.DamageTypes.PHYSICAL,
		0.7,
		0.25,
		0.75,
		UnitConstants.TargetPriorities.Unit,
		3,
		UnitConstants.ArmorTypes.CHAINMAIL,
		10,
		2,
		false,
		5,
		PlayerID
	)
	return newBarbarian
end

function Barbarian:Draw()

end

return Barbarian
