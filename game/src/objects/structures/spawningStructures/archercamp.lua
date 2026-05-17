--- ArcherCamp class, representing a structure that can spawn archer units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local StructureStats = require("src.data.structureStats").SpawningStructures.ArcherCamp

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
		StructureStats.MaxHealth,
		StructureStats.Armor,
		StructureStats.ArmorType,
		StructureStats.Costs,
		StructureStats.Size,
		StructureStats.SpawnUnit,
		StructureStats.SpawnAmount,
		StructureStats.SpawnRate,
		StructureStats.Bounty,
		PlayerID
	)

	return newArcherCamp
end


return ArcherCamp
