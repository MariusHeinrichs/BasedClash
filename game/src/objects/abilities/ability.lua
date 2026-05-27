--- Base Ability class for all unit abilities.

---@class Ability
---@field Name string
---@field Owner any
local Ability = {}
Ability.__index = Ability
Ability.__type = "Ability"

--- Creates a new Ability.
---@generic T : Ability
---@param self T
---@param Name string | nil
---@param Owner Unit | Structure | nil -- Reference to the owning unit or structure
---@return T
function Ability:new(Name, Owner, Cooldown)
	local newAbility = {}
	setmetatable(newAbility, self)
	newAbility.Name = Name or "Ability"
	newAbility.Owner = Owner or nil -- Reference to the owning unit/object
	return newAbility
end

---@param dt number
function Ability:Update(dt)
end

--- Stub methods for mixin functionality (to avoid errors if mixins are not properly added)
function Ability:InitHeal(HealAmount) end
function Ability:Heal(target) end
function Ability:InitCooldown(Cooldown) end
function Ability:StartCooldown() end
function Ability:UpdateCooldown(dt) end
function Ability:IsReady() return false end
function Ability:InitTargeting() end
function Ability:GetTarget() return nil end


return Ability
