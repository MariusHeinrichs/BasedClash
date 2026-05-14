--- Projectile class, representing a projectile in the game.

local Object = require("src.objects.object")

---@class Projectile : Object
---@field Velocity {X: number, Y: number}
---@field Source Unit | Structure | nil
---@field Target Unit | Structure | nil
---@field Size number
---@field SplashRadius number
---@field SplashDamageMultiplier number
local Projectile = {}
Projectile.__index = Projectile

setmetatable(Projectile, { __index = Object })

--- Creates a new Projectile.
--- @generic T : Projectile
--- @param self T
--- @param Name string | nil
--- @param Velocity {X: number, Y: number} | nil
--- @param Source Unit | Structure | nil
--- @param Target Unit | Structure | nil
--- @param SplashRadius number | nil
--- @param SplashDamageMultiplier number | nil
--- @return T
function Projectile:new(Name, Velocity, Source, Target, SplashRadius, SplashDamageMultiplier)
	local newProjectile = Object.new(self, Name or "Projectile")
	newProjectile.Velocity = Velocity or { X = 0, Y = 0 }
	newProjectile.Source = Source
	newProjectile.Target = Target
	newProjectile.SplashRadius = SplashRadius or 0
	newProjectile.SplashDamageMultiplier = SplashDamageMultiplier or 0
	return newProjectile
end

function Projectile:Draw()

end
