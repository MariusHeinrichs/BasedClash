--- Fireball class, represents a fireball projectile in the game.

local Projectile = require("src.objects.projectiles.projectile")

--- @class Fireball : Projectile
local Fireball = {}
Fireball.__index = Fireball

setmetatable(Fireball, { __index = Projectile })

--- Creates a new Fireball.
--- @param Source Unit | Structure | nil -- The source unit or structure that fired the fireball.
--- @param Target Unit | Structure | nil -- The target unit or structure that the fireball is aimed at.
--- @return Fireball
function Fireball:new(Source, Target)
	local newFireball = Projectile.new(self,
		"Fireball",
		100,
		10,
		50,
		0.5,
		Source,
		Target
	)
	return newFireball
end

function Fireball:Draw()
	local x, y, r = self.Position.X, self.Position.Y, 3.5
	love.graphics.setColor(1, 0.22, 0.04, 0.28)
	love.graphics.circle("fill", x, y, r * 2.5)
	love.graphics.setColor(1, 0.52, 0.12, 0.62)
	love.graphics.circle("fill", x, y, r * 1.75)
	love.graphics.setColor(1, 0.78, 0.23, 0.95)
	love.graphics.circle("fill", x, y, r * 1.2)
	love.graphics.setColor(1, 0.95, 0.62, 1)
	love.graphics.circle("fill", x, y, math.max(1.2, r * 0.62))
	love.graphics.setColor(1, 1, 1)
end

return Fireball
