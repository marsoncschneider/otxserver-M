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
			npcHandler:say('Você recuperou meu broche! Eu sempre vou estar em dívida, meu amigo!', cid)
			return true
		end

		npcHandler:say('O que? Você quer que eu examine um broche?', cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			if player:getItemCount(2318) == 0 then
				npcHandler:say('Do que você está falando? Sou muito pobre para me interessar em jóias.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			npcHandler:say('Pode ser? Eu reconheço os braços da minha família! Você já encontrou um tesouro! Eu sou pobre e tudo o que posso oferecer é minha amizade, mas ... por favor ... me dê esse broche.', cid)
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 2 then
			npcHandler.topic[cid] = 0
			if not player:removeItem(2318, 1) then
				npcHandler:say('Eu deveria ter pensado melhor antes de pedir um ato de bondade neste mundo cruel e egoísta!', cid)
				return true
			end

			npcHandler:say('Obrigado! Eu considero você meu amigo de agora em diante! Apenas me avise se você precisar {need} de algo!', cid)
			player:setStorageValue(Storage.WhiteRavenMonasteryQuest.Passage, 1)
			player:setStorageValue(Storage.WhiteRavenMonasteryQuest.QuestLog, 1) -- Quest log
		end
	elseif msgcontains(msg, 'no') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say('Então pare de ser um tolo. Eu sou pobre e tenho que trabalhar o dia inteiro!', cid)
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say('Eu deveria ter pensado melhor antes de pedir um ato de bondade neste mundo cruel e egoísta!', cid)
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu apenas viajei para a ilha dos reis uma ou duas vezes. Não me atrevo a irritar os monges trazendo viajantes lá sem sua permissão.'}, function(player) return player:getStorageValue(Storage.WhiteRavenMonasteryQuest.Passage) ~= 1 end)

local travelNode = keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Você procura uma passagem para a ilha dos reis para 10 moedas de ouro?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, text = 'Tenha uma boa viagem!', cost = 10, destination = Position(32190, 31957, 6) })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, reset = true, text = 'Bem, eu estarei aqui se você mudar de idéia.'})

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome é Dalbrect Windtrouser, da família orgulhosa de Windtrouser."})
keywordHandler:addKeyword({'hut'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou apenas um humilde pescador agora que nada resta do meu nobre legado {legacy}."})
keywordHandler:addKeyword({'legacy'}, StdModule.say, {npcHandler = npcHandler, text = "Uma vez que minha família já foi nobre e rica, mas o destino {fate} se virou contra nós e nos lançou na pobreza."})
keywordHandler:addKeyword({'poverty'}, StdModule.say, {npcHandler = npcHandler, text = "Quando Carlin tentou colonizar a região agora conhecida como os ghostlands, meus ancestrais colocaram sua fortuna nesse projeto {project}."})
keywordHandler:addKeyword({'fate'}, StdModule.say, {npcHandler = npcHandler, text = "Quando Carlin tentou colonizar a região agora conhecida como os ghostlands, meus ancestrais colocaram sua fortuna nesso projeto {project}."})
keywordHandler:addKeyword({'ghostlands'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa fortuna familiar estava perdida quando a colonização dessas terras malditas falhou. Agora, nada é da nossa fama ou da nossa fortuna. Se eu tivesse apenas uma lembrança desses tempos melhores. <sigh>"})
keywordHandler:addKeyword({'project'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa fortuna familiar estava perdida quando a colonização dessas terras malditas falhou. Agora, nada é da nossa fama ou da nossa fortuna. Se eu tivesse apenas algo como uma lembrança daqueles tempos melhores. <sigh>"})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = "Pensar que minha família costumava pertencer à nobreza local! E agora as mulheres arrogantes estão no comando!"})
keywordHandler:addKeyword({'need'}, StdModule.say, {npcHandler = npcHandler, text = "Há pouco que posso lhe oferecer, mas uma viagem com meu barco. Você está procurando uma passagem {passage} para a Ilha dos Reis {Isle of the Kings} talvez?"})
keywordHandler:addKeyword({'ship'}, StdModule.say, {npcHandler = npcHandler, text = "Meu navio é meu único orgulho e alegria."})

npcHandler:setMessage(MESSAGE_GREET, "Seja saudado, viajante|PLAYERNAME|. Bem vindo à minha cabana {hut}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus. Você é bem vindo.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
