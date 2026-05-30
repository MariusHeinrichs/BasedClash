--- ArcherCamp class, representing a structure that can spawn archer units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local StructureStats = require("src.data.structureStats").SpawningStructures.ArcherCamp

---@class ArcherCamp : SpawningStructure
local ArcherCamp = {}
ArcherCamp.__index = ArcherCamp
ArcherCamp.__type = "ArcherCamp"

setmetatable(ArcherCamp, { __index = SpawningStructure })

--- Creates a new ArcherCamp.
--- @generic T : ArcherCamp
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function ArcherCamp:new(PlayerID)
	local newArcherCamp = SpawningStructure.new(self,
		"ArcherCamp",
		StructureStats.MaxHealth,
		StructureStats.Armor,
		StructureStats.ArmorType,
		StructureStats.Costs,
		StructureStats.IncomeBonus,
		StructureStats.Size,
		StructureStats.SpawnUnit,
		StructureStats.SpawnAmount,
		StructureStats.SpawnRate,
		StructureStats.Bounty,
		PlayerID
	)

	return newArcherCamp
end

ArcherCamp.Draw = function(self)
	SpawningStructure.Draw(self)

	-- Draw a simple archery target on the structure
	local pos = self.Position
	local size = self.Size or 20
	local x, y = pos.X, pos.Y

	-- Outer circle (white)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.circle("fill", x + 5, y + 5, size * 0.6)

	-- Middle circle (red)
	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.circle("fill", x + 5, y + 5, size * 0.4)

	-- Inner circle (yellow)
	love.graphics.setColor(1, 1, 0, 1)
	love.graphics.circle("fill", x + 5, y + 5, size * 0.2)
end


return ArcherCamp
