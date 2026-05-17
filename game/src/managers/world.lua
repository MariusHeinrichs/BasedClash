local EntityManager = require("src.managers.entities").getInstance()
local GameStateManager = require("src.managers.gamestate").getInstance()
local SpawnSystem = require("src.systems.spawn")
local MovementSystem = require("src.systems.movement")
local TargetingSystem = require("src.systems.targeting")

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
	end
	return instance
end

return {
	getInstance = getInstance
}
