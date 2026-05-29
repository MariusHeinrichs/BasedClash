local entityManager = require("src.managers.entities").getInstance()
local unitHashGrid = require("src.utilities.unitHashGrid").getInstance()
local abilityManager = require("src.managers.abilities").getInstance()
local EntityEnums = require("src.enums.entities")

--- AbilitySystem: Handles all abilities in the game, including their updates and interactions.
local AbilitySystem = {}

function AbilitySystem:Update(dt)
	for _, unit in pairs(entityManager:GetUnits()) do
		self:UpdateAbility(dt, unit)
		self:TargetingPhase(unit)
		self:ActivationPhase(unit)
	end
end

--- Updates the abilities of a unit. f.e cooldowns, visual durations, etc.
--- @param dt any
--- @param Unit Unit
function AbilitySystem:UpdateAbility(dt, Unit)
	if Unit:GetAbilities() then
		for _, ability in pairs(Unit:GetAbilities()) do
			ability:Update(dt)
		end
	end
end

--- Selects targets for abilities that require targeting.
--- @param Unit Unit
function AbilitySystem:TargetingPhase(Unit)
	if Unit:GetAbilities() then
		for _, ability in pairs(Unit:GetAbilities()) do
			-- Only process abilities that are ready and require targeting
			if ability:IsReady() then
				local criterias = ability:GetTargetCriterias()
				if criterias then
					local target = self:FindTargetsThatMeetCriteria(ability, criterias)
					if target then
						ability:SetTarget(target)
					end
				end
			end
		end
	end
end

--- Finds targets that meet the specified criteria for an ability.
---@param Ability Ability
---@param TargetCriterias {HPCriteria: AbilityEnums.TargetCriteria.HPCriteria | nil, TeamCriteria: AbilityEnums.TargetCriteria.TeamCriteria | nil, UnitTypeCriteria: AbilityEnums.TargetCriteria.UnitTypeCriteria | nil, DistanceCriteria: AbilityEnums.TargetCriteria.DistanceCriteria | nil, TargetTypeCriteria: AbilityEnums.TargetCriteria.TargetTypeCriteria | nil}
---@return Unit | Structure | nil
function AbilitySystem:FindTargetsThatMeetCriteria(Ability, TargetCriterias)
	local viableTargets = {}
	local target = nil
	local positionOwner = { X = Ability.Owner.Position.X, Y = Ability.Owner.Position.Y }
	local radius = Ability:GetAbilityRange() or 0

	local entitiesInRange = unitHashGrid:GetEntitiesInRadius(positionOwner, radius)

	-- find viableTargets
	for _, entity in pairs(entitiesInRange) do
		local viableTarget = true
		if TargetCriterias.TeamCriteria then
			-- filter entities by team
			if TargetCriterias.TeamCriteria == "Enemy" and entity.PlayerID == Ability.Owner.PlayerID then
				viableTarget = false
			elseif TargetCriterias.TeamCriteria == "Ally" and entity.PlayerID ~= Ability.Owner.PlayerID then
				viableTarget = false
			end
		end

		if TargetCriterias.TargetTypeCriteria then
			-- filter entities by type
			if TargetCriterias.TargetTypeCriteria == "Unit" and not entity:IsInstanceOf(EntityEnums.EntityTypes.UNIT) then
				viableTarget = false
			elseif TargetCriterias.TargetTypeCriteria == "Structure" and not entity:IsInstanceOf(EntityEnums.EntityTypes.STRUCTURE) then
				viableTarget = false
			end
		end

		if TargetCriterias.UnitTypeCriteria then
			-- filter entities by unit type
			if TargetCriterias.UnitTypeCriteria == "RangedUnits" and not entity:IsInstanceOf(EntityEnums.UnitTypes.RANGED) then
				viableTarget = false
			elseif TargetCriterias.UnitTypeCriteria == "MeleeUnits" and not entity:IsInstanceOf(EntityEnums.UnitTypes.MELEE) then
				viableTarget = false
			end
		end

		if viableTarget then
			table.insert(viableTargets, entity)
		end
	end

	--- Further filter viable targets
	for _, viableTarget in pairs(viableTargets) do
		if TargetCriterias.HPCriteria then
			-- filter entities by health
			if TargetCriterias.HPCriteria == "LowestHealth" then
				if not target or viableTarget.Health < target.Health then
					target = viableTarget
				end
			elseif TargetCriterias.HPCriteria == "HighestHealth" then
				if not target or viableTarget.Health > target.Health then
					target = viableTarget
				end
			end
		elseif TargetCriterias.DistanceCriteria then
			-- filter entities by distance
			local dist = math.sqrt((viableTarget.Position.X - positionOwner.X) ^ 2 + (viableTarget.Position.Y - positionOwner.Y) ^ 2)
			if TargetCriterias.DistanceCriteria == "Closest" then
				if not target or dist < target.Distance then
					target = viableTarget
					target.Distance = dist
				end
			elseif TargetCriterias.DistanceCriteria == "Farthest" then
				if not target or dist > target.Distance then
					target = viableTarget
					target.Distance = dist
				end
			end
		end
	end

	-- If no target was selected based on the criteria, but there are still viable targets, select the first one.
	if not target and #viableTargets > 0 then
		target = viableTargets[1]
	end

	return target
end

--- Activates abilities that are ready and have valid targets.
--- @param Unit Unit
function AbilitySystem:ActivationPhase(Unit)
	if Unit:GetAbilities() then
		for _, ability in pairs(Unit:GetAbilities()) do
			-- Only activate abilities that are ready
			if ability.IsReady and ability.Activate then
				ability:Activate()
				abilityManager:SetAbility(ability)
			end
		end
	end
end

return AbilitySystem
