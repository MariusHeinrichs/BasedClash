--- Shared unit constants.

local EntityEnums = {}

--- @enum EntityEnums.DamageTypes
EntityEnums.DamageTypes = {
	PHYSICAL = "Physical",
	MAGICAL = "Magical",
	PURE = "Pure",
}

--- @enum EntityEnums.ProjectileTypes
EntityEnums.ProjectileTypes = {
	ARROW = "Arrow",
	FIREBALL = "Fireball",
}

--- @enum EntityEnums.ArmorTypes
EntityEnums.ArmorTypes = {
	LEATHER = "Leather",
	CHAINMAIL = "Chainmail",
	PLATE = "Plate",
	STRUCTURE = "Structure",
}

--- @enum EntityEnums.TargetPriorities
EntityEnums.TargetPriorities = {
	UNIT = "Unit",
	STRUCTURE = "Structure",
}

--- @enum EntityEnums.Units
EntityEnums.Units = {
	KNIGHT = "Knight",
	BARBARIAN = "Barbarian",
	ARCHER = "Archer",
	MAGE = "Mage",
}

--- @enum EntityEnums.Structures
EntityEnums.Structures = {
	CASTLE = "Castle",
	BARBARIAN_CAMP = "BarbarianCamp",
	ARCHER_CAMP = "ArcherCamp",
	LIBRARY = "Library",
}

return EntityEnums
