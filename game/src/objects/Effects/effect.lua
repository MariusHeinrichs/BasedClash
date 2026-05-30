 --- Effect class, representing an effect applied to a unit.
---@class Effect
---@field Target Unit | Structure | nil
local Effect = {}
Effect.__index = Effect
Effect.__type = "Effect"

--- Creates a new Effect.
---@generic T : Effect
---@param self T
---@param Target Unit | Structure | nil
---@return T
function Effect:new(Target)
	local newEffect = setmetatable({}, self)
	newEffect.Target = Target
	return newEffect
end

--- Updates the effect
--- @param dt number
function Effect:Update(dt)
end

--- Draws the effect
function Effect:Draw()
end

return Effect
