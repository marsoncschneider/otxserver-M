local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Mercadorias e artigos de papelaria para venda! Só aqui!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	if msgcontains(msg, "football") then
		npcHandler:say("Quer comprar uma bola de futebol por 111 gold?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			local player = Player(cid)
			if player:getMoney() >= 111 then
				npcHandler:say("Aqui está.", cid)
				player:addItem(2109, 1)
				player:removeMoney(111)
			else
				npcHandler:say("Você não tem dinheiro o suficiente.", cid)
			end
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

-- Basic
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Estou vendendo equipamentos de todos os tipos. Você precisa de algo?"})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, text = "O Rei ajuda muito na economia do Tibia."})
keywordHandler:addAliasKeyword({'tibianus'})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = "Magia? Pergunte a um sorcerer ou um druid sobre isso."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou Gorn. Meus produtos são conhecidos em todo o Tibia."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "Agora são exatamente |TIME|. Talvez você queria comprar um relógio?"})
keywordHandler:addKeyword({'druids'}, StdModule.say, {npcHandler = npcHandler, text = "Os druids são muito gente boa, agradáveis. Você pode encontrá-los no leste da cidade."})
keywordHandler:addKeyword({'knights'}, StdModule.say, {npcHandler = npcHandler, text = "Até o mais forte knight precisa de meu equipamento para suas aventuras em Tibia."})
keywordHandler:addKeyword({'sorcerers'}, StdModule.say, {npcHandler = npcHandler, text = "Você pode encontrá-lo na guild dos sorcerers."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, text = "Ela é a líder da guild dos paladins."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, text = "Old Baxter era barulhento. Quando éramos jovens, tivemos algumas aventuras e mulheres."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, text = "Bah! Sai pra lá com esse palhaço chato."})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, text = "Frodo é um bom amigo, muito alegre."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = "Nos desentendemos uma ou duas vezes nos velhos tempos."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, text = "Até o mais forte knight precisa de meu equipamento para suas aventuras em Tibia."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, text = "Essa é uma gatinha."})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, text = "Eu quase não conheço os McRonalds."})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, text = "Você vai encontrá-lo na guild dos sorceres."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, text = "Esse Oswald não gosta de trabalhar, mas tem muito tempo pra espalhar rumores."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, text = "Ele aconselha os novatos a comprarem minhas mercadorias. Eu amo esse cara!"})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, text = "Forte como o Léo Stronda, concerteza ganharia em uma queda de braço contra um minotauro, eu aposto."})
keywordHandler:addKeyword({'xodet'}, StdModule.say, {npcHandler = npcHandler, text = "Ele é o dono da loja de magia aqui. Mas eu logo aviso: Os preços são exorbitantes."})


npcHandler:setMessage(MESSAGE_GREET, "Oh, por favor entre, |PLAYERNAME|. Do que você precisa")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, volte sempre.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ei! Mal educado.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "É claro, fique a vontade para olhar todas minhas mercadorias. Bolas de Futebol {Footballs} tem que ser compradas separadamente.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
