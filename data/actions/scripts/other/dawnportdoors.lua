local config = {
	[2003] = Position(32055, 31885, 6), -- S 
	[2005] = Position(32059, 31885, 6), -- P
	[2006] = Position(32069, 31885, 6), -- K 
	[2004] = Position(32073, 31885, 6), -- D 
	[2007] = Position(32054, 31880, 6), -- S 
	[2009] = Position(32059, 31880, 6), -- P
	[2010] = Position(32068, 31880, 6), -- K 
	[2008] = Position(32073, 31880, 6),  -- D 
	[0] = {
		--club, coat
		items = {},
		--container rope, shovel, red apple
		container = {{2120, 1}}
	},
	[1] = {
		--equipment spellbook, wand of vortex, magician's robe, mage hat, studded legs, leather boots, scarf
		items = {},
		--container platinum coin, rope, shovel, mana potion, adventurer stone
		container = {{2152, 20}, {7620, 5}, {18559, 1}, {2643, 1}, {2661, 1}, {2175, 1}, {2190, 1}, {8819, 1}, {8820, 1}, {2468, 1}}
	},
	[2] = {
		--equipment spellbook, snakebite rod, magician's robe, mage hat, studded legs, leather boots scarf
		items = {},
		--container platinum coin, rope, shovel, mana potion, adventurer's stone
		container = {{2152, 20}, {7620, 5}, {18559, 1}, {2643, 1}, {2661, 1}, {2175, 1}, {2182, 1}, {8819, 1}, {8820, 1}, {2468, 1}}
	},
	[3] = {
		--equipment dwarven shield, 5 spear, ranger's cloak, ranger legs scarf, legion helmet
		items = {},
		--container platinum coin, rope, shovel, health potion, mana potion, adventurer's stone
		container = {{2152, 20}, {7618, 5}, {7620, 5}, {18559, 1}, {2643, 1}, {2661, 1}, {2525, 1}, {2389, 5}, {2660, 1}, {8923, 1}, {2480, 1}}
	},
	[4] = {
		--equipment steel shield, steel axe, brass armor, brass helmet, brass legs scarf
		items = {},
		--container platinum coin, jagged sword, daramian mace, rope, shovel, health potion, mana potion, adventurer's stone
		container = {{2152, 20}, {8602, 1}, {2439, 1}, {7618, 5}, {7620, 5}, {18559, 1}, {2643, 1}, {2661, 1}, {2509, 1}, {8601, 1}, {2465, 1}, {2460, 1}, {2478, 1}}
	}
	
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetPosition = config[item.actionid]
	local targetVocation = config[player:getVocation():getId()]
	if player:getStorageValue(32907) < 1 then
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você ainda nao falou com a NPC Oressa')
	return false
	end
	if item:getActionId() == 2011 and player:getStorageValue(32906) >= 1 then
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você ja pegou seus itens. Siga em frente.')
	return false
	end
	--[[if player:getStorageValue(32907) >= 2 then
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você ja pegou seus itens. siga em frente')
	return false
	end]]
	
	if player:getLevel() >= 8 and player:getVocation():getId() > 0 then
	
	if item:getActionId() == 2011 and player:getStorageValue(32906) ~= 1 then
	player:setStorageValue(32906, 1)
	player:setStorageValue(32907, 2)
	
	for i = 1, #targetVocation.items do
		player:addItem(targetVocation.items[i][1], targetVocation.items[i][2])
	end

	local backpack = player:getVocation():getId() == 0 and player:addItem(1988) or player:addItem(1988)
	if not backpack then
		--return true
	end

	for i = 1, #targetVocation.container do
		player:addItem(targetVocation.container[i][1], targetVocation.container[i][2]) --backpack
		
	end
	end
	
	if not targetPosition then
		--return true
	end
		
	local fromVocation = player:getVocation():getId()
	if (item:getActionId() - 2002) == fromVocation then
	--player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	
	if item:getId() == 12195 or item:getId() == 6898 or item:getId() == 9279 or item:getId() == 7040 then --  or 6898 or 9279 or 7040) 
	--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'DEBUG: ENTRADA')
	if player:getStorageValue(32907) >= 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você ja pegou seus itens. siga em frente')
	return false
	end
	item:transform(item.itemid + 1)
	end
	player:teleportTo(targetPosition)
	
	elseif (item:getActionId() - 2006) == fromVocation then
	if player:getStorageValue(32907) >= 2 then
	if item:getId() == 12195 or item:getId() == 6898 or item:getId() == 9279 or item:getId() == 7040 then --  or 6898 or 9279 or 7040) 
	--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'DEBUG: SAIDA')
	item:transform(item.itemid + 1)
	end
	--player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(targetPosition)
	else
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você ainda nao pegou os seus itens')
	end
	
	end
	--return true
end
end
