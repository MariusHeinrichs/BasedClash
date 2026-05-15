--- Handles the creation and placement of structures in the world.
local EntityManager = require("src.managers.entities").getInstance()
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

--- Places the currently selected Structure at the given position
--- @param Position { X: number, Y: number } the position to place the structure
--- @param PlayerID number the ID of the player placing the structure
function StructurePlacement:PlaceStructure(Position, PlayerID)
	if Position == nil or PlayerID == nil then
		error("Position and PlayerID must be provided to place a structure.")
	end
	-- create the structure of the selected type for the player at the specified position.
	if not self.SelectedStructureType then
		return -- No structure type selected, do nothing.
	end
	local newStructure = StructureFactory:CreateStructure(self.SelectedStructureType, PlayerID)
	newStructure.Position = Position
	-- Logic to place the structure of the specified type at the given position.
	EntityManager:SetStructure(newStructure)
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

