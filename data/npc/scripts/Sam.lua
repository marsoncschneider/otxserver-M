 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Olá aventureiro! Precisa de armas ou armaduras? Eu sou o cara!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if msgcontains(msg, 'adorn')
			or msgcontains(msg, 'outfit')
			or msgcontains(msg, 'addon') then
		local addonProgress = player:getStorageValue(Storage.OutfitQuest.Knight.AddonHelmet)
		if addonProgress == 5 then
			player:setStorageValue(Storage.OutfitQuest.Knight.MissionHelmet, 6)
			player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmet, 6)
			player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmetTimer, os.time() + 7200)
			npcHandler:say('Oh, Gregor enviou você? Parece que sim. Vai ser totalmente uma honra adornar (adorn) seu helmet. Por favor me dê algum tempo para que eu possa concluir o adorno.', cid)
		elseif addonProgress == 6 then
			if player:getStorageValue(Storage.OutfitQuest.Knight.AddonHelmetTimer) < os.time() then
				player:setStorageValue(Storage.OutfitQuest.Knight.MissionHelmet, 0)
				player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmet, 7)
				player:setStorageValue(Storage.OutfitQuest.Ref, math.min(0, player:getStorageValue(Storage.OutfitQuest.Ref) - 1))
				player:addOutfitAddon(131, 2)
				player:addOutfitAddon(139, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say('Bem na hora, |PLAYERNAME|. Seu capacete (helmet) está pronto, espero que você goste.', cid)
			else
				npcHandler:say('Por favor seja paciente, |PLAYERNAME|. Forjar é um trabalho difícil!', cid)
			end
		elseif addonProgress == 7 then
			npcHandler:say('Acho que essa é uma das minhas obras-primas!', cid)
		else
			npcHandler:say('Desculpe-me, mas sem a permissão de Gregor eu não posso ajudar você.', cid)
		end

	elseif msgcontains(msg, "old backpack") or msgcontains(msg, "backpack") then
		if player:getStorageValue(Storage.SamsOldBackpack) < 1 then
			npcHandler:say("O que? Você está me dizendo que encontrou a minha old adventurer's backpack que perdi anos atrás??", cid)
			npcHandler.topic[cid] = 1
		end

	elseif msgcontains(msg, '2000 steel shields') then
		if player:getStorageValue(Storage.WhatAFoolishQuest.Questline) ~= 29
				or player:getStorageValue(Storage.WhatAFoolishQuest.Contract) == 2 then
			npcHandler:say('Minhas ofertas são armas, armaduras, capacetes, perneiras e escudos (armors, helmets, legs, and shields). Se você quiser ver minhas ofertas, me chame negociar {trade}.', cid)
			return true
		end

		npcHandler:say('O que? Você quer comprar 2000 steel shields??', cid)
		npcHandler.topic[cid] = 2

	elseif msgcontains(msg, 'contract') then
		if player:getStorageValue(Storage.WhatAFoolishQuest.Contract) == 0 then
			npcHandler:say('Você assinou o contrato?', cid)
			npcHandler.topic[cid] = 4
		end

	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			if player:removeItem(3960, 1) then
				npcHandler:say({
					"Muito obrigado! Isso trás devolta boas e velhas memórias! Por favor, como uma recompensa, viaje até Kazordoon e pergunte ao meu velho amigo Kroox para providênciar a você uma especial dwarven armor. ...",
					"Eu vou mandar uma carta imediatamente falando sobre você. Apenas diga a ele que seu velho amigo Sam enviou você."
				}, cid)
				player:setStorageValue(Storage.SamsOldBackpack, 1)
				player:addAchievement('Backpack Tourist')
			else
				npcHandler:say("Você não tem...", cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say('Eu não consigo acreditar. Finalmente eu vou ficar rico! Eu posso me mudar para Edron e usufruir de minha aposentadoria! Mas ... espere um pouco! Eu não vou começar a trabalhar sem um contrato! VocÊ planeja assinar um?', cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			player:addItem(7492, 1)
			player:setStorageValue(Storage.WhatAFoolishQuest.Contract, 1)
			npcHandler:say('Certo! Aqui está o contrato. Por favor assine. Fale comigo sobre ele novamente quando estiver pronto.', cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if not player:removeItem(7491, 1) then
				npcHandler:say('Você não assinou o contrato.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			player:setStorageValue(Storage.WhatAFoolishQuest.Contract, 2)
			npcHandler:say('Excelente! Eu vou começar a trabalhar logo! Sinto que estou começando a ficar rico, eu vou aproveitar isso pra dizer à algumas pessoas o que eu realmente ACHO delas!', cid)
			npcHandler.topic[cid] = 0
		end

	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Então não.", cid)
		elseif isInArray({2, 3, 4}, npcHandler.topic[cid]) then
			npcHandler:say("É, parecia bom demais pra ser verdade.", cid)
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou um ferreiro. Se você precisar de armas ou armaduras - apenas me pergunte."})

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo a minha loja, aventureiro |PLAYERNAME|! Eu negocio {trade} com armas e armaduras.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, volte sempre! Foi um prazer, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Essas pessoas de hoje em dia, espero que ele volte.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
