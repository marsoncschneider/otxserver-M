function onSay(player, words, param)
	local Price = 2600
	local x = 0
		
	if player:getLevel() > 30 then
	Price = Price + (260*(player:getLevel()-30))
	end
	
	for i = 1, 8 do
		if not player:hasBlessing(i) then
			x = x + 1	
		end
	end
	
	if x == 0 then
		return	doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "Voc� j� foi aben�oado pelos deuses.") and doSendMagicEffect(getCreaturePosition(player), 3)
	else
		if player:removeMoney(Price*(x)) then
			for i = 1, 8 do
				if not player:hasBlessing(i) then
					player:addBlessing(i, 1)
				end
			end
			return doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "Voc� foi aben�oado pelos deuses por "..  Price*(x) .." gps.") and doSendMagicEffect(getCreaturePosition(player), 3)
		else
			player:sendCancelMessage("Voc� n�o tem ".. Price*(x) .." gold para comprar Bless.")
			doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "Voc� n�o tem ".. Price*(x) .." gold para comprar Bless.")
			return false
		end
		return false
	end
end