-- CooldownMixin: Adds cooldown logic to abilities.
local CooldownMixin = {}

function CooldownMixin:InitCooldown(cooldown)
    self.Cooldown = cooldown or 1
    self.CooldownTimer = 0
end

function CooldownMixin:StartCooldown()
    self.CooldownTimer = self.Cooldown
end

function CooldownMixin:UpdateCooldown(dt)
    if self.CooldownTimer and self.CooldownTimer > 0 then
        self.CooldownTimer = math.max(0, self.CooldownTimer - dt)
    end
end

function CooldownMixin:IsReady()
    return not self.CooldownTimer or self.CooldownTimer <= 0
end

return CooldownMixin
