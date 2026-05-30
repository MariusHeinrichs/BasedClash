--- Factory for creating projectiles.

local Arrow = require("src.objects.projectiles.arrow")
local Fireball = require("src.objects.projectiles.fireball")
local FireArrow = require("src.objects.projectiles.fireArrow")

local EntityEnums = require("src.enums.entities")

local ProjectileFactory = {}

--- Creates a Projectile
--- @param ProjectileType EntityEnums.ProjectileTypes
--- @param Source Unit | Structure | nil -- The source unit or structure that fired the projectile
--- @param Target Unit | Structure | nil -- The target unit or structure that the projectile is aimed at
--- @return Projectile
function ProjectileFactory:CreateProjectile(ProjectileType, Source, Target)
	if ProjectileType == EntityEnums.ProjectileTypes.ARROW then
		return Arrow:new(Source, Target)
	elseif ProjectileType == EntityEnums.ProjectileTypes.FIREBALL then
		return Fireball:new(Source, Target)
	elseif ProjectileType == EntityEnums.ProjectileTypes.FIRE_ARROW then
		return FireArrow:new(Source, Target)
	else
		error("Unknown projectile type: " .. tostring(ProjectileType))
	end
end

return ProjectileFactory
