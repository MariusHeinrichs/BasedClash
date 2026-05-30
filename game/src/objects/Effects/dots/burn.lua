--- Class representing the burn DoT effect.

local DamageOverTime = require("src.objects.effects.dots.dot")
local DotStats = require("src.data.dotStats").Burn

---@class Burn : DamageOverTime
local Burn = setmetatable({}, { __index = DamageOverTime })
Burn.__index = Burn
Burn.__type = "Burn"

--- Creates a new Burn effect.
---@return Burn
function Burn:new()
	local newBurn = DamageOverTime.new(self, DotStats.DoTDamage, DotStats.DoTDuration, DotStats.DoTTickInterval)
	return newBurn
end

function Burn:Draw()
	if not self.Target or not self.Target.Position then return end
	local x, y = self.Target.Position.X, self.Target.Position.Y
	local size = self.Target.Size or 10

	local colors = {
		{ 1, 0.5, 0 },
		{ 1, 0.2, 0 },
		{ 1, 1,   0 },
	}

	for i = 1, 5 do
		local angle = math.rad((i - 1) * 72)
		local radius = size * 0.7 + math.random() * size * 0.3
		local fx = x + math.cos(angle) * radius
		local fy = y + math.sin(angle) * radius - math.random() * 5

		local color = colors[math.random(#colors)]
		love.graphics.setColor(color[1], color[2], color[3], 0.8)
		love.graphics.circle("fill", fx, fy, size * 0.2 + math.random() * size * 0.1)
	end

	love.graphics.setColor(1, 1, 1, 1) -- Reset color
end

return Burn
