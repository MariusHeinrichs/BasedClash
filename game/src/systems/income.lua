local resourceManager = require("src.managers.resources").getInstance()

--- Handles the income phase of the game, iterating through player resources and applying income bonuses from structures to update the player's total resources.
local IncomeSystem = {}

function IncomeSystem:Update(dt)
	-- Check if enough time has passed to apply income bonuses, if not, return early and wait for the next update cycle.
	resourceManager.IncomeTimer = resourceManager.IncomeTimer + dt
	if resourceManager.IncomeTimer >= resourceManager.IncomeRate then
		resourceManager.IncomeTimer = resourceManager.IncomeTimer - resourceManager.IncomeRate

		--- Iterate through each player's resources and apply their income bonuses to update their total resources accordingly.
		local incomes = resourceManager:GetIncomes()

		for playerID, playerIncome in pairs(incomes) do
			resourceManager:AddPlayerResources(playerID, playerIncome)
		end
	end
end

return IncomeSystem
