function onStepIn(creature, item, position, fromPosition)
    local enabled = 1
	if creature:isPlayer() and enabled == 1 then
        local player = Player(creature)
        local pVocation = player:getVocation():getId()
		local pLevel = player:getLevel()
        if pVocation == 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Para descer as escadas voce precisa ter uma vocacao.')
			player:teleportTo(fromPosition)
			return true
		end
		if pVocation ~= 0 and pLevel < 8 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Voce e %s porem para descer as escadas voce precisa ter no minimo level 8.', player:getVocation():getName()))
			player:teleportTo(fromPosition)
			return true
		end
		if pLevel < 8 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Para descer as escadas voce precisa ter no minimo level 8.')
			player:teleportTo(fromPosition)
			return true
		end					
    end
    return true
end
