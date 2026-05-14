--- Castle class, representing a structure that can spawn knight units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local EntityEnums = require("src.enums.entities")

---@class Castle : SpawningStructure
local Castle = {}
Castle.__index = Castle

setmetatable(Castle, { __index = SpawningStructure })

--- Creates a new Castle.
--- @generic T : Castle
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Castle:new(PlayerID)
	local newCastle = SpawningStructure.new(self,
		"Castle",
		500,
		5,
		EntityEnums.ArmorTypes.STRUCTURE,
		{ Gold = 200, Metal = 0, Aether = 0 },
		6,
		EntityEnums.Units.KNIGHT,
		15,
		50,
		PlayerID
	)

	return newCastle
end

return Castle
