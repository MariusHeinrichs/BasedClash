-- DoTMixin: Adds damage-over-time logic to abilities.
local DoTMixin = {}

function DoTMixin:initDoT(damage, duration, tickInterval)
    self.DoTDamage = damage or 1
    self.DoTDuration = duration or 5
    self.DoTTickInterval = tickInterval or 1
    self.DoTTimeElapsed = 0
    self.DoTTimeSinceLastTick = 0
end

function DoTMixin:updateDoT(dt, target)
    self.DoTTimeElapsed = self.DoTTimeElapsed + dt
    self.DoTTimeSinceLastTick = self.DoTTimeSinceLastTick + dt
    if self.DoTTimeElapsed <= self.DoTDuration and self.DoTTimeSinceLastTick >= self.DoTTickInterval then
        if target and target.Health then
            target.Health = math.max(0, target.Health - self.DoTDamage)
        end
        self.DoTTimeSinceLastTick = 0
    end
end

return DoTMixin
