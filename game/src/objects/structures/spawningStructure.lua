--- SpawningStructure class, representing a structure that can spawn units in the game.

local Structure = require("src.objects.structures.structure")
local EntityEnums = require("src.enums.entities")

---@class SpawningStructure : Structure
---@field SpawnUnit EntityEnums.Units
---@field SpawnAmount number
---@field SpawnRate number
local SpawningStructure = {}
SpawningStructure.__index = SpawningStructure

setmetatable(SpawningStructure, { __index = Structure })

--- Creates a new SpawningStructure.
--- @generic T : SpawningStructure
--- @param self T
--- @param Name string | nil -- The name of the structure.
--- @param MaxHealth number | nil -- The maximum health of the structure.
--- @param Armor number | nil -- The armor value of the structure.
--- @param ArmorType EntityEnums.ArmorTypes | nil -- The type of armor of the structure.
--- @param Costs {Gold: number, Metal: number, Aether: number} | nil -- The resource costs to build the structure.
--- @param Size number | nil -- The size of the structure.
--- @param SpawnUnit EntityEnums.Units | nil -- The unit that the structure spawns.
--- @param SpawnAmount number | nil -- The amount of units the structure spawns at a time.
--- @param SpawnRate number | nil -- The rate at which the structure spawns units (units per second).
--- @param Bounty number | nil -- The bounty awarded for defeating the structure.
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function SpawningStructure:new(Name, MaxHealth, Armor, ArmorType, Costs, Size, SpawnUnit, SpawnAmount, SpawnRate, Bounty, PlayerID)
	local newSpawningStructure = Structure.new(self,
		Name,
		MaxHealth,
		Armor,
		ArmorType,
		Costs,
		Size,
		Bounty,
		PlayerID
	)
	newSpawningStructure.SpawnUnit = SpawnUnit or EntityEnums.Units.KNIGHT
	newSpawningStructure.SpawnRate = SpawnRate or 10
	newSpawningStructure.SpawnAmount = SpawnAmount or 1
	return newSpawningStructure
end

--- Spawns units based on the structure's SpawnUnit, SpawnAmount and SpawnRate.
--- @param dt number
--- @return Unit[] | nil -- An array of newly spawned units.
function SpawningStructure:Spawn(dt)
	local newUnits = {}

	return newUnits
end

return SpawningStructure
