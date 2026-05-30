--- Factory for creating damage over time (DoT) effects.
local Burn = require("src.objects.Effects.dots.burn")
local DoTEnums = require("src.enums.dots")

local DoTFactory = {}

--- Creates a DoT effect based on the specified DoT type.
---@param dotType DoTEnums.DoTTypes
---@return DamageOverTime | nil
function DoTFactory.CreateDoT(dotType)
	if dotType == DoTEnums.DoTTypes.BURN then
		return Burn:new()
	else
		return nil -- Return nil if the DoT type is not recognized
	end
end

return DoTFactory
