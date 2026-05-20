--- Path graph represented by ordered waypoints for one lane.

---@class Path
---@field Id string -- Unique identifier for the path graph
---@field Waypoints { X: number, Y: number }[] -- List of waypoints, each with X and Y coordinates
local Path = {}
Path.__index = Path


--- Creates a new Path.
---@param Id string | nil
---@param Waypoints { X: number, Y: number }[] | nil
---@return Path
function Path:new(Id, Waypoints)
	return setmetatable({
		Id = Id or "path",
		Waypoints = Waypoints or {},
	}, self)
end

--- Adds a waypoint to the path.
---@param x number
---@param y number
function Path:AddWaypoint(x, y)
	table.insert(self.Waypoints, { X = x, Y = y })
end

--- Returns the list of waypoints for the path.
---@return table
function Path:GetWaypoints()
	return self.Waypoints
end

--- Returns the index of the closest waypoint to the given coordinates.
---@param x number
---@param y number
---@return number | nil
function Path:GetClosestWaypointIndex(x, y)
	if #self.Waypoints == 0 then
		return nil
	end

	local bestIndex = 1
	local bestDistSq = math.huge
	for i, waypoint in ipairs(self.Waypoints) do
		local dx = waypoint.X - x
		local dy = waypoint.Y - y
		local distSq = dx * dx + dy * dy
		if distSq < bestDistSq then
			bestDistSq = distSq
			bestIndex = i
		end
	end

	return bestIndex
end

--- Returns the waypoint at the given index.
---@param index number
---@return table | nil
function Path:GetWaypoint(index)
	return self.Waypoints[index]
end

--- Draws the path graph.
function Path:Draw()
	if #self.Waypoints == 0 then
		return
	end

	love.graphics.setColor(0, 1, 0, 0.5)
	local points = {}
	for _, waypoint in ipairs(self.Waypoints) do
		table.insert(points, waypoint.X)
		table.insert(points, waypoint.Y)
	end
	love.graphics.line(points)
	love.graphics.setColor(1, 1, 1)
end

return Path
