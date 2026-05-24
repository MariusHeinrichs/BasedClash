local structureHashGrid = require("src.utilities.structureHashGrid").getInstance()
local structurePlacement = require("src.systems.structurePlacement").getInstance()

--- @class StructurePlacementHUD
--- @field FailureMessage string | nil
--- @field FailureMessageTimer number
local StructurePlacementHUD = {}
StructurePlacementHUD.__index = StructurePlacementHUD

--- Creates a new StructurePlacementHUD.
--- @return StructurePlacementHUD
function StructurePlacementHUD:new()
	local structurePlacementHud = setmetatable({}, self)
	structurePlacementHud.FailureMessage = nil
	structurePlacementHud.FailureMessageTimer = 0
	return structurePlacementHud
end

--- Sets a failure message to be displayed on the HUD for a limited time after a failed structure placement attempt.
--- @param message string
function StructurePlacementHUD:SetFailureMessage(message)
	self.FailureMessage = message
	self.FailureMessageTimer = 2 -- Display the message for 2 seconds
end

--- Update the HUD, particularly for managing the display duration of failure messages after placement attempts. Should be called every frame with the delta time since the last update.
function StructurePlacementHUD:Update(dt)
	if self.FailureMessage then
		self.FailureMessageTimer = self.FailureMessageTimer - dt
		if self.FailureMessageTimer <= 0 then
			self.FailureMessage = nil
			self.FailureMessageTimer = 0
		end
	end
end

--- Draws the grid overlay for structure placement.
function StructurePlacementHUD:Draw()
	if not structureHashGrid then
		return
	end

	structureHashGrid:Rebuild() -- Ensure the structure hash grid is up to date before drawing.

	if self.FailureMessage and self.FailureMessageTimer > 0 then
		local width = love.graphics.getDimensions()
		love.graphics.setColor(1, 0.3, 0.3, 1)
		love.graphics.printf(self.FailureMessage, 0, 36, width, "center")
		love.graphics.setColor(1, 1, 1, 1)
	end

	-- we need to check if the user has selected a structure type to place before drawing the grid
	if not structurePlacement.SelectedStructureType then
		return
	end
	local mapSize = structureHashGrid.MapSize
	local cellSize = structureHashGrid.CellSize

	local cols = math.ceil(mapSize.Width / cellSize)
	local rows = math.ceil(mapSize.Height / cellSize)

	for x = 0, cols - 1 do
		for y = 0, rows - 1 do
			local cellX = x * cellSize
			local cellY = y * cellSize
			if structureHashGrid:IsCellAvailable(cellX, cellY) then
				love.graphics.setColor(1, 1, 0, 0.25)
			else
				love.graphics.setColor(1, 0, 0, 0.5)
			end
			love.graphics.rectangle("line", cellX, cellY, cellSize, cellSize)
		end
	end
	love.graphics.setColor(1, 1, 1, 1)
end

--- Handles a MousePressed Event
--- @param x number mouse x position
--- @param y number mouse y position
--- @param button number mouse button pressed
function StructurePlacementHUD:HandleMousePressed(x, y, button)
	if structurePlacement.SelectedStructureType then
		if button == 1 then
			-- Left mouse button: Place structure at the clicked position.
			local failureMessage = structurePlacement:PlaceStructure({ X = x, Y = y }, 1)
			if failureMessage then
				self:SetFailureMessage(failureMessage)
			end
		elseif button == 2 then
			-- Right mouse button: Cancel structure placement.
			structurePlacement:CancelPlacement()
		end
	end
end

return StructurePlacementHUD
