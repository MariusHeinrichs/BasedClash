-- TargetingMixin: Adds targeting logic to abilities.
local TargetingMixin = {}

function TargetingMixin:initTargeting()
    self.Target = nil
end

function TargetingMixin:setTarget(target)
    self.Target = target
end

function TargetingMixin:getTarget()
    return self.Target
end

return TargetingMixin
