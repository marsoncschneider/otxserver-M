function onThink(cid, interval)
local player = Player(cid)
	--local player = Player(cid)
	--[[if getPlayerStorageValue(cid, 25471) ~= "on" then
		return true
	end]]
	--if cid:getStorageValue(250123) == 1 then
	if cid:getStorageValue(250123) == 1 or cid:getStorageValue(250123) == 2 then
	local target = cid:getTarget()
	if target then
		--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'targeted.')
		return true
	else
	--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'not targeted.')
	end
	
	local monsterScreen = {}
	
	for x = -7, 7 do -- -7 7
		for y = -5, 5 do -- -5 5
			--local player1 = Tile(pos1):getTopCreature()
			--creature = getTopCreature({x = cid:getPosition().x + x, y = cid:getPosition().y + y, z = cid:getPosition().z})
			local pos1 = cid:getPosition()
			pos1.x = pos1.x + x
			pos1.y = pos1.y + y
			if not Tile(pos1):getTopCreature() then
			return true
			end
			local creature = Tile(pos1):getTopCreature()
			if isMonster(creature) then
				table.insert(monsterScreen, creature)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'inseriu.')
			end
		end
	end
    --cid:setTarget(monsterScreen[1])
	if #monsterScreen == 0 then
		return true
	end
   
	monsterTarget = monsterScreen[1]
	local monsterTarget2
	local a = 1
	
	
	if monsterTarget then
		--local option = getPlayerStorageValue(cid, 25471)
		local option = cid:getStorageValue(250123)
		for i = 1, #monsterScreen do
		
		
            if option == 1 then
				if getDistanceBetween(monsterScreen[i]:getPosition(), cid:getPosition()) < getDistanceBetween(monsterTarget:getPosition(), cid:getPosition()) then
					monsterTarget = monsterScreen[i]
				--else
				--monsterTarget = monsterScreen[a]
				
				end
			elseif option == 2 then
				--if getCreatureMaxHealth(monsterScreen[i]) > getCreatureMaxHealth(monsterScreen[i]) then
					if monsterScreen[i]:getMaxHealth() > monsterTarget:getMaxHealth() then
					monsterTarget = monsterScreen[i]
				end
			end
		end
	end
	--doMonsterSetTarget(cid, monsterTarget)
	cid:setTarget(monsterTarget)
	if player:hasChaseMode() then
	cid:setFollowCreature(monsterTarget)
	end
	end
return true
end