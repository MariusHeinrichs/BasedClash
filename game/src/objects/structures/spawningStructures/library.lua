--- Library class, representing a structure that can spawn mage units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local StructureStats = require("src.data.structureStats").SpawningStructures.Library

---@class Library : SpawningStructure
local Library = {}
Library.__index = Library

setmetatable(Library, { __index = SpawningStructure })

--- Creates a new Library.
--- @generic T : Library
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Library:new(PlayerID)
	local newLibrary = SpawningStructure.new(self,
		"Library",
		StructureStats.MaxHealth,
		StructureStats.Armor,
		StructureStats.ArmorType,
		StructureStats.Costs,
		StructureStats.IncomeBonus,
		StructureStats.Size,
		StructureStats.SpawnUnit,
		StructureStats.SpawnAmount,
		StructureStats.SpawnRate,
		StructureStats.Bounty,
		PlayerID
	)

	return newLibrary
end

return Library
