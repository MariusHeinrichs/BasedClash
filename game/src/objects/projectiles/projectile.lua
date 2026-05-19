--- Projectile class, representing a projectile in the game.

local Object = require("src.objects.object")

---@class Projectile : Object
---@field Velocity number
---@field Damage number
---@field SplashRadius number
---@field SplashDamageMultiplier number
---@field Position { X: number, Y: number }
---@field Source Unit | Structure | nil
---@field Target Unit | Structure | nil
local Projectile = {}
Projectile.__index = Projectile

setmetatable(Projectile, { __index = Object })

--- Creates a new Projectile.
--- @generic T : Projectile
--- @param self T
--- @param Name string | nil -- The name of the projectile.
--- @param Velocity number | nil -- The velocity of the projectile.
--- @param Damage number | nil -- The damage of the projectile.
--- @param SplashRadius number | nil -- The radius of the splash damage.
--- @param SplashDamageMultiplier number | nil -- The multiplier for the splash damage.
--- @param Source Unit | Structure | nil -- The source unit or structure that fired the projectile.
--- @param Target Unit | Structure | nil -- The target unit or structure that the projectile is aimed at.
--- @return T
function Projectile:new(Name, Velocity, Damage, SplashRadius, SplashDamageMultiplier, Source, Target)
	local newProjectile = Object.new(self, Name or "Projectile")
	newProjectile.Velocity = Velocity or 100
	newProjectile.Source = Source
	newProjectile.Target = Target
	newProjectile.SplashRadius = SplashRadius or 0
	newProjectile.SplashDamageMultiplier = SplashDamageMultiplier or 0
	newProjectile.Damage = Damage or 0
	newProjectile.Position = { X = newProjectile.Source.Position.X, Y = newProjectile.Source.Position.Y }
	return newProjectile
end

--- Moves the projectile towards its target based on its velocity and the delta time.
function Projectile:MoveToTarget(dt)
	if self.Target then
		local dx = self.Target.Position.X - self.Position.X
		local dy = self.Target.Position.Y - self.Position.Y
		local distance = math.sqrt(dx * dx + dy * dy)

		if distance > 0 then
			local moveX = (dx / distance) * self.Velocity * dt
			local moveY = (dy / distance) * self.Velocity * dt

			self:SetPosition({ X = self.Position.X + moveX, Y = self.Position.Y + moveY })
		end
	end
end

function Projectile:Draw()

end

return Projectile
