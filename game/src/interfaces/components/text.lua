--- Text class for creating UI text.

local DEFAULTS = {
	Content = "",
	Position = { X = 0, Y = 0 },
	Width = 0,
	Color = { R = 1, G = 1, B = 1, A = 1 },
	Align = "left",
}

---@class Text
---@field Content string
---@field Position {X: number, Y: number}
---@field Width number
---@field Color {R: number, G: number, B: number, A: number}
---@field Align "left" | "center" | "right" | "justify"
local Text = {}
Text.__index = Text

--- Creates a new Text object.
---@generic T : Text
---@param content string | nil
---@param position {X: number, Y: number} | nil
---@param width number | nil
---@param color {R: number, G: number, B: number, A: number} | nil
---@param align "left" | "center" | "right" | "justify" | nil
---@return T
function Text:new(content, position, width, color, align)
	local text = setmetatable({}, self)
	text.Content = content or DEFAULTS.Content
	text.Position = position or DEFAULTS.Position
	text.Width = width or DEFAULTS.Width
	text.Color = color or DEFAULTS.Color
	text.Align = align or DEFAULTS.Align
	return text
end

--- Draws the text using its current properties.
function Text:Draw()
	love.graphics.setColor(self.Color.R, self.Color.G, self.Color.B, self.Color.A)
	love.graphics.printf(self.Content, self.Position.X, self.Position.Y, self.Width, self.Align)
	love.graphics.setColor(1, 1, 1, 1)
end

return Text
