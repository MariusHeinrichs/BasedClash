--- Unit class, representing a single unit in the game.

local EntityEnums = require("src.enums.entities")
local Object = require("src.objects.object")

---@class Unit : Object
---@field Health number
---@field MaxHealth number
---@field Damage number
---@field DamageType EntityEnums.DamageTypes
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
--- @param Name string | nil
--- @param MaxHealth number | nil
--- @param Damage number | nil
--- @param DamageType EntityEnums.DamageTypes | nil
--- @param AttackSpeed number | nil
--- @param AttackRange number | nil
--- @param AggroRange number | nil
--- @param TargetPriority EntityEnums.TargetPriorities | nil
--- @param Armor number | nil
--- @param ArmorType EntityEnums.ArmorTypes | nil
--- @param MovementSpeed number | nil
--- @param Size number | nil
--- @param IsFlying boolean | nil
--- @param Bounty number | nil
--- @param PlayerID number | nil
--- @return T
function Unit:new(Name, MaxHealth, Damage, DamageType, AttackSpeed, AttackRange, AggroRange, TargetPriority, Armor,
				  ArmorType, MovementSpeed, Size, IsFlying, Bounty, PlayerID)
	local newUnit = Object.new(self, Name or "Unit")
	newUnit.MaxHealth = MaxHealth or 100
	newUnit.Health = newUnit.MaxHealth
	newUnit.Damage = Damage or 10
	newUnit.DamageType = DamageType or EntityEnums.DamageTypes.PHYSICAL
	newUnit.AttackSpeed = AttackSpeed or 1
	newUnit.AttackRange = AttackRange or 1
	newUnit.AggroRange = AggroRange or 5
	newUnit.Target = nil
	newUnit.TargetPriority = TargetPriority or EntityEnums.TargetPriorities.Unit
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
