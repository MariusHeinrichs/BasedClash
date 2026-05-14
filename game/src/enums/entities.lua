--- Shared unit constants.

local EntityEnums = {}

--- @enum EntityEnums.DamageTypes
EntityEnums.DamageTypes = {
	PHYSICAL = "Physical",
	MAGICAL = "Magical",
	PURE = "Pure",
}

--- @enum EntityEnums.ArmorTypes
EntityEnums.ArmorTypes = {
	LEATHER = "Leather",
	CHAINMAIL = "Chainmail",
	PLATE = "Plate",
}

--- @enum EntityEnums.TargetPriorities
EntityEnums.TargetPriorities = {
	Unit = "Unit",
	Structure = "Structure",
}

return EntityEnums
