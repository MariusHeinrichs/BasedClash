local Button = require("src.interfaces.components.button")
local gameStateManager = require("src.managers.gamestate").getInstance()

local BASE_BUTTON_WIDTH = 200
local BASE_BUTTON_HEIGHT = 50
local BASE_SPACING_Y = 60

--- game lost menu interface.
--- @class GameLostMenu
local GameLostMenu = {}
GameLostMenu.__index = GameLostMenu

--- Creates a new GameLostMenu.
---@return GameLostMenu
function GameLostMenu:new()
	local gameLostMenu = setmetatable({}, GameLostMenu)

	gameLostMenu:RebuildLayout()

	return gameLostMenu
end

function GameLostMenu:RebuildLayout()

end

function GameLostMenu:Draw()
	local width, height = love.graphics.getDimensions()

	love.graphics.setColor(0, 0, 0, 0.75)
	love.graphics.rectangle("fill", 0, 0, width, height)

	love.graphics.setColor(1, 1, 1)
	love.graphics.printf("You Lose!", 0, height / 2 - 50, width, "center")
end

return GameLostMenu
