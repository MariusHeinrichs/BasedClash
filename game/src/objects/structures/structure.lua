--- Structure class, representing a single structure in the game.

local EntityEnums = require("src.enums.entities")
local Object = require("src.objects.object")

---@class Structure : Object
---@field Health number
---@field MaxHealth number
---@field Armor number
---@field ArmorType EntityEnums.ArmorTypes
---@field Costs table
---@field Size number
---@field Bounty number
---@field PlayerID number
local Structure = {}
Structure.__index = Structure

setmetatable(Structure, { __index = Object })

--- Creates a new Structure.
--- @generic T : Structure
--- @param self T
--- @param Name string | nil -- The name of the structure.
--- @param MaxHealth number | nil -- The maximum health of the structure.
--- @param Armor number | nil -- The armor value of the structure.
--- @param ArmorType EntityEnums.ArmorTypes | nil -- The type of armor of the structure.
--- @param Costs {Gold: number, Metal: number, Aether: number} | nil -- The resource costs to build the structure.
--- @param Size number | nil -- The size of the structure.
--- @param Bounty number | nil -- The bounty awarded for defeating the structure.
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function Structure:new(Name, MaxHealth, Armor, ArmorType, Costs, Size, Bounty, PlayerID)
	local newStructure = Object.new(self, Name or "Structure")
	newStructure.MaxHealth = MaxHealth or 500
	newStructure.Health = newStructure.MaxHealth
	newStructure.Armor = Armor or 5
	newStructure.ArmorType = ArmorType or EntityEnums.ArmorTypes.STRUCTURE
	newStructure.Costs = Costs or { Gold = 100, Metal = 50, Aether = 25 }
	newStructure.Size = Size or 4
	newStructure.Bounty = Bounty or 50
	newStructure.PlayerID = PlayerID or 0
	return newStructure
end

--- draws the structure on the screen 
function Structure:Draw()
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

return Structure
