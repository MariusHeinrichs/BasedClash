--- BarbarianCamp class, representing a structure that can spawn barbarian units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local EntityEnums = require("src.enums.entities")

---@class BarbarianCamp : SpawningStructure
local BarbarianCamp = {}
BarbarianCamp.__index = BarbarianCamp

setmetatable(BarbarianCamp, { __index = SpawningStructure })

--- Creates a new BarbarianCamp.
--- @generic T : BarbarianCamp
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function BarbarianCamp:new(PlayerID)
	local newBarbarianCamp = SpawningStructure.new(self,
		"Barbarian Camp",
		500,
		5,
		EntityEnums.ArmorTypes.STRUCTURE,
		{ Gold = 160, Metal = 0, Aether = 0 },
		5,
		EntityEnums.Units.BARBARIAN,
		1,
		10,
		50,
		PlayerID
	)

	return newBarbarianCamp
end

return BarbarianCamp
