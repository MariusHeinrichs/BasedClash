--- Knight class, represents a knight unit in the game.

local MeleeUnit = require("src.objects.units.meleeUnit")
local UnitConstants = require("src.enums.entities")

--- @class Knight : MeleeUnit
local Knight = {}
Knight.__index = Knight

setmetatable(Knight, { __index = MeleeUnit })

--- Creates a new Knight.
--- @param PlayerID number | nil -- The ID of the player controlling the knight.
--- @return Knight
function Knight:new(PlayerID)
	local newKnight = MeleeUnit.new(self,
		"Knight",
		60,
		20,
		UnitConstants.DamageTypes.PHYSICAL,
		0.6,
		0.25,
		0.75,
		UnitConstants.TargetPriorities.UNIT,
		4,
		UnitConstants.ArmorTypes.PLATE,
		10,
		2,
		false,
		6,
		PlayerID
	)
	return newKnight
end

return Knight
