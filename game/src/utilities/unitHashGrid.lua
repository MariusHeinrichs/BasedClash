local entityManager = require("src.managers.entities").getInstance()

local DEFAULTS = {
	CellSize = 128 -- Size of each cell in the spatial hash grid
}

-- Singleton-Instanz
local instance = nil

--- Spatial hash grid for fast entity lookups.
---@class UnitHashGrid
---@field CellSize number
---@field Cells table<string, table> -- Table of cells, each containing a list of entities
local UnitHashGrid = {}
UnitHashGrid.__index = UnitHashGrid

--- Generates a unique key for a cell based on its coordinates.
---@param cellX number
---@param cellY number
---@return string
function UnitHashGrid:GetCellKey(cellX, cellY)
	return tostring(cellX) .. ":" .. tostring(cellY)
end

--- Converts world coordinates to cell coordinates.
---@param x number -- The x-coordinate in world space.
---@param y number -- The y-coordinate in world space.
---@return number, number -- The cell coordinates (cellX, cellY).
function UnitHashGrid:GetCellCoords(x, y)
	return math.floor(x / self.CellSize), math.floor(y / self.CellSize)
end

---@param cellX number -- The x-coordinate of the cell.
---@param cellY number -- The y-coordinate of the cell.
---@param entity Object -- The entity to insert into the cell.
function UnitHashGrid:InsertCellEntity(cellX, cellY, entity)
	local key = self:GetCellKey(cellX, cellY)
	if not self.Cells[key] then
		self.Cells[key] = {}
	end
	table.insert(self.Cells[key], entity)
end

--- Rebuilds the spatial hash grid by clearing existing cells and re-inserting all entities based on their current positions.
function UnitHashGrid:Rebuild()
	self.Cells = {}
	local units = entityManager:GetUnits()
	local structures = entityManager:GetStructures()

	for _, unit in ipairs(units) do
		local cellX, cellY = self:GetCellCoords(unit.Position.X, unit.Position.Y)
		self:InsertCellEntity(cellX, cellY, unit)
	end

	for _, structure in ipairs(structures) do
		local cellX, cellY = self:GetCellCoords(structure.Position.X, structure.Position.Y)
		self:InsertCellEntity(cellX, cellY, structure)
	end
end

--- Returns the closest enemy to the given Object that passes the aggro and priority check.
--- @param Object Unit | Structure -- The unit or structure for which to find a target.
--- @return Unit | Structure | nil -- The closest enemy object that is within aggro range and meets the targeting criteria, or nil if no valid target is found.
function UnitHashGrid:FindClosestEnemyInAggroRange(Object)
	local closestEnemy = nil
	local closestDistSq = math.huge
	if not Object or not Object.Position or not Object.PlayerID or not Object.AggroRange or not Object.TargetPriority then
		return nil
	end

	local aggroRange = Object.AggroRange
	local px, py = Object.Position.X, Object.Position.Y
	local cellX, cellY = self:GetCellCoords(px, py)
	local cellsToCheck = {}

	-- Bestimme, wie viele Zellen im AggroRange liegen
	local cellRadius = math.ceil(aggroRange / self.CellSize)
	for dx = -cellRadius, cellRadius do
		for dy = -cellRadius, cellRadius do
			table.insert(cellsToCheck, self:GetCellKey(cellX + dx, cellY + dy))
		end
	end

	-- Zuerst: Suche nach Ziel mit passender TargetPriority
	for _, key in ipairs(cellsToCheck) do
		local cell = self.Cells[key]
		if cell then
			for _, entity in ipairs(cell) do
				if entity ~= Object and entity.Position and entity.PlayerID and entity.TargetPriority then
					if entity.PlayerID ~= Object.PlayerID then
						if entity.TargetPriority == Object.TargetPriority then
							local ex, ey = entity.Position.X, entity.Position.Y
							local dx, dy = ex - px, ey - py
							local distSq = dx * dx + dy * dy
							if distSq <= aggroRange * aggroRange and distSq < closestDistSq then
								closestDistSq = distSq
								closestEnemy = entity
							end
						end
					end
				end
			end
		end
	end
	-- Falls kein Ziel mit TargetPriority gefunden wurde: Suche beliebigen Gegner
	if not closestEnemy then
		closestDistSq = math.huge
		for _, key in ipairs(cellsToCheck) do
			local cell = self.Cells[key]
			if cell then
				for _, entity in ipairs(cell) do
					if entity ~= Object and entity.Position and entity.PlayerID then
						if entity.PlayerID ~= Object.PlayerID then
							local ex, ey = entity.Position.X, entity.Position.Y
							local dx, dy = ex - px, ey - py
							local distSq = dx * dx + dy * dy
							if distSq <= aggroRange * aggroRange and distSq < closestDistSq then
								closestDistSq = distSq
								closestEnemy = entity
							end
						end
					end
				end
			end
		end
	end
	return closestEnemy
end

---Returns all entities in the radius at the given position
---@param position {X: number, Y: number} -- The center position to check around, with properties X and Y.
---@param radius number -- The radius within which to search for entities.
---@return Unit[] | Structure[] -- A list of entities within the specified radius.
function UnitHashGrid:GetEntitiesInRadius(position, radius)
	local entities = {}
	local px, py = position.X, position.Y
	local cellX, cellY = self:GetCellCoords(px, py)
	local cellsToCheck = {}

	-- Determine how many cells are within the radius and add those cell keys to the list of cells to check
	local cellRadius = math.ceil(radius / self.CellSize)
	for dx = -cellRadius, cellRadius do
		for dy = -cellRadius, cellRadius do
			table.insert(cellsToCheck, self:GetCellKey(cellX + dx, cellY + dy))
		end
	end

	for _, key in ipairs(cellsToCheck) do
		local cell = self.Cells[key]
		if cell then
			for _, entity in ipairs(cell) do
				if entity.Position then
					local ex, ey = entity.Position.X, entity.Position.Y
					local dx, dy = ex - px, ey - py
					local distSq = dx * dx + dy * dy
					if distSq <= radius * radius then
						table.insert(entities, entity)
					end
				end
			end
		end
	end

	return entities
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			CellSize = DEFAULTS.CellSize,
			Cells = {}
		}, UnitHashGrid)
	end
	return instance
end

return {
	getInstance = getInstance
}
