local Button = require("src.interfaces.components.button")

local StructurePlacement = require("src.systems.structurePlacement").getInstance()
local EntityEnums = require("src.enums.entities")

local BASE_BUTTON_WIDTH = 200
local BASE_BUTTON_HEIGHT = 50
local BASE_SPACING_X = 20
local BASE_BOTTOM_MARGIN = 24

local function onBarbarianPressed()
	StructurePlacement:SetSelectedStructureType(EntityEnums.Structures.BARBARIAN_CAMP)
end

local function onKnightPressed()
	StructurePlacement:SetSelectedStructureType(EntityEnums.Structures.CASTLE)
end

local function onArcherPressed()
	StructurePlacement:SetSelectedStructureType(EntityEnums.Structures.ARCHER_CAMP)
end

local function onMagePressed()
	StructurePlacement:SetSelectedStructureType(EntityEnums.Structures.LIBRARY)
end

--- battle menu interface.
--- @class BattleMenu
--- @field BarbarianButton Button
--- @field KnightButton Button
--- @field ArcherButton Button
--- @field MageButton Button
local BattleMenu = {}
BattleMenu.__index = BattleMenu

--- Creates a new BattleMenu.
--- @returns BattleMenu
function BattleMenu:new()
	local battleMenu = setmetatable({}, self)

	local definitions = {
		{ key = "BarbarianButton", name = "Barbarian", text = "Barbarian", action = onBarbarianPressed },
		{ key = "KnightButton",    name = "Knight",    text = "Knight",    action = onKnightPressed },
		{ key = "ArcherButton",    name = "Archer",    text = "Archer",    action = onArcherPressed },
		{ key = "MageButton",      name = "Mage",      text = "Mage",      action = onMagePressed },
	}

	for index, definition in ipairs(definitions) do
		battleMenu[definition.key] = Button:new(
			definition.name,
			BASE_BUTTON_WIDTH,
			BASE_BUTTON_HEIGHT,
			{ R = 0.5, G = 0.5, B = 0.5 },
			definition.text or "placeholder_text",
			{ X = 0, Y = 0 },
			{ X = 0, Y = 15 },
			definition.action or function() end
		)
	end

	battleMenu:RebuildLayout()

	return battleMenu
end

function BattleMenu:RebuildLayout()
	local width, height = love.graphics.getDimensions()
	local scale = math.min(width / 1280, height / 720)
	scale = math.max(0.75, math.min(1.6, scale))

	local buttonWidth = math.floor(BASE_BUTTON_WIDTH * scale + 0.5)
	local buttonHeight = math.floor(BASE_BUTTON_HEIGHT * scale + 0.5)
	local spacingX = math.floor(BASE_SPACING_X * scale + 0.5)
	local bottomMargin = math.floor(BASE_BOTTOM_MARGIN * scale + 0.5)

	local buttonCount = 4
	local totalWidth = buttonCount * buttonWidth + (buttonCount - 1) * spacingX
	local startX = (width - totalWidth) / 2
	local y = height - buttonHeight - bottomMargin
	local textOffsetY = math.floor(buttonHeight * 0.3 + 0.5)

	self.BarbarianButton.Width = buttonWidth
	self.BarbarianButton.Height = buttonHeight
	self.BarbarianButton.PositionText.Y = textOffsetY

	self.BarbarianButton.PositionButton.X = startX
	self.BarbarianButton.PositionButton.Y = y

	self.KnightButton.Width = buttonWidth
	self.KnightButton.Height = buttonHeight
	self.KnightButton.PositionText.Y = textOffsetY

	self.KnightButton.PositionButton.X = startX + (buttonWidth + spacingX)
	self.KnightButton.PositionButton.Y = y

	self.ArcherButton.Width = buttonWidth
	self.ArcherButton.Height = buttonHeight
	self.ArcherButton.PositionText.Y = textOffsetY

	self.ArcherButton.PositionButton.X = startX + (2 * (buttonWidth + spacingX))
	self.ArcherButton.PositionButton.Y = y

	self.MageButton.Width = buttonWidth
	self.MageButton.Height = buttonHeight
	self.MageButton.PositionText.Y = textOffsetY

	self.MageButton.PositionButton.X = startX + (3 * (buttonWidth + spacingX))
	self.MageButton.PositionButton.Y = y
end

--- Draws the BattleMenu
function BattleMenu:Draw()
	self.BarbarianButton:Draw()
	self.KnightButton:Draw()
	self.ArcherButton:Draw()
	self.MageButton:Draw()
end

--- Checks if any of the buttons are pressed based on the mouse position and cursor radius.
--- if a button is pressed, its associated action will be executed.
---@param PositionMouse {X: number, Y: number}
---@param CursorRadius number
function BattleMenu:IsPressed(PositionMouse, CursorRadius)
	if self.BarbarianButton:IsPressed(PositionMouse, CursorRadius) then
		return true
	elseif self.KnightButton:IsPressed(PositionMouse, CursorRadius) then
		return true
	elseif self.ArcherButton:IsPressed(PositionMouse, CursorRadius) then
		return true
	elseif self.MageButton:IsPressed(PositionMouse, CursorRadius) then
		return true
	end
	return false
end

--- Handles a raw mouse press event.
---@param x number
---@param y number
---@param button number
---@return boolean True if a menu button handled the click.
function BattleMenu:HandleMousePressed(x, y, button)
	if button ~= 1 then
		return false
	end
	return self:IsPressed({ X = x, Y = y }, 0)
end

return BattleMenu
