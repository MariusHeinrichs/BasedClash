local EntityManager = require("src.managers.entities").getInstance()
local GameStateManager = require("src.managers.gamestate").getInstance()
local SpawnSystem = require("src.systems.spawn")

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
	-- Phase 1: movement and pathing.
	-- MovementSystem.Update(self.Entities, units)

	-- Phase 2: direct combat resolution.
	-- CombatSystem.Update(self.Entities, units, structures, dt)

	-- Phase 3: projectile simulation and post-combat cleanup.
	-- ProjectileSystem.Update(self.Entities, dt)

	-- Phase 4: structure-based spawns and structure cleanup.
	SpawnSystem:Update(dt)
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
