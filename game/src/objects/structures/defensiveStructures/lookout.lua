--- Lookout structure class, representing a structure that shoots arrows at enemies in the game.

local StructureStats = require("src.data.structureStats").RangeDefenseStructures.Lookout
local EntityEnums = require("src.enums.entities")
local RangeDefenseStructure = require("src.objects.structures.rangeDefenseStructure")

---@class Lookout : RangeDefenseStructure
local Lookout = {}
Lookout.__index = Lookout
Lookout.__type = "Lookout"

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

function Lookout:Draw()
	RangeDefenseStructure.Draw(self)

	local pos = self.Position
	local size = self.Size or 20
	local x, y = pos.X, pos.Y

	-- Draw the lookout's roof (red triangle)
	love.graphics.setColor(0.8, 0.2, 0.2, 1)
	love.graphics.polygon("fill", x - size * 0.6, y - size * 0.5,
		x + size * 0.6, y - size * 0.5,
		x, y - size * 1.2)
end

return Lookout
