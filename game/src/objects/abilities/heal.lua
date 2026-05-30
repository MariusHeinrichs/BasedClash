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
			local t = love.timer.getTime()
			local x, y = target.Position.X, target.Position.Y
			local baseRadius = 15
			local pulse = 2 + math.sin(t * 4) * 2
			local alpha = 0.5 * (self.VisualDurationTimer / self.VisualDuration)

			-- -- Pulsating green circle
			love.graphics.setColor(0.2, 1, 0.2, alpha)
			love.graphics.setLineWidth(3)
			love.graphics.circle("line", x, y, baseRadius + pulse)
			love.graphics.setLineWidth(1)

			-- Animated plus sign (slightly floats upwards)
			local plusYOffset = -10 - 10 * (1 - self.VisualDurationTimer / self.VisualDuration)
			local plusAlpha = 0.8 * (self.VisualDurationTimer / self.VisualDuration)
			love.graphics.setColor(0.8, 1, 0.8, plusAlpha)
			love.graphics.setLineWidth(3)
			love.graphics.line(x - 6, y + plusYOffset, x + 6, y + plusYOffset)
			love.graphics.line(x, y + plusYOffset - 6, x, y + plusYOffset + 6)
			love.graphics.setLineWidth(1)

			love.graphics.setColor(1, 1, 1, 1) -- Reset color
		end
	end
end

return Heal
