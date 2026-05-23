-- Provides utility functions for mathematical operations.

local MathUtils = {}

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

---Checks if a point is in the given polygon
---@param point { X: number, Y: number }
---@param polygon { X: number, Y: number }[] 
---@return boolean
function MathUtils.PointInPolygon(point, polygon)
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

return MathUtils
