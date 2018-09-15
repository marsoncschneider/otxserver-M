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

	local player = Player(cid)

	if msgcontains(msg, 'brooch') then
		if player:getStorageValue(Storage.WhiteRavenMonasteryQuest.Passage) == 1 then
			npcHandler:say('Voc� recuperou meu broche! Eu sempre vou estar em d�vida, meu amigo!', cid)
			return true
		end

		npcHandler:say('O que? Voc� quer que eu examine um broche?', cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			if player:getItemCount(2318) == 0 then
				npcHandler:say('Do que voc� est� falando? Sou muito pobre para me interessar em j�ias.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			npcHandler:say('Pode ser? Eu reconhe�o os bra�os da minha fam�lia! Voc� j� encontrou um tesouro! Eu sou pobre e tudo o que posso oferecer � minha amizade, mas ... por favor ... me d� esse broche.', cid)
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 2 then
			npcHandler.topic[cid] = 0
			if not player:removeItem(2318, 1) then
				npcHandler:say('Eu deveria ter pensado melhor antes de pedir um ato de bondade neste mundo cruel e ego�sta!', cid)
				return true
			end

			npcHandler:say('Obrigado! Eu considero voc� meu amigo de agora em diante! Apenas me avise se voc� precisar {need} de algo!', cid)
			player:setStorageValue(Storage.WhiteRavenMonasteryQuest.Passage, 1)
			player:setStorageValue(Storage.WhiteRavenMonasteryQuest.QuestLog, 1) -- Quest log
		end
	elseif msgcontains(msg, 'no') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say('Ent�o pare de ser um tolo. Eu sou pobre e tenho que trabalhar o dia inteiro!', cid)
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say('Eu deveria ter pensado melhor antes de pedir um ato de bondade neste mundo cruel e ego�sta!', cid)
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu apenas viajei para a ilha dos reis uma ou duas vezes. N�o me atrevo a irritar os monges trazendo viajantes l� sem sua permiss�o.'}, function(player) return player:getStorageValue(Storage.WhiteRavenMonasteryQuest.Passage) ~= 1 end)

local travelNode = keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� procura uma passagem para a ilha dos reis para 10 moedas de ouro?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, text = 'Tenha uma boa viagem!', cost = 10, destination = Position(32190, 31957, 6) })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, reset = true, text = 'Bem, eu estarei aqui se voc� mudar de id�ia.'})

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome � Dalbrect Windtrouser, da fam�lia orgulhosa de Windtrouser."})
keywordHandler:addKeyword({'hut'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou apenas um humilde pescador agora que nada resta do meu nobre legado {legacy}."})
keywordHandler:addKeyword({'legacy'}, StdModule.say, {npcHandler = npcHandler, text = "Uma vez que minha fam�lia j� foi nobre e rica, mas o destino {fate} se virou contra n�s e nos lan�ou na pobreza."})
keywordHandler:addKeyword({'poverty'}, StdModule.say, {npcHandler = npcHandler, text = "Quando Carlin tentou colonizar a regi�o agora conhecida como os ghostlands, meus ancestrais colocaram sua fortuna nesse projeto {project}."})
keywordHandler:addKeyword({'fate'}, StdModule.say, {npcHandler = npcHandler, text = "Quando Carlin tentou colonizar a regi�o agora conhecida como os ghostlands, meus ancestrais colocaram sua fortuna nesso projeto {project}."})
keywordHandler:addKeyword({'ghostlands'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa fortuna familiar estava perdida quando a coloniza��o dessas terras malditas falhou. Agora, nada � da nossa fama ou da nossa fortuna. Se eu tivesse apenas uma lembran�a desses tempos melhores. <sigh>"})
keywordHandler:addKeyword({'project'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa fortuna familiar estava perdida quando a coloniza��o dessas terras malditas falhou. Agora, nada � da nossa fama ou da nossa fortuna. Se eu tivesse apenas algo como uma lembran�a daqueles tempos melhores. <sigh>"})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = "Pensar que minha fam�lia costumava pertencer � nobreza local! E agora as mulheres arrogantes est�o no comando!"})
keywordHandler:addKeyword({'need'}, StdModule.say, {npcHandler = npcHandler, text = "H� pouco que posso lhe oferecer, mas uma viagem com meu barco. Voc� est� procurando uma passagem {passage} para a Ilha dos Reis {Isle of the Kings} talvez?"})
keywordHandler:addKeyword({'ship'}, StdModule.say, {npcHandler = npcHandler, text = "Meu navio � meu �nico orgulho e alegria."})

npcHandler:setMessage(MESSAGE_GREET, "Seja saudado, viajante|PLAYERNAME|. Bem vindo � minha cabana {hut}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus. Voc� � bem vindo.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
