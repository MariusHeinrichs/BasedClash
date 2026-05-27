-- Heal: Ability that restores health to the target. Can be used on self or allies.
local Ability = require("src.objects.abilities.ability")
local HealMixin = require("src.objects.abilities.mixins.healMixin")
local CooldownMixin = require("src.objects.abilities.mixins.cooldownMixin")
local TargetingMixin = require("src.objects.abilities.mixins.targetingMixin")

---@class Heal : Ability
---@field HealAmount number
---@field Cooldown number
---@field CooldownTimer number
---@field Target any
local Heal = setmetatable({}, { __index = Ability })
Heal.__index = Heal
Heal.__type = "Heal"

---Creates a new Heal abilitie
---@param Name string | nil
---@param Owner Structure | Unit | nil
---@param HealAmount number | nil
---@param Cooldown number | nil
---@return Ability
function Heal:new(Name, Owner, HealAmount, Cooldown)
    local newAbility = Ability:new(Name or "Heal", Owner)

    -- Add mixins
    for k, v in pairs(HealMixin) do newAbility[k] = v end
    for k, v in pairs(CooldownMixin) do newAbility[k] = v end
    for k, v in pairs(TargetingMixin) do newAbility[k] = v end
    newAbility:initHeal(HealAmount or 20)
    newAbility:initCooldown(Cooldown or 5)
    newAbility:initTargeting()
    return newAbility
end

function Heal:activate(target)
    if self:isReady() then
        local tgt = target or self:getTarget() or self.Owner
        self:heal(tgt)
        self:startCooldown()
    end
end

function Heal:update(dt)
    self:updateCooldown(dt)
end

return Heal
