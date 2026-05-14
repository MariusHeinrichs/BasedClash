--- start menu interface.

local Text = require("src.interfaces.components.text")

--- @class StartInterface
--- @field TitleText Text
--- @field PromptText Text
local StartInterface = {}
StartInterface.__index = StartInterface

--- Creates a new StartInterface table.
---@return StartInterface
function StartInterface:new()
	local startInterface = setmetatable({}, self)
	startInterface.TitleText = Text:new("Based Clash", { X = 0, Y = 0 }, 0, { 1, 1, 1, 1 }, "center")
	startInterface.PromptText = Text:new("Press enter to start the game.", { X = 0, Y = 0 }, 0, { 1, 1, 1, 1 }, "center")
	startInterface:RebuildLayout()
	return startInterface
end

--- Recomputes text positions based on current window size.
function StartInterface:RebuildLayout()
	local width, height = love.graphics.getDimensions()
	self.TitleText.Position.X = 0
	self.TitleText.Position.Y = height / 2 - 56
	self.TitleText.Width = width

	self.PromptText.Position.X = 0
	self.PromptText.Position.Y = height / 2
	self.PromptText.Width = width
end

--- Draws start screen text.
function StartInterface:Draw()
	self.TitleText:Draw()
	self.PromptText:Draw()
end

return StartInterface
