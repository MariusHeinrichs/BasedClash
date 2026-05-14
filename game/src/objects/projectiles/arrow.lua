--- Arrow class, represents an arrow projectile in the game.

local Projectile = require("src.objects.projectiles.projectile")

--- @class Arrow : Projectile
local Arrow = {}
Arrow.__index = Arrow

setmetatable(Arrow, { __index = Projectile })

--- Creates a new Arrow.
--- @param Name string | nil
--- @param Velocity {X: number, Y: number} | nil
--- @param Source Unit | Structure | nil
--- @param Target Unit | Structure | nil
--- @param SplashRadius number | nil
--- @param SplashDamageMultiplier number | nil
--- @return Arrow
function Arrow:new(Name, Velocity, Source, Target, SplashRadius, SplashDamageMultiplier)
	local newArrow = Projectile.new(self, Name or "Arrow", Velocity, Source, Target, SplashRadius, SplashDamageMultiplier)
	return newArrow
end

function Arrow:Draw()
	local x, y = self.Position.X, self.Position.Y
	local dx = self.Velocity.X
	local dy = self.Velocity.Y
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
