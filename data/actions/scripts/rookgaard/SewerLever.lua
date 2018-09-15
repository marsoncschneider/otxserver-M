local config = {
	bridgePositions = {
		{position = Position(32099, 32205, 8), groundId = 9022, itemId = 4645},
		{position = Position(32100, 32205, 8), groundId = 4616},
		{position = Position(32101, 32205, 8), groundId = 9022, itemId = 4647}
	},
	leverPositions = {
		Position(32098, 32204, 8),
		Position(32104, 32204, 8)
	},
	relocatePosition = Position(32102, 32205, 8),
	relocateMonsterPosition = Position(32103, 32205, 8),
	bridgeId = 5770,
	trash = {5964, 2813, 2814, 2815, 2016, 2017, 2018, 2019, 2020, 2021}	
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local leverLeft, lever = item.itemid == 1945
	local positionstable = {Position(32099, 32205, 8), Position(32100, 32205, 8), Position(32101, 32205, 8)}
	for i = 1, #config.leverPositions do
		lever = Tile(config.leverPositions[i]):getItemById(leverLeft and 1945 or 1946)
		if lever then
			lever:transform(leverLeft and 1946 or 1945)
		end
	end

	local tile, tmpItem, bridge
	if leverLeft then
		for i = 1, #config.bridgePositions do
			bridge = config.bridgePositions[i]
			tile = Tile(bridge.position)
			tmpItem = tile:getGround()
			if bridge.itemId then
				tmpItem = tile:getItemById(bridge.itemId)
				if tmpItem then
					tmpItem:remove()
				end
			end
			
			for i = 1, #positionstable do
				if not Tile(positionstable[i]):getItemById(config.bridgeId) then
					Game.createItem(config.bridgeId, 1, positionstable[i])
				end
			end
		end
	else
		for i = 1, #config.bridgePositions do
			bridge = config.bridgePositions[i]
			tile = Tile(bridge.position)
			tile:relocateTo(config.relocatePosition, true, config.relocateMonsterPosition)
			
			if not Tile(positionstable[1]):getItemById(9022) and not Tile(positionstable[1]):getItemById(4645) then
				Game.createItem(9022, 1, positionstable[1])
				Game.createItem(4645, 1, positionstable[1])
			end
			if not Tile(positionstable[2]):getItemById(4616) then
				Game.createItem(4616, 1, positionstable[2])
			end
			if not Tile(positionstable[3]):getItemById(9022) and not Tile(positionstable[3]):getItemById(4647) then
				Game.createItem(9022, 1, positionstable[3])
				Game.createItem(4647, 1, positionstable[3])
			end
			for i = 1, #config.trash do
				while tile:getItemById(config.trash[i]) do
					tile:getItemById(config.trash[i]):remove()
				end
			end
		end
	end
	return true
end