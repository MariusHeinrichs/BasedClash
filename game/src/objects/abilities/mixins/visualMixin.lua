-- VisualMixin: Adds visual duration logic to abilities.
local VisualMixin = {}

function VisualMixin:InitVisualDuration(visualDuration)
    self.VisualDuration = visualDuration or 1
    self.VisualDurationTimer = 0
end

function VisualMixin:StartVisualDuration()
    self.VisualDurationTimer = self.VisualDuration
end

function VisualMixin:UpdateVisualDuration(dt)
    if self.VisualDurationTimer and self.VisualDurationTimer > 0 then
        self.VisualDurationTimer = math.max(0, self.VisualDurationTimer - dt)
    end
end

function VisualMixin:VisualDurationEnded()
    return self.VisualDurationTimer <= 0
end

return VisualMixin
