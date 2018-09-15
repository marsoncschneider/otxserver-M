local msg = true




function onThink(interval)

	for _, player in ipairs(Game.getPlayers()) do
	
	local eater = player:getStorageValue(250127)
	
	if eater == 1 then
		local status = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
		if status and (status:getTicks()/1000) >= 1000 then
			--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You are full.')
		else
			if math.random(1,10) == 10 then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, 'BOT: SEM FOOD')
			end
			local food, timefood = {2672, 2671, 2789, 2666, 2689},{60, 30, 22, 15, 10}
			for i = 1, #food do
			if player:getItemCount(food[i]) >= 1 then
			local food = player:getItemById(food[i], true)
			food:remove(1)
			player:feed(timefood[i] * 12)
			end	
			end			
			
		end
	end

	
	end
	return true
end