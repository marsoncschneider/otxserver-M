local price_aol = 10000

function onSay(player, words, param)
	if player:getStorageValue(250123) == 2 then
	player:setStorageValue(250123, 0)
	doPlayerPopupFYI(player, "!AUTOATTACK CANCELADO com sucesso")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	return true
	end
	if player:getStorageValue(250123) == 1 then
	player:setStorageValue(250123, 2)
	doPlayerPopupFYI(player, "!AUTOATTACK MODO 2. \nMais Fortes serao atacados primeiro.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	return true
	end
	
	if true then
		
		--player:removeMoney(price_aol)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		--player:addItem(2173, 1)	
		--player:addItem(24322, 1)	
		player:setStorageValue(250123, 1)
		--registerCreatureEvent(player, "autotarget")
		doPlayerPopupFYI(player, "!AUTOATTACK MODO 1. \nMais Proximos serao atacados primeiro.")
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You dont have enought money.")
	end
	
end