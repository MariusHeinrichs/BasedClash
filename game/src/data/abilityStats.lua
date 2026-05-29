--- Ability stats configuration file.
local AbilityEnums = require("src.enums.abilities")

return {
	Heal = {
		HealAmount = 25,
		Cooldown = 8,
		TargetType = AbilityEnums.TargetTypes.UNIT,
		TargetCriterias = {
			HPCriteria = AbilityEnums.TargetCriteria.HPCriteria.LOWEST_HEALTH,
			TeamCriteria = AbilityEnums.TargetCriteria.TeamCriteria.ALLY,
			TargetType = AbilityEnums.TargetCriteria.TargetTypeCriteria.UNIT,
		},
		AbilityRange = 200,
		VisualDuration = 1
	}
}
