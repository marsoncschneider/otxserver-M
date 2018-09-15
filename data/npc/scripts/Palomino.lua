local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, 'transport') then
		npcHandler:say('Nós podemos levar você para Venore com um de nossos treinadores por 125 gold. Você está interessado?', cid)
		npcHandler.topic[cid] = 1
	elseif isInArray({'rent', 'horses'}, msg) then
		npcHandler:say('Você quer alugar o cavalo por um dia por 500 gold?', cid)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, 'yes') then
		local player = Player(cid)
		if npcHandler.topic[cid] == 1 then
			if player:isPzLocked() then
				npcHandler:say('Primeiro, livre-se dessas manchas de sangue.', cid)
				return true
			end

			if not player:removeMoney(125) then
				npcHandler:say('Você não tem dinheiro o suficiente.', cid)
				return true
			end

			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			local destination = Position(32850, 32124, 7)
			player:teleportTo(destination)
			destination:sendMagicEffect(CONST_ME_TELEPORT)
			npcHandler:say('Tenha uma boa viagem!', cid)
		elseif npcHandler.topic[cid] == 2 then
			if player:getStorageValue(Storage.RentedHorseTimer) >= os.time() then
				npcHandler:say('Você já tem um cavalo.', cid)
				return true
			end

			if not player:removeMoney(500) then
				npcHandler:say('Você não tem dinheiro suficiente para comprar um cavalo!', cid)
				return true
			end

			local mountId = {22, 25, 26}
			player:addMount(mountId[math.random(#mountId)])
			player:setStorageValue(Storage.RentedHorseTimer, os.time() + 86400)
			player:addAchievement('Natural Born Cowboy')
			npcHandler:say('Eu vou te dar um dos nossos melhores. Tenha cuidado! Procure por ramificações baixas.', cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > 0 then
		npcHandler:say('Então não.', cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Saudações, |PLAYERNAME| Eu acho que você está aqui pelos cavalos {horses}.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
