--- Initialize Managers
local GameStateManager = require("src.managers.gamestate").getInstance()
local InterfaceManager = require("src.managers.interfaces").getInstance()
local InputManager = require("src.managers.inputs").getInstance()

local InterfaceEnums = require("src.enums.interfaces")
local GameStateEnums = require("src.enums.gameStates")


function love.load()
end

function love.update()
	print("Hello!")
end

function love.draw()
	local GameState = GameStateManager:GetGameState()
	if GameState == GameStateEnums.Names.STARTMENU then
		InterfaceManager:Draw(InterfaceEnums.Names.STARTMENU)
	elseif GameState == GameStateEnums.Names.MAINMENU then
		InterfaceManager:Draw(InterfaceEnums.Names.MAINMENU)
	end
end
