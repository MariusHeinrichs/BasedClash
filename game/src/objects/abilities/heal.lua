-- Heal: Ability that restores health to the target. Can be used on self or allies.
local Ability = require("src.objects.abilities.ability")
local HealMixin = require("src.objects.abilities.mixins.healMixin")
local CooldownMixin = require("src.objects.abilities.mixins.cooldownMixin")
local TargetingMixin = require("src.objects.abilities.mixins.targetingMixin")
local AbilityStats = require("src.data.abilityStats")
local EntityEnums = require("src.enums.entities")

---@class Heal : Ability
---@field HealAmount number
---@field Cooldown number
---@field CooldownTimer number
---@field AbilityRange number
---@field Target Unit | Structure | nil
local Heal = {}
Heal.__index = Heal
Heal.__type = "Heal"

setmetatable(Heal, { __index = Ability })

-- Add mixins
for k, v in pairs(HealMixin) do Heal[k] = v end
for k, v in pairs(CooldownMixin) do Heal[k] = v end
for k, v in pairs(TargetingMixin) do Heal[k] = v end

---Creates a new Heal ability
---@param Name string | nil
---@param Owner Structure | Unit | nil
---@return Heal
function Heal:new(Name, Owner)
	local newAbility = Ability.new(self, Name or "Heal", Owner)

	-- Initialize mixin properties
	newAbility:InitHeal(AbilityStats.Heal.HealAmount)
	newAbility:InitCooldown(AbilityStats.Heal.Cooldown)
	newAbility:StartCooldown()
	newAbility:InitTargeting(AbilityStats.Heal.TargetType, AbilityStats.Heal.TargetCriterias,
	AbilityStats.Heal.AbilityRange)

	return newAbility
end

function Heal:Activate()
	if self:IsReady() then
		if self.Owner then
			local tgt = self:GetTarget()
			-- If a target is set, heal that target. Otherwise, heal self if self is damaged.
			if not tgt then
				if self.Owner.Health > 0 and self.Owner.Health < self.Owner.MaxHealth then
					tgt = self.Owner
				end
			end
			if tgt then
				self:Heal(tgt)
				self:StartCooldown()
			end
		end
	end
end

return Heal
