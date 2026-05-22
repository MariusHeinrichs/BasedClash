--- The default map for the game, containing basic paths, boundaries, and team start positions/resources.
local Map = require("src.maps.components.map")
local Path = require("src.maps.components.path")
local Boundary = require("src.maps.components.boundary")
local StructureFactory = require("src.objects.structures.structureFactory")
local EntityEnums = require("src.enums.entities")

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
		[1] = { X = 50, Y = 50 },
		[2] = { X = 550, Y = 350 }
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
		{ Structure = StructureFactory:CreateStructure(EntityEnums.Structures.CASTLE, 2),  X = 550, Y = 300 },
		{ Structure = StructureFactory:CreateStructure(EntityEnums.Structures.LIBRARY, 2), X = 550, Y = 400 }
	}
	return Map:new({ width = 800, height = 600 }, { path }, { boundary }, teamStarts, teamResources, teamIncomes,
	teamStructures)
end

return defaultMap
