

-- Singleton-Instanz
local instance = nil

-- Manages tables for all entities. Handles adding and removing of entities.
--- @class EntityManager
--- @field Units Unit[]
--- @field Projectiles Projectile[]
--- @field Structures Structure[]
local EntityManager = {}
EntityManager.__index = EntityManager

--- Adds a unit to the entity manager
--- @param Unit Unit
function EntityManager:SetUnit(Unit)
	table.insert(self.Units, Unit)
end

--- Adds a projectile to the entity manager
--- @param Projectile Projectile
function EntityManager:SetProjectile(Projectile)
	table.insert(self.Projectiles, Projectile)
end

--- Adds a structure to the entity manager
--- @param Structure Structure
function EntityManager:SetStructure(Structure)
	table.insert(self.Structures, Structure)
end

--- Returns the table with all units
--- @return Unit[]
function EntityManager:GetUnits()
	return self.Units
end

--- Returns the table with all projectiles
--- @return Projectile[]
function EntityManager:GetProjectiles()
	return self.Projectiles
end

--- Returns the table with all structures
--- @return Structure[]
function EntityManager:GetStructures()
	return self.Structures
end

--- Removes a unit from the entity manager
--- @param Unit Unit
function EntityManager:RemoveUnit(Unit)
	for i, u in ipairs(self.Units) do
		if u == Unit then
			table.remove(self.Units, i)
			return
		end
	end
end

--- Removes a projectile from the entity manager
--- @param Projectile Projectile
function EntityManager:RemoveProjectile(Projectile)
	for i, p in ipairs(self.Projectiles) do
		if p == Projectile then
			table.remove(self.Projectiles, i)
			return
		end
	end
end

--- Removes a structure from the entity manager
--- @param Structure Structure
function EntityManager:RemoveStructure(Structure)
	for i, s in ipairs(self.Structures) do
		if s == Structure then
			table.remove(self.Structures, i)
			return
		end
	end
end

--- Clears all entity lists
function EntityManager:ClearAll()
	self.Units = {}
	self.Projectiles = {}
	self.Structures = {}
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			Units = {},
			Projectiles = {},
			Structures = {},
		}, EntityManager)
	end
	return instance
end

return {
	getInstance = getInstance
}
