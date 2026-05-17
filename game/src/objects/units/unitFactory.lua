--- Factory for creating units.

local Knight = require("src.objects.units.meleeUnits.knight")
local Archer = require("src.objects.units.rangeUnits.archer")
local Mage = require("src.objects.units.rangeUnits.mage")
local Barbarian = require("src.objects.units.meleeUnits.barbarian")
local EntityEnums = require("src.enums.entities")

local UnitFactory = {}

--- Creates a Unit
--- @param unitType EntityEnums.Units
--- @param playerID number
--- @return Unit
function UnitFactory:CreateUnit(unitType, playerID)
	if unitType == EntityEnums.Units.KNIGHT then
		return Knight:new(playerID)
	elseif unitType == EntityEnums.Units.ARCHER then
		return Archer:new(playerID)
	elseif unitType == EntityEnums.Units.MAGE then
		return Mage:new(playerID)
	elseif unitType == EntityEnums.Units.BARBARIAN then
		return Barbarian:new(playerID)
	else
		error("Unknown unit type: " .. tostring(unitType))
	end
end

return UnitFactory
