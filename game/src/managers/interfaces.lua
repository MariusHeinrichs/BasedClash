local MainMenu = require("src.interfaces.menus.mainMenu")
local StartMenu = require("src.interfaces.menus.startMenu")
local PauseMenu = require("src.interfaces.menus.pauseMenu")
local GameWonMenu = require("src.interfaces.menus.gameWonMenu")
local GameLostMenu = require("src.interfaces.menus.gameLostMenu")
local BattleHUD = require("src.interfaces.huds.battleHud")
local StructurePlacementHud = require("src.interfaces.huds.structurePlacementHud")
local GameStateEnums = require("src.enums.gameStates")
local gameStateManager = require("src.managers.gamestate").getInstance()

-- Singleton-Instanz
local instance = nil

--- Manages the different user interfaces (menus, HUDs, etc.) and their rendering.
--- @class InterfaceManager
--- @field Interfaces table<string, any>
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
	elseif gameState == GameStateEnums.Names.PAUSE then
		if self.Interfaces.Pause then
			self.Interfaces.Pause:Draw()
		end
	elseif gameState == GameStateEnums.Names.RUNNING then
		if self.Interfaces.BattleHUD then
			self.Interfaces.BattleHUD:Draw()
		end
		if self.Interfaces.StructurePlacementHUD then
			self.Interfaces.StructurePlacementHUD:Draw()
		end
	elseif gameState == GameStateEnums.Names.GAME_WON then
		if self.Interfaces.GameWon then
			self.Interfaces.GameWon:Draw()
		end
	elseif gameState == GameStateEnums.Names.GAME_LOST then
		if self.Interfaces.GameLost then
			self.Interfaces.GameLost:Draw()
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
	if self.Interfaces.BattleHUD then
		self.Interfaces.BattleHUD:RebuildLayout()
	end
	if self.Interfaces.Pause then
		self.Interfaces.Pause:RebuildLayout()
	end
	if self.Interfaces.GameWon then
		self.Interfaces.GameWon:RebuildLayout()
	end
	if self.Interfaces.GameLost then
		self.Interfaces.GameLost:RebuildLayout()
	end
end

function InterfaceManager:Update(dt)
	local gameState = gameStateManager:GetGameState()
	if gameState == GameStateEnums.Names.RUNNING then
		if self.Interfaces.StructurePlacementHUD then
			--- update Placement HUD for any dynamic elements (e.g., failure messages) that need to be shown for a limited time after a placement attempt.
			self.Interfaces.StructurePlacementHUD:Update(dt)
		end
	end
end

local function getInstance()
	if not instance then
		instance = setmetatable({}, InterfaceManager)
		instance.Interfaces = {
			MainMenu = MainMenu:new(),
			StartMenu = StartMenu:new(),
			BattleHUD = BattleHUD:new(),
			StructurePlacementHUD = StructurePlacementHud:new(),
			Pause = PauseMenu:new(),
			GameWon = GameWonMenu:new(),
			GameLost = GameLostMenu:new(),
		}
	end
	return instance
end

return {
	getInstance = getInstance
}
