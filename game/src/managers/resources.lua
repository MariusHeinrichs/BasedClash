-- Singleton-Instanz
local instance = nil

-- Manages tables of resources for all players. Handles adding and removing of resources.
local ResourceManager = {}
ResourceManager.__index = ResourceManager

--- Adds a Resource table for a player.
--- @param PlayerID number
function ResourceManager:SetPlayer(PlayerID)
	self.Resources[PlayerID] = { Gold = 0, Metal = 0, Aether = 0 }
end

--- Sets the resources for a player.
--- @param PlayerID number
--- @param Resources {Gold: number, Metal: number, Aether: number}
function ResourceManager:SetPlayerResources(PlayerID, Resources)
	self.Resources[PlayerID] = Resources
end

--- Gets the resources for a player.
--- @param PlayerID number
--- @return {Gold: number, Metal: number, Aether: number}
function ResourceManager:GetPlayerResources(PlayerID)
	return self.Resources[PlayerID] or { Gold = 0, Metal = 0, Aether = 0 }
end

--- Adds resources to a player's existing resources.
--- @param PlayerID number
--- @param Resources {Gold: number, Metal: number, Aether: number}
function ResourceManager:AddPlayerResources(PlayerID, Resources)
	local PlayerResources = self:GetPlayerResources(PlayerID)
	PlayerResources.Gold = PlayerResources.Gold + (Resources.Gold or 0)
	PlayerResources.Metal = PlayerResources.Metal + (Resources.Metal or 0)
	PlayerResources.Aether = PlayerResources.Aether + (Resources.Aether or 0)
	self:SetPlayerResources(PlayerID, PlayerResources)
end

--- Substracts resources from a player's existing resources
--- @param PlayerID number
--- @param Resources {Gold: number, Metal: number, Aether: number}
function ResourceManager:SubstractPlayerResources(PlayerID, Resources)
	local PlayerResources = self:GetPlayerResources(PlayerID)
	PlayerResources.Gold = PlayerResources.Gold - (Resources.Gold or 0)
	PlayerResources.Metal = PlayerResources.Metal - (Resources.Metal or 0)
	PlayerResources.Aether = PlayerResources.Aether - (Resources.Aether or 0)
	self:SetPlayerResources(PlayerID, PlayerResources)
end

--- Clears all player resources
function ResourceManager:ClearAll()
	self.Resources = {}
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			Resources = {}
		}, ResourceManager)
	end
	return instance
end

return {
	getInstance = getInstance
}
