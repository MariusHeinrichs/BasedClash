local structureHashGrid = require("src.utilities.structureHashGrid").getInstance()
local structurePlacement = require("src.systems.structurePlacement").getInstance()

--- @class StructurePlacementHUD
local StructurePlacementHUD = {}
StructurePlacementHUD.__index = StructurePlacementHUD

--- Creates a new StructurePlacementHUD.
--- @return StructurePlacementHUD
function StructurePlacementHUD:new()
	local structurePlacementHud = setmetatable({}, self)
	return structurePlacementHud
end

--- Draws the grid overlay for structure placement.
function StructurePlacementHUD:Draw()
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
			if structureHashGrid:IsCellOccupied(cellX, cellY) then
				love.graphics.setColor(1, 0, 0, 0.5)
			else
				love.graphics.setColor(1, 1, 0, 0.25)
			end
			love.graphics.rectangle("line", cellX, cellY, cellSize, cellSize)
		end
	end
	love.graphics.setColor(1, 1, 1, 1)
end

return StructurePlacementHUD
