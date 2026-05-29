-- Singleton-Instanz
local instance = nil

-- Manages tables for all abilities. Handles adding and removing of abilities.
--- @class AbilityManager
--- @field Abilities Ability[]
local AbilityManager = {}
AbilityManager.__index = AbilityManager

--- Adds an ability to the ability manager
--- @param Ability Ability
function AbilityManager:SetAbility(Ability)
	table.insert(self.Abilities, Ability)
end

--- Removes an ability from the ability manager
--- @param Ability Ability
function AbilityManager:RemoveAbility(Ability)
	for i, a in ipairs(self.Abilities) do
		if a == Ability then
			table.remove(self.Abilities, i)
			break
		end
	end
end

--- Clears all ability lists
function AbilityManager:ClearAll()
	self.Abilities = {}
end

--- Draws all abilities (e.g., for visual indicators)
function AbilityManager:Draw()
	for _, ability in ipairs(self.Abilities) do
		ability:Draw()
	end
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			Abilities = {},
		}, AbilityManager)
	end
	return instance
end

return {
	getInstance = getInstance
}
