--- Shared game state mode constants.
local GameStateEnums = {}

--- @enum GameStateEnums.Names
GameStateEnums.Names = {
	STARTMENU = "start_menu",
	MAINMENU = "main_menu",
	RUNNING = "running",
	PAUSE = "pause",
	GAME_WON = "game_won",
	GAME_LOST = "game_lost",
	NEWGAME = "new_game"
}

return GameStateEnums
