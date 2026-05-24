local Structure = require("src.objects.structures.structure")
local UnitFactory = require("src.objects.units.unitFactory")
local EntityEnums = require("src.enums.entities")
local Collisions = require("src.utilities.collisions")
local unitHashGrid = require("src.utilities.unitHashGrid").getInstance()


--- SpawningStructure class, representing a structure that can spawn units in the game.
---@class SpawningStructure : Structure
---@field SpawnUnit EntityEnums.Units
---@field SpawnAmount number
---@field SpawnRate number
---@field SpawnTimer number
local SpawningStructure = {}
SpawningStructure.__index = SpawningStructure
SpawningStructure.__type = "SpawningStructure"

setmetatable(SpawningStructure, { __index = Structure })

--- Creates a new SpawningStructure.
--- @generic T : SpawningStructure
--- @param self T
--- @param Name string | nil -- The name of the structure.
--- @param MaxHealth number | nil -- The maximum health of the structure.
--- @param Armor number | nil -- The armor value of the structure.
--- @param ArmorType EntityEnums.ArmorTypes | nil -- The type of armor of the structure.
--- @param Costs {Gold: number, Metal: number, Aether: number} | nil -- The resource costs to build the structure.
--- @param IncomeBonus {Gold: number, Metal: number, Aether: number} | nil -- The income bonus provided by the structure.
--- @param Size number | nil -- The size of the structure.
--- @param SpawnUnit EntityEnums.Units | nil -- The unit that the structure spawns.
--- @param SpawnAmount number | nil -- The amount of units the structure spawns at a time.
--- @param SpawnRate number | nil -- The rate at which the structure spawns units (units per second).
--- @param Bounty number | nil -- The bounty awarded for defeating the structure.
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function SpawningStructure:new(Name, MaxHealth, Armor, ArmorType, Costs, IncomeBonus, Size, SpawnUnit, SpawnAmount,
							   SpawnRate, Bounty, PlayerID)
	local newSpawningStructure = Structure.new(self,
		Name,
		MaxHealth,
		Armor,
		ArmorType,
		Costs,
		IncomeBonus,
		Size,
		Bounty,
		PlayerID
	)
	newSpawningStructure.SpawnUnit = SpawnUnit or EntityEnums.Units.KNIGHT
	newSpawningStructure.SpawnRate = SpawnRate or 10
	newSpawningStructure.SpawnAmount = SpawnAmount or 1
	newSpawningStructure.SpawnTimer = 0
	return newSpawningStructure
end

--- Spawns units based on the structure's SpawnUnit, SpawnAmount and SpawnRate.
--- @param dt number
--- @return Unit[] | nil -- An array of newly spawned units.
function SpawningStructure:Spawn(dt)
	local newUnits = {}

	if not self.SpawnUnit then
		return nil
	end
	if not self.SpawnRate or self.SpawnRate <= 0 then
		return nil
	end

	self.SpawnTimer = self.SpawnTimer + dt
	if self.SpawnTimer >= self.SpawnRate then
		self.SpawnTimer = self.SpawnTimer - self.SpawnRate
		for i = 1, self.SpawnAmount do
			local newUnit = UnitFactory:CreateUnit(self.SpawnUnit, self.PlayerID)
			local pos = self:FindFreeSpawnPosition(newUnit.Size or 1)
			newUnit.Position = pos
			table.insert(newUnits, newUnit)
		end
	end

	return newUnits
end

---Finds a free spawnposition around the structure
---@param unitSize number
---@return { X: number, Y: number }
function SpawningStructure:FindFreeSpawnPosition(unitSize)
	local maxTries = 10
	local radius = self.Size + unitSize + 5
	for _ = 1, maxTries do
		local angle = math.random() * 2 * math.pi
		local x = self.Position.X + math.cos(angle) * radius
		local y = self.Position.Y + math.sin(angle) * radius
		local collides = false
		local entities = unitHashGrid:GetEntitiesInRadius({ X = x, Y = y }, unitSize + 2)
		for _, entity in ipairs(entities) do
			if entity.Position and Collisions.CirclesOverlap(x, y, unitSize, entity.Position.X, entity.Position.Y, entity.Size or 1) then
				collides = true
				break
			end
		end
		if not collides then
			return { X = x, Y = y }
		end
	end
	-- Fallback: Standardposition
	return { X = self.Position.X + radius, Y = self.Position.Y }
end

return SpawningStructure
