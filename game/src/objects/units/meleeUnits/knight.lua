--- Knight class, represents a knight unit in the game.

local MeleeUnit = require("src.objects.units.meleeUnit")
local UnitStats = require("src.data.unitStats").MeleeUnits.Knight

--- @class Knight : MeleeUnit
local Knight = {}
Knight.__index = Knight
Knight.__type = "Knight"

setmetatable(Knight, { __index = MeleeUnit })

--- Creates a new Knight.
--- @param PlayerID number | nil -- The ID of the player controlling the knight.
--- @return Knight
function Knight:new(PlayerID)
	local newKnight = MeleeUnit.new(self,
		"Knight",
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
	return newKnight
end

return Knight
