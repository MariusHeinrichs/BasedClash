local entityManager = require("src.managers.entities").getInstance()
local unitHashGrid = require("src.utilities.unitHashGrid").getInstance()

--- AbilitySystem: Handles all abilities in the game, including their updates and interactions.
local AbilitySystem = {}

function AbilitySystem:Update(dt)
	for _, unit in pairs(entityManager:GetUnits()) do
		self:UpdateCooldowns(dt, unit)
		self:TargetingPhase(dt, unit)
		self:ActivationPhase(dt, unit)
	end
end

--- @param dt any
--- @param Unit Unit
function AbilitySystem:UpdateCooldowns(dt, Unit)
	if Unit:GetAbilities() then
		for _, ability in pairs(Unit:GetAbilities()) do
			ability:UpdateCooldown(dt)
		end
	end
end

--- Selects targets for abilities that require targeting.
--- @param dt any
--- @param Unit Unit
function AbilitySystem:TargetingPhase(dt, Unit)
	if Unit:GetAbilities() then
		for _, ability in pairs(Unit:GetAbilities()) do
			-- Only process abilities that are ready and require targeting
			if ability.IsReady then
				local criterias = ability:GetTargetCriterias()
				if criterias then
					local targets = self:FindTargetsThatMeetCriteria(ability, criterias)
					if targets then

					end
				end
			end
		end
	end
end

--- Finds targets that meet the specified criteria for an ability.
---@param Ability Ability
---@param TargetCriterias {HPCriteria: AbilityEnums.TargetCriteria.HPCriteria | nil, TeamCriteria: AbilityEnums.TargetCriteria.TeamCriteria | nil, UnitTypeCriteria: AbilityEnums.TargetCriteria.UnitTypeCriteria | nil, DistanceCriteria: AbilityEnums.TargetCriteria.DistanceCriteria | nil, TargetTypeCriteria: AbilityEnums.TargetCriteria.TargetTypeCriteria | nil}
---@return Unit[] | Structure[] | nil
function AbilitySystem:FindTargetsThatMeetCriteria(Ability, TargetCriterias)
	local targets = {}
	local position = { X = Ability.Owner.Position.X, Y = Ability.Owner.Position.Y }
	local radius = Ability:GetAbilityRange() or 0

	local entitiesInRange = unitHashGrid:GetEntitiesInRadius(position, radius)

	if TargetCriterias.TeamCriteria then

	end

	if TargetCriterias.TargetTypeCriteria then

	end

	if TargetCriterias.UnitTypeCriteria then

	end


	if TargetCriterias.HPCriteria then

	end

	if TargetCriterias.DistanceCriteria then

	end

	print("lel")

	return targets
end

--- Activates abilities that are ready and have valid targets.
--- @param dt any
--- @param Unit Unit
function AbilitySystem:ActivationPhase(dt, Unit)
	if Unit:GetAbilities() then
		for _, ability in pairs(Unit:GetAbilities()) do
			-- Only activate abilities that are ready
			if ability.IsReady and ability.Activate then
				ability:Activate()
			end
		end
	end
end

return AbilitySystem
