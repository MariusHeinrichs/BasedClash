--- Base Ability class for all unit abilities.

---@class Ability
---@field Name string
---@field Owner Unit | Structure | nil
local Ability = {}
Ability.__index = Ability
Ability.__type = "Ability"

--- Creates a new Ability.
---@generic T : Ability
---@param self T
---@param Name string | nil
---@param Owner Unit | Structure | nil -- Reference to the owning unit or structure
---@return T
function Ability:new(Name, Owner)
	local newAbility = {}
	setmetatable(newAbility, self)
	newAbility.Name = Name or "Ability"
	newAbility.Owner = Owner or nil -- Reference to the owning unit/object
	return newAbility
end

---@param dt number
function Ability:Update(dt)
end

function Ability:Activate()
end

function Ability:Draw(dt)
end

--- Stub methods for mixin functionality (to avoid errors if mixins are not properly added)

-- heal mixin

---Sets the heal amount for the ability
---@param HealAmount number
function Ability:InitHeal(HealAmount) end

---Heals the target with the ability
---@param Target Unit | Structure
function Ability:Heal(Target) end

-- cooldown mixin

---Sets the cooldown for the ability
---@param Cooldown number
function Ability:InitCooldown(Cooldown) end

---Restarts the cooldown for the ability
function Ability:StartCooldown() end

---Updates the cooldown for the ability
---@param dt number
function Ability:UpdateCooldown(dt) end

---Checks if the ability is ready to be used
---@return boolean | nil
function Ability:IsReady() return nil end

-- targeting mixin

---Initializes the targeting parameters for the ability
---@param TargetType AbilityEnums.TargetTypes
---@param TargetCriterias {HPCriteria: AbilityEnums.TargetCriteria.HPCriteria | nil, TeamCriteria: AbilityEnums.TargetCriteria.TeamCriteria | nil, UnitTypeCriteria: AbilityEnums.TargetCriteria.UnitTypeCriteria | nil, DistanceCriteria: AbilityEnums.TargetCriteria.DistanceCriteria | nil, TargetTypeCriteria: AbilityEnums.TargetCriteria.TargetTypeCriteria | nil} | nil
---@param AbilityRange number
function Ability:InitTargeting(TargetType, TargetCriterias, AbilityRange) end

--- Gets the targeting criteria for the ability
---@return table | nil
function Ability:GetTargetCriterias() return nil end

--- Sets the target for the ability
---@param Target Unit | Structure
function Ability:SetTarget(Target) end

--- Gets the target of the ability
---@return Unit | Structure | nil
function Ability:GetTarget() return nil end

--- Gets the range of the ability
---@return integer | nil
function Ability:GetAbilityRange() return nil end

--- visual mixin

--- Initializes the visual duration for the ability
--- @param VisualDuration number
function Ability:InitVisualDuration(VisualDuration) end

--- Starts the visual duration timer for the ability
function Ability:StartVisualDuration() end

--- Updates the visual duration timer for the ability
--- @param dt number
function Ability:UpdateVisualDuration(dt) end

--- Checks if the visual duration has ended for the ability
--- @return boolean | nil
function Ability:VisualDurationEnded() return nil end

--- projectile mixin

--- Sets the type of projectile to be used by the ability.
---@param Projectile EntityEnums.ProjectileTypes
function Ability:InitProjectile(Projectile) end

--- Creates and fires a projectile towards the target.
---@param Target Unit | Structure
function Ability:FireProjectile(Target) end

--- DoT mixin

--- Initializes the DoT parameters for the ability
---@param DoTDamage number
---@param DoTDuration number
---@param DoTTickInterval number
function Ability:InitDoT(DoTDamage, DoTDuration, DoTTickInterval) end

function Ability:UpdateDoT(dt) end

return Ability
