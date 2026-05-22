local entityManager = require("src.managers.entities").getInstance()

local DEFAULTS = {
	MapSize = { Width = 1280, Height = 720 },
	CellSize = 64 -- Size of each cell in the map grid, in pixels.
}

-- Singleton-Instanz
local instance = nil

--- Structure grid for tracking occupied cells and facilitating structure placement.
---@class StructureHashGrid
---@field MapSize { Width: number, Height: number } -- Size of the map in pixels.
---@field CellSize number -- Size of each cell in the map grid, in pixels.
---@field Cells table<string, boolean> -- Table of cells, where the key is "cellX:cellY" and the value indicates if the cell is occupied.
local StructureHashGrid = {}
StructureHashGrid.__index = StructureHashGrid

--- Generates a unique key for a cell based on its coordinates.
---@param CellX number
---@param CellY number
---@return string
function StructureHashGrid:GetCellKey(CellX, CellY)
	return tostring(CellX) .. ":" .. tostring(CellY)
end

--- Converts world coordinates to cell coordinates.
---@param X number -- The x-coordinate in world space.
---@param Y number -- The y-coordinate in world space.
---@return number, number -- The cell coordinates (cellX, cellY).
function StructureHashGrid:GetCellCoords(X, Y)
	return math.floor(X / self.CellSize), math.floor(Y / self.CellSize)
end

--- Returns the cells center coordiantes
---@param X number -- The x-coordinate in world space.
---@param Y number -- The y-coordinate in world space.
---@return number -- The x-coordinate of the cell's center in world space.
---@return number -- The y-coordinate of the cell's center in world space.
function StructureHashGrid:GetCellCenter(X, Y)
	local cellX, cellY = self:GetCellCoords(X, Y)
	return (cellX + 0.5) * self.CellSize, (cellY + 0.5) * self.CellSize
end

---Sets the Map Size the hash grid will represent
---@param Width number
---@param Height number
function StructureHashGrid:SetMapSize(Width, Height)
	self.MapSize = { Width = Width, Height = Height }
end

---@param X number -- The x-coordinate in world space.
---@param Y number -- The y-coordinate in world space.
function StructureHashGrid:MarkCellAsOccupied(X, Y)
	local cellX, cellY = self:GetCellCoords(X, Y)
	local key = self:GetCellKey(cellX, cellY)
	if not self.Cells[key] then
		self.Cells[key] = false
	end
	self.Cells[key] = true
end

--- Checks if a cell is occupied, meaning a structure is present or it is outside the map boundaries.
---@param X number -- The x-coordinate in world space.
---@param Y number -- The y-coordinate in world space.
---@return boolean -- True if the cell is occupied, false otherwise.
function StructureHashGrid:IsCellOccupied(X, Y)
	local cellX, cellY = self:GetCellCoords(X, Y)
	local key = self:GetCellKey(cellX, cellY)
	-- Check if the cell is outside the map boundaries
	if cellX < 0 or cellY < 0 or cellX >= self.MapSize.Width / self.CellSize or cellY >= self.MapSize.Height / self.CellSize then
		return true
	end
	return self.Cells[key] == true
end

--- Rebuilds the map grid by clearing existing cells and re-inserting all structures based on their current positions.
function StructureHashGrid:Rebuild()
	local structures = entityManager:GetStructures()
	self.Cells = {}
	for _, structure in ipairs(structures) do
		self:MarkCellAsOccupied(structure.Position.X, structure.Position.Y)
	end
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			MapSize = DEFAULTS.MapSize,
			CellSize = DEFAULTS.CellSize,
			Cells = {}
		}, StructureHashGrid)
	end
	return instance
end

return {
	getInstance = getInstance
}
