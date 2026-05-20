-- Map Class represented by paths, boundaries, and team start positions/resources.
local StructureFactory = require("src.objects.structures.structureFactory")
local EntityEnums = require("src.enums.entities")
local ResourceManager = require("src.managers.resources").getInstance()
local EntityManager = require("src.managers.entities").getInstance()


---@class Map
---@field Size { width: number, height: number } -- Dimensions of the map
---@field Paths Path[] -- List of paths on the map
---@field Boundaries Boundary[] -- List of boundaries on the map
---@field TeamStarts table<integer, { X: number, Y: number }> -- Start points for teams
---@field TeamResources table<integer, { Gold: number, Metal: number, Aether: number }> -- Start resources per team
local Map = {}
Map.__index = Map

-- Constructor for creating a new Map instance.
---@generic T : Map
---@param Size { width: number, height: number } -- Dimensions of the map
---@param Paths Path[] -- List of paths on the map
---@param Boundaries Boundary[] -- List of boundaries on the map
---@param TeamStarts table<integer, { X: number, Y: number }>
---@param TeamResources table<integer, { Gold: number, Metal: number, Aether: number }>
---@return T
function Map:new(Size, Paths, Boundaries, TeamStarts, TeamResources)
	local newMap = setmetatable({}, self)
	newMap.Size = Size or { width = 0, height = 0 }
	newMap.Boundaries = Boundaries or {}
	newMap.Paths = Paths or {}
	newMap.TeamStarts = TeamStarts or {}
	newMap.TeamResources = TeamResources or {}
	return newMap
end

-- Beispielmethode: Gibt die Startposition eines Teams zurück
function Map:getTeamStart(PlayerID)
	return self.TeamStarts[PlayerID]
end

-- Beispielmethode: Gibt die Startressourcen eines Teams zurück
function Map:getTeamResources(PlayerID)
	return self.TeamResources[PlayerID]
end

-- Beispielmethode: Fügt einen neuen Pfad hinzu
function Map:addPath(Path)
	table.insert(self.Paths, Path)
end

-- Beispielmethode: Fügt eine neue Grenze hinzu
function Map:addBoundary(Boundary)
	table.insert(self.Boundaries, Boundary)
end


--- Creates a fresh world by resetting units, resources, and setting up the map.
function Map:Setup()
	EntityManager:ClearAll()
	ResourceManager:ClearAll()

	for playerID, resources in pairs(self.TeamResources) do
		ResourceManager:SetPlayerResources(playerID, resources)
	end

	for playerID, startPos in pairs(self.TeamStarts) do
		local playerTownhall = StructureFactory:CreateStructure(EntityEnums.Structures.TOWNHALL, playerID)
		EntityManager:SetStructure(playerTownhall)
		playerTownhall.Position = { X = startPos.X, Y = startPos.Y }
	end
end

function Map:Draw()
	for _, boundary in ipairs(self.Boundaries) do
		boundary:Draw()
	end

	for _, path in ipairs(self.Paths) do
		path:Draw()
	end

	love.graphics.setColor(1, 1, 1) -- Farbe zurücksetzen
end

return Map
