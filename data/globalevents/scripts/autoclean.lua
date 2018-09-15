
local function cleanMake()
	

	--cleanMap()
	local itemCount = cleanMap()
	if itemCount >= 0 then
		Game.broadcastMessage('Mapa LIMPO! Removidos ' .. itemCount .. ' item' .. (itemCount > 1 and 's' or '') .. ' do mapa. NEXT CLEAN em 1 hora.', MESSAGE_STATUS_WARNING)
		--player:sendTextMessage(MESSAGE_STATUS_WARNING, "Cleaned " .. itemCount .. " item" .. (itemCount > 1 and "s" or "") .. " from the map.")
	end
end

function onThink(interval)
	Game.broadcastMessage('O servidor LIMPARÁ todos os itens do mapa dentro de 60 segundos, possivelmente terá um LAG por 5 segundos, pegue seus itens.', MESSAGE_STATUS_WARNING)
	addEvent(cleanMake, 60000)
	return true
end