local MainMenu = require("src.interfaces.menus.mainMenu")
local StartMenu = require("src.interfaces.menus.startMenu")
local BattleMenu = require("src.interfaces.menus.battleMenu")
local InterfaceEnums = require("src.enums.interfaces")

-- Singleton-Instanz
local instance = nil

--- Manages the different user interfaces (menus, HUDs, etc.) and their rendering.
local InterfaceManager = {}
InterfaceManager.__index = InterfaceManager

--- Draws the specified Interface
--- @param InterfaceName InterfaceEnums.Names
function InterfaceManager:Draw(InterfaceName)
	if InterfaceName == InterfaceEnums.Names.MAINMENU then
		if self.Interfaces.MainMenu then
			self.Interfaces.MainMenu:Draw()
		end
	elseif InterfaceName == InterfaceEnums.Names.STARTMENU then
		if self.Interfaces.StartMenu then
			self.Interfaces.StartMenu:Draw()
		end
	elseif InterfaceName == InterfaceEnums.Names.BATTLEMENU then
		if self.Interfaces.BattleMenu then
			self.Interfaces.BattleMenu:Draw()
		end
	end
end

function love.resize(w, h)
	local o = InterfaceManager:getInstance()
	if o.Interfaces.MainMenu then
		o.Interfaces.MainMenu:RebuildLayout()
	end
	if o.Interfaces.StartMenu then
		o.Interfaces.StartMenu:RebuildLayout()
	end
	if o.Interfaces.BattleMenu then
		o.Interfaces.BattleMenu:RebuildLayout()
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
