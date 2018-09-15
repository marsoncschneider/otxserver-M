local cent = Player(param)
local price_aol = 10000

function onSay(player, words, param)
local split = param:split(",")

    if split[1] ~= nil and split[2] ~= nil then
		count = tonumber(split[1])
		count2 = tonumber(split[2])
		else
		
		
		if player:getStorageValue(250124) > 0 and player:getStorageValue(250125) > 0 then
		player:setStorageValue(250124, 0)
		player:setStorageValue(250125, 0)
		doPlayerPopupFYI(player, "!HEALER CANCELADO com sucesso")
		else
		doPlayerPopupFYI(player, "Uso: !healer NUM1, NUM2 \nEx: !healer 70, 30\nAo chegar em 70% de HP ou 30% de MP, o bot tentara usar Potions.")
		end
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	return true
	end
   -- if action == "add" then
if count >= 0 then




	if player:getStorageValue(250124) > 0 and player:getStorageValue(250125) > 0 then
	player:setStorageValue(250124, 0)
	player:setStorageValue(250125, 0)
	
	doPlayerPopupFYI(player, "!HEALER CANCELADO com sucesso")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	return true
	end
	if count > 0 and  count < 100 and count2 > 0 and  count2 < 100 then
		
		--player:removeMoney(price_aol)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		--player:addItem(2173, 1)	
		--player:addItem(24322, 1)	
		player:setStorageValue(250124, count)
		player:setStorageValue(250125, count2)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, '!HEALER - Se abaixo de "' .. count .. ' %" de hp "' .. count2 .. ' %"mana tentaremos usar potions.')
		--registerCreatureEvent(player, "autotarget")
		doPlayerPopupFYI(player, "!HEALER ATIVADO com sucesso")
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("Minimo 1 maximo 99%.")
	end
	end
	
end