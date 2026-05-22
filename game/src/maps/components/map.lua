-- Map Class represented by paths, boundaries, and team start positions/resources.
local StructureFactory = require("src.objects.structures.structureFactory")
local EntityEnums = require("src.enums.entities")
local ResourceManager = require("src.managers.resources").getInstance()
local EntityManager = require("src.managers.entities").getInstance()


---@class Map
---@field Size { width: number, height: number } -- Dimensions of the map
---@field Paths Path[] -- List of paths on the map
---@field Boundaries Boundary[] | nil -- List of boundaries on the map
---@field TeamStarts table<integer, { X: number, Y: number }> -- Start points for teams
---@field TeamResources table<integer, { Gold: number, Metal: number, Aether: number }> -- Start resources per team
---@field TeamIncomes table<integer, { Gold: number, Metal: number, Aether: number }> -- Start income per team
---@field TeamStructures {Structure: Structure, X: number, Y: number}[] | nil -- Optional initial structures for each team
local Map = {}
Map.__index = Map

-- Constructor for creating a new Map instance.
---@generic T : Map
---@param Size { width: number, height: number } -- Dimensions of the map
---@param Paths Path[] -- List of paths on the map
---@param Boundaries Boundary[] | nil -- List of boundaries on the map
---@param TeamStarts table<integer, { X: number, Y: number }> -- Start points for teams townhalls
---@param TeamResources table<integer, { Gold: number, Metal: number, Aether: number }>
---@param TeamIncomes table<integer, { Gold: number, Metal: number, Aether: number }> -- Start income per team
---@param TeamStructures {Structure: Structure, X: number, Y: number}[] | nil -- Optional initial structures for each team
---@return T
function Map:new(Size, Paths, Boundaries, TeamStarts, TeamResources, TeamIncomes, TeamStructures)
	local newMap = setmetatable({}, self)
	newMap.Size = Size or { width = 0, height = 0 }
	newMap.Boundaries = Boundaries or {}
	newMap.Paths = Paths or {}
	newMap.TeamStarts = TeamStarts or {}
	newMap.TeamResources = TeamResources or {}
	newMap.TeamIncomes = TeamIncomes or {}
	newMap.TeamStructures = TeamStructures or {}
	return newMap
end

--- Returns the starting Position of the given Player
--- @param PlayerID number
--- @return { X: number, Y: number }
function Map:getTeamStart(PlayerID)
	return self.TeamStarts[PlayerID]
end

--- Returns the starting resources of the given Player
--- @param PlayerID number
--- @return { Gold: number, Metal: number, Aether: number }
function Map:getTeamResources(PlayerID)
	return self.TeamResources[PlayerID]
end

--- Returns the starting income of the given Player
--- @param PlayerID number
--- @return { Gold: number, Metal: number, Aether: number }
function Map:getTeamIncome(PlayerID)
	return self.TeamIncomes[PlayerID]
end

--- returns the paths on the map
--- @return Path[]
function Map:GetPaths()
	return self.Paths
end

---Findes the closest path to the given coordinates
---@param x number
---@param y number
---@return Path|nil
function Map:GetClosestPath(x, y)
	local bestPath = nil
	local bestDistSq = math.huge

	for _, path in ipairs(self.Paths) do
		local closestWaypointIndex = path:GetClosestWaypointIndex(x, y)
		if closestWaypointIndex then
			local waypoint = path:GetWaypoint(closestWaypointIndex)
			if waypoint then
				local dx = waypoint.X - x
				local dy = waypoint.Y - y
				local distSq = dx * dx + dy * dy
				if distSq < bestDistSq then
					bestDistSq = distSq
					bestPath = path
				end
			end
		end
	end

	return bestPath
end

--- Adds a Path to the map
--- @param Path Path
function Map:SetPath(Path)
	table.insert(self.Paths, Path)
end

--- Adds a boundary to the map.
---@param Boundary Boundary
function Map:SetBoundary(Boundary)
	table.insert(self.Boundaries, Boundary)
end

--- Creates a fresh world by resetting units, resources, and setting up the map.
function Map:Setup()
	EntityManager:ClearAll()
	ResourceManager:ClearAll()

	for playerID, resources in pairs(self.TeamResources) do
		ResourceManager:SetPlayerResources(playerID, resources)
	end

	for playerID, income in pairs(self.TeamIncomes) do
		ResourceManager:SetPlayerIncome(playerID, income)
	end

	for playerID, startPos in pairs(self.TeamStarts) do
		local playerTownhall = StructureFactory:CreateStructure(EntityEnums.Structures.TOWNHALL, playerID)
		EntityManager:SetStructure(playerTownhall)
		playerTownhall.Position = { X = startPos.X, Y = startPos.Y }
	end

	for _, structureData in pairs(self.TeamStructures) do
		EntityManager:SetStructure(structureData.Structure)
		structureData.Structure.Position = { X = structureData.X, Y = structureData.Y }
	end
end

--- Draws Paths and Boundarys of the Map
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
