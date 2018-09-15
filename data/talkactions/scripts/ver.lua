function onSay(player, words, param)
	local ver = player:getClient().version
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'VERSAO: "' .. ver .. '".')	
end