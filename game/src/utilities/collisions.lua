local MathUtils = require("src.utilities.mathUtils")
local GridData = require("src.data.gridData").StructureHashGrid

-- Provides functions for collision detection.
local Collisions = {}

--- Returns true if two line segments intersect.
--- Segment 1: (ax, ay) to (bx, by)
--- Segment 2: (cx, cy) to (dx, dy)
---@param ax number x-start of segment 1
---@param ay number y-start of segment 1
---@param bx number x-end of segment 1
---@param by number y-end of segment 1
---@param cx number x-start of segment 2
---@param cy number y-start of segment 2
---@param dx number x-end of segment 2
---@param dy number y-end of segment 2
---@return boolean true -- if the segments intersect
function Collisions.SegmentsIntersect(ax, ay, bx, by, cx, cy, dx, dy)
	-- Two segments intersect if the endpoints are on different sides of the other segment
	local ab_cd = MathUtils.CCW(ax, ay, cx, cy, dx, dy) ~= MathUtils.CCW(bx, by, cx, cy, dx, dy)
	local cd_ab = MathUtils.CCW(ax, ay, bx, by, cx, cy) ~= MathUtils.CCW(ax, ay, bx, by, dx, dy)
	return ab_cd and cd_ab
end

---Checks if a path crosses or touches a cell (rectangle)
---@param cellCenter { X: number, Y: number } -- Center of the cell in world coordinates
---@param path Path Path object with Waypoints
---@return boolean
function Collisions.PathOnCell(cellCenter, path)
	local half = GridData.CellSize / 2
	local minX, maxX = cellCenter.X - half, cellCenter.X + half
	local minY, maxY = cellCenter.Y - half, cellCenter.Y + half

	for i = 1, #path.Waypoints - 1 do
		local a = path.Waypoints[i]
		local b = path.Waypoints[i + 1]

		-- 1. Check if either endpoint is inside the cell
		if a.X >= minX and a.X <= maxX and a.Y >= minY and a.Y <= maxY then
			return true
		end
		if b.X >= minX and b.X <= maxX and b.Y >= minY and b.Y <= maxY then
			return true
		end

		-- 2. Check if segment crosses any cell edge
		if Collisions.SegmentsIntersect(a.X, a.Y, b.X, b.Y, minX, minY, maxX, minY) then return true end -- Top
		if Collisions.SegmentsIntersect(a.X, a.Y, b.X, b.Y, minX, maxY, maxX, maxY) then return true end -- Bottom
		if Collisions.SegmentsIntersect(a.X, a.Y, b.X, b.Y, minX, minY, minX, maxY) then return true end -- Left
		if Collisions.SegmentsIntersect(a.X, a.Y, b.X, b.Y, maxX, minY, maxX, maxY) then return true end -- Right

		-- 3. Check if segment is very close to the cell (within tolerance)
		local dx = b.X - a.X
		local dy = b.Y - a.Y
		local lengthSq = dx * dx + dy * dy
		if lengthSq > 0 then
			local t = ((cellCenter.X - a.X) * dx + (cellCenter.Y - a.Y) * dy) / lengthSq
			t = MathUtils.Clamp(t, 0, 1)
			local closestX = a.X + t * dx
			local closestY = a.Y + t * dy
			local dist = MathUtils.PointRectDist(closestX, closestY, minX, minY, maxX, maxY)
			if dist <= 0 then
				return true
			end
		end
	end
	return false
end

---Checks if a point is in the given polygon
---@param point { X: number, Y: number }
---@param polygon { X: number, Y: number }[]
---@return boolean
function Collisions.PointInPolygon(point, polygon)
	local inside = false
	local j = #polygon
	for i = 1, #polygon do
		local xi, yi = polygon[i].X, polygon[i].Y
		local xj, yj = polygon[j].X, polygon[j].Y
		if ((yi > point.Y) ~= (yj > point.Y)) and
			(point.X < (xj - xi) * (point.Y - yi) / (yj - yi + 0.00001) + xi) then
			inside = not inside
		end
		j = i
	end
	return inside
end

---Checks if a point is on the given path
---@param point { X: number, Y: number }
---@param path Path
---@return boolean
function Collisions.PointOnPath(point, path)
	local onPath = false

	for i = 1, #path.Waypoints - 1 do
		local start = path.Waypoints[i]
		local endPoint = path.Waypoints[i + 1]

		local dx = endPoint.X - start.X
		local dy = endPoint.Y - start.Y
		local lengthSq = dx * dx + dy * dy

		if lengthSq > 0 then
			local t = ((point.X - start.X) * dx + (point.Y - start.Y) * dy) / lengthSq
			t = MathUtils.Clamp(t, 0, 1)

			local closestX = start.X + t * dx
			local closestY = start.Y + t * dy

			local distSq = (point.X - closestX) ^ 2 + (point.Y - closestY) ^ 2
			if distSq < 25 then -- Assuming a threshold of 5 units for being "on the path"
				onPath = true
				break
			end
		end
	end

	return onPath
end

--- Returns true if two circles overlap.
---@param ax number
---@param ay number
---@param ar number
---@param bx number
---@param by number
---@param br number
---@return boolean
function Collisions.CirclesOverlap(ax, ay, ar, bx, by, br)
	local dx = ax - bx
	local dy = ay - by
	local radiusSum = ar + br
	return (dx * dx + dy * dy) < (radiusSum * radiusSum)
end

--- Returns true if a circle intersects an axis-aligned rectangle.
---@param cx number
---@param cy number
---@param radius number
---@param rx number
---@param ry number
---@param rw number
---@param rh number
---@return boolean
function Collisions.CircleIntersectsRect(cx, cy, radius, rx, ry, rw, rh)
	local closestX = math.max(rx, math.min(cx, rx + rw))
	local closestY = math.max(ry, math.min(cy, ry + rh))
	local dx = cx - closestX
	local dy = cy - closestY
	return (dx * dx + dy * dy) < (radius * radius)
end

--- Returns true if two axis-aligned rectangles overlap.
---@param ax number
---@param ay number
---@param aw number
---@param ah number
---@param bx number
---@param by number
---@param bw number
---@param bh number
---@return boolean
function Collisions.RectsOverlap(ax, ay, aw, ah, bx, by, bw, bh)
	return ax < bx + bw and ax + aw > bx and ay < by + bh and ay + ah > by
end

return Collisions
