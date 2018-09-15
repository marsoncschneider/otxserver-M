local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Mercadorias e artigos de papelaria para venda! S� aqui!'} }
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
				npcHandler:say("Aqui est�.", cid)
				player:addItem(2109, 1)
				player:removeMoney(111)
			else
				npcHandler:say("Voc� n�o tem dinheiro o suficiente.", cid)
			end
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

-- Basic
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Estou vendendo equipamentos de todos os tipos. Voc� precisa de algo?"})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, text = "O Rei ajuda muito na economia do Tibia."})
keywordHandler:addAliasKeyword({'tibianus'})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = "Magia? Pergunte a um sorcerer ou um druid sobre isso."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou Gorn. Meus produtos s�o conhecidos em todo o Tibia."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "Agora s�o exatamente |TIME|. Talvez voc� queria comprar um rel�gio?"})
keywordHandler:addKeyword({'druids'}, StdModule.say, {npcHandler = npcHandler, text = "Os druids s�o muito gente boa, agrad�veis. Voc� pode encontr�-los no leste da cidade."})
keywordHandler:addKeyword({'knights'}, StdModule.say, {npcHandler = npcHandler, text = "At� o mais forte knight precisa de meu equipamento para suas aventuras em Tibia."})
keywordHandler:addKeyword({'sorcerers'}, StdModule.say, {npcHandler = npcHandler, text = "Voc� pode encontr�-lo na guild dos sorcerers."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, text = "Ela � a l�der da guild dos paladins."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, text = "Old Baxter era barulhento. Quando �ramos jovens, tivemos algumas aventuras e mulheres."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, text = "Bah! Sai pra l� com esse palha�o chato."})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, text = "Frodo � um bom amigo, muito alegre."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = "Nos desentendemos uma ou duas vezes nos velhos tempos."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, text = "At� o mais forte knight precisa de meu equipamento para suas aventuras em Tibia."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, text = "Essa � uma gatinha."})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, text = "Eu quase n�o conhe�o os McRonalds."})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, text = "Voc� vai encontr�-lo na guild dos sorceres."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, text = "Esse Oswald n�o gosta de trabalhar, mas tem muito tempo pra espalhar rumores."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, text = "Ele aconselha os novatos a comprarem minhas mercadorias. Eu amo esse cara!"})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, text = "Forte como o L�o Stronda, concerteza ganharia em uma queda de bra�o contra um minotauro, eu aposto."})
keywordHandler:addKeyword({'xodet'}, StdModule.say, {npcHandler = npcHandler, text = "Ele � o dono da loja de magia aqui. Mas eu logo aviso: Os pre�os s�o exorbitantes."})


npcHandler:setMessage(MESSAGE_GREET, "Oh, por favor entre, |PLAYERNAME|. Do que voc� precisa")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, volte sempre.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ei! Mal educado.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "� claro, fique a vontade para olhar todas minhas mercadorias. Bolas de Futebol {Footballs} tem que ser compradas separadamente.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
