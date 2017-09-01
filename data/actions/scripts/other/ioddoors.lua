local config = {
	[4531] = Position(32085, 32004, 8), -- S 
	[4532] = Position(32111, 32004, 8), -- D
	[4533] = Position(32111, 31987, 8), -- P 
	[4534] = Position(32085, 31987, 8), -- K 
	
	
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetPosition = config[item.actionid]
	
	
	if player:getLevel() >= 8 and player:getVocation():getId() > 0 then
	

	
	end
	
	if not targetPosition then
		return true
	end
	
	local fromVocation = player:getVocation():getId()
	if (item:getActionId() - 4530) == fromVocation then
	
	
	if targetPosition ~= player:getPosition() then
	player:teleportTo(targetPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
	local position = player:getPosition()
	if player:getVocation():getId() == 4 or player:getVocation():getId() == 3 then

	position.y = position.y + 2
	else	
	
	position.y = position.y - 2
	
	end
	player:teleportTo(position)
	end
	
	
	return true
end
end