local config = {
	ratPosition = Position(32312, 32204, 6),
	barataPosition = Position(32358, 32244, 8)
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local exhausth = 3600 --em quantos segundos podera usar denovo
	if not player or not player:isPlayer() then
		return true
	end
	
	item:transform(item.itemid == 1945 and 1946 or 1945)
	
	if item.itemid ~= 1945 then
		return true
	end
	
	if item.actionid == 2012 or item.actionid == 2013 then
		if item.actionid == 2012 then
			if (getPlayerStorageValue(player, 32903) <= os.time()) and player:getFreeCapacity() > ItemType(7620):getWeight(50) then
				player:addItem(7620, 50)
				setPlayerStorageValue(player, 32903, os.time()+exhausth)  
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			elseif not (getPlayerStorageValue(player, 32903) <= os.time()) then
				doPlayerSendCancel(player, "You are exhausted, use again in 1 hour.")
				return true
			end
		end
		if item.actionid == 2013 then
			if (getPlayerStorageValue(player, 32902) <= os.time()) and player:getFreeCapacity() > ItemType(7620):getWeight(50) then
				player:addItem(7618, 50)
				setPlayerStorageValue(player, 32902, os.time()+exhausth)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			elseif not (getPlayerStorageValue(player, 32902) <= os.time()) then
				doPlayerSendCancel(player, "You are exhausted, use again in 1 hour.")
				return true
			end
		end		
		if player:getFreeCapacity() < ItemType(7620):getWeight(50) then
			doPlayerSendCancel(player, "135.00 oz of cap needed.")
		end
	end
	if item.actionid == 2014 then
	tmpItem = Tile(config.ratPosition):getItemById(2813)
		if item.actionid == 2014 then
			if (getPlayerStorageValue(player, 32904) <= os.time()) and tmpItem then
				tmpItem:remove()
				player:addItem(2152, 10)
				setPlayerStorageValue(player, 32904, os.time()+exhausth)  
				config.ratPosition:sendMagicEffect(CONST_ME_TELEPORT)
				return true
			elseif not (getPlayerStorageValue(player, 32904) <= os.time()) then
				doPlayerSendCancel(player, "You are exhausted, use again in 1 hour.")
				return true
			end
		end
	end
	
	if item.actionid == 2015 then
	tmpItem = Tile(config.barataPosition):getItemById(8710)
		if getPlayerStorageValue(player, 32905) < 0 then
				setPlayerStorageValue(player, 32905, 0)
			end
		if getPlayerStorageValue(player, 32905) < 10 and tmpItem then
			tmpItem:remove()
			setPlayerStorageValue(player, 32905, getPlayerStorageValue(player, 32905)+1)  
			config.barataPosition:sendMagicEffect(CONST_ME_TELEPORT)
			local value = getPlayerStorageValue(player, 32905)
			local spectators = Game.getSpectators(getCreaturePosition(player), false, true, 3, 3)
				for i = 1, #spectators do
					player:say(player:getName() .. " sacrificed " .. value .. " of 10 barata legs.", TALKTYPE_MONSTER_SAY, isInGhostMode, spectators[i], getCreaturePosition(player))
				end
				if (value == 10) then
					doPlayerSendCancel(player, "You got a new mount.")
					setPlayerStorageValue(player, 32905, 11)
					player:addMount(127)
				end
				return true
			elseif (getPlayerStorageValue(player, 32905) > 10) then
				doPlayerSendCancel(player, "You already have this mount.")
				return true
			end
	end
		
	return true
end
