local shutdownAtServerSave = false
local cleanMapAtServerSave = true

local function serverSave()
	--Game.setGameState(GAME_STATE_CLOSED)
	--Game.setGameState(GAME_STATE_INIT)   --## GAME_STATE_STARTUP GAME_STATE_INIT GAME_STATE_NORMAL GAME_STATE_CLOSED GAME_STATE_SHUTDOWN GAME_STATE_CLOSING GAME_STATE_MAINTAIN)##
	if cleanMapAtServerSave then
		cleanMap()
	end
	saveServer()
	--Game.setGameState(GAME_STATE_NORMAL)
end

local function secondServerSaveWarning()
	Game.broadcastMessage("Server is saving game in one minute. Please logout.", MESSAGE_EVENT_ADVANCE)
	addEvent(serverSave, 60000)
end 
 
local function firstServerSaveWarning()
	Game.broadcastMessage("Server is saving game in 3 minutes. Please logout.", MESSAGE_EVENT_ADVANCE)
	addEvent(secondServerSaveWarning, 120000)
end

function onTime(interval)
	Game.broadcastMessage("Server is saving game in 5 minutes. Please logout.", MESSAGE_EVENT_ADVANCE)
	addEvent(firstServerSaveWarning, 120000)
	return not shutdownAtServerSave
end
