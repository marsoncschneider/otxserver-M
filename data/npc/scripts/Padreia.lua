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
		npcHandler:say("Voc� quer comprar uma garrafa de xarope contra a tosse por 50 de ouro?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'mission') then
		if player:getStorageValue(Storage.TibiaTales.TheExterminator) == -1 then
			npcHandler:say({
				'Oh, |PLAYERNAME|, Gra�as a Deus, voc� veio at� mim. Na noite passada, tive uma vis�o sobre uma praga pr�xima aqui em Carlin. ...',
				'Ele se originar� de esmaltes que ir�o escorrer dos esgotos e infectar todos os cidad�os com uma doen�a mortal. Voc� est� disposto a me ajudar a salvar Carlin?'
			}, cid)
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(Storage.TibiaTales.TheExterminator) == 1 then
			npcHandler:say('Voc� DEVE encontrar aquele pool de lima imediatamente ou a vida aqui em Carlin n�o ser� mais a mesma coisa.', cid)
		elseif player:getStorageValue(Storage.TibiaTales.TheExterminator) == 2 then
			local itemId = {2150, 2149, 2147, 2146}
			for i = 1, #itemId do
				player:addItem(itemId[i], 1)
			end
			player:setStorageValue(Storage.TibiaTales.TheExterminator, 3)
			npcHandler:say('Voc� fez isso! Mesmo que apenas alguns dos Carliners jamais tenham sabido sobre isso, voc� salvou todas as suas vidas. Aqui, pegue isso como uma recompensa. Despedida!', cid)
		else
			npcHandler:say('Talvez os guardas tenham algo a fazer por voc� ou conhe�am algu�m que possa precisar de alguma ajuda.', cid)
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			if not player:removeMoney(50) then
				npcHandler:say("Voc� n�o tem dinheiro suficiente.", cid)
				return true
			end

			npcHandler:say("Obrigado. Aqui est�.", cid)
			player:addItem(4839, 1)
		elseif npcHandler.topic[cid] == 2 then
			player:addItem(8205, 1)
			player:setStorageValue(Storage.TibiaTales.TheExterminator, 1)
			npcHandler:say({
				'Eu sabia que eu poderia contar com voc�. Tome este veneno altamente intensificado de vermes. Na minha vis�o, eu vi algum tipo de piscina {pool} de onde esses slimes vieram. ...',
				'Despeje o veneno na �gua para parar o desaparecimento de Carlin. Conte-me sobre sua miss�o depois de cumprir sua tarefa.'
			}, cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Entao n�o.", cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say('Ent�o a queda de Carlin � inevit�vel. Por favor, pense nisso. Voc� sabe onde me encontrar.', cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou o grande druida de Carlin. Sou respons�vel pela guilda, os campos e a sa�de dos nossos cidad�os."})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = "Todo druida � capaz de aprender os numerosos feiti�os do nosso of�cio."})
--keywordHandler:addKeyword({'spell'}, StdModule.say, {npcHandler = npcHandler, text = "Desculpe, eu n�o ensino feiti�os para sua voca��o."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou Padreia, grande druida da nossa bela cidade."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "O tempo � apenas um pilar de cristal - o centro da cria��o e da vida."})
keywordHandler:addKeyword({'druids'}, StdModule.say, {npcHandler = npcHandler, text = "Somos druidas, preservadoras da vida. Nossa magia � sobre defesa, cura e natureza."})
keywordHandler:addKeyword({'sorcerers'}, StdModule.say, {npcHandler = npcHandler, text = "Os feiticeiros s�o destrutivos. Seu poder reside na destrui��o e dor."})

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo � nossa humilde alian�a, vagabunda. Posso ajud�-lo?")
npcHandler:setMessage(MESSAGE_FAREWELL, "At� a pr�xima.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "At� a pr�xima.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
