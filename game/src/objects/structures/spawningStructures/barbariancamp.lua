--- BarbarianCamp class, representing a structure that can spawn barbarian units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local StructureStats = require("src.data.structureStats").SpawningStructures.BarbarianCamp

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

	return newBarbarianCamp
end

return BarbarianCamp
