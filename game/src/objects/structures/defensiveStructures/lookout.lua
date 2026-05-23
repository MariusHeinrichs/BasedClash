--- Lookout structure class, representing a structure that shoots arrows at enemies in the game.

local StructureStats = require("src.data.structureStats").RangeDefenseStructures.Lookout
local EntityEnums = require("src.enums.entities")
local RangeDefenseStructure = require("src.objects.structures.rangeDefenseStructure")

---@class Lookout : RangeDefenseStructure
local Lookout = {}
Lookout.__index = Lookout

setmetatable(Lookout, { __index = RangeDefenseStructure })

--- Creates a new Lookout structure.
--- @generic T : Lookout
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Lookout:new(PlayerID)
	local newLookout = RangeDefenseStructure.new(self,
		"Lookout",
		StructureStats.MaxHealth,
		StructureStats.Armor,
		StructureStats.ArmorType,
		StructureStats.Costs,
		StructureStats.IncomeBonus,
		StructureStats.Size,
		EntityEnums.ProjectileTypes.ARROW,
		StructureStats.AttackSpeed,
		StructureStats.AttackRange,
		StructureStats.AggroRange,
		EntityEnums.TargetPriorities.UNIT,
		StructureStats.Bounty,
		PlayerID
	)

	return newLookout
end

return Lookout
