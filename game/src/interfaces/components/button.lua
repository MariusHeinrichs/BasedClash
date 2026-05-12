--- Button class for creating interactive UI buttons.

local DEFAULTS = {
	Name = "Button",
	Width = 100,
	Height = 50,
	Text = "Button",
	PositionButton = { X = 0, Y = 0 },
	PositionText = { X = 0, Y = 0 },
	Color = { R = 0.5, G = 0.5, B = 0.5 },
	Action = function() end,
}

---@class Button
---@field Name string
---@field Width number
---@field Height number
---@field Color {R: number, G: number, B: number}
---@field Text string
---@field PositionButton {X: number, Y: number}
---@field PositionText {X: number, Y: number}
---@field Action function
local Button = {}
Button.__index = Button

--- Creates a new Button.
---@generic T : Button
---@param Name string | nil
---@param Width number | nil
---@param Height number | nil
---@param Color {R: number, G: number, B: number} | nil
---@param Text string | nil
---@param PositionButton {X: number, Y: number} | nil
---@param PositionText {X: number, Y: number} | nil
---@param Action function | nil
---@return T
function Button:new(Name, Width, Height, Color, Text, PositionButton, PositionText, Action)
	local newButton = {}
	setmetatable(newButton, self)
	newButton.Name = Name or DEFAULTS.Name
	newButton.Action = Action or DEFAULTS.Action
	newButton.Width = Width or DEFAULTS.Width
	newButton.Height = Height or DEFAULTS.Height
	newButton.Text = Text or DEFAULTS.Text
	newButton.PositionButton = PositionButton or DEFAULTS.PositionButton
	newButton.PositionText = PositionText or DEFAULTS.PositionText
	newButton.Color = Color or DEFAULTS.Color
	return newButton
end

--- Draws the button on the screen.
function Button:Draw()
	love.graphics.setColor(self.Color.R, self.Color.G, self.Color.B)
	love.graphics.rectangle("fill", self.PositionButton.X, self.PositionButton.Y, self.Width, self.Height)
	love.graphics.setColor(1, 1, 1)
	love.graphics.printf(self.Text, self.PositionButton.X + self.PositionText.X,
		self.PositionButton.Y + self.PositionText.Y, self.Width, "center")
end

--- Checks if the button is pressed based on the mouse position and cursor radius.
--- If the button is pressed, its associated action will be executed.
---@param PositionMouse {X: number, Y: number}
---@param CursorRadius number
---@return boolean True if the button is pressed, otherwise false.
function Button:IsPressed(PositionMouse, CursorRadius)
	if PositionMouse.X + CursorRadius >= self.PositionButton.X and PositionMouse.X - CursorRadius <= self.PositionButton.X + self.Width and
		PositionMouse.Y + CursorRadius >= self.PositionButton.Y and PositionMouse.Y - CursorRadius <= self.PositionButton.Y + self.Height then
		self.Action()
		return true
	end
	return false
end

return Button
