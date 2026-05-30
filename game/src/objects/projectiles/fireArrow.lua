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
		ProjectileStats.DoTEffect,
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
	local wing = 3 * 1.3

	-- Neuer feuriger Shaft: kräftiger Kern, Glow, Funken
	local t = love.timer.getTime()
	-- Glow außen (rot)
	love.graphics.setLineWidth(8)
	love.graphics.setColor(1, 0.2, 0, 0.18)
	love.graphics.line(
		x - ux * shaft * 0.5, y - uy * shaft * 0.5,
		x + ux * shaft * 0.5, y + uy * shaft * 0.5
	)
	-- Glow innen (orange)
	love.graphics.setLineWidth(5)
	love.graphics.setColor(1, 0.5, 0, 0.28)
	love.graphics.line(
		x - ux * shaft * 0.5, y - uy * shaft * 0.5,
		x + ux * shaft * 0.5, y + uy * shaft * 0.5
	)
	-- Kern (gelb)
	love.graphics.setLineWidth(2)
	love.graphics.setColor(1, 1, 0.2, 1)
	love.graphics.line(
		x - ux * shaft * 0.5, y - uy * shaft * 0.5,
		x + ux * shaft * 0.5, y + uy * shaft * 0.5
	)
	love.graphics.setLineWidth(1)

	-- Funken entlang des Schafts
	for i = 1, 3 do
		local sparkT = t * 7 + i * 1.7
		local sparkPos = 0.2 + 0.6 * (i-1)/2 + math.sin(sparkT) * 0.08
		local sx = x - ux * shaft * 0.5 + ux * shaft * sparkPos + math.random(-1,1)
		local sy = y - uy * shaft * 0.5 + uy * shaft * sparkPos + math.random(-1,1)
		love.graphics.setColor(1, 1, 0.4, 0.85 - 0.25 * i)
		love.graphics.circle("fill", sx, sy, 1.2 + math.random() * 0.7)
	end

	-- Wings als Flammenzungen
	local flameT = t * 8
	for i = -1, 1, 2 do
		for j = 1, 2 do
			local flameLen = wing * (1 + 0.2 * math.sin(flameT + i * j))
			local flameCol = j == 1 and {1, 0.7, 0.1, 0.7} or {1, 0.3, 0, 0.5}
			love.graphics.setColor(flameCol[1], flameCol[2], flameCol[3], flameCol[4])
			love.graphics.polygon(
				"fill",
				x + ux * shaft * 0.5,
				y + uy * shaft * 0.5,
				x + px * flameLen * i + ux * 2,
				y + py * flameLen * i + uy * 2,
				x + px * flameLen * i * 0.6 + ux * 2,
				y + py * flameLen * i * 0.6 + uy * 2
			)
		end
	end
	love.graphics.setColor(1, 1, 1, 1) -- Reset color
end

return FireArrow
