--- Projectile Mixin: Adds Projectile logic to abilities.

local ProjectileFactory = require("src.objects.projectiles.projectileFactory")
local entityManager = require("src.managers.entities").getInstance()

local ProjectileMixin = {}

---Sets the type of projectile to be used by the ability.
---@param Projectile EntityEnums.ProjectileTypes
function ProjectileMixin:InitProjectile(Projectile)
	self.Projectile = Projectile or nil
	self.FiredProjectiles = {}
	self.ReachedProjectiles = {}
end

--- Creates and fires a projectile towards the target.
---@param Target Unit | Structure
function ProjectileMixin:FireProjectile(Target)
	if self.Projectile then
		local projectile = ProjectileFactory:CreateProjectile(self.Projectile, self.Owner, Target)
		if projectile then
			entityManager:SetProjectile(projectile)
		end
	end
end

return ProjectileMixin
