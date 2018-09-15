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

	if msgcontains(msg, "cough syrup") then
		npcHandler:say("Você quer comprar uma garrafa de xarope contra a tosse por 50 de ouro?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'mission') then
		if player:getStorageValue(Storage.TibiaTales.TheExterminator) == -1 then
			npcHandler:say({
				'Oh, |PLAYERNAME|, Graças a Deus, você veio até mim. Na noite passada, tive uma visão sobre uma praga próxima aqui em Carlin. ...',
				'Ele se originará de esmaltes que irão escorrer dos esgotos e infectar todos os cidadãos com uma doença mortal. Você está disposto a me ajudar a salvar Carlin?'
			}, cid)
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(Storage.TibiaTales.TheExterminator) == 1 then
			npcHandler:say('Você DEVE encontrar aquele pool de lima imediatamente ou a vida aqui em Carlin não será mais a mesma coisa.', cid)
		elseif player:getStorageValue(Storage.TibiaTales.TheExterminator) == 2 then
			local itemId = {2150, 2149, 2147, 2146}
			for i = 1, #itemId do
				player:addItem(itemId[i], 1)
			end
			player:setStorageValue(Storage.TibiaTales.TheExterminator, 3)
			npcHandler:say('Você fez isso! Mesmo que apenas alguns dos Carliners jamais tenham sabido sobre isso, você salvou todas as suas vidas. Aqui, pegue isso como uma recompensa. Despedida!', cid)
		else
			npcHandler:say('Talvez os guardas tenham algo a fazer por você ou conheçam alguém que possa precisar de alguma ajuda.', cid)
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			if not player:removeMoney(50) then
				npcHandler:say("Você não tem dinheiro suficiente.", cid)
				return true
			end

			npcHandler:say("Obrigado. Aqui está.", cid)
			player:addItem(4839, 1)
		elseif npcHandler.topic[cid] == 2 then
			player:addItem(8205, 1)
			player:setStorageValue(Storage.TibiaTales.TheExterminator, 1)
			npcHandler:say({
				'Eu sabia que eu poderia contar com você. Tome este veneno altamente intensificado de vermes. Na minha visão, eu vi algum tipo de piscina {pool} de onde esses slimes vieram. ...',
				'Despeje o veneno na água para parar o desaparecimento de Carlin. Conte-me sobre sua missão depois de cumprir sua tarefa.'
			}, cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Entao não.", cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say('Então a queda de Carlin é inevitável. Por favor, pense nisso. Você sabe onde me encontrar.', cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou o grande druida de Carlin. Sou responsável pela guilda, os campos e a saúde dos nossos cidadãos."})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = "Todo druida é capaz de aprender os numerosos feitiços do nosso ofício."})
--keywordHandler:addKeyword({'spell'}, StdModule.say, {npcHandler = npcHandler, text = "Desculpe, eu não ensino feitiços para sua vocação."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou Padreia, grande druida da nossa bela cidade."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "O tempo é apenas um pilar de cristal - o centro da criação e da vida."})
keywordHandler:addKeyword({'druids'}, StdModule.say, {npcHandler = npcHandler, text = "Somos druidas, preservadoras da vida. Nossa magia é sobre defesa, cura e natureza."})
keywordHandler:addKeyword({'sorcerers'}, StdModule.say, {npcHandler = npcHandler, text = "Os feiticeiros são destrutivos. Seu poder reside na destruição e dor."})

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo à nossa humilde aliança, vagabunda. Posso ajudá-lo?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Até a próxima.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Até a próxima.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
