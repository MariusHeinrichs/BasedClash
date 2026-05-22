local entityManager = require("src.managers.entities").getInstance()

local DEFAULTS = {
	CellSize = 64 -- Size of each cell in the map grid, in pixels.
}

-- Singleton-Instanz
local instance = nil

--- Map grid for tracking occupied cells and facilitating structure placement.
---@class MapGrid
---@field MapSize { Width: number, Height: number } -- Size of the map in pixels.
---@field CellSize number -- Size of each cell in the map grid, in pixels.
---@field Cells table<string, boolean> -- Table of cells, where the key is "cellX:cellY" and the value indicates if the cell is occupied.
local MapGrid = {}
MapGrid.__index = MapGrid

--- Generates a unique key for a cell based on its coordinates.
---@param cellX number
---@param cellY number
---@return string
function MapGrid:GetCellKey(cellX, cellY)
	return tostring(cellX) .. ":" .. tostring(cellY)
end

--- Converts world coordinates to cell coordinates.
---@param x number -- The x-coordinate in world space.
---@param y number -- The y-coordinate in world space.
---@return number, number -- The cell coordinates (cellX, cellY).
function MapGrid:GetCellCoords(x, y)
	return math.floor(x / self.CellSize), math.floor(y / self.CellSize)
end

--- Returns the cells center coordiantes
---@param cellX number -- The x-coordinate of the cell.
---@param cellY number -- The y-coordinate of the cell.
---@return number -- The x-coordinate of the cell's center in world space.
---@return number -- The y-coordinate of the cell's center in world space.
function MapGrid:GetCellCenter(cellX, cellY)
	return (cellX + 0.5) * self.CellSize, (cellY + 0.5) * self.CellSize
end

---@param cellX number -- The x-coordinate of the cell.
---@param cellY number -- The y-coordinate of the cell.
function MapGrid:MarkCellAsOccupied(cellX, cellY)
	local key = self:GetCellKey(cellX, cellY)
	if not self.Cells[key] then
		self.Cells[key] = false
	end
	self.Cells[key] = true
end

--- Checks if a cell is occupied.
---@param cellX number -- The x-coordinate of the cell.
---@param cellY number -- The y-coordinate of the cell.
---@return boolean -- True if the cell is occupied, false otherwise.
function MapGrid:IsCellOccupied(cellX, cellY)
	local key = self:GetCellKey(cellX, cellY)
	return self.Cells[key] == true
end

--- Rebuilds the map grid by clearing existing cells and re-inserting all structures based on their current positions.
function MapGrid:Rebuild()
	local structures = entityManager:GetStructures()
	self.Cells = {}
	for _, structure in ipairs(structures) do
		local cellX, cellY = self:GetCellCoords(structure.Position.X, structure.Position.Y)
		self:MarkCellAsOccupied(cellX, cellY)
	end
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			MapSize = { Width = 1280, Height = 720 },
			CellSize = DEFAULTS.CellSize,
			Cells = {}
		}, MapGrid)
	end
	return instance
end

return {
	getInstance = getInstance
}
