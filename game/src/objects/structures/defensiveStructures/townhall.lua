--- Townhall class, representing the player's main structure in the game.

local RangeDefenseStructure = require("src.objects.structures.rangeDefenseStructure")
local StructureStats = require("src.data.structureStats").RangeDefenseStructures.Townhall

---@class Townhall : RangeDefenseStructure
local Townhall = {}
Townhall.__index = Townhall
Townhall.__type = "Townhall"

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

function Townhall:Draw()
	RangeDefenseStructure.Draw(self)

	local pos = self.Position
	local size = self.Size or 30
	local x, y = pos.X, pos.Y

	-- Draw the townhall's roof (dark gray triangle)
	love.graphics.setColor(0.3, 0.3, 0.35, 1)
	love.graphics.polygon("fill", x - size * 0.6, y - size * 0.5,
		x + size * 0.6, y - size * 0.5,
		x, y - size * 1.2)
end

return Townhall
