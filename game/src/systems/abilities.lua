local entityManager = require("src.managers.entities").getInstance()

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

end

--- Activates abilities that are ready and have valid targets.
function AbilitySystem:ActivationPhase(dt)

end

return AbilitySystem
