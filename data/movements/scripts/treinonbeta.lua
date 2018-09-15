function onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'DEBUG MODE: 1 PLAYER PISOU NO TILE.')
		--creature:stopLiveCast()
		
		local nextPosition = creature:getPosition()
		nextPosition:getNextPosition(creature:getDirection())
		
		
			--position:getNextPosition(player:getDirection(), 1)
		
		--Positions = {nextPosition, b}
		--local master = Game.createMonster("Black Sheep", nextPosition)
		
		
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'DEBUG MODE: 2 CRIATURA "MASTER" CRIADA POSICAO 1.')
		
		nextPosition:getNextPosition(creature:getDirection())
		--local slave = Game.createMonster("Sheep", nextPosition)
		
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'DEBUG MODE: 3 getnextPosition NOVAMENTE , GAMECREATEMONSTER NOVAMENTE "SLAVE".')
		
	end
	return true
end
