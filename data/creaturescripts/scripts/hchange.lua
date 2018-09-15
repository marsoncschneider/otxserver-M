function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

    local player = creature:getPlayer()
    

    if player then
        --player:sendTextMessage(messageType, 'change HP.')
		player:sendCancelMessage("change HP")
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end