function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end


	local position = player:getPosition()
	position.z = position.z + 1
	player:teleportTo(position)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
