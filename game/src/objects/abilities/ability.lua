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
function Ability:initHeal(HealAmount) end
function Ability:heal(target) end
function Ability:initCooldown(Cooldown) end
function Ability:startCooldown() end
function Ability:updateCooldown(dt) end
function Ability:isReady() return false end
function Ability:initTargeting() end
function Ability:getTarget() return nil end


return Ability
