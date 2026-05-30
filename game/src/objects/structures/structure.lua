--- Structure class, representing a single structure in the game.

local EntityEnums = require("src.enums.entities")
local Object = require("src.objects.object")
local DoTEnums = require("src.enums.dots")

---@class Structure : Object
---@field Health number
---@field MaxHealth number
---@field Armor number
---@field ArmorType EntityEnums.ArmorTypes
---@field Costs {Gold: number, Metal: number, Aether: number}
---@field IncomeBonus {Gold: number, Metal: number, Aether: number}
---@field Bounty number
---@field DoTEffects DoTEnums.DoTTypes[] -- List of DoT effects currently applied to the structure
---@field PlayerID number
local Structure = {}
Structure.__index = Structure
Structure.__type = "Structure"

setmetatable(Structure, { __index = Object })

--- Creates a new Structure.
--- @generic T : Structure
--- @param self T
--- @param Name string | nil -- The name of the structure.
--- @param MaxHealth number | nil -- The maximum health of the structure.
--- @param Armor number | nil -- The armor value of the structure.
--- @param ArmorType EntityEnums.ArmorTypes | nil -- The type of armor of the structure.
--- @param Costs {Gold: number, Metal: number, Aether: number} | nil -- The resource costs to build the structure.
--- @param IncomeBonus {Gold: number, Metal: number, Aether: number} | nil -- The income bonus provided by the structure.
--- @param Size number | nil -- The size of the structure.
--- @param Bounty number | nil -- The bounty awarded for defeating the structure.
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Structure:new(Name, MaxHealth, Armor, ArmorType, Costs, IncomeBonus, Size, Bounty, PlayerID)
	local newStructure = Object.new(self, Name or "Structure", Size)
	newStructure.MaxHealth = MaxHealth or 500
	newStructure.Health = newStructure.MaxHealth
	newStructure.Armor = Armor or 5
	newStructure.ArmorType = ArmorType or EntityEnums.ArmorTypes.STRUCTURE
	newStructure.Costs = Costs or { Gold = 100, Metal = 50, Aether = 25 }
	newStructure.IncomeBonus = IncomeBonus or { Gold = 0, Metal = 0, Aether = 0 }
	newStructure.Bounty = Bounty or 50
	newStructure.PlayerID = PlayerID or 0
	newStructure.DoTEffects = {} -- Initialize the list of DoT effects
	return newStructure
end

--- draws the structure on the screen
function Structure:Draw()
	if self.PlayerID == 1 then
		love.graphics.setColor(0, 1, 0) -- Green for player 1
	else
		love.graphics.setColor(1, 0, 0) -- Red for player 2
	end

	love.graphics.rectangle("fill", self.Position.X - self.Size / 2, self.Position.Y - self.Size / 2, self.Size,
		self.Size)
	love.graphics.setColor(1, 1, 1)
end

--- Base spawn function for structures, can be overridden by specific structure types like SpawningStructure.
--- @param dt number
--- @return Unit[] | nil
function Structure:Spawn(dt)
	return nil
end

--- Reduces the structure's health by the specified amount of damage.
---@param Amount number -- The amount of damage to apply to the structure.
---@return boolean dead -- Returns true if the structure dies from the damage, false otherwise.
function Structure:TakeDamage(Amount)
	local dead = false
	self.Health = self.Health - Amount
	if self.Health <= 0 then
		self.Health = 0
		dead = true
	end
	return dead
end

---Applies a DoT effect on to the Structure
---@param DoT DamageOverTime -- The damage over time effect to apply to the structure.
function Structure:ApplyDoT(DoT)
	table.insert(self.DoTEffects, DoT)
end

---Removes the DoT from the Structure
---@param DoT DamageOverTime
function Structure:RemoveDoT(DoT)
	for i, activeDoT in ipairs(self.DoTEffects) do
		if activeDoT == DoT then
			table.remove(self.DoTEffects, i)
			break
		end
	end
end

---Returns all currently applied DoT effects
---@return DamageOverTime[]
function Structure:GetDoTs()
	return self.DoTEffects
end

return Structure
