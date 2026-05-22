local entityManager = require("src.managers.entities").getInstance()
local gameStateManager = require("src.managers.gamestate").getInstance()
local SpawnSystem = require("src.systems.spawn")
local MovementSystem = require("src.systems.movement")
local TargetingSystem = require("src.systems.targeting")
local CombatSystem = require("src.systems.combat")
local IncomeSystem = require("src.systems.income")


local GameStateEnums = require("src.enums.gameStates")

-- Singleton-Instanz
local instance = nil

--- Manages the game's systems and the game loop.
---@class WorldManager
---@field Map Map -- The current map of the world
local WorldManager = {}
WorldManager.__index = WorldManager

-- Update game logic, entities, etc. based on the current game state.
function WorldManager:Update(dt)
	-- Only update the game world when in the RUNNING state.
	if gameStateManager:GetGameState() ~= GameStateEnums.Names.RUNNING then
		return
	end

	-- Phase 1: structure-based spawns.
	SpawnSystem:Update(dt)

	-- Phase 2: targeting and aggro management.
	TargetingSystem:Update(dt)

	-- Phase 3: movement and pathing.
	MovementSystem:Update(dt, self.Map)

	-- Phase 4: direct combat resolution.
	CombatSystem:Update(dt)

	-- Phase 5: income generation.
	IncomeSystem:Update(dt)

	-- Phase 6: win condition checks and game state transitions.
end

--- Resets the world's units and resources and creates a fresh world.
function WorldManager:Setup()
	if self.Map then
		self.Map:Setup()
	end
end

-- Render the game world, entities, and interfaces based on the current game state.
function WorldManager:Draw()
	-- Only draw the game world when in the RUNNING state.
	if gameStateManager:GetGameState() ~= GameStateEnums.Names.RUNNING then
		return
	end
	-- Draw entities
	entityManager:Draw()
	-- Draw the map components.
	if self.Map then
		self.Map:Draw()
	end
end

--- Sets the current map for the world.
---@param Map Map
function WorldManager:SetMap(Map)
	self.Map = Map
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
