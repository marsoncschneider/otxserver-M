function onThink(cid, interval)
    local player = Player(cid)
	local option = cid:getStorageValue(250123)
	if option == 1 or option == 2 then
        local target = cid:getTarget()
		if getTilePzInfo(getCreaturePosition(cid)) then
			player:setTarget(nil)
			cid:setFollowCreature(nil)
		return true
		end
		if target then
			return true
		end
		
		
		local monsterScreen = {}
		for x = -7, 7 do
			for y = -5, 5 do
				creature = getTopCreature({x = getThingPos(cid).x + x, y = getThingPos(cid).y + y, z = getThingPos(cid).z}).uid
				if isMonster(creature) and not isSummon(creature) then
					table.insert(monsterScreen, creature)
				end
			end
		end
		
		if #monsterScreen == 0 then
			return true
		end
		
		
		local monsterTarget = monsterScreen[1]
		for i = 1, #monsterScreen do
			if option == 1 then
				if getDistanceBetween(getThingPos(monsterScreen[i]), getThingPos(cid)) < getDistanceBetween(getThingPos(monsterScreen[1]), getThingPos(cid)) then
					monsterTarget = monsterScreen[i]					
				end
				elseif option == 2 then
				if getCreatureMaxHealth(monsterScreen[i]) > getCreatureMaxHealth(monsterTarget) then
					monsterTarget = monsterScreen[i]
				end
			end
		end
		player:setTarget(monsterTarget)
		if player:hasChaseMode() then
			cid:setFollowCreature(monsterTarget)
			--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ''.. #monsterScreen ..' monstros na tela. chase ativado, follow')
		end
		
		return true
	end
end
