function onSay(player, words, param)
	local level, maxHealth, maxMana = player:getLevel(), player:getMaxHealth(), player:getMaxMana()
	local resetLevel
	local reseted = player:getStorageValue(250128)
	
	
	local levelsReset = {350, 400, 450, 500, 600, 700, 800, 900, 999}
	local maximoReset = #levelsReset
	
	if reseted >= maximoReset then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Resets indisponiveis. Numero maximo atingido.')
		return false
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Resets disponiveis. [' .. maximoReset-reseted .. '].')
	end
	
	if reseted then
		if reseted < 1 then
			player:setStorageValue(250128, 1)
		end
		resetLevel = levelsReset[player:getStorageValue(250128)]
	end
	
	local resetDisp = level/resetLevel
	local a = 0
	
	if resetDisp >= 1 then
		--resetDisp = resetDisp - 1
		a = 1
	end
	
	local nmaxHealth, nmaxMana, ncap = player:getMaxHealth() * 1.10, player:getMaxMana() * 1.10, player:getCapacity() * 1.10
	if level >= resetLevel then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Level: ' .. level .. '. Resets disponivel.')
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'DEBUG: newMAXHP ' .. nmaxHealth .. ' newMAXMP ' .. nmaxMana .. ' newCAP ' .. ncap .. ' !!RESET!!.')
	elseif (resetLevel - level) > 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Faltam ' .. resetLevel - level .. ' leveis para poder resetar.')
	elseif (resetLevel - level) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Falta ' .. resetLevel - level .. ' level para poder resetar.')
		
	end
	
	if a >= 1 then
		local resultId = db.storeQuery("SELECT `id` FROM `players` WHERE `name` = " .. db.escapeString(player:getName():lower()))
		local accountId = result.getDataInt(resultId, "id")
		player:setStorageValue(250128, player:getStorageValue(250128)+1)
		--** removendo player **--
		player:remove() -- apos o player ser removido nao utilizar funcoes para o player ex: player:get
		db.query("UPDATE `players` SET level = '8', manamax = manamax*1.1, mana = manamax, healthmax = healthmax*1.1, health = healthmax, cap = cap*1.1 WHERE `players`.`id` = " .. accountId)
	end
end