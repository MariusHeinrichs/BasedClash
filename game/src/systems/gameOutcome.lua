local EntityEnums = require("src.enums.entities")
local entityManager = require("src.managers.entities").getInstance()
local gameStateManager = require("src.managers.gamestate").getInstance()

--- System for handling game outcomes, such as determining when a player has won or lost, and triggering appropriate events or transitions in the game state.
local GameOutcomeSystem = {}

--- Checks for win conditions and updates the game state accordingly.
function GameOutcomeSystem:Update(dt)
	local structures = entityManager:GetStructures()
	local player1Base = nil
	local player2Base = nil

	for _, structure in ipairs(structures) do
		if structure.__type == EntityEnums.Structures.TOWNHALL then
			if structure.PlayerID == 1 then
				player1Base = structure
			elseif structure.PlayerID == 2 then
				player2Base = structure
			end
		end
	end

	if not player1Base then
		gameStateManager:EnterGameLost()
	elseif not player2Base then
		gameStateManager:EnterGameWon()
	end
end

return GameOutcomeSystem
