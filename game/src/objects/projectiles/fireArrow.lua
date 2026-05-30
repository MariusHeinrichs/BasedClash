--- FireArrow class, represents a fire arrow projectile in the game.

local Projectile = require("src.objects.projectiles.projectile")
local ProjectileStats = require("src.data.projectileStats").FireArrow

--- @class FireArrow : Projectile
local FireArrow = {}
FireArrow.__index = FireArrow
FireArrow.__type = "FireArrow"

setmetatable(FireArrow, { __index = Projectile })

--- Creates a new FireArrow.
--- @param Source Unit | Structure | nil -- The source unit or structure that fired the arrow.
--- @param Target Unit | Structure | nil -- The target unit or structure that the arrow is aimed at.
--- @return FireArrow
function FireArrow:new(Source, Target)
	local newArrow = Projectile.new(self,
		"FireArrow",
		ProjectileStats.Velocity,
		ProjectileStats.Damage,
		ProjectileStats.DamageType,
		ProjectileStats.SplashRadius,
		ProjectileStats.SplashDamageMultiplier,
		ProjectileStats.DoTDamage,
		ProjectileStats.DoTDuration,
		ProjectileStats.DoTTickInterval,
		Source,
		Target
	)
	return newArrow
end

function FireArrow:Draw()
	local x, y = self.Position.X, self.Position.Y
	local dx = self.Velocity
	local dy = self.Velocity
	local len = math.sqrt(dx * dx + dy * dy)
	if len < 0.001 then
		dx, dy = 1, 0
		len = 1
	end
	local ux, uy = dx / len, dy / len
	local px, py = -uy, ux
	local shaft = 2.5 * 3.0
	local wing = 3 * 0.9

	love.graphics.line(x - ux * shaft * 0.5, y - uy * shaft * 0.5, x + ux * shaft * 0.5, y + uy * shaft * 0.5)
	love.graphics.setColor(1, 0.5, 0, 1) -- Orange color for fire arrow
	love.graphics.polygon(
		"fill",
		x + ux * shaft * 0.5,
		y + uy * shaft * 0.5,
		x + px * wing,
		y + py * wing,
		x - px * wing,
		y - py * wing
	)
	love.graphics.setColor(1, 1, 1) -- Reset color
end

return FireArrow
