local GameStateEnums = require("src.enums.gameStates")

-- Singleton-Instanz
local instance = nil

--- Manages the current game state and transitions between states.
local GameStateManager = {}
GameStateManager.__index = GameStateManager

function GameStateManager:EnterStartMenu()
	self.CurrentGameState = GameStateEnums.Names.STARTMENU
end

function GameStateManager:EnterMainMenu()
	self.CurrentGameState = GameStateEnums.Names.MAINMENU
end

function GameStateManager:EnterNewGame()
	self.CurrentGameState = GameStateEnums.Names.RUNNING
end

function GameStateManager:EnterRunning()
	self.CurrentGameState = GameStateEnums.Names.RUNNING
end

function GameStateManager:EnterPause()
	self.CurrentGameState = GameStateEnums.Names.PAUSE
end

function GameStateManager:EnterGameOver()
	self.CurrentGameState = GameStateEnums.Names.GAME_OVER
end

function GameStateManager:GetGameState()
	return self.CurrentGameState
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			CurrentGameState = GameStateEnums.Names.STARTMENU
		}, GameStateManager)
	end
	return instance
end

return {
	getInstance = getInstance
}
