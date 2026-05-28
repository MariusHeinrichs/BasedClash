-- TargetingMixin: Adds targeting logic to abilities.
local TargetingMixin = {}

---initialises targeting
---@param TargetType AbilityEnums.TargetTypes
---@param TargetCriterias {HPCriteria: AbilityEnums.TargetCriteria.HPCriteria | nil, TeamCriteria: AbilityEnums.TargetCriteria.TeamCriteria | nil, UnitTypeCriteria: AbilityEnums.TargetCriteria.UnitTypeCriteria | nil, DistanceCriteria: AbilityEnums.TargetCriteria.DistanceCriteria | nil, TargetTypeCriteria: AbilityEnums.TargetCriteria.TargetTypeCriteria | nil} | nil
---@param AbilityRange number
function TargetingMixin:InitTargeting(TargetType, TargetCriterias, AbilityRange)
    self.Target = nil
	self.TargetType = TargetType
	self.TargetCriterias = TargetCriterias
	self.AbilityRange = AbilityRange
end

function TargetingMixin:SetTarget(Target)
    self.Target = Target
end

function TargetingMixin:GetTarget()
    return self.Target
end

function TargetingMixin:GetTargetCriterias()
	return self.TargetCriterias
end

function TargetingMixin:GetAbilityRange()
	return self.AbilityRange
end

return TargetingMixin
