-- DamageMixin: Adds damage logic to abilities.
local DamageMixin = {}

function DamageMixin:initDamage(damage)
    self.Damage = damage or 0
end

function DamageMixin:dealDamage(target)
    if target and target.Health then
        target.Health = math.max(0, target.Health - self.Damage)
    end
end

return DamageMixin
