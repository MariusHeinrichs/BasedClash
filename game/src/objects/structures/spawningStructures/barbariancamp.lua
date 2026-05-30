--- BarbarianCamp class, representing a structure that can spawn barbarian units in the game.

local SpawningStructure = require("src.objects.structures.spawningStructure")
local StructureStats = require("src.data.structureStats").SpawningStructures.BarbarianCamp

---@class BarbarianCamp : SpawningStructure
local BarbarianCamp = {}
BarbarianCamp.__index = BarbarianCamp
BarbarianCamp.__type = "BarbarianCamp"

setmetatable(BarbarianCamp, { __index = SpawningStructure })

--- Creates a new BarbarianCamp.
--- @generic T : BarbarianCamp
--- @param self T
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function BarbarianCamp:new(PlayerID)
	local newBarbarianCamp = SpawningStructure.new(self,
		"Barbarian Camp",
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

	return newBarbarianCamp
end

function BarbarianCamp:Draw()
	SpawningStructure.Draw(self)

	-- Draw a barbarian camp: semicircular palisade and central fire
	local pos = self.Position
	local size = self.Size or 20
	local x, y = pos.X, pos.Y

	-- Palisade (semicircle of wooden posts)
	local postCount = 9
	local palRadius = size * 0.95
	for i = 0, postCount - 1 do
		local angle = math.pi * (i / (postCount - 1)) + math.pi
		local px = x + math.cos(angle) * palRadius
		local py = y + math.sin(angle) * palRadius * 0.7
		love.graphics.setColor(0.45, 0.28, 0.1, 1)
		love.graphics.setLineWidth(5)
		love.graphics.line(px, py, px, py - size * 0.32)
		love.graphics.setLineWidth(1)
		love.graphics.setColor(0.3, 0.18, 0.05, 1)
		love.graphics.circle("fill", px, py - size * 0.32, size * 0.09)
	end

	-- Central fire (orange/yellow circles)
	love.graphics.setColor(1, 0.5, 0, 1)
	love.graphics.circle("fill", x, y + size * 0.18, size * 0.28)
	love.graphics.setColor(1, 0.85, 0.2, 0.7)
	love.graphics.circle("fill", x, y + size * 0.18, size * 0.16)

	-- Stones around the fire
	for i = 1, 6 do
		local angle = math.rad(60 * i)
		local sx = x + math.cos(angle) * size * 0.22
		local sy = y + size * 0.18 + math.sin(angle) * size * 0.13
		love.graphics.setColor(0.7, 0.7, 0.7, 1)
		love.graphics.circle("fill", sx, sy, size * 0.05)
	end
end

return BarbarianCamp
