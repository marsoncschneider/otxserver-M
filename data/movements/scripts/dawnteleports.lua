function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	--local action = Tile(position):getGround():getActionId()
	local id = Tile(position):getGround():getId()
	if player then
		if player:getStorageValue(54) < 1 and id ~= 9624 then
			player:sendTutorial(2)
			player:setStorageValue(54, 1)
		end
		if id == 9624 then
		player:teleportTo(Position(32075, 31899, 5), true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '<krrk> <krrrrrk> You move away hurriedly.')
		end
	end
	return true
end
