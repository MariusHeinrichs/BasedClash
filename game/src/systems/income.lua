local ResourceManager = require("src.managers.resources").getInstance()

--- Handles the income phase of the game, iterating through player resources and applying income bonuses from structures to update the player's total resources.
local IncomeSystem = {}

function IncomeSystem:Update(dt)
	-- Check if enough time has passed to apply income bonuses, if not, return early and wait for the next update cycle.
	ResourceManager.IncomeTimer = ResourceManager.IncomeTimer + dt
	if ResourceManager.IncomeTimer >= ResourceManager.IncomeRate then
		ResourceManager.IncomeTimer = ResourceManager.IncomeTimer - ResourceManager.IncomeRate

		--- Iterate through each player's resources and apply their income bonuses to update their total resources accordingly.
		local incomes = ResourceManager:GetIncomes()

		for playerID, playerIncome in pairs(incomes) do
			ResourceManager:AddPlayerResources(playerID, playerIncome)
		end
	end
end

return IncomeSystem
