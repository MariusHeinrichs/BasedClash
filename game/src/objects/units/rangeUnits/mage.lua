--- Mage class, represents a mage unit in the game.

local RangeUnit = require("src.objects.units.rangeUnit")
local UnitStats = require("src.data.unitStats").RangeUnits.Mage
local HealAbility = require("src.objects.abilities.heal")

--- @class Mage : RangeUnit
local Mage = {}
Mage.__index = Mage
Mage.__type = "Mage"

setmetatable(Mage, { __index = RangeUnit })

--- Creates a new Mage.
--- @param PlayerID number | nil -- The ID of the player controlling the mage.
--- @return Mage
function Mage:new(PlayerID)
	local newMage = RangeUnit.new(self,
		"Mage",
		UnitStats.MaxHealth,
		UnitStats.Projectile,
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
	-- Add the Heal ability to the mage's abilities list
	table.insert(newMage:GetAbilities(), HealAbility:new("Heal", newMage))
	return newMage
end

function Mage:Draw()
	RangeUnit.Draw(self)
	-- Add some mage-specific visual elements (e.g., a staff, a magical aura)
	local pos = self.Position
	local size = self.Size or 12
	local x, y = pos.X, pos.Y

	-- Cape
	love.graphics.setColor(0.5, 0.2, 0.8, 0.8)
	love.graphics.arc("fill", x, y, size, math.pi, 2 * math.pi)

	-- Hat (tall and pointy)
	love.graphics.setColor(0.2, 0.2, 0.5, 1)
	love.graphics.polygon("fill",
		x, y - size * 1.25,
		x - size * 0.38, y - size * 0.18,
		x + size * 0.38, y - size * 0.18
	)
	love.graphics.setColor(0.25, 0.25, 0.4, 1)
	love.graphics.ellipse("fill", x, y - size * 0.18, size * 0.52, size * 0.13)

	-- Staff (longer)
	love.graphics.setColor(0.4, 0.2, 0.1, 1)
	love.graphics.setLineWidth(3)
	love.graphics.line(x + size * 0.4, y + size * 0.2, x + size * 1.0, y + size * 1.15)
	love.graphics.setLineWidth(1)
	love.graphics.setColor(0.2, 1, 1, 0.8)
	love.graphics.circle("fill", x + size * 1.0, y + size * 1.15, size * 0.16)

	-- Magical effect
	local t = love.timer.getTime()
	local pulse = 0.12 + 0.06 * math.sin(t * 4)
	love.graphics.setColor(0.7, 0.9, 1, 0.25)
	love.graphics.circle("line", x, y, size * (0.7 + pulse))

	-- eyes
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.circle("fill", x - size * 0.18, y - size * 0.1, size * 0.08)
	love.graphics.circle("fill", x + size * 0.18, y - size * 0.1, size * 0.08)

	love.graphics.setColor(1, 1, 1, 1) -- Reset color
end

return Mage
