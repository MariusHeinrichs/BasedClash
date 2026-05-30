-- Projectile-Stats
local EntityEnums = require("src.enums.entities")

return {
	Arrow = {
		Velocity = 50.0,
		Damage = 20,
		DamageType = EntityEnums.DamageTypes.PHYSICAL,
		SplashRadius = 0,
		SplashDamageMultiplier = 0,
		DoTDamage = 0,
		DoTDuration = 0,
		DoTTickInterval = 0,
	},
	Fireball = {
		Velocity = 40.0,
		Damage = 20,
		DamageType = EntityEnums.DamageTypes.MAGICAL,
		SplashRadius = 35,
		SplashDamageMultiplier = 0.3,
		DoTDamage = 0,
		DoTDuration = 0,
		DoTTickInterval = 0,
	},
	FireArrow = {
		Velocity = 70.0,
		Damage = 20,
		DamageType = EntityEnums.DamageTypes.MAGICAL,
		SplashRadius = 0,
		SplashDamageMultiplier = 0,
		DoTDamage = 10,
		DoTDuration = 5,
		DoTTickInterval = 1,
	},
}
