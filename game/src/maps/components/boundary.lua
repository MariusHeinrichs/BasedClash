--- Static map boundary definition used for movement and placement blocking.

---@class Boundary
---@field Polygon { X: number, Y: number }[] -- List of points defining the boundary polygon
---@field BlocksMovement boolean -- Whether this boundary blocks movement
---@field BlocksPlacement boolean -- Whether this boundary blocks building placement
local Boundary = {}
Boundary.__index = Boundary

--- Creates a new Boundary.
---@param Polygon { X: number, Y: number }[] -- Array of points
---@param BlocksMovement boolean | nil
---@param BlocksPlacement boolean | nil
---@return Boundary
function Boundary:new(Polygon, BlocksMovement, BlocksPlacement)
	local boundary = {
		Polygon = Polygon,
		BlocksMovement = BlocksMovement ~= false,
		BlocksPlacement = BlocksPlacement ~= false
	}
	return setmetatable(boundary, self)
end

--- Draws the boundary.
function Boundary:Draw()
	love.graphics.setColor(1, 0, 0, 0.5)
	local points = {}
	for _, vertex in ipairs(self.Polygon) do
		table.insert(points, vertex.X)
		table.insert(points, vertex.Y)
	end
	love.graphics.polygon("fill", points)
	love.graphics.setColor(1, 1, 1)
end

return Boundary
