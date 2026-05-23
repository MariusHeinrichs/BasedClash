--- The default map for the game, containing basic paths, boundaries, and team start positions/resources.
local Map = require("src.maps.components.map")
local Path = require("src.maps.components.path")
local Boundary = require("src.maps.components.boundary")
local StructureFactory = require("src.objects.structures.structureFactory")
local EntityEnums = require("src.enums.entities")
local GridData = require("src.data.gridData").StructureHashGrid

---@class DefaultMap : Map
local defaultMap = {}

--- Creates and returns the default map instance.
--- @return DefaultMap
function defaultMap:new()
	local path = Path:new("mainPath", {
		{ X = 100, Y = 100 },
		{ X = 300, Y = 100 },
		{ X = 300, Y = 300 },
		{ X = 500, Y = 300 }
	})

	local boundary = Boundary:new({
		{ X = 200, Y = 200 },
		{ X = 400, Y = 200 },
		{ X = 400, Y = 400 },
		{ X = 200, Y = 400 }
	}, true, true)

	local teamStarts = {
		[1] = { X = GridData.CellSize / 2, Y = GridData.CellSize / 2 },
		[2] = { X = GridData.CellSize * 9 - GridData.CellSize / 2 , Y = GridData.CellSize * 6 - GridData.CellSize / 2 }
	}
	local teamResources = {
		[1] = { Gold = 1000, Metal = 500, Aether = 200 },
		[2] = { Gold = 1000, Metal = 500, Aether = 200 }
	}
	local teamIncomes = {
		[1] = { Gold = 10, Metal = 5, Aether = 0 },
		[2] = { Gold = 10, Metal = 5, Aether = 0 }
	}
	local teamStructures = {
		{ Structure = StructureFactory:CreateStructure(EntityEnums.Structures.CASTLE, 2),  X = GridData.CellSize * 9 - GridData.CellSize / 2, Y = GridData.CellSize * 5 - GridData.CellSize / 2 },
		{ Structure = StructureFactory:CreateStructure(EntityEnums.Structures.LIBRARY, 2), X = GridData.CellSize * 9 - GridData.CellSize / 2, Y = GridData.CellSize * 8 - GridData.CellSize / 2 },
		{ Structure = StructureFactory:CreateStructure(EntityEnums.Structures.LOOKOUT, 2), X = GridData.CellSize * 9 - GridData.CellSize / 2, Y = GridData.CellSize * 7 - GridData.CellSize / 2 }
	}
	local buildZones = {
		[1] = {
			{ X = 0, Y = 0 },
			{ X = 0, Y = GridData.CellSize * 5 },
			{ X = GridData.CellSize * 5, Y = GridData.CellSize * 5 },
			{ X = GridData.CellSize * 5, Y = 0 }
		},
		[2] = {
			{ X = 550, Y = 300 },
			{ X = 550, Y = 600 },
			{ X = 800, Y = 600 },
			{ X = 800, Y = 300 }
		}
	}
	return Map:new({ width = 800, height = 600 }, buildZones, { path }, { boundary }, teamStarts, teamResources, teamIncomes,
	teamStructures)
end

return defaultMap
