--- Base Object class for all objects that will be rendered in the game.

local DEFAULTS = {
	Name = "Object",
	Position = { X = 0, Y = 0 },
}

---@class Object
---@field Name string
---@field Position {X: number, Y: number}
local Object = {}
Object.__index = Object

--- Creates a new Object.
---@generic T : Object
---@param self T
---@param Name string | nil
---@return T
function Object:new(Name)
	local newObj = {}
	setmetatable(newObj, self)
	newObj.Name = Name or DEFAULTS.Name
	newObj.Position = { X = DEFAULTS.Position.X, Y = DEFAULTS.Position.Y }
	return newObj
end

--- Sets the current location of the Object.
---@param Position {X: number, Y: number}
function Object:SetPosition(Position)
	if Position.X then
		self.Position.X = Position.X
	end
	if Position.Y then
		self.Position.Y = Position.Y
	end
end

function Object:Draw()
	-- Base draw method, can be overridden by subclasses
end

return Object
