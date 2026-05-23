--- Townhall class, representing the player's main structure in the game.

local RangeDefenseStructure = require("src.objects.structures.rangeDefenseStructure")
local StructureStats = require("src.data.structureStats").RangeDefenseStructures.Townhall

---@class Townhall : RangeDefenseStructure
local Townhall = {}
Townhall.__index = Townhall

setmetatable(Townhall, { __index = RangeDefenseStructure })

--- Creates a new Townhall.
--- @generic T : Townhall
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Townhall:new(PlayerID)
	local newTownhall = RangeDefenseStructure.new(self,
		"Townhall",
		StructureStats.MaxHealth,
		StructureStats.Armor,
		StructureStats.ArmorType,
		StructureStats.Costs,
		StructureStats.IncomeBonus,
		StructureStats.Size,
		StructureStats.Projectile,
		StructureStats.AttackSpeed,
		StructureStats.AttackRange,
		StructureStats.AggroRange,
		StructureStats.TargetPriority,
		StructureStats.Bounty,
		PlayerID
	)

	return newTownhall
end

return Townhall
