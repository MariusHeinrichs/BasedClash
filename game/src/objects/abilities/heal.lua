-- Heal: Ability that restores health to the target. Can be used on self or allies.
local Ability = require("src.objects.abilities.ability")
local HealMixin = require("src.objects.abilities.mixins.healMixin")
local CooldownMixin = require("src.objects.abilities.mixins.cooldownMixin")
local TargetingMixin = require("src.objects.abilities.mixins.targetingMixin")
local AbilityStats = require("src.data.abilityStats")

---@class Heal : Ability
---@field HealAmount number
---@field Cooldown number
---@field CooldownTimer number
---@field Target any
local Heal = {}
Heal.__index = Heal
Heal.__type = "Heal"

setmetatable(Heal, { __index = Ability })

---Creates a new Heal ability
---@param Name string | nil
---@param Owner Structure | Unit | nil
---@return Heal
function Heal:new(Name, Owner)
	local newAbility = Ability.new(self, Name or "Heal", Owner)

	-- Add mixins
	for k, v in pairs(HealMixin) do newAbility[k] = v end
	for k, v in pairs(CooldownMixin) do newAbility[k] = v end
	for k, v in pairs(TargetingMixin) do newAbility[k] = v end

	-- Initialize mixin properties
	newAbility:InitHeal(AbilityStats.Heal.HealAmount)
	newAbility:InitCooldown(AbilityStats.Heal.Cooldown)
	newAbility:StartCooldown()
	newAbility:InitTargeting()
	return newAbility
end

function Heal:Activate(target)
	if self:IsReady() then
		local tgt = target or self:GetTarget() or self.Owner
		self:Heal(tgt)
		self:StartCooldown()
	end
end

function Heal:Update(dt)
	self:UpdateCooldown(dt)
end

return Heal
