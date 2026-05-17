local EntityManager = require("src.managers.entities").getInstance()
local GameStateManager = require("src.managers.gamestate").getInstance()
local ResourceManager = require("src.managers.resources").getInstance()
local SpawnSystem = require("src.systems.spawn")
local MovementSystem = require("src.systems.movement")
local TargetingSystem = require("src.systems.targeting")
local StructureFactory = require("src.objects.structures.structureFactory")
local EntityEnums = require("src.enums.entities")

local GameStateEnums = require("src.enums.gameStates")

-- Singleton-Instanz
local instance = nil

--- Manages the game's systems and the game loop.
---@class WorldManager
local WorldManager = {}
WorldManager.__index = WorldManager

-- Update game logic, entities, etc. based on the current game state.
function WorldManager:Update(dt)
	-- Only update the game world when in the RUNNING state.
	if GameStateManager:GetGameState() ~= GameStateEnums.Names.RUNNING then
		return
	end

	-- Phase 1: structure-based spawns and structure cleanup.
	SpawnSystem:Update(dt)

	-- Phase 2: targeting and aggro management.
	TargetingSystem:Update(dt)

	-- Phase 3: movement and pathing.
	MovementSystem:Update(dt)

	-- Phase 4: direct combat resolution.
	-- CombatSystem.Update(self.Entities, units, structures, dt)

	-- Phase 5: projectile simulation and post-combat cleanup.
	-- ProjectileSystem.Update(self.Entities, dt)
end

--- Resets the world's units and resources and creates a fresh world.
function WorldManager:Reset()
	EntityManager:ClearAll()
	ResourceManager:ClearAll()

	local playerTownhall = StructureFactory:CreateStructure(EntityEnums.Structures.TOWNHALL, 1)
	local enemyTownhall = StructureFactory:CreateStructure(EntityEnums.Structures.TOWNHALL, 2)

	EntityManager:SetStructure(playerTownhall)
	EntityManager:SetStructure(enemyTownhall)

	playerTownhall.Position = { X = 200, Y = 300 }
	enemyTownhall.Position = { X = 600, Y = 300 }

	ResourceManager:SetPlayerResources(1, {Gold = 500, Metal =  250, Aether = 100})
	ResourceManager:SetPlayerResources(2, {Gold = 500, Metal =  250, Aether = 100})
end

-- Render the game world, entities, and interfaces based on the current game state.
function WorldManager:Draw()
	-- Only draw the game world when in the RUNNING state.
	if GameStateManager:GetGameState() ~= GameStateEnums.Names.RUNNING then
		return
	end

	local structures = EntityManager:GetStructures()
	local units = EntityManager:GetUnits()
	local projectiles = EntityManager:GetProjectiles()

	for _, structure in ipairs(structures) do
		structure:Draw()
	end
	for _, unit in ipairs(units) do
		unit:Draw()
	end
	for _, projectile in ipairs(projectiles) do
		projectile:Draw()
	end
end

local function getInstance()
	if not instance then
		instance = setmetatable({}, WorldManager)
		instance:Reset() -- Initialize the world with default entities and resources.
	end
	return instance
end

return {
	getInstance = getInstance
}
