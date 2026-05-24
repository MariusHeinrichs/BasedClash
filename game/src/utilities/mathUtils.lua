-- Provides utility functions for mathematical operations.
local MathUtils = {}

---Calculates the minimum distance from a point to a rectangle.
---@param px number x-coordinate of the point
---@param py number y-coordinate of the point
---@param minX number left boundary of the rectangle
---@param minY number top boundary of the rectangle
---@param maxX number right boundary of the rectangle
---@param maxY number bottom boundary of the rectangle
---@return number minimum distance
function MathUtils.PointRectDist(px, py, minX, minY, maxX, maxY)
	local dx = math.max(minX - px, 0, px - maxX)
	local dy = math.max(minY - py, 0, py - maxY)
	return math.sqrt(dx * dx + dy * dy)
end

--- Checks if three points are in counter-clockwise order.
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param x3 number
---@param y3 number
---@return boolean
function MathUtils.CCW(x1, y1, x2, y2, x3, y3)
	return (y3 - y1) * (x2 - x1) > (y2 - y1) * (x3 - x1)
end

---@param x number
---@param y number
---@return number, number
function MathUtils.Normalize(x, y)
	local len = math.sqrt(x * x + y * y)
	if len <= 0 then
		return 0, 0
	end
	return x / len, y / len
end

---@param value number
---@param minValue number
---@param maxValue number
---@return number
function MathUtils.Clamp(value, minValue, maxValue)
	if value < minValue then
		return minValue
	end
	if value > maxValue then
		return maxValue
	end
	return value
end

return MathUtils
