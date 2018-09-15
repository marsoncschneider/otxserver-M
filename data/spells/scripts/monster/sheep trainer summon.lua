local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SOUND_RED)

local area = createCombatArea(AREA_CROSS1X1)
combat:setArea(area)

function onCastSpell(creature, var)
	local a, b, c, summonCount = 1, 1, creature, creature:getSummons()
	local pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8 = c:getPosition(), c:getPosition(), c:getPosition(), c:getPosition(), c:getPosition(), c:getPosition(), c:getPosition(), c:getPosition()
	local player1, player2, player3, player4, player5, player6, player7, player8 --listagem de players
	local players = {player1, player2, player3, player4, player5, player6, player7, player8} --tabela de players
	local playerList, summonPid = {}, {} --tabela com players ativos
	
	pos1.x = pos1.x - 1	pos2.x = pos2.x + 1 -- lista de posições
	pos3.y = pos3.y - 1	pos4.y = pos4.y + 1
	pos5.x = pos5.x - 1	pos5.y = pos5.y - 1
	pos6.x = pos6.x + 1	pos6.y = pos6.y - 1
	pos7.x = pos7.x - 1	pos7.y = pos7.y + 1
	pos8.x = pos8.x + 1	pos8.y = pos8.y + 1 -- end of lista de posições
	local positions = {pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8} --tabela com posições de 1 a 8
		
	for i = 1, 8 do
		players[i] = Tile(positions[i]):getTopCreature()
		if isPlayer(players[i]) then
			table.insert(playerList, players[i]) --table.insert(playerUid, creatures[i].uid)
		end
	end
	
	local maxsummons = 2 * #playerList --definir maximo de summons
	
	if #playerList > 0 and #summonCount < maxsummons then --criar summons
		Game.createMonster("Mad Sheep", creature:getPosition()):setMaster(creature)
		Game.createMonster("Mad Sheep", creature:getPosition()):setMaster(creature)
	end

	if(table.maxn(summonCount) >= 1) then
		for _, pid in ipairs(summonCount) do
			pid:changeSpeed(500)
			if a == 3 or a == 5 or a == 7 or a == 9 or a == 11 or a == 13 or a == 15 then 
				b = b + 1
			end
			pid:setTarget(playerList[b])
			table.insert(summonPid, pid)
		a = a + 1
		end
	end
		
	for i = 1, 8 do
		if not playerList[i] and table.maxn(summonCount) > maxsummons then 
			doRemoveCreature(summonPid[table.maxn(summonCount)])
			--doRemoveCreature(summonPid[table.maxn(summonCount)-1])
		end
	end
	
	return combat:execute(creature, var)
end