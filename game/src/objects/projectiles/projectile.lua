--- Projectile class, representing a projectile in the game.

local Object = require("src.objects.object")
local EntityEnums = require("src.enums.entities")
local DoTFactory = require("src.objects.Effects.dots.dotFactory")
local effectManager = require("src.managers.effectManager").getInstance()

---@class Projectile : Object
---@field Velocity number
---@field Damage number
---@field DamageType EntityEnums.DamageTypes
---@field SplashRadius number
---@field SplashDamageMultiplier number
---@field DoTEffect DoTEnums.DoTTypes | nil
---@field Position { X: number, Y: number }
---@field Source Unit | Structure | nil
---@field Target Unit | Structure | nil
local Projectile = {}
Projectile.__index = Projectile
Projectile.__type = "Projectile"

setmetatable(Projectile, { __index = Object })

--- Creates a new Projectile.
--- @generic T : Projectile
--- @param self T
--- @param Name string | nil -- The name of the projectile.
--- @param Velocity number | nil -- The velocity of the projectile.
--- @param Damage number | nil -- The damage of the projectile.
--- @param DamageType EntityEnums.DamageTypes | nil -- The type of damage dealt by the projectile.
--- @param SplashRadius number | nil -- The radius of the splash damage.
--- @param SplashDamageMultiplier number | nil -- The multiplier for the splash damage.
--- @param DoTEffect DoTEnums.DoTTypes | nil -- The damage over time effect applied by the projectile, if any.
--- @param Source Unit | Structure | nil -- The source unit or structure that fired the projectile.
--- @param Target Unit | Structure | nil -- The target unit or structure that the projectile is aimed at.
--- @return T
function Projectile:new(Name, Velocity, Damage, DamageType, SplashRadius, SplashDamageMultiplier, DoTEffect, Source, Target)
	local newProjectile = Object.new(self, Name or "Projectile")
	newProjectile.Velocity = Velocity or 100
	newProjectile.DamageType = DamageType or EntityEnums.DamageTypes.PHYSICAL
	newProjectile.Source = Source
	newProjectile.Target = Target
	newProjectile.SplashRadius = SplashRadius or 0
	newProjectile.SplashDamageMultiplier = SplashDamageMultiplier or 0
	newProjectile.Damage = Damage or 0
	newProjectile.DoTEffect = DoTEffect or nil
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

--- Checks if the projectile's Position is within a small margin of the target
--- @return boolean True if the projectile has reached its target, false otherwise.
function Projectile:HasReachedTarget()
	if self.Target then
		local dx = self.Target.Position.X - self.Position.X
		local dy = self.Target.Position.Y - self.Position.Y
		local distance = math.sqrt(dx * dx + dy * dy)
		return distance <= self.Velocity * 0.1 -- Consider it reached if it's within a small threshold
	end
	return true -- If there's no target, consider it has reached its target for cleanup purposes
end

--- Executes an attack, applying damage and its DoT to its target and returning whether the target was killed.
--- @return boolean
function Projectile:Attack()
	--- Apply damage to the target
	local targetKilled = false
	if self.Target then
		local targetArmor = self.Target.Armor or 0
		local targetArmorType = self.Target.ArmorType or EntityEnums.ArmorTypes.LEATHER
		local damageMultiplier = EntityEnums.DamageMultipliers[self.DamageType][targetArmorType] or 1
		local effectiveDamage = math.max(0, self.Damage * damageMultiplier - targetArmor)
		targetKilled = self.Target:TakeDamage(effectiveDamage)
		if targetKilled then
			self.Source.Target = nil -- Clear the source's target if the target was killed to prevent it from trying to attack a dead target.
			self.Source.Path = nil -- Clear the source's path so it can recalculate a new path if needed after the target is killed.
			self.Target = nil
		else
			self:ApplyDoTEffect(self.Target)
		end
	end
	return targetKilled
end

--- @param target Unit | Structure | nil
function Projectile:ApplyDoTEffect(target)
	if self.DoTEffect and target then
		local dot = DoTFactory.CreateDoT(self.DoTEffect)
		if dot then
			dot:ApplyToTarget(target)
			effectManager:SetEffect(dot)
		end
	end
end

function Projectile:Draw()

end

return Projectile
