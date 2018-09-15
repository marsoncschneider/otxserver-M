function onStepIn(creature, item, position, fromPosition)
    if creature:isPlayer() then
        local player = Player(creature)
        local pVocation = player:getVocation():getId()
		local pLevel = player:getLevel()
        
		if pVocation ~= 0 and pLevel >= 8 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Voce e %s e ja tem o level necessario. Continue sua jornada falando com a NPC Oressa.', player:getVocation():getName()))
			player:teleportTo(fromPosition)
		end
				
    end
    return true
end
