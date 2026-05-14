--- SpawningStructure class, representing a structure that can spawn units in the game.

local Structure = require("src.objects.structures.structure")

---@class SpawningStructure : Structure
---@field SpawnRate number
---@field SpawnUnit Unit
local SpawningStructure = {}
SpawningStructure.__index = SpawningStructure

setmetatable(SpawningStructure, { __index = Structure })

--- Creates a new SpawningStructure.
--- @generic T : SpawningStructure
--- @param self T
--- @param Name string | nil
--- @param MaxHealth number | nil
--- @param Armor number | nil
--- @param ArmorType EntityEnums.ArmorTypes | nil
--- @param Costs {Gold: number, Metal: number, Aether: number} | nil
--- @param Size number | nil
--- @param SpawnUnit Unit | nil
--- @param SpawnRate number | nil
--- @param Bounty number | nil
--- @param PlayerID number | nil
--- @return T
function SpawningStructure:new(Name, MaxHealth, Armor, ArmorType, Costs, Size, SpawnUnit, SpawnRate, Bounty, PlayerID)
	local newSpawningStructure = Structure.new(self, Name, MaxHealth, Armor, ArmorType, Costs, Size, Bounty, PlayerID)
	newSpawningStructure.SpawnUnit = SpawnUnit
	newSpawningStructure.SpawnRate = SpawnRate or 1
	return newSpawningStructure
end

return SpawningStructure
