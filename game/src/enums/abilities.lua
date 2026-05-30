--- Shared enums for abilities
local AbilityEnums = {}

--- @enum AbilityEnums.TargetTypes
AbilityEnums.TargetTypes = {
	UNIT = "Unit",
	STRUCTURE = "Structure",
	SELF = "Self",
	ANY = "Any"
}

---@enum AbilityEnums.Abilities
AbilityEnums.Abilities = {
	HEAL = "Heal",
	BLAZE_SHOT = "BlazeShot",
}

---@enum AbilityEnums.TargetCriteria
AbilityEnums.TargetCriteria = {
	TargetTypeCriteria = {
		UNIT = "Unit",
		STRUCTURE = "Structure",
	},
	TeamCriteria = {
		ALLY = "Ally",
		ENEMY = "Enemy",
		ANY = "Any"
	},
	HPCriteria = {
		LOWEST_HEALTH = "LowestHealth",
		HIGHEST_HEALTH = "HighestHealth"
	},
	UnitTypeCriteria = {
		RANGE_UNITS = "RangeUnits",
		MELEE_UNITS = "MeleeUnits",
	},
	DistanceCriteria = {
		CLOSEST = "Closest",
		FARTHEST = "Farthest"
	}
}

return AbilityEnums
