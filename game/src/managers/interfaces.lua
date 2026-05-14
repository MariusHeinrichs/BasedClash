local MainMenuInterface = require("src.interfaces.menus.mainMenu")
local StartInterface = require("src.interfaces.menus.startMenu")
local InterfaceEnums = require("src.enums.interfaces")

-- Singleton-Instanz
local instance = nil

--- Manages the different user interfaces (menus, HUDs, etc.) and their rendering.
local InterfaceManager = {}
InterfaceManager.__index = InterfaceManager

function InterfaceManager:Draw(InterfaceName)
	if InterfaceName == InterfaceEnums.Names.MAINMENU then
		if self.Interfaces.MainMenu then
			self.Interfaces.MainMenu:Draw()
		end
	elseif InterfaceName == InterfaceEnums.Names.STARTMENU then
		if self.Interfaces.StartMenu then
			self.Interfaces.StartMenu:Draw()
		end
	end
end

function love.resize(w, h)
	local singleton = require("src.managers.interfaces").getInstance()
	if singleton.Interfaces.MainMenu then
		singleton.Interfaces.MainMenu:RebuildLayout()
	end
	if singleton.Interfaces.StartMenu then
		singleton.Interfaces.StartMenu:RebuildLayout()
	end
end

local function getInstance()
	if not instance then
		instance = setmetatable({}, InterfaceManager)
		instance.Interfaces = {
			MainMenu = MainMenuInterface:new(),
			StartMenu = StartInterface:new(),
			Battle = nil,
			Pause = nil,
			GameOver = nil,
		}
	end
	return instance
end

return {
	getInstance = getInstance
}
