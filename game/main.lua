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
end

function love.draw()
	love.graphics.printf("FPS: " .. love.timer.getFPS(), 10, 10, 200, "left")
	interfaceManager:Draw()
end

function love.resize(w, h)
	interfaceManager:Resize()
end
