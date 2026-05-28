local entityManager = require("src.managers.entities").getInstance()
local unitHashGrid = require("src.utilities.unitHashGrid").getInstance()

--- AbilitySystem: Handles all abilities in the game, including their updates and interactions.
local AbilitySystem = {}

function AbilitySystem:Update(dt)
	-- Update all abilities for all units
	self:UpdatePhase(dt)
	self:TargetingPhase(dt)
	self:ActivationPhase(dt)
end

--- Updates all abilities for all units. This includes managing cooldowns, durations, and any ongoing effects such as damage-over-time or heal-over-time.
function AbilitySystem:UpdatePhase(dt)
	for _, unit in pairs(entityManager:GetUnits()) do
		if unit:GetAbilities() then
			for _, ability in pairs(unit:GetAbilities()) do
				ability:Update(dt)
			end
		end
	end
end

--- Selects targets for abilities that require targeting.
function AbilitySystem:TargetingPhase(dt)
	for _, unit in pairs(entityManager:GetUnits()) do
		if unit:GetAbilities() then
			for _, ability in pairs(unit:GetAbilities()) do
				-- Targeting logic can be implemented here, such as selecting the nearest enemy or ally within range.
				-- This is a placeholder and should be expanded based on specific targeting requirements.
			end
		end
	end
end

--- Activates abilities that are ready and have valid targets.
function AbilitySystem:ActivationPhase(dt)

end

return AbilitySystem
