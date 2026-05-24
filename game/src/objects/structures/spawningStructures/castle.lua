--- Castle class, representing a structure that can spawn knight units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local StructureStats = require("src.data.structureStats").SpawningStructures.Castle

---@class Castle : SpawningStructure
local Castle = {}
Castle.__index = Castle
Castle.__type = "Castle"

setmetatable(Castle, { __index = SpawningStructure })

--- Creates a new Castle.
--- @generic T : Castle
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Castle:new(PlayerID)
	local newCastle = SpawningStructure.new(self,
		"Castle",
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

	return newCastle
end

return Castle
