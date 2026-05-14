--- Structure class, representing a single structure in the game.

local EntityEnums = require("src.enums.entityconstants")
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
--- @param Name string | nil
--- @param MaxHealth number | nil
--- @param Armor number | nil
--- @param ArmorType EntityEnums.ArmorTypes | nil
--- @param Costs {Gold: number, Metal: number, Aether: number} | nil
--- @param Size number | nil
--- @param Bounty number | nil
--- @param PlayerID number | nil
--- @return T
function Structure:new(Name, MaxHealth, Armor, ArmorType, Costs, Size, Bounty, PlayerID)
	local newStructure = Object.new(self, Name or "Structure")
	newStructure.MaxHealth = MaxHealth or 500
	newStructure.Health = newStructure.MaxHealth
	newStructure.Armor = Armor or 0
	newStructure.ArmorType = ArmorType or EntityEnums.ArmorTypes.PLATE
	newStructure.Costs = Costs or { Gold = 100, Metal = 50, Aether = 25 }
	newStructure.Size = Size or 2
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

return Structure
