--- Barbarian class, represents a barbarian unit in the game.

local MeleeUnit = require("src.objects.units.meleeUnit")
local UnitStats = require("src.data.unitStats").MeleeUnits.Barbarian

--- @class Barbarian : MeleeUnit
local Barbarian = {}
Barbarian.__index = Barbarian
Barbarian.__type = "Barbarian"

setmetatable(Barbarian, { __index = MeleeUnit })

--- Creates a new Barbarian.
--- @param PlayerID number | nil -- The ID of the player controlling the barbarian.
--- @return Barbarian
function Barbarian:new(PlayerID)
	local newBarbarian = MeleeUnit.new(self,
		"Barbarian",
		UnitStats.MaxHealth,
		UnitStats.Damage,
		UnitStats.DamageType,
		UnitStats.AttackSpeed,
		UnitStats.AttackRange,
		UnitStats.AggroRange,
		UnitStats.TargetPriority,
		UnitStats.Armor,
		UnitStats.ArmorType,
		UnitStats.MovementSpeed,
		UnitStats.Size,
		UnitStats.IsFlying,
		UnitStats.Bounty,
		PlayerID
	)
	return newBarbarian
end

return Barbarian
