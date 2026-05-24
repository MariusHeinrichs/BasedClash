--- Handles the creation and placement of structures in the world.
local entityManager = require("src.managers.entities").getInstance()
local resourceManager = require("src.managers.resources").getInstance()
local structureHashGrid = require("src.utilities.structureHashGrid").getInstance()
local StructureFactory = require("src.objects.structures.structureFactory")


-- Singleton-Instanz
local instance = nil

--- @class StructurePlacement
--- @field SelectedStructureType EntityEnums.Structures | nil
local StructurePlacement = {}
StructurePlacement.__index = StructurePlacement
StructurePlacement.SelectedStructureType = nil

---Sets the selected StructureType
---@param StructureType EntityEnums.Structures | nil
function StructurePlacement:SetSelectedStructureType(StructureType)
	self.SelectedStructureType = StructureType
end

--- Places the currently selected Structure at the given position if possible
--- @param Position { X: number, Y: number } the position to place the structure
--- @param PlayerID number the ID of the player placing the structure
--- @return string | nil failureMessage - returns a string describing the reason for failure, or nil if placement was successful
function StructurePlacement:PlaceStructure(Position, PlayerID)

	if Position == nil or PlayerID == nil then
		error("Position and PlayerID must be provided to place a structure.")
	end

	--- Check if a structure type is selected for placement.
	if not self.SelectedStructureType then
		return "No structure type selected" -- No structure type selected, do nothing.
	end

	--- Check if the cell is available for placement (not occupied, within boundaries, and within build zones).
	if not structureHashGrid:IsCellAvailable(Position.X, Position.Y) then
		return "Cell is not available" -- Cell is not available, do not place the structure.
	end

	--- create the strucutre and set its position to the center of the cell
	local newStructure = StructureFactory:CreateStructure(self.SelectedStructureType, PlayerID)
	local cellCenterX, cellCenterY = structureHashGrid:GetCellCenter(Position.X, Position.Y)
	newStructure.Position = { X = cellCenterX, Y = cellCenterY }

	--- Check if the player has enough resources to place the structure.
	if not resourceManager:SubstractPlayerResources(PlayerID, newStructure.Costs) then
		return "Not enough resources" -- Not enough resources, do not place the structure in the world.
	end

	-- structure passed all checks we can place it in the world
	entityManager:SetStructure(newStructure)
	structureHashGrid:MarkCellAsOccupied(Position.X, Position.Y)

	-- Add the structure's income bonus to the player's resources
	resourceManager:AddPlayerIncome(PlayerID, newStructure.IncomeBonus)

	-- Clear the selected structure type after placing.
	self:CancelPlacement()
end

--- Resets the structure placement state, clearing any selected structure type.
function StructurePlacement:CancelPlacement()
	self.SelectedStructureType = nil
end

local function getInstance()
	if not instance then
		instance = setmetatable({
			SelectedStructureType = nil
		}, StructurePlacement)
	end
	return instance
end

return {
	getInstance = getInstance
}
