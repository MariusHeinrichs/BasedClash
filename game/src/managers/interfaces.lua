local MainMenu = require("src.interfaces.menus.mainMenu")
local StartMenu = require("src.interfaces.menus.startMenu")
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
	elseif gameState == GameStateEnums.Names.RUNNING then
		if self.Interfaces.BattleHUD then
			self.Interfaces.BattleHUD:Draw()
		end
		if self.Interfaces.StructurePlacementHud then
			self.Interfaces.StructurePlacementHud:Draw()
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
end

local function getInstance()
	if not instance then
		instance = setmetatable({}, InterfaceManager)
		instance.Interfaces = {
			MainMenu = MainMenu:new(),
			StartMenu = StartMenu:new(),
			BattleHUD = BattleHUD:new(),
			StructurePlacementHud = StructurePlacementHud:new(),
			Pause = nil,
			GameOver = nil,
		}
	end
	return instance
end

return {
	getInstance = getInstance
}
