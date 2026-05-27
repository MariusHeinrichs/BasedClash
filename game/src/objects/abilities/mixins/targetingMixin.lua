-- TargetingMixin: Adds targeting logic to abilities.
local TargetingMixin = {}

function TargetingMixin:InitTargeting()
    self.Target = nil
end

function TargetingMixin:SetTarget(target)
    self.Target = target
end

function TargetingMixin:GetTarget()
    return self.Target
end

return TargetingMixin
