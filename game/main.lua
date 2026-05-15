--- Initialize Managers
local interfaceManager = require("src.managers.interfaces").getInstance()
local worldManager = require("src.managers.world").getInstance()
local inputManager = require("src.systems.inputs").getInstance()

function love.load()
end

function love.update(dt)
	worldManager:Update(dt)
end

function love.draw()
	love.graphics.printf("FPS: " .. love.timer.getFPS(), 10, 10, 200, "left")
	interfaceManager:Draw()
	worldManager:Draw()
end

function love.resize(w, h)
	interfaceManager:Resize()
end
