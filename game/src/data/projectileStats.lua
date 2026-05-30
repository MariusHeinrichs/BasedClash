-- Projectile-Stats
local EntityEnums = require("src.enums.entities")
local DoTEnums = require("src.enums.dots")

return {
	Arrow = {
		Velocity = 50.0,
		Damage = 20,
		DamageType = EntityEnums.DamageTypes.PHYSICAL,
		SplashRadius = 0,
		SplashDamageMultiplier = 0,
		DoTEffect = nil
	},
	Fireball = {
		Velocity = 40.0,
		Damage = 20,
		DamageType = EntityEnums.DamageTypes.MAGICAL,
		SplashRadius = 35,
		SplashDamageMultiplier = 0.3,
		DoTEffect = nil
	},
	FireArrow = {
		Velocity = 70.0,
		Damage = 20,
		DamageType = EntityEnums.DamageTypes.MAGICAL,
		SplashRadius = 0,
		SplashDamageMultiplier = 0,
		DoTEffect = DoTEnums.DoTTypes.BURN
	},
}
