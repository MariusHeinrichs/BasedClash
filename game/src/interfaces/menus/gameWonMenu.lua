local Button = require("src.interfaces.components.button")
local gameStateManager = require("src.managers.gamestate").getInstance()

local BASE_BUTTON_WIDTH = 200
local BASE_BUTTON_HEIGHT = 50
local BASE_SPACING_Y = 60

--- game won menu interface.
--- @class GameWonMenu
local GameWonMenu = {}
GameWonMenu.__index = GameWonMenu

--- Creates a new GameWonMenu.
---@return GameWonMenu
function GameWonMenu:new()
	local gameWonMenu = setmetatable({}, GameWonMenu)

	gameWonMenu:RebuildLayout()

	return gameWonMenu
end

function GameWonMenu:RebuildLayout()

end

function GameWonMenu:Draw()
	local width, height = love.graphics.getDimensions()

	love.graphics.setColor(0, 0, 0, 0.75)
	love.graphics.rectangle("fill", 0, 0, width, height)

	love.graphics.setColor(1, 1, 1)
	love.graphics.printf("You Win!", 0, height / 2 - 50, width, "center")
end

return GameWonMenu
