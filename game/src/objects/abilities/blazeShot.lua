-- BlazeShot ability: Shoots a fire arrow projectile that damages the first enemy it hits and deals burn damage over time.
local Ability = require("src.objects.abilities.ability")
local CooldownMixin = require("src.objects.abilities.mixins.cooldownMixin")
local TargetingMixin = require("src.objects.abilities.mixins.targetingMixin")
local ProjectileMixin = require("src.objects.abilities.mixins.projectileMixin")
local AbilityStats = require("src.data.abilityStats").Blaze_Shot

---@class BlazeShot : Ability
---@field Cooldown number
---@field CooldownTimer number
---@field AbilityRange number
---@field Projectile EntityEnums.ProjectileTypes
---@field Target Unit | Structure | nil
local BlazeShot = {}
BlazeShot.__index = BlazeShot
BlazeShot.__type = "BlazeShot"

setmetatable(BlazeShot, { __index = Ability })

-- Add mixins
for k, v in pairs(CooldownMixin) do BlazeShot[k] = v end
for k, v in pairs(TargetingMixin) do BlazeShot[k] = v end
for k, v in pairs(ProjectileMixin) do BlazeShot[k] = v end

--- Creates a new BlazeShot ability.
---@param Name string | nil
---@param Owner Unit | Structure | nil
---@return BlazeShot
function BlazeShot:new(Name, Owner)
	local newAbility = Ability.new(self, Name or "BlazeShot", Owner)

	newAbility:InitCooldown(AbilityStats.Cooldown)
	newAbility:StartCooldown()
	newAbility:InitTargeting(AbilityStats.TargetType, AbilityStats.TargetCriterias,
		AbilityStats.AbilityRange)
	newAbility:InitProjectile(AbilityStats.Projectile)

	return newAbility
end

function BlazeShot:Update(dt)
	self:UpdateCooldown(dt)
end

function BlazeShot:Activate()
	if self:IsReady() then
		local target = self:GetTarget()
		if target then
			self:FireProjectile(target)
			self:StartCooldown()
		end
	end
end

return BlazeShot
