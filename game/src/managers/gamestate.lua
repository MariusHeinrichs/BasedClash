local GameStateEnums = require("src.enums.gameStates")

-- Singleton-Instanz
local instance = nil

--- Manages the current game state and transitions between states.
--- @class GameStateManager
--- @field CurrentGameState GameStateEnums.Names
local GameStateManager = {}
GameStateManager.__index = GameStateManager

--- Transitions to the startmenu gamestate
function GameStateManager:EnterStartMenu()
	self.CurrentGameState = GameStateEnums.Names.STARTMENU
end

--- Transitions to the mainmenu gamestate
function GameStateManager:EnterMainMenu()
	self.CurrentGameState = GameStateEnums.Names.MAINMENU
end

--- Transitions to the newgame gamestate
function GameStateManager:EnterNewGame()
	self.CurrentGameState = GameStateEnums.Names.NEWGAME
end

--- Transitions to the running gamestate
function GameStateManager:EnterRunning()
	self.CurrentGameState = GameStateEnums.Names.RUNNING
end

--- Transitions to the pause gamestate
function GameStateManager:EnterPause()
	self.CurrentGameState = GameStateEnums.Names.PAUSE
end

--- Transitions to the game won gamestate
function GameStateManager:EnterGameWon()
	self.CurrentGameState = GameStateEnums.Names.GAME_WON
end

--- Transitions to the game lost gamestate
function GameStateManager:EnterGameLost()
	self.CurrentGameState = GameStateEnums.Names.GAME_LOST
end

--- Returns the current game state
--- @return GameStateEnums.Names
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
