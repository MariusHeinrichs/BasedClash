--- -- Singleton-Instanz
local instance = nil

-- Manages tables for all Effects (DoTs, Hots, Buffs). Handles adding and removing of effects.
--- @class EffectManager
--- @field Effects Effect[]
local EffectManager = {}
EffectManager.__index = EffectManager

--- Adds an effect to the effect manager
--- @param Effect Effect
function EffectManager:SetEffect(Effect)
	table.insert(self.Effects, Effect)
end

--- Removes an effect from the effect manager
--- @param Effect Effect
function EffectManager:RemoveEffect(Effect)
	for i, a in ipairs(self.Effects) do
		if a == Effect then
			table.remove(self.Effects, i)
			break
		end
	end
end

--- Clears all effect lists
function EffectManager:ClearAll()
	self.Effects = {}
end

--- Draws all effects (e.g., for visual indicators)
function EffectManager:Draw()
	for _, effect in ipairs(self.Effects) do
		effect:Draw()
	end
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			Effects = {},
		}, EffectManager)
	end
	return instance
end

return {
	getInstance = getInstance
}
