--- Factory for creating structures.

local ArcherCamp = require("src.objects.structures.spawningStructures.archercamp")
local Library = require("src.objects.structures.spawningStructures.library")
local BarbarianCamp = require("src.objects.structures.spawningStructures.barbarianCamp")
local Castle = require("src.objects.structures.spawningStructures.castle")

local EntityEnums = require("src.enums.entities")

local StructureFactory = {}

--- Creates a Structure
---@param structureType EntityEnums.Structures
---@param playerID number
---@return Structure
function StructureFactory:CreateStructure(structureType, playerID)
	if structureType == EntityEnums.Structures.ARCHER_CAMP then
		return ArcherCamp:new(playerID)
	elseif structureType == EntityEnums.Structures.LIBRARY then
		return Library:new(playerID)
	elseif structureType == EntityEnums.Structures.BARBARIAN_CAMP then
		return BarbarianCamp:new(playerID)
	elseif structureType == EntityEnums.Structures.CASTLE then
		return Castle:new(playerID)
	else
		error("Unknown structure type: " .. tostring(structureType))
	end
end

return StructureFactory
