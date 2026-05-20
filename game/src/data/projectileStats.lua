-- Projectile-Stats
local EntityEnums = require("src.enums.entities")

return {
  Arrow = {
    Velocity = 25.0,
    Damage = 20,
	DamageType = EntityEnums.DamageTypes.PHYSICAL,
    SplashRadius = 0,
    SplashDamageMultiplier = 0,
  },
  Fireball = {
    Velocity = 20.0,
    Damage = 30,
	DamageType = EntityEnums.DamageTypes.MAGICAL,
    SplashRadius = 50,
    SplashDamageMultiplier = 0.3,
  }
}
