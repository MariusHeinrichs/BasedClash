--- Initialize Managers
local gameStateManager = require("src.managers.gamestate").getInstance()
local interfaceManager = require("src.managers.interfaces").getInstance()
local inputManager = require("src.managers.inputs").getInstance()
local entityManager = require("src.managers.entities").getInstance()
local resourceManager = require("src.managers.resources").getInstance()

local InterfaceEnums = require("src.enums.interfaces")
local GameStateEnums = require("src.enums.gameStates")


function love.load()
end

function love.update()
	print("Hello!")
end

function love.draw()
	love.graphics.printf("FPS: " .. love.timer.getFPS(), 10, 10, 200, "left")

	local gameState = gameStateManager:GetGameState()

	if gameState == GameStateEnums.Names.STARTMENU then
		interfaceManager:Draw(InterfaceEnums.Names.STARTMENU)
	elseif gameState == GameStateEnums.Names.MAINMENU then
		interfaceManager:Draw(InterfaceEnums.Names.MAINMENU)
	elseif gameState == GameStateEnums.Names.RUNNING then
		interfaceManager:Draw(InterfaceEnums.Names.BATTLEMENU)
	end
end
