--- ArcherCamp class, representing a structure that can spawn archer units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local EntityEnums = require("src.enums.entities")

---@class ArcherCamp : SpawningStructure
local ArcherCamp = {}
ArcherCamp.__index = ArcherCamp

setmetatable(ArcherCamp, { __index = SpawningStructure })

--- Creates a new ArcherCamp.
--- @generic T : ArcherCamp
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function ArcherCamp:new(PlayerID)
	local newArcherCamp = SpawningStructure.new(self,
		"ArcherCamp",
		500,
		5,
		EntityEnums.ArmorTypes.STRUCTURE,
		{ Gold = 160, Metal = 0, Aether = 0 },
		4,
		EntityEnums.Units.ARCHER,
		1,
		10,
		50,
		PlayerID
	)

	return newArcherCamp
end


return ArcherCamp
