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

	-- Mission 1 - The Supply Thief
	if msgcontains(msg, "job") then
		if Player(cid):getStorageValue(Storage.DjinnWar.EfreetFaction.Mission01) == 2 then
			npcHandler:say("O que voc� acha? Eu sou a Xerife de Carlin.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "water pipe") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say({
				"Ah, h� um cano de �gua {water pipe} em uma das minhas celas? ...",
				"Acho que meu �ltimo prisioneiro {prisoner} esqueceu l�."
			}, cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "prisoner") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Meu �ltimo prisioneiro? Hmm. ... "," eu acho que ele era um cara de Darama. N�o consigo lembrar seu nome. ...",
				"Ele esteve aqui apenas por uma noite, porque ele ficou b�bado e irritando nossos cidad�os. ...",
				"Obviamente, ele n�o estava satisfeito com este lugar, porque ele se dirigiu para a Thais no dia seguinte. ...",
				"Algo me diz que ele n�o vai entrar em problemas por muito tempo."
			}, cid)
			Player(cid):setStorageValue(Storage.DjinnWar.EfreetFaction.Mission01, 3)
			npcHandler.topic[cid] = 0
		end
	end
	-- Mission 1 - The Supply Thief
	return true
end

keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, text = "Nenhuma not�cia � uma boa not�cia."})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, text = "SA�DE A RAINHA ELOISE!"})
keywordHandler:addKeyword({'leader'}, StdModule.say, {npcHandler = npcHandler, text = "SAUDEM A RAINHA ELOISE!"})
keywordHandler:addKeyword({'how', 'are', 'you'}, StdModule.say, {npcHandler = npcHandler, text = "Tudo bem."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = "Gostaria de comprar a chave geral para a cidade?"})
keywordHandler:addKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = "Sim, eu aposto que voc� gostaria de fazer isso! HO, HO, HO!"})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, text = "Se eles causarem problemas, eu os colocarei atr�s das grades como todos os outros."})
keywordHandler:addKeyword({'guard'}, StdModule.say, {npcHandler = npcHandler, text = "Se eles causarem problemas, eu os colocarei atr�s das grades como todos os outros."})
keywordHandler:addKeyword({'general'}, StdModule.say, {npcHandler = npcHandler, text = "A fam�lia Bonecrusher � ideal para empregos militares."})
keywordHandler:addKeyword({'bonecrusher'}, StdModule.say, {npcHandler = npcHandler, text = "A fam�lia Bonecrusher � ideal para empregos militares."})
keywordHandler:addKeyword({'enemies'}, StdModule.say, {npcHandler = npcHandler, text = "Se voc� tem um crime para denunciar e pistas, ent�o fa�a, mas n�o perca meu tempo."})
keywordHandler:addKeyword({'enemy'}, StdModule.say, {npcHandler = npcHandler, text = "Se voc� tem um crime para denunciar e pistas, ent�o fa�a, mas n�o perca meu tempo."})
keywordHandler:addKeyword({'criminal'}, StdModule.say, {npcHandler = npcHandler, text = "Se voc� tem um crime para denunciar e pistas, ent�o fa�a, mas n�o perca meu tempo."})
keywordHandler:addKeyword({'murderer'}, StdModule.say, {npcHandler = npcHandler, text = "Se voc� tem um crime para denunciar e pistas, ent�o fa�a, mas n�o perca meu tempo."})
keywordHandler:addKeyword({'castle'}, StdModule.say, {npcHandler = npcHandler, text = "O castelo � um dos lugares mais seguros em Carlin."})
keywordHandler:addKeyword({'subject'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa gente est� bem e pac�fica."})
keywordHandler:addKeyword({'tbi'}, StdModule.say, {npcHandler = npcHandler, text = "Aposto que eles nos espiam ... n�o � o meu neg�cio, no entanto."})
keywordHandler:addKeyword({'todd'}, StdModule.say, {npcHandler = npcHandler, text = "Eu assustei essa bigmouth tanto que ele deixou a cidade de noite. HO, HO, HO!"})
keywordHandler:addKeyword({'city'}, StdModule.say, {npcHandler = npcHandler, text = "A cidade � um lugar pac�fico, e cabe a mim manter assim."})
keywordHandler:addKeyword({'hain'}, StdModule.say, {npcHandler = npcHandler, text = "Ele � o cara respons�vel por manter os esgotos funcionando. Algu�m tem que fazer esse tipo de trabalho. N�o posso lidar com todo o lixo da cidade."})
keywordHandler:addKeyword({'rowenna'}, StdModule.say, {npcHandler = npcHandler, text = "Rowenna � um dos nossos smiths locais. Quando voc� procura armas, procure Rowenna."})
keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, text = "Rowenna � um dos nossos smiths locais. Quando voc� procura armas, procure Rowenna."})
keywordHandler:addKeyword({'cornelia'}, StdModule.say, {npcHandler = npcHandler, text = "Cornelia � um dos nossos smiths locais. Quando voc� procura armadura, procure Cornelia."})
keywordHandler:addKeyword({'armor'}, StdModule.say, {npcHandler = npcHandler, text = "Cornelia � um dos nossos smiths locais. Quando voc� procura armadura, procure Cornelia."})
keywordHandler:addKeyword({'legola'}, StdModule.say, {npcHandler = npcHandler, text = "Ela tem o olho mais afiado na regi�o, eu diria."})
keywordHandler:addKeyword({'padreia'}, StdModule.say, {npcHandler = npcHandler, text = "Sua tranquilidade �s vezes � quase uma estupidez."})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, text = "Adoro Banor, � claro."})
keywordHandler:addKeyword({'banor'}, StdModule.say, {npcHandler = npcHandler, text = "Para mim, ele � o deus da justi�a."})
keywordHandler:addKeyword({'zathroth'}, StdModule.say, {npcHandler = npcHandler, text = "Seu culto � proibido em nossa cidade."})
keywordHandler:addKeyword({'brog'}, StdModule.say, {npcHandler = npcHandler, text = "N�o se perguntaria se alguns machos o adoravam secretamente. HO, HO, HO!"})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, text = "Eu lido mais com os monstros humanos, voc� sabe? HO, HO, HO!"})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = "Certamente, faria uma boa borracha. HO, HO, HO!"})
keywordHandler:addKeyword({'rebellion'}, StdModule.say, {npcHandler = npcHandler, text = "A �nica coisa que se revolta aqui e agora � o est�mago de um homem depois de tentar fazer �lcool ilegal. HO, HO, HO!"})
keywordHandler:addKeyword({'alcohol'}, StdModule.say, {npcHandler = npcHandler, text = "Por raz�es �bvias, est� proibido em nossa cidade."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Ol�, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "VIDA LONGA A RAINHA!!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "VIDA LONGA A RAINHA!!")
npcHandler:addModule(FocusModule:new())
