local MainMenu = require("src.interfaces.menus.mainMenu")
local StartMenu = require("src.interfaces.menus.startMenu")
local BattleMenu = require("src.interfaces.menus.battleMenu")
local GameStateEnums = require("src.enums.gameStates")
local gameStateManager = require("src.managers.gamestate").getInstance()

-- Singleton-Instanz
local instance = nil

--- Manages the different user interfaces (menus, HUDs, etc.) and their rendering.
local InterfaceManager = {}
InterfaceManager.__index = InterfaceManager

--- Draws the currently active Interface based on the game state.
function InterfaceManager:Draw()
	local gameState = gameStateManager:GetGameState()

	if gameState == GameStateEnums.Names.STARTMENU then
		if self.Interfaces.StartMenu then
			self.Interfaces.StartMenu:Draw()
		end
	elseif gameState == GameStateEnums.Names.MAINMENU then
		if self.Interfaces.MainMenu then
			self.Interfaces.MainMenu:Draw()
		end
	elseif gameState == GameStateEnums.Names.RUNNING then
		if self.Interfaces.BattleMenu then
			self.Interfaces.BattleMenu:Draw()
		end
	end
end

function InterfaceManager:Resize()
	if self.Interfaces.MainMenu then
		self.Interfaces.MainMenu:RebuildLayout()
	end
	if self.Interfaces.StartMenu then
		self.Interfaces.StartMenu:RebuildLayout()
	end
	if self.Interfaces.BattleMenu then
		self.Interfaces.BattleMenu:RebuildLayout()
	end
end

local function getInstance()
	if not instance then
		instance = setmetatable({}, InterfaceManager)
		instance.Interfaces = {
			MainMenu = MainMenu:new(),
			StartMenu = StartMenu:new(),
			BattleMenu = BattleMenu:new(),
			Pause = nil,
			GameOver = nil,
		}
	end
	return instance
end

return {
	getInstance = getInstance
}
