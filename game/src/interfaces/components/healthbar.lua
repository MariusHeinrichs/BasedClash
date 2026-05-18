--- Healthbar class for displaying unit health in the BattleHUD.
--- @class Healthbar
--- @field MaxHealth number
--- @field Health number
--- @field Position table
--- @field PlayerID number
local Healthbar = {}
Healthbar.__index = Healthbar

--- Creates a new Healthbar for a Unit or Structure.
--- @param Object Unit | Structure The unit or structure to create the healthbar for.
--- @return Healthbar
function Healthbar:new(Object)
	local newHealthbar = {}
	setmetatable(newHealthbar, self)
	newHealthbar.MaxHealth = Object.MaxHealth or 100
	newHealthbar.Health = Object.Health or newHealthbar.MaxHealth
	newHealthbar.Position = Object.Position or { X = 0, Y = 0 }
	newHealthbar.PlayerID = Object.PlayerID or 1

	return newHealthbar
end

--- Draws the healthbar on the screen.
function Healthbar:Draw()
	if self.Health <= 0 then
		return -- Don't draw if the unit is dead.
	end
	if self.MaxHealth <= 0 then
		return -- Avoid division by zero.
	end
	-- Draw the background of the healthbar
	if self.PlayerID == 1 then
		love.graphics.setColor(0, 1, 0) -- Green for player 1
	else
		love.graphics.setColor(1, 0, 0) -- Red for player 2
	end
	love.graphics.rectangle("fill", self.Position.X - 25, self.Position.Y - 40, 50, 8)
	-- Draw the foreground of the healthbar (green/red based on health percentage)
	local healthPercentage = self.Health / self.MaxHealth
	love.graphics.setColor(1 - healthPercentage, healthPercentage, 0)
	love.graphics.rectangle("fill", self.Position.X - 25, self.Position.Y - 40, 50 * healthPercentage, 8)
	love.graphics.setColor(1, 1, 1)
end

return Healthbar
