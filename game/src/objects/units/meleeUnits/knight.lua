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

function Knight:Draw()
	MeleeUnit.Draw(self)

	-- Draw the knight's body (gray armor)
	local pos = self.Position
	local size = self.Size or 13
	local x, y = pos.X, pos.Y
	love.graphics.setColor(0.7, 0.7, 0.8, 1)
	love.graphics.circle("fill", x, y, size * 0.7)

	-- Draw the knight's helmet (darker gray)
	love.graphics.setColor(0.45, 0.45, 0.55, 1)
	love.graphics.arc("fill", x, y - size * 0.25, size * 0.5, math.pi, 2 * math.pi)
	love.graphics.rectangle("fill", x - size * 0.5, y - size * 0.25, size, size * 0.25)

	-- Draw the face slit (black)
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", x - size * 0.18, y - size * 0.13, size * 0.36, size * 0.09)

	-- Draw the shield (blue ellipse on left)
	love.graphics.setColor(0.2, 0.4, 0.8, 0.85)
	love.graphics.ellipse("fill", x - size * 0.85, y + size * 0.25, size * 0.23, size * 0.45)
	love.graphics.setColor(0.1, 0.2, 0.4, 1)
	love.graphics.ellipse("line", x - size * 0.85, y + size * 0.25, size * 0.23, size * 0.45)

	-- Draw the sword (right, silver blade, brown handle)
	-- Blade (long, slender sword)
	love.graphics.setColor(0.85, 0.85, 0.95, 1)
	love.graphics.setLineWidth(2)
	love.graphics.line(x + size * 0.7, y + size * 0.1, x + size * 1.55, y - size * 0.7)
	love.graphics.setLineWidth(1)
	-- Sword tip (small triangle)
	love.graphics.setColor(0.95, 0.95, 1, 1)
	love.graphics.polygon("fill",
		x + size * 1.55, y - size * 0.7,
		x + size * 1.58, y - size * 0.75,
		x + size * 1.52, y - size * 0.75
	)
	-- Crossguard (horizontal line)
	love.graphics.setColor(0.7, 0.7, 0.8, 1)
	love.graphics.setLineWidth(3)
	love.graphics.line(x + size * 0.78, y + size * 0.18, x + size * 0.95, y + size * 0.02)
	love.graphics.setLineWidth(1)
	-- Handle (brown, thinner)
	love.graphics.setColor(0.5, 0.3, 0.1, 1)
	love.graphics.setLineWidth(2)
	love.graphics.line(x + size * 0.7, y + size * 0.1, x + size * 0.82, y + size * 0.38)
	love.graphics.setLineWidth(1)

	-- Draw the eyes (white dots)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.circle("fill", x - size * 0.09, y - size * 0.18, size * 0.05)
	love.graphics.circle("fill", x + size * 0.09, y - size * 0.18, size * 0.05)

	love.graphics.setColor(1, 1, 1, 1) -- Reset color
end

return Knight
