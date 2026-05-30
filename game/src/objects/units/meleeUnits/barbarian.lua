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

function Barbarian:Draw()
	MeleeUnit.Draw(self)

	-- Draw two clubs (left and right)
	local pos = self.Position
	local size = self.Size or 13
	local x, y = pos.X, pos.Y

	-- Left club (slim, long, pointing up)
	love.graphics.setColor(0.45, 0.28, 0.1, 1)
	love.graphics.setLineWidth(3)
	love.graphics.line(x - size * 0.7, y + size * 0.5, x - size * 1.1, y - size * 1.2)
	love.graphics.setLineWidth(1)
	love.graphics.setColor(0.3, 0.18, 0.05, 1)
	love.graphics.ellipse("fill", x - size * 1.1, y - size * 1.2, size * 0.11, size * 0.22)

	-- Right club (slim, long, pointing up)
	love.graphics.setColor(0.45, 0.28, 0.1, 1)
	love.graphics.setLineWidth(3)
	love.graphics.line(x + size * 0.7, y + size * 0.5, x + size * 1.1, y - size * 1.2)
	love.graphics.setLineWidth(1)
	love.graphics.setColor(0.3, 0.18, 0.05, 1)
	love.graphics.ellipse("fill", x + size * 1.1, y - size * 1.2, size * 0.11, size * 0.22)

	-- Leather hat (brown, simple shape)
	love.graphics.setColor(0.45, 0.28, 0.13, 1)
	love.graphics.ellipse("fill", x, y - size * 0.85, size * 0.45, size * 0.18)
	love.graphics.setColor(0.35, 0.18, 0.08, 1)
	love.graphics.polygon("fill",
		x, y - size * 1.15,
		x - size * 0.22, y - size * 0.85,
		x + size * 0.22, y - size * 0.85
	)

	love.graphics.setColor(1, 1, 1, 1) -- Reset color
end

return Barbarian
