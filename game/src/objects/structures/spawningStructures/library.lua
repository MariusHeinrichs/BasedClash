--- Library class, representing a structure that can spawn mage units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local StructureStats = require("src.data.structureStats").SpawningStructures.Library

---@class Library : SpawningStructure
local Library = {}
Library.__index = Library
Library.__type = "Library"

setmetatable(Library, { __index = SpawningStructure })

--- Creates a new Library.
--- @generic T : Library
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Library:new(PlayerID)
	local newLibrary = SpawningStructure.new(self,
		"Library",
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

	return newLibrary
end

function Library:Draw()
	SpawningStructure.Draw(self)

	-- Draw a simple library (a building with a book on top)
	local pos = self.Position
	local size = self.Size or 20
	local x, y = pos.X, pos.Y

	-- Book on top (brown rectangle with a white line)
	love.graphics.setColor(0.6, 0.3, 0.1, 1)
	love.graphics.rectangle("fill", x - size * 0.4, y - size * 1.2, size * 0.8, size * 0.4)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.line(x - size * 0.4, y - size * 1.2 + size * 0.2, x + size * 0.4, y - size * 1.2 + size * 0.2)
end

return Library
