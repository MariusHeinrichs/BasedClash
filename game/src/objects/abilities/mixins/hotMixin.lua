-- HoTMixin: Adds heal-over-time logic to abilities.
local HoTMixin = {}

function HoTMixin:initHoT(healAmount, duration, tickInterval)
    self.HoTHealAmount = healAmount or 1
    self.HoTDuration = duration or 5
    self.HoTTickInterval = tickInterval or 1
    self.HoTTimeElapsed = 0
    self.HoTTimeSinceLastTick = 0
end

function HoTMixin:updateHoT(dt, target)
    self.HoTTimeElapsed = self.HoTTimeElapsed + dt
    self.HoTTimeSinceLastTick = self.HoTTimeSinceLastTick + dt
    if self.HoTTimeElapsed <= self.HoTDuration and self.HoTTimeSinceLastTick >= self.HoTTickInterval then
        if target and target.Health and target.MaxHealth then
            target.Health = math.min(target.Health + self.HoTHealAmount, target.MaxHealth)
        end
        self.HoTTimeSinceLastTick = 0
    end
end

return HoTMixin
