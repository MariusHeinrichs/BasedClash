local Text = require("src.interfaces.components.text")

--- @class StartMenu
--- @field TitleText Text
--- @field PromptText Text
local StartMenu = {}
StartMenu.__index = StartMenu

--- Creates a new StartMenu.
---@return StartMenu
function StartMenu:new()
	local startMenu = setmetatable({}, self)
	startMenu.TitleText = Text:new("Based Clash", { X = 0, Y = 0 }, 0, { 1, 1, 1, 1 }, "center")
	startMenu.PromptText = Text:new("Press enter to start the game.", { X = 0, Y = 0 }, 0, { 1, 1, 1, 1 }, "center")
	startMenu:RebuildLayout()
	return startMenu
end

--- Recomputes text positions based on current window size.
function StartMenu:RebuildLayout()
	local width, height = love.graphics.getDimensions()
	self.TitleText.Position.X = 0
	self.TitleText.Position.Y = height / 2 - 56
	self.TitleText.Width = width

	self.PromptText.Position.X = 0
	self.PromptText.Position.Y = height / 2
	self.PromptText.Width = width
end

--- Draws start screen text.
function StartMenu:Draw()
	self.TitleText:Draw()
	self.PromptText:Draw()
end

return StartMenu
