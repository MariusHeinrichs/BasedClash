--- Damage over time class, representing a damage over time effect applied to a unit.

local Effect = require("src.objects.effects.effect")

---@class DamageOverTime : Effect
---@field Damage number
---@field Duration number
---@field TickInterval number
---@field ElapsedTime number
---@field TicksApplied number
local DamageOverTime = {}
DamageOverTime.__index = DamageOverTime
DamageOverTime.__type = "DamageOverTime"

setmetatable(DamageOverTime, { __index = Effect })

--- Creates a new DamageOverTime effect.
---@generic T : DamageOverTime
---@param self T
---@param Damage number
---@param Duration number
---@param TickInterval number
---@return T
function DamageOverTime:new(Damage, Duration, TickInterval)
	local newDoT = Effect.new(self, nil) -- Target will be set when applied
	newDoT.Damage = Damage or 0
	newDoT.Duration = Duration or 0
	newDoT.TickInterval = TickInterval or 0
	newDoT.ElapsedTime = 0
	newDoT.TicksApplied = 0
	return newDoT
end

---Updates the DoT effect and applies damage to target if TickInterval was hit.
---@param dt number
function DamageOverTime:Update(dt)
	self.ElapsedTime = self.ElapsedTime + dt
	if self.Target and self.ElapsedTime >= self.TickInterval then
		if self.Target.Health <= 0 then
			self.Target = nil -- Clear target if it's already dead
			return
		end
		local targetKilled = self.Target:TakeDamage(self.Damage)
		self.ElapsedTime = self.ElapsedTime - self.TickInterval
		self.TicksApplied = self.TicksApplied + 1
		if targetKilled then
			self.Target = nil -- Clear target if it's killed
		end
	end
end

--- Checks if the effect is expired
--- @return boolean
function DamageOverTime:IsExpired()
	return self.TicksApplied * self.TickInterval >= self.Duration
end

--- Applies the DoT effect to a target
---@param Target Unit | Structure | nil
function DamageOverTime:ApplyToTarget(Target)
	self.Target = Target
	if self.Target then
		self.Target:ApplyDoT(self)
	end
end

return DamageOverTime
