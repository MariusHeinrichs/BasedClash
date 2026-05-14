--- Projectile class, representing a projectile in the game.

local Object = require("src.objects.object")

---@class Projectile : Object
---@field Velocity number
---@field Damage number
---@field SplashRadius number
---@field SplashDamageMultiplier number
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
	return newProjectile
end

function Projectile:Draw()

end

return Projectile
