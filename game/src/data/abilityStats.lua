--- Ability stats configuration file.
local AbilityEnums = require("src.enums.abilities")
local EntityEnums = require("src.enums.entities")

return {
	Heal = {
		HealAmount = 25,
		Cooldown = 8,
		TargetCriterias = {
			HPCriteria = AbilityEnums.TargetCriteria.HPCriteria.LOWEST_HEALTH,
			TeamCriteria = AbilityEnums.TargetCriteria.TeamCriteria.ALLY,
			TargetTypeCriteria = AbilityEnums.TargetCriteria.TargetTypeCriteria.UNIT,
		},
		AbilityRange = 200,
		VisualDuration = 1
	},
	Blaze_Shot = {
		Cooldown = 12,
		Projectile = EntityEnums.ProjectileTypes.FIRE_ARROW,
		TargetCriterias = {
			TeamCriteria = AbilityEnums.TargetCriteria.TeamCriteria.ENEMY,
			TargetTypeCriteria = AbilityEnums.TargetCriteria.TargetTypeCriteria.UNIT,
			DistanceCriteria = AbilityEnums.TargetCriteria.DistanceCriteria.FARTHEST,
		},
		AbilityRange = 400,
		VisualDuration = 5
	}
}
