local effectManager = require("src.managers.effectManager").getInstance()
local entityManager = require("src.managers.entities").getInstance()

--- Handles the updating and management of effects in the game, such as damage over time, buffs, debuffs, etc.
local EffectSystem = {}

function EffectSystem:Update(dt)
	UpdateDoTs(dt)
end

function UpdateDoTs(dt)
	for _, unit in pairs(entityManager:GetUnits()) do
		for _, dot in pairs(unit:GetDoTs()) do
			dot:Update(dt)
		end
	end
end

return EffectSystem
