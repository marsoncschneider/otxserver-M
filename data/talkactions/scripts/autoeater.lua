function onSay(player, words, param)
	local eater = player:getStorageValue(250127)
	
	if eater ~= 1 then	
	player:setStorageValue(250127, 1)
	doPlayerPopupFYI(player, "!ATIVADO com sucesso")
	elseif eater == 1 then
	player:setStorageValue(250127, -1)
	doPlayerPopupFYI(player, "!CANCELADO com sucesso")
	end
	--return false
	
end