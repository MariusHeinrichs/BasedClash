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
function StructurePlacement:PlaceStructure(Position, PlayerID)
	structureHashGrid:Rebuild() -- Ensure the structure hash grid is up to date before checking for occupied cells.
	
	if Position == nil or PlayerID == nil then
		error("Position and PlayerID must be provided to place a structure.")
	end

	if not self.SelectedStructureType then
		return -- No structure type selected, do nothing.
	end

	if not structureHashGrid:IsCellOccupied(Position.X, Position.Y) then
		structureHashGrid:MarkCellAsOccupied(Position.X, Position.Y)
	else
		return -- Cell is already occupied, do not place the structure.
	end

	--- create the strucutre and set its position to the center of the cell
	local newStructure = StructureFactory:CreateStructure(self.SelectedStructureType, PlayerID)
	local cellCenterX, cellCenterY = structureHashGrid:GetCellCenter(Position.X, Position.Y)
	newStructure.Position = { X = cellCenterX, Y = cellCenterY }

	if not resourceManager:SubstractPlayerResources(PlayerID, newStructure.Costs) then
		return -- Not enough resources, do not place the structure in the world.
	end

	-- structure passed all checks we can place it in the world
	entityManager:SetStructure(newStructure)

	-- Add the structure's income bonus to the player's resources
	resourceManager:AddPlayerIncome(PlayerID, newStructure.IncomeBonus)

	-- Clear the selected structure type after placing.
	self:CancelPlacement()
end

--- Resets the structure placement state, clearing any selected structure type.
function StructurePlacement:CancelPlacement()
	self.SelectedStructureType = nil
end

--- Handles a MousePressed Event
--- @param x number mouse x position
--- @param y number mouse y position
--- @param button number mouse button pressed
function StructurePlacement:HandleMousePressed(x, y, button)
	if self.SelectedStructureType then
		if button == 1 then
			-- Left mouse button: Place structure at the clicked position.
			self:PlaceStructure({ X = x, Y = y }, 1)
		elseif button == 2 then
			-- Right mouse button: Cancel structure placement.
			self:CancelPlacement()
		end
	end
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
