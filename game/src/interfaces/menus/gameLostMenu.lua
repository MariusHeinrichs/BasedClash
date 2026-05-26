local Button = require("src.interfaces.components.button")
local Text = require("src.interfaces.components.text")
local gameStateManager = require("src.managers.gamestate").getInstance()

local BASE_BUTTON_WIDTH = 200
local BASE_BUTTON_HEIGHT = 50
local BASE_SPACING_Y = 60

--- game lost menu interface.
--- @class GameLostMenu
--- @field RestartButton Button
--- @field MainMenuButton Button
--- @field QuitButton Button
--- @field PostGameMessage Text
local GameLostMenu = {}
GameLostMenu.__index = GameLostMenu

--- Creates a new GameLostMenu.
---@return GameLostMenu
function GameLostMenu:new()
	local gameLostMenu = setmetatable({}, GameLostMenu)

	local definitions = {
		{
			key = "RestartButton",
			name = "Restart",
			text = "Restart Game",
			action = function()
				gameStateManager:EnterNewGame()
			end
		},
		{
			key = "MainMenuButton",
			name = "MainMenu",
			text = "Main Menu",
			action = function()
				gameStateManager:EnterMainMenu()
			end
		},
		{ key = "QuitButton", name = "Quit", text = "Quit Game", action = function() love.event.quit() end },
	}

	for index, definition in ipairs(definitions) do
		gameLostMenu[definition.key] = Button:new(
			definition.name,
			BASE_BUTTON_WIDTH,
			BASE_BUTTON_HEIGHT,
			{ R = 0.5, G = 0.5, B = 0.5, A = 1 },
			definition.text,
			{ X = 0, Y = 0 },
			{ X = 0, Y = 15 },
			definition.action
		)
	end

	gameLostMenu.PostGameMessage = Text:new(
		"Sorry! You lost the game!",
		{ X = 0, Y = 0 },
		0,
		{ R = 1, G = 1, B = 1, A = 1 },
		"center"
	)

	gameLostMenu:RebuildLayout()

	return gameLostMenu
end

--- Recomputes button positions based on current window size.
function GameLostMenu:RebuildLayout()
	local width, height = love.graphics.getDimensions()
	local scale = math.min(width / 1280, height / 720)
	scale = math.max(0.75, math.min(1.6, scale))

	local buttonWidth = math.floor(BASE_BUTTON_WIDTH * scale + 0.5)
	local buttonHeight = math.floor(BASE_BUTTON_HEIGHT * scale + 0.5)
	local spacingY = math.floor(BASE_SPACING_Y * scale + 0.5)

	local startY = height / 2
	local centerX = width / 2 - buttonWidth / 2
	local textOffsetY = math.floor(buttonHeight * 0.3 + 0.5)

	self.RestartButton.Width = buttonWidth
	self.RestartButton.Height = buttonHeight
	self.RestartButton.PositionText.Y = textOffsetY

	self.RestartButton.PositionButton.X = centerX
	self.RestartButton.PositionButton.Y = startY

	self.MainMenuButton.Width = buttonWidth
	self.MainMenuButton.Height = buttonHeight
	self.MainMenuButton.PositionText.Y = textOffsetY

	self.MainMenuButton.PositionButton.X = centerX
	self.MainMenuButton.PositionButton.Y = startY + spacingY

	self.QuitButton.Width = buttonWidth
	self.QuitButton.Height = buttonHeight
	self.QuitButton.PositionText.Y = textOffsetY

	self.QuitButton.PositionButton.X = centerX
	self.QuitButton.PositionButton.Y = startY + (2 * spacingY)

	self.PostGameMessage.Position.X = 0
	self.PostGameMessage.Position.Y = height / 2 - 56
	self.PostGameMessage.Width = width
end

function GameLostMenu:Draw()
	self.RestartButton:Draw()
	self.MainMenuButton:Draw()
	self.QuitButton:Draw()
	self.PostGameMessage:Draw()
end

--- Checks if any of the buttons are pressed based on the mouse position and cursor radius.
--- if a button is pressed, its associated action will be executed.
---@param PositionMouse {X: number, Y: number}
---@param CursorRadius number
---@return boolean True if any menu button was pressed, otherwise false.
function GameLostMenu:IsPressed(PositionMouse, CursorRadius)
	if self.RestartButton:IsPressed(PositionMouse, CursorRadius) then
		return true
	elseif self.MainMenuButton:IsPressed(PositionMouse, CursorRadius) then
		return true
	elseif self.QuitButton:IsPressed(PositionMouse, CursorRadius) then
		return true
	end
	return false
end

--- Handles a raw mouse press event for the menu.
---@param x number
---@param y number
---@param button number
---@return boolean True if a menu button handled the click.
function GameLostMenu:HandleMousePressed(x, y, button)
	if button ~= 1 then
		return false
	end
	return self:IsPressed({ X = x, Y = y }, 0)
end

return GameLostMenu
