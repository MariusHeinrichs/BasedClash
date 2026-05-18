local GameStateEnums = require("src.enums.gameStates")
local GameStateManager = require("src.managers.gamestate").getInstance()
local InterfaceManager = require("src.managers.interfaces").getInstance()
local StructurePlacement = require("src.systems.structurePlacement").getInstance()

-- Singleton-Instanz
local instance = nil

--- Manages player inputs and routes them to the appropriate handlers based on the current game state.
--- @class InputManager
local InputManager = {}
InputManager.__index = InputManager

function InputManager:HandleKeyPressed(key)
	local GameState = GameStateManager:GetGameState()

	if GameState == GameStateEnums.Names.STARTMENU then
		if key == "return" then
			GameStateManager:EnterMainMenu()
			return true
		end
		if key == "escape" then
			love.event.quit()
			return true
		end
	elseif GameState == GameStateEnums.Names.MAINMENU then
		if key == "escape" then
			GameStateManager:EnterStartMenu()
			return true
		end
	elseif GameState == GameStateEnums.Names.RUNNING then
		if key == "escape" then
			GameStateManager:EnterPause()
			return true
		end
	elseif GameState == GameStateEnums.Names.PAUSE then
		if key == "escape" then
			GameStateManager:EnterRunning()
			return true
		end
	elseif GameState == GameStateEnums.Names.GAME_OVER then
		if key == "escape" then
			GameStateManager:EnterMainMenu()
			return true
		end
	end

	return false
end

function InputManager:HandleMousePressed(x, y, button)
	local GameState = GameStateManager:GetGameState()

	if GameState == GameStateEnums.Names.MAINMENU then
		if InterfaceManager.Interfaces.MainMenu then
			InterfaceManager.Interfaces.MainMenu:HandleMousePressed(x, y, button)
		end
		return true
	end

	if GameState == GameStateEnums.Names.RUNNING then
		if InterfaceManager.Interfaces.BattleHUD then
			--- check if a button has been pressed and execute its action if so.
			local pressed = InterfaceManager.Interfaces.BattleHUD:HandleMousePressed(x, y, button)
			--- if no button was pressed, we can allow the click to interact with the game world (e.g., for structure placement).
			if not pressed then
				StructurePlacement:HandleMousePressed(x, y, button)
			end
		end
		return true
	end

	if GameState == GameStateEnums.Names.PAUSE then
		if InterfaceManager.Interfaces.Pause then
			-- InterfaceManager.Interfaces.Pause:HandleMousePressed(x, y, button)
		end
		return true
	end

	if GameState == GameStateEnums.Names.GAME_OVER then
		if InterfaceManager.Interfaces.GameOver then
			-- InterfaceManager.Interfaces.GameOver:HandleMousePressed(x, y, button)
		end
		return true
	end

	return false
end

local function getInstance()
	if not instance then
		instance = setmetatable({}, InputManager)
		love.keypressed = function(key)
			instance:HandleKeyPressed(key)
		end
		love.mousepressed = function(x, y, button, istouch, presses)
			instance:HandleMousePressed(x, y, button)
		end
	end
	return instance
end

return {
	getInstance = getInstance
}
