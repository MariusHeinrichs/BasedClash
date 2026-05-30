--- Castle class, representing a structure that can spawn knight units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local StructureStats = require("src.data.structureStats").SpawningStructures.Castle

---@class Castle : SpawningStructure
local Castle = {}
Castle.__index = Castle
Castle.__type = "Castle"

setmetatable(Castle, { __index = SpawningStructure })

--- Creates a new Castle.
--- @generic T : Castle
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Castle:new(PlayerID)
	local newCastle = SpawningStructure.new(self,
		"Castle",
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

	return newCastle
end

function Castle:Draw()
	SpawningStructure.Draw(self)

	-- Draw a simple castle (a square with battlements)
	local pos = self.Position
	local size = self.Size or 20
	local x, y = pos.X, pos.Y

	-- Battlements (evenly spaced along the top edge of the base square)
	local baseTopY = y - size / 2
	local battlementCount = 5
	local battlementWidth = size / battlementCount
	local battlementHeight = size * 0.22
	for i = 0, battlementCount - 1 do
		local bx = x - size / 2 + i * battlementWidth
		love.graphics.rectangle("fill", bx, baseTopY - battlementHeight, battlementWidth * 0.8, battlementHeight)
	end
end

return Castle
