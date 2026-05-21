--- Unit class, representing a single unit in the game.

local EntityEnums = require("src.enums.entities")
local Object = require("src.objects.object")

---@class Unit : Object
---@field Health number
---@field MaxHealth number
---@field AttackSpeed number
---@field AttackRange number
---@field AggroRange number
---@field Target Unit | Structure | nil
---@field TargetPriority EntityEnums.TargetPriorities
---@field Armor number
---@field ArmorType EntityEnums.ArmorTypes
---@field MovementSpeed number
---@field Size number
---@field IsFlying boolean
---@field Bounty number
---@field PlayerID number
---@field AttackTimer number
---@field Path Path | nil
---@field CurrentWayPointIndex number
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
	newUnit.AttackTimer = 0
	newUnit.Path = nil
	newUnit.CurrentWayPointIndex = nil
	return newUnit
end

--- draws the unit on the screen
function Unit:Draw()
	love.graphics.circle("fill", self.Position.X, self.Position.Y, self.Size)

	love.graphics.setColor(1, 1, 1)
end

--- Moves the unit closer to its target.
---@param dt any
function Unit:MoveToTarget(dt)
	if self.Target then
		local dx = self.Target.Position.X - self.Position.X
		local dy = self.Target.Position.Y - self.Position.Y
		local distance = math.sqrt(dx * dx + dy * dy)

		if distance > 0 then
			local moveX = (dx / distance) * self.MovementSpeed * dt
			local moveY = (dy / distance) * self.MovementSpeed * dt

			self:SetPosition({ X = self.Position.X + moveX, Y = self.Position.Y + moveY })
		end
	end
end

function Unit:MoveAlongPath(dt)
	if self.Path then
		--- unit does not have a current waypoint index, we need to find the closest waypoint to the unit's current position and set it as the current waypoint index.
		if not self.CurrentWayPointIndex then
			local currentWaypointIndex = self.Path:GetClosestWaypointIndex(self.Position.X, self.Position.Y)
			self.CurrentWayPointIndex = currentWaypointIndex or 1
		end
		local isAtWaypoint = self.Path:IsAtWaypoint(self.CurrentWayPointIndex, self.Position.X, self.Position.Y)
		if isAtWaypoint then
			--- If the unit is at the current waypoint, we need to move to the next waypoint in the path.
			local direction = self.PlayerID == 1 and 1 or -1
			self.CurrentWayPointIndex = self.CurrentWayPointIndex + direction
		end
		-- If the unit has a current waypoint index, we need to move towards the current waypoint.
		local waypoint = self.Path:GetWaypoint(self.CurrentWayPointIndex)
		if waypoint then
			local dx = waypoint.X - self.Position.X
			local dy = waypoint.Y - self.Position.Y
			local distance = math.sqrt(dx * dx + dy * dy)

			if distance > 0 then
				local moveX = (dx / distance) * self.MovementSpeed * dt
				local moveY = (dy / distance) * self.MovementSpeed * dt

				self:SetPosition({ X = self.Position.X + moveX, Y = self.Position.Y + moveY })
			end
		end
	end
end

---Checks if the current target is in attack range
---@return boolean inRange -- Returns true if the target is in attack range, false otherwise.
function Unit:IsTargetInRange()
	if not self.Target then
		return false
	end
	local dx = self.Target.Position.X - self.Position.X
	local dy = self.Target.Position.Y - self.Position.Y
	local distance = math.sqrt(dx * dx + dy * dy)
	return distance <= self.AttackRange
end

--- Sets the target for the unit.
--- @param Target Unit | Structure | nil -- The target to set for the unit.
function Unit:SetTarget(Target)
	self.Target = Target
end

---Sets the current path the unit should follow.
---@param Path Path
function Unit:SetPath(Path)
	self.Path = Path
end

---Returns the current target of the unit
---@return Structure|Unit|nil
function Unit:GetTarget()
	return self.Target
end

---Returns the current path the unit is following
---@return Path|nil
function Unit:GetPath()
	return self.Path
end

--- Executes an attack on the unit's current target.
function Unit:Attack(dt)
	-- Attack logic will be implemented in MeleeUnit and RangeUnit subclasses.
end

--- Reduces the unit's health by the specified amount of damage.
---@param Amount number -- The amount of damage to apply to the unit.
---@return boolean dead -- Returns true if the unit dies from the damage, false otherwise.
function Unit:TakeDamage(Amount)
	local dead = false
	self.Health = self.Health - Amount
	if self.Health <= 0 then
		self.Health = 0
		dead = true
	end
	return dead
end

return Unit
