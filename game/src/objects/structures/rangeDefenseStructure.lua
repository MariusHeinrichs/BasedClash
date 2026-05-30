local Structure = require("src.objects.structures.structure")
local EntityEnums = require("src.enums.entities")
local ProjectileFactory = require("src.objects.projectiles.projectileFactory")
local entityManager = require("src.managers.entities").getInstance()

--- RangeDefenseStructure class, representing a structure that can attack units at a range in the game.
---@class RangeDefenseStructure : Structure
---@field Projectile EntityEnums.ProjectileTypes -- The projectile used by the structure.
---@field AttackSpeed number -- The attack speed of the structure (attacks per second).
---@field AttackRange number -- The attack range of the structure.
---@field AggroRange number -- The aggro range of the structure, within which it will detect and target enemies.
---@field Target Unit | Structure | nil -- The current target of the structure, which can be a unit, another structure, or nil if no target is selected.
---@field TargetPriority EntityEnums.TargetPriorities -- The target priority of the structure.
---@field AttackTimer number -- Timer to manage attack cooldowns.
local RangeDefenseStructure = {}
RangeDefenseStructure.__index = RangeDefenseStructure
RangeDefenseStructure.__type = "RangeDefenseStructure"

setmetatable(RangeDefenseStructure, { __index = Structure })

--- Creates a new RangeDefenseStructure.
--- @generic T : RangeDefenseStructure
--- @param self T
--- @param Name string | nil -- The name of the structure.
--- @param MaxHealth number | nil -- The maximum health of the structure.
--- @param Armor number | nil -- The armor value of the structure.
--- @param ArmorType EntityEnums.ArmorTypes | nil -- The type of armor of the structure.
--- @param Costs {Gold: number, Metal: number, Aether: number} | nil -- The resource costs to build the structure.
--- @param IncomeBonus {Gold: number, Metal: number, Aether: number} | nil -- The income bonus provided by the structure.
--- @param Size number | nil -- The size of the structure.
--- @param Projectile EntityEnums.ProjectileTypes | nil -- The projectile used by the structure.
--- @param AttackSpeed number | nil -- The attack speed of the structure (attacks per second).
--- @param AttackRange number | nil -- The attack range of the structure.
--- @param AggroRange number | nil -- The aggro range of the structure, within which it will detect and target enemies.
--- @param TargetPriority EntityEnums.TargetPriorities | nil -- The target priority of the structure.
--- @param Bounty number | nil -- The bounty awarded for defeating the structure.
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function RangeDefenseStructure:new(Name, MaxHealth, Armor, ArmorType, Costs, IncomeBonus, Size, Projectile, AttackSpeed,
								   AttackRange, AggroRange, TargetPriority, Bounty, PlayerID)
	local newRangeDefenseStructure = Structure.new(self,
		Name,
		MaxHealth,
		Armor,
		ArmorType,
		Costs,
		IncomeBonus,
		Size,
		Bounty,
		PlayerID
	)
	newRangeDefenseStructure.Projectile = Projectile or EntityEnums.ProjectileTypes.ARROW
	newRangeDefenseStructure.AttackRange = AttackRange or 5
	newRangeDefenseStructure.AttackSpeed = AttackSpeed or 1
	newRangeDefenseStructure.AggroRange = AggroRange or 200
	newRangeDefenseStructure.Target = nil
	newRangeDefenseStructure.TargetPriority = TargetPriority or EntityEnums.TargetPriorities.UNIT
	newRangeDefenseStructure.AttackTimer = 0
	return newRangeDefenseStructure
end

--- Sets the target for the structure.
--- @param Target Unit | Structure | nil -- The target to set for the structure.
function RangeDefenseStructure:SetTarget(Target)
	self.Target = Target
end

function RangeDefenseStructure:IsTargetInRange()
	if not self.Target then
		return false
	end
	local dx = self.Target.Position.X - self.Position.X
	local dy = self.Target.Position.Y - self.Position.Y
	local distanceSquared = dx * dx + dy * dy
	return distanceSquared <= self.AttackRange * self.AttackRange
end

--- Executes a ranged attack, shooting a projectile at the target.
--- @param dt number -- The delta time since the last update, used for timing attacks based on attack speed.
--- @return Projectile | nil projectile -- Returns the created projectile if an attack was executed, nil otherwise.
function RangeDefenseStructure:Attack(dt)
	-- No target to attack.
	if not self.Target then
		return
	end
	-- Check if enough time has elapsed since the last attack.
	self.AttackTimer = (self.AttackTimer or 0) + dt
	if self.AttackTimer < self.AttackSpeed then
		return
	end
	-- Check if the target is still in attack range.
	if not self:IsTargetInRange() then
		return
	end
	self.AttackTimer = 0
	-- Create a projectile
	local projectile = ProjectileFactory:CreateProjectile(self.Projectile, self, self.Target)
	if projectile then
		entityManager:SetProjectile(projectile)
	end
end

return RangeDefenseStructure
