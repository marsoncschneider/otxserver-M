local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Pssst!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function greetCallback(cid)
	local player = Player(cid)

	if player:getStorageValue(Storage.secretService.AVINMission01) == 1 and player:getItemCount(14326) > 0 then
		player:setStorageValue(Storage.secretService.AVINMission01, 2)
		npcHandler:say("Não gosto do modo como você me olha. Me ajudem garotos!", cid)
		for i = 1, 2 do
			Game.createMonster("Bandit", Npc():getPosition())
		end
		npcHandler.topic[cid] = 0
	else
		npcHandler:setMessage(MESSAGE_GREET, "Pssst! Silêncio. Deseja comprar {buy} alguma coisa?")
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)

	if msgcontains(msg, "letter") then
		if player:getStorageValue(Storage.secretService.AVINMission01) == 2 then
			npcHandler:say("Você tem uma carta para mim?", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			if player:removeItem(14326, 1) then
				player:setStorageValue(Storage.secretService.AVINMission01, 3)
				npcHandler:say("Bom. Acho que ainda estou preso nesse gancho. Diga a seu 'tio' que irei prosseguir como ele me orientou.", cid)
			else
				npcHandler:say("Você não tem nenhuma carta!", cid)
			end
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus. Diga aos seu amigos... sobre minha pequena loja.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus. Diga aos seu amigos... sobre minha pequena loja.")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
