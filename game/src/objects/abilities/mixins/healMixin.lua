-- HealMixin: Adds healing logic to abilities.
local HealMixin = {}

function HealMixin:initHeal(healAmount)
    self.HealAmount = healAmount or 0
end

function HealMixin:heal(target)
    if target and target.Health and target.MaxHealth then
        target.Health = math.min(target.Health + self.HealAmount, target.MaxHealth)
    end
end

return HealMixin
