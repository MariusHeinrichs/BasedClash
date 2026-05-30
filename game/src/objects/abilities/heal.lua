-- Heal: Ability that restores health to the target. Can be used on self or allies.
local Ability = require("src.objects.abilities.ability")
local HealMixin = require("src.objects.abilities.mixins.healMixin")
local CooldownMixin = require("src.objects.abilities.mixins.cooldownMixin")
local TargetingMixin = require("src.objects.abilities.mixins.targetingMixin")
local VisualMixin = require("src.objects.abilities.mixins.visualMixin")
local AbilityStats = require("src.data.abilityStats")

---@class Heal : Ability
---@field HealAmount number
---@field Cooldown number
---@field CooldownTimer number
---@field AbilityRange number
---@field VisualDuration number
---@field VisualDurationTimer number
---@field Target Unit | Structure | nil
local Heal = {}
Heal.__index = Heal
Heal.__type = "Heal"

setmetatable(Heal, { __index = Ability })

-- Add mixins
for k, v in pairs(HealMixin) do Heal[k] = v end
for k, v in pairs(CooldownMixin) do Heal[k] = v end
for k, v in pairs(TargetingMixin) do Heal[k] = v end
for k, v in pairs(VisualMixin) do Heal[k] = v end
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
	newAbility:InitVisualDuration(AbilityStats.Heal.VisualDuration)

	return newAbility
end

function Heal:Update(dt)
	self:UpdateCooldown(dt)
	self:UpdateVisualDuration(dt)
end

function Heal:Activate()
	if self:IsReady() then
		if self.Owner then
			local tgt = self:GetTarget()
			-- If the target is at full health, ignore the target and attempt to heal self if self is damaged.
			if tgt and tgt.Health >= tgt.MaxHealth then
				tgt = nil
			end
			-- If a target is set, heal that target. Otherwise, heal self if self is damaged.
			if not tgt then
				if self.Owner.Health > 0 and self.Owner.Health < self.Owner.MaxHealth then
					tgt = self.Owner
				end
			end
			if tgt then
				self:Heal(tgt)
				self:StartCooldown()
				self:StartVisualDuration()
			end
		end
	end
end

function Heal:Draw()
	if not self:VisualDurationEnded() then
		local target = self:GetTarget()
		if target then
			love.graphics.setColor(1, 1, 0, 1 * (self.VisualDurationTimer / self.VisualDuration)) -- Semi-transparent yellow
			love.graphics.circle("line", target.Position.X, target.Position.Y, 15)
			love.graphics.setColor(1, 1, 1)                                              -- Reset color
		end
	end
end

return Heal
