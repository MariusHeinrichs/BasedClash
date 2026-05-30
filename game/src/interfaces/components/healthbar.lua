--- Healthbar class for displaying unit health in the BattleHUD.
--- @class Healthbar
--- @field MaxHealth number
--- @field Health number
--- @field Object Unit | Structure
--- @field PlayerID number
local Healthbar = {}
Healthbar.__index = Healthbar

--- Creates a new Healthbar for a Unit or Structure.
--- @param Object Unit | Structure The unit or structure to create the healthbar for.
--- @return Healthbar
function Healthbar:new(Object)
	local newHealthbar = {
		MaxHealth = Object.MaxHealth or 100,
		Health = Object.Health or (Object.MaxHealth or 100),
		Object = Object,
		PlayerID = Object.PlayerID or 1
	}
	setmetatable(newHealthbar, self)

	return newHealthbar
end

--- Draws the healthbar on the screen.
function Healthbar:Draw()
	local position = self.Object.Position
	local size = self.Object:IsInstanceOf("Unit") and self.Object.Size or self.Object.Size / 2
	if self.Health <= 0 then
		return -- Don't draw if the unit is dead.
	end
	if self.MaxHealth <= 0 then
		return -- Avoid division by zero.
	end
	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", position.X - 20, position.Y - size - 10, 40, 2)
	-- Draw the foreground of the healthbar (green/red based on health percentage)
	local healthPercentage = self.Health / self.MaxHealth
	love.graphics.setColor(1 - healthPercentage, healthPercentage, 0)
	love.graphics.rectangle("fill", position.X - 20, position.Y - size - 10, 40 * healthPercentage, 2)
	love.graphics.setColor(1, 1, 1)
end

return Healthbar
