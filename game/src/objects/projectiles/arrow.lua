--- Arrow class, represents an arrow projectile in the game.

local Projectile = require("src.objects.projectiles.projectile")
local ProjectileStats = require("src.data.projectileStats").Arrow

--- @class Arrow : Projectile
local Arrow = {}
Arrow.__index = Arrow

setmetatable(Arrow, { __index = Projectile })

--- Creates a new Arrow.
--- @param Source Unit | Structure | nil -- The source unit or structure that fired the arrow.
--- @param Target Unit | Structure | nil -- The target unit or structure that the arrow is aimed at.
--- @return Arrow
function Arrow:new(Source, Target)
	local newArrow = Projectile.new(self,
		"Arrow",
		ProjectileStats.Velocity,
		ProjectileStats.Damage,
		ProjectileStats.DamageType,
		ProjectileStats.SplashRadius,
		ProjectileStats.SplashDamageMultiplier,
		Source,
		Target
	)
	return newArrow
end

function Arrow:Draw()
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
	local wing = 2.5 * 0.9

	love.graphics.line(x - ux * shaft * 0.5, y - uy * shaft * 0.5, x + ux * shaft * 0.5, y + uy * shaft * 0.5)
	love.graphics.polygon(
		"fill",
		x + ux * shaft * 0.5,
		y + uy * shaft * 0.5,
		x + px * wing,
		y + py * wing,
		x - px * wing,
		y - py * wing
	)
end

return Arrow
