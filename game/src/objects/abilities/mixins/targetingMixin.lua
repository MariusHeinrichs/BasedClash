-- TargetingMixin: Adds targeting logic to abilities.
local TargetingMixin = {}

---initialises targeting
---@param TargetType Unit | Structure
---@param TargetEnemy boolean
---@param AbilityRange number
function TargetingMixin:InitTargeting(TargetType, TargetEnemy, AbilityRange)
    self.Target = nil
	self.TargetType = TargetType
	self.TargetEnemy = TargetEnemy
	self.AbilityRange = AbilityRange
end

function TargetingMixin:SetTarget(Target)
    self.Target = Target
end

function TargetingMixin:GetTarget()
    return self.Target
end

function TargetingMixin:TargetsEnemy()
	return self.TargetEnemy
end

function TargetingMixin:GetAbilityRange()
	return self.AbilityRange
end

return TargetingMixin
