-- PassiveMixin: Adds passive effect logic to abilities.
local PassiveMixin = {}

function PassiveMixin:initPassive()
    self.IsPassive = true
end

-- Called every update tick for passive effects (e.g. regen, aura)
function PassiveMixin:updatePassive(dt, owner)
    -- To be implemented by the ability using this mixin
end

return PassiveMixin
