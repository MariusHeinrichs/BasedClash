--- Archer class, represents an archer unit in the game.

local RangeUnit = require("src.objects.units.rangeUnit")
local UnitStats = require("src.data.unitStats").RangeUnits.Archer
local BlazeShotAbility = require("src.objects.abilities.blazeShot")

--- @class Archer : RangeUnit
local Archer = {}
Archer.__index = Archer
Archer.__type = "Archer"

setmetatable(Archer, { __index = RangeUnit })

--- Creates a new Archer.
--- @param PlayerID number | nil -- The ID of the player controlling the archer.
--- @return Archer
function Archer:new(PlayerID)
	local newArcher = RangeUnit.new(self,
		"Archer",
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
	-- Add the BlazeShot ability to the archer's abilities list
	table.insert(newArcher:GetAbilities(), BlazeShotAbility:new("BlazeShot", newArcher))
	return newArcher
end

function Archer:Draw()
	RangeUnit.Draw(self)

	-- Draw the archer's body (green tunic)
	local pos = self.Position
	local size = self.Size or 12
	local x, y = pos.X, pos.Y
	love.graphics.setColor(0.2, 0.7, 0.2, 1)
	love.graphics.circle("fill", x, y, size * 0.65)

	-- Draw the archer's head (beige)
	love.graphics.setColor(0.95, 0.85, 0.7, 1)
	love.graphics.circle("fill", x, y - size * 0.7, size * 0.32)

	-- Draw the bow (half-circle opening to the right)
	local bowCenterX = x + size * 0.7
	local bowCenterY = y - size * 0.1
	local bowRadius = size * 1.15
	love.graphics.setColor(0.45, 0.25, 0.08, 1)
	love.graphics.setLineWidth(2)
	love.graphics.arc("line", bowCenterX, bowCenterY, bowRadius, -math.pi/2, math.pi/2)
	love.graphics.setLineWidth(1)

    -- Draw the bowstring (natural curve)
    local topX = bowCenterX + math.cos(math.rad(220)) * bowRadius
    local topY = bowCenterY + math.sin(math.rad(220)) * bowRadius
    local botX = bowCenterX + math.cos(math.rad(500)) * bowRadius
    local botY = bowCenterY + math.sin(math.rad(500)) * bowRadius
    love.graphics.setColor(0.85, 0.85, 0.8, 1)
    love.graphics.setLineWidth(2)
    love.graphics.line(topX, topY, x + size * 0.2, y - size * 0.1, botX, botY)
    love.graphics.setLineWidth(1)

    -- Draw a nocked arrow (simple line)
    love.graphics.setColor(0.8, 0.8, 0.7, 1)
    love.graphics.setLineWidth(2)
    love.graphics.line(x + size * 0.2, y - size * 0.1, x + size * 1.1, y - size * 0.1)
    -- Arrow head
    love.graphics.setColor(0.9, 0.9, 0.9, 1)
    love.graphics.polygon("fill",
        x + size * 1.1, y - size * 0.1,
        x + size * 1.13, y - size * 0.13,
        x + size * 1.13, y - size * 0.07
    )
    love.graphics.setLineWidth(1)

	-- Draw the quiver (dark brown rectangle)
	love.graphics.setColor(0.25, 0.15, 0.08, 1)
	love.graphics.rectangle("fill", x - size * 0.7, y + size * 0.2, size * 0.22, size * 0.7)

	-- Draw arrows in the quiver (gray lines)
	love.graphics.setColor(0.8, 0.8, 0.8, 1)
	for i = -1, 1 do
		love.graphics.line(
			x - size * 0.59 + i * size * 0.06,
			y + size * 0.25,
			x - size * 0.59 + i * size * 0.06,
			y + size * 0.8
		)
	end

	-- Draw the face (eyes)
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.circle("fill", x - size * 0.09, y - size * 0.75, size * 0.04)
	love.graphics.circle("fill", x + size * 0.09, y - size * 0.75, size * 0.04)

	love.graphics.setColor(1, 1, 1, 1) -- Reset color
end

return Archer
