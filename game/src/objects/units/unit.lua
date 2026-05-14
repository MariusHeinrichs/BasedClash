--- Unit class, representing a single unit in the game.

local EntityEnums = require("src.enums.entities")
local Object = require("src.objects.object")

---@class Unit : Object
---@field Health number
---@field MaxHealth number
---@field AttackSpeed number
---@field AttackRange number
---@field AggroRange number
---@field Target Object | nil
---@field TargetPriority EntityEnums.TargetPriorities
---@field Armor number
---@field ArmorType EntityEnums.ArmorTypes
---@field MovementSpeed number
---@field Size number
---@field IsFlying boolean
---@field Bounty number
---@field PlayerID number
local Unit = {}
Unit.__index = Unit

setmetatable(Unit, { __index = Object })

--- Creates a new Unit.
--- @generic T : Unit
--- @param self T
--- @param Name string | nil -- The name of the unit.
--- @param MaxHealth number | nil -- The maximum health of the unit.
--- @param AttackSpeed number | nil -- The attack speed of the unit.
--- @param AttackRange number | nil -- The attack range of the unit.
--- @param AggroRange number | nil -- The aggro range of the unit.
--- @param TargetPriority EntityEnums.TargetPriorities | nil -- The target priority of the unit.
--- @param Armor number | nil -- The armor value of the unit.
--- @param ArmorType EntityEnums.ArmorTypes | nil -- The type of armor of the unit.
--- @param MovementSpeed number | nil -- The movement speed of the unit.
--- @param Size number | nil -- The size of the unit.
--- @param IsFlying boolean | nil -- Whether the unit is flying.
--- @param Bounty number | nil -- The bounty awarded for defeating the unit.
--- @param PlayerID number | nil -- The ID of the player controlling the unit.
--- @return T
function Unit:new(Name, MaxHealth, AttackSpeed, AttackRange, AggroRange, TargetPriority, Armor,
				  ArmorType, MovementSpeed, Size, IsFlying, Bounty, PlayerID)
	local newUnit = Object.new(self, Name or "Unit")
	newUnit.MaxHealth = MaxHealth or 100
	newUnit.Health = newUnit.MaxHealth
	newUnit.AttackSpeed = AttackSpeed or 1
	newUnit.AttackRange = AttackRange or 1
	newUnit.AggroRange = AggroRange or 5
	newUnit.Target = nil
	newUnit.TargetPriority = TargetPriority or EntityEnums.TargetPriorities.UNIT
	newUnit.Armor = Armor or 0
	newUnit.ArmorType = ArmorType or EntityEnums.ArmorTypes.LEATHER
	newUnit.MovementSpeed = MovementSpeed or 1
	newUnit.Size = Size or 1
	newUnit.IsFlying = IsFlying or false
	newUnit.Bounty = Bounty or 10
	newUnit.PlayerID = PlayerID or 0
	return newUnit
end

--- draws the unit on the screen
function Unit:Draw()
	love.graphics.circle("fill", self.Position.X, self.Position.Y, self.Size)

	love.graphics.setColor(1, 1, 1)
end

return Unit
