-- Singleton-Instanz
local instance = nil

-- Manages tables of resources for all players. Handles adding and removing of resources.
--- @class ResourceManager
--- @field Resources table<number, {Gold: number, Metal: number, Aether: number}>
--- @field Income table<number, {Gold: number, Metal: number, Aether: number}>
--- @field IncomeRate number
--- @field IncomeTimer number
local ResourceManager = {}
ResourceManager.__index = ResourceManager

--- Adds a Resource table for a player.
--- @param PlayerID number
function ResourceManager:SetPlayer(PlayerID)
	self.Resources[PlayerID] = { Gold = 0, Metal = 0, Aether = 0 }
	self.Income[PlayerID] = { Gold = 0, Metal = 0, Aether = 0 }
end

--- Sets the resources for a player.
--- @param PlayerID number
--- @param Resources {Gold: number, Metal: number, Aether: number}
function ResourceManager:SetPlayerResources(PlayerID, Resources)
	self.Resources[PlayerID] = Resources
end

--- Sets the income for a player.
--- @param PlayerID number
--- @param Income {Gold: number, Metal: number, Aether: number}
function ResourceManager:SetPlayerIncome(PlayerID, Income)
	self.Income[PlayerID] = Income
end

--- Gets the resources for a player.
--- @param PlayerID number
--- @return {Gold: number, Metal: number, Aether: number}
function ResourceManager:GetPlayerResources(PlayerID)
	return self.Resources[PlayerID] or { Gold = 0, Metal = 0, Aether = 0 }
end

--- Gets the resources for all players.
--- @return table<number, {Gold: number, Metal: number, Aether: number}>
function ResourceManager:GetResources()
	return self.Resources
end

--- Gets the income for a player.
--- @param PlayerID number
--- @return {Gold: number, Metal: number, Aether: number}
function ResourceManager:GetPlayerIncome(PlayerID)
	return self.Income[PlayerID] or { Gold = 0, Metal = 0, Aether = 0 }
end

--- Gets the income for all players.
--- @return table<number, {Gold: number, Metal: number, Aether: number}>
function ResourceManager:GetIncomes()
	return self.Income
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

--- Adds income to a player's existing income.
--- @param PlayerID number
--- @param Income {Gold: number, Metal: number, Aether: number}
function ResourceManager:AddPlayerIncome(PlayerID, Income)
	local PlayerIncome = self:GetPlayerIncome(PlayerID)
	PlayerIncome.Gold = PlayerIncome.Gold + (Income.Gold or 0)
	PlayerIncome.Metal = PlayerIncome.Metal + (Income.Metal or 0)
	PlayerIncome.Aether = PlayerIncome.Aether + (Income.Aether or 0)
	self:SetPlayerIncome(PlayerID, PlayerIncome)
end

--- Substracts resources from a player's existing resources
--- @param PlayerID number
--- @param Resources {Gold: number, Metal: number, Aether: number}
--- @return boolean true if resources were successfully subtracted, false if the player did not have enough resources.
function ResourceManager:SubstractPlayerResources(PlayerID, Resources)
	local PlayerResources = self:GetPlayerResources(PlayerID)
	--- Check if the player has enough resources before subtracting
	if PlayerResources.Gold < (Resources.Gold or 0) or
		PlayerResources.Metal < (Resources.Metal or 0) or
		PlayerResources.Aether < (Resources.Aether or 0) then
		return false -- Not enough resources, return false to indicate failure.
	end
	PlayerResources.Gold = PlayerResources.Gold - (Resources.Gold or 0)
	PlayerResources.Metal = PlayerResources.Metal - (Resources.Metal or 0)
	PlayerResources.Aether = PlayerResources.Aether - (Resources.Aether or 0)
	self:SetPlayerResources(PlayerID, PlayerResources)
	return true -- Resources successfully subtracted.
end

--- Substracts income from a player's existing income
--- @param PlayerID number
--- @param Income {Gold: number, Metal: number, Aether: number}
function ResourceManager:SubstractPlayerIncome(PlayerID, Income)
	local PlayerIncome = self:GetPlayerIncome(PlayerID)
	PlayerIncome.Gold = PlayerIncome.Gold - (Income.Gold or 0)
	PlayerIncome.Metal = PlayerIncome.Metal - (Income.Metal or 0)
	PlayerIncome.Aether = PlayerIncome.Aether - (Income.Aether or 0)
	self:SetPlayerIncome(PlayerID, PlayerIncome)
end

--- Clears all player resources
function ResourceManager:ClearAll()
	self.Resources = {}
	self.Income = {}
	self.IncomeRate = 10
	self.IncomeTimer = 0
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			Resources = {},
			Income = {},
			IncomeRate = 0,
			IncomeTimer = 0
		}, ResourceManager)
	end
	return instance
end

return {
	getInstance = getInstance
}
