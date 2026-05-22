-- Structure-Stats
local EntityEnums = require("src.enums.entities")

return {
	SpawningStructures = {
		Castle = {
			MaxHealth = 1000,
			Armor = 8,
			ArmorType = EntityEnums.ArmorTypes.STRUCTURE,
			Costs = { Gold = 100, Metal = 50, Aether = 0 },
			IncomeBonus = { Gold = 5, Metal = 1, Aether = 0 },
			Size = 20.0,
			SpawnUnit = EntityEnums.Units.KNIGHT,
			SpawnAmount = 1,
			SpawnRate = 10,
			Bounty = 200
		},
		BarbarianCamp = {
			MaxHealth = 1000,
			Armor = 8,
			ArmorType = EntityEnums.ArmorTypes.STRUCTURE,
			Costs = { Gold = 100, Metal = 0, Aether = 0 },
			IncomeBonus = { Gold = 5, Metal = 1, Aether = 0 },
			Size = 15.0,
			SpawnUnit = EntityEnums.Units.BARBARIAN,
			SpawnAmount = 1,
			SpawnRate = 8,
			Bounty = 200
		},
		ArcherCamp = {
			MaxHealth = 1000,
			Armor = 8,
			ArmorType = EntityEnums.ArmorTypes.STRUCTURE,
			Costs = { Gold = 100, Metal = 0, Aether = 0 },
			IncomeBonus = { Gold = 5, Metal = 1, Aether = 0 },
			Size = 10.0,
			SpawnUnit = EntityEnums.Units.ARCHER,
			SpawnAmount = 1,
			SpawnRate = 8,
			Bounty = 200
		},
		Library = {
			MaxHealth = 1000,
			Armor = 8,
			ArmorType = EntityEnums.ArmorTypes.STRUCTURE,
			Costs = { Gold = 150, Metal = 25, Aether = 0 },
			IncomeBonus = { Gold = 5, Metal = 1, Aether = 0 },
			Size = 20.0,
			SpawnUnit = EntityEnums.Units.MAGE,
			SpawnAmount = 1,
			SpawnRate = 10,
			Bounty = 200
		}
	},
	RangeDefenseStructures = {
		Townhall = {
			MaxHealth = 1500,
			Armor = 10,
			ArmorType = EntityEnums.ArmorTypes.STRUCTURE,
			Costs = { Gold = 0, Metal = 0, Aether = 0 },
			IncomeBonus = { Gold = 0, Metal = 0, Aether = 0 },
			Size = 30,
			Projectile = EntityEnums.ProjectileTypes.ARROW,
			AttackSpeed = 0.5,
			AttackRange = 200.0,
			TargetPriority = EntityEnums.TargetPriorities.UNIT,
			Bounty = 300,
			PlayerID = 0
		},
	}
}
