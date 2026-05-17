local Structure = require("src.objects.structures.structure")
local EntityEnums = require("src.enums.entities")

--- RangeDefenseStructure class, representing a structure that can attack units at a range in the game.
---@class RangeDefenseStructure : Structure
---@field Projectile EntityEnums.ProjectileTypes -- The projectile used by the structure.
---@field AttackSpeed number -- The attack speed of the structure (attacks per second).
---@field AttackRange number -- The attack range of the structure.
---@field TargetPriority EntityEnums.TargetPriorities -- The target priority of the structure.
---@field AttackTimer number -- Timer to manage attack cooldowns.
local RangeDefenseStructure = {}
RangeDefenseStructure.__index = RangeDefenseStructure

setmetatable(RangeDefenseStructure, { __index = Structure })

--- Creates a new RangeDefenseStructure.
--- @generic T : RangeDefenseStructure
--- @param self T
--- @param Name string | nil -- The name of the structure.
--- @param MaxHealth number | nil -- The maximum health of the structure.
--- @param Armor number | nil -- The armor value of the structure.
--- @param ArmorType EntityEnums.ArmorTypes | nil -- The type of armor of the structure.
--- @param Costs {Gold: number, Metal: number, Aether: number} | nil -- The resource costs to build the structure.
--- @param Size number | nil -- The size of the structure.
--- @param Projectile EntityEnums.ProjectileTypes | nil -- The projectile used by the structure.
--- @param AttackSpeed number | nil -- The attack speed of the structure (attacks per second).
--- @param AttackRange number | nil -- The attack range of the structure.
--- @param TargetPriority EntityEnums.TargetPriorities | nil -- The target priority of the structure.
--- @param Bounty number | nil -- The bounty awarded for defeating the structure.
--- @param PlayerID number | nil -- The ID of the player controlling the structure.
--- @return T
function RangeDefenseStructure:new(Name, MaxHealth, Armor, ArmorType, Costs, Size, Projectile, AttackSpeed, AttackRange, TargetPriority, Bounty, PlayerID)
	local newRangeDefenseStructure = Structure.new(self,
		Name,
		MaxHealth,
		Armor,
		ArmorType,
		Costs,
		Size,
		Bounty,
		PlayerID
	)
	newRangeDefenseStructure.Projectile = Projectile or EntityEnums.ProjectileTypes.ARROW
	newRangeDefenseStructure.AttackRange = AttackRange or 5
	newRangeDefenseStructure.AttackSpeed = AttackSpeed or 1
	newRangeDefenseStructure.TargetPriority = TargetPriority or EntityEnums.TargetPriorities.UNIT
	newRangeDefenseStructure.AttackTimer = 0
	return newRangeDefenseStructure
end

return RangeDefenseStructure
