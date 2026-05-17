--- Townhall class, representing the player's main structure in the game.

local RangeDefenseStructure = require("src.objects.structures.rangeDefenseStructure")
local EntityEnums = require("src.enums.entities")

---@class Townhall : RangeDefenseStructure
local Townhall = {}
Townhall.__index = Townhall

setmetatable(Townhall, { __index = RangeDefenseStructure })

--- Creates a new Townhall.
--- @generic T : Townhall
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Townhall:new(PlayerID)
	local newTownhall = RangeDefenseStructure.new(self,
		"Townhall",
		2000,
		10,
		EntityEnums.ArmorTypes.STRUCTURE,
		{ Gold = 0, Metal = 0, Aether = 0 },
		6,
		EntityEnums.ProjectileTypes.ARROW,
		0.5,
		6,
		EntityEnums.TargetPriorities.UNIT,
		200,
		PlayerID
	)

	return newTownhall
end

return Townhall
