-- AoEMixin: Adds area-of-effect logic to abilities.
local AoEMixin = {}

function AoEMixin:InitAoE(radius)
    self.AoERadius = radius or 1
    self.AoECenter = nil
end

function AoEMixin:SetAoECenter(center)
    self.AoECenter = center
end

function AoEMixin:GetAoECenter()
    return self.AoECenter
end

function AoEMixin:GetUnitsInRadius(units)
    local result = {}
    if not self.AoECenter or not units then return result end
    for _, unit in ipairs(units) do
        local dx = unit.Position.X - self.AoECenter.X
        local dy = unit.Position.Y - self.AoECenter.Y
        local dist = math.sqrt(dx * dx + dy * dy)
        if dist <= self.AoERadius then
            table.insert(result, unit)
        end
    end
    return result
end

return AoEMixin
