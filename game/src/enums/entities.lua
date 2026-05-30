--- Shared unit constants.

local EntityEnums = {}

--- @enum EntityEnums.DamageTypes
EntityEnums.DamageTypes = {
	PHYSICAL = "Physical",
	MAGICAL = "Magical",
	PURE = "Pure",
}

--- @enum EntityEnums.EntityTypes
EntityEnums.EntityTypes = {
	UNIT = "Unit",
	STRUCTURE = "Structure",
	PROJECTILE = "Projectile",
}

--- @enum EntityEnums.UnitTypes
EntityEnums.UnitTypes = {
	MELEE = "MeleeUnit",
	RANGED = "RangeUnit",
}

--- @enum EntityEnums.ProjectileTypes
EntityEnums.ProjectileTypes = {
	ARROW = "Arrow",
	FIREBALL = "Fireball",
	FIRE_ARROW = "FireArrow",
}

--- @enum EntityEnums.ArmorTypes
EntityEnums.ArmorTypes = {
	LEATHER = "Leather",
	CHAINMAIL = "Chainmail",
	PLATE = "Plate",
	STRUCTURE = "Structure",
}

EntityEnums.DamageMultipliers = {
	[EntityEnums.DamageTypes.PHYSICAL] = {
		[EntityEnums.ArmorTypes.LEATHER] = 1.0,
		[EntityEnums.ArmorTypes.CHAINMAIL] = 0.75,
		[EntityEnums.ArmorTypes.PLATE] = 0.5,
		[EntityEnums.ArmorTypes.STRUCTURE] = 0.5,
	},
	[EntityEnums.DamageTypes.MAGICAL] = {
		[EntityEnums.ArmorTypes.LEATHER] = 0.25,
		[EntityEnums.ArmorTypes.CHAINMAIL] = 0.75,
		[EntityEnums.ArmorTypes.PLATE] = 1.0,
		[EntityEnums.ArmorTypes.STRUCTURE] = 0.5,
	},
	[EntityEnums.DamageTypes.PURE] = {
		[EntityEnums.ArmorTypes.LEATHER] = 1.0,
		[EntityEnums.ArmorTypes.CHAINMAIL] = 1.0,
		[EntityEnums.ArmorTypes.PLATE] = 1.0,
		[EntityEnums.ArmorTypes.STRUCTURE] = 1.0,
	},
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
	TOWNHALL = "Townhall",
	LOOKOUT = "Lookout",
}

return EntityEnums
