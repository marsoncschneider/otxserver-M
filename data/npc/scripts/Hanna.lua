local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Gemas e joalheria! Os melhores preços da cidade!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if msgcontains(msg, "addon") or msgcontains(msg, "outfit") or msgcontains(msg, "hat") then
		local addonProgress = player:getStorageValue(Storage.OutfitQuest.Citizen.AddonHat)
		if addonProgress < 1 then
			npcHandler:say("Linda, não acha? Minha amiga Amber me ensinou como fazer, mas eu posso ajudar você com uma se você quiser. O que você diz?", cid)
			npcHandler.topic[cid] = 1
		elseif addonProgress == 1 then
			npcHandler:say("Oh, você já voltou? Trouxe o legion helmet, 100 chicken feathers e 50 honeycombs?", cid)
			npcHandler.topic[cid] = 2
		elseif addonProgress == 2 then
			npcHandler:say('Lindo, não acha?', cid)
		end
		return true
	end

	if npcHandler.topic[cid] == 1 then
		if msgcontains(msg, 'yes') then
			player:setStorageValue(Storage.OutfitQuest.Ref, math.max(0, player:getStorageValue(Storage.OutfitQuest.Ref)) + 1)
			player:setStorageValue(Storage.OutfitQuest.Citizen.AddonHat, 1)
			player:setStorageValue(Storage.OutfitQuest.Citizen.MissionHat, 1)
			npcHandler:say('Okay, aqui vamos nós, escute com cuidado! Eu preciso de algumas coisas... um basico capacete amaldiçoado, um legion helmet pode dar conta. Provavelmente umas 100 chicken feathers... e 50 honeycombs como cola. É isso! Volte aqui quando tiver tudo o que eu lhe pedi!', cid)
		else
			npcHandler:say('Aw, acho que você não gosta de chapéu de pena. Sem grandes negócios.', cid)
		end
		npcHandler.topic[cid] = 0

	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'yes') then
			if player:getItemCount(2480) < 1 then
				npcHandler:say('Hmmm, não estou vendo seu legion helmet.', cid)
			elseif player:getItemCount(5890) < 100 then
				npcHandler:say('Desculpe, você não tem chicken feathers o suficiente.', cid)
			elseif player:getItemCount(5902) < 50 then
				npcHandler:say('Desculpe, você não tem 50 honeycombs.', cid)
			else
				npcHandler:say('Bom trabalho! Isso deve ter dado muito trabalho. Okay, você coloca aqui assim... depois um pouco de cola assim... aqui!', cid)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

				player:removeItem(2480, 1)
				player:removeItem(5902, 50)
				player:removeItem(5890, 100)

				player:addOutfitAddon(136, 2)
				player:addOutfitAddon(128, 2)

				player:setStorageValue(Storage.OutfitQuest.Ref, math.min(0, player:getStorageValue(Storage.OutfitQuest.Ref) - 1))
				player:setStorageValue(Storage.OutfitQuest.Citizen.MissionHat, 0)
				player:setStorageValue(Storage.OutfitQuest.Citizen.AddonHat, 2)
			end
		else
			npcHandler:say('Talvez uma outra hora.', cid)
		end
		npcHandler.topic[cid] = 0
	end

	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu trabalho na joalheira. Talvez você queira dar uma olhada em minhas maravilhosas ofertas.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu sou Hanna.'})

npcHandler:setMessage(MESSAGE_GREET, 'Oh, por favor entre, |PLAYERNAME|. Do que você precisa? Dê uma olhada em minhas ofertas {offers} de gemas e joalheria.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Adeus, até mais.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Só tem gente mal educada por aqui.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
