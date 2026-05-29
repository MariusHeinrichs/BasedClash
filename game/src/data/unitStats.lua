-- Unit-Stats als Lua-Tabelle
local UnitConstants = require("src.enums.entities")

return {
	MeleeUnits = {
		Barbarian = {
			MaxHealth = 120,
			Damage = 30,
			DamageType = UnitConstants.DamageTypes.PHYSICAL,
			AttackSpeed = 1.0,
			AttackRange = 40,
			AggroRange = 180,
			TargetPriority = UnitConstants.TargetPriorities.UNIT,
			Armor = 2,
			ArmorType = UnitConstants.ArmorTypes.LEATHER,
			MovementSpeed = 15,
			Size = 8,
			IsFlying = false,
			Bounty = 15
		},
		Knight = {
			MaxHealth = 160,
			Damage = 40,
			DamageType = UnitConstants.DamageTypes.PHYSICAL,
			AttackSpeed = 1.0,
			AttackRange = 35,
			AggroRange = 180,
			TargetPriority = UnitConstants.TargetPriorities.UNIT,
			Armor = 5,
			ArmorType = UnitConstants.ArmorTypes.PLATE,
			MovementSpeed = 10,
			Size = 10,
			IsFlying = false,
			Bounty = 30
		}
	},
	RangeUnits = {
		Archer = {
			MaxHealth = 80,
			Projectile = UnitConstants.ProjectileTypes.ARROW,
			AttackSpeed = 1.5,
			AttackRange = 140,
			AggroRange = 180,
			TargetPriority = UnitConstants.TargetPriorities.UNIT,
			Armor = 0,
			ArmorType = UnitConstants.ArmorTypes.LEATHER,
			MovementSpeed = 15,
			Size = 5,
			IsFlying = false,
			Bounty = 10,
		},
		Mage = {
			MaxHealth = 80,
			Projectile = UnitConstants.ProjectileTypes.FIREBALL,
			AttackSpeed = 1.5,
			AttackRange = 120,
			AggroRange = 180,
			TargetPriority = UnitConstants.TargetPriorities.UNIT,
			Armor = 0,
			ArmorType = UnitConstants.ArmorTypes.LEATHER,
			MovementSpeed = 15,
			Size = 4,
			IsFlying = false,
			Bounty = 20,
		}
	}
}
