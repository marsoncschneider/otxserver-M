local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local Price = {}

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Hey! Aqui! Vamos conversar?'} }
npcHandler:addModule(VoiceModule:new(voices))

local function greetCallback(cid)
	if Player(cid):getSex() == PLAYERSEX_FEMALE then
		npcHandler:setMessage(MESSAGE_GREET, "Oh, ol� |PLAYERNAME|, seu cabelo parece �timo! Quem fez isso pra voc�?")
		npcHandler.topic[cid] = 1
	else
		npcHandler:setMessage(MESSAGE_GREET, "Oh, ol� bonit�o! � um prazer conhecer voc�, |PLAYERNAME|. Felizmente tenho tempo para conversar {chat} um pouco.")
		npcHandler.topic[cid] = nil
	end
	Price[cid] = nil
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	local Sex = player:getSex()
	if npcHandler.topic[cid] == 1 then
		npcHandler:say("Acho que eu nunca teria advinhado isso.", cid)
		npcHandler.topic[cid] = nil
	elseif npcHandler.topic[cid] == 2 then
		if player:removeMoney(Price[cid]) then
			npcHandler:say("Oh, me desculpe, Eu estrava distra�da, o que voc� disse?", cid)
		else
			npcHandler:say("Oh, acabei de me lembrar, tenho um trabalho a fazer, me desculpe. Tchau!", cid)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		end
		npcHandler.topic[cid] = nil
		Price[cid] = nil
	elseif npcHandler.topic[cid] == 3 and player:removeItem(2036, 1) then
		npcHandler:say("Arranje algum tempo para falar comigo!", cid)
		npcHandler.topic[cid] = nil
	elseif npcHandler.topic[cid] == 4 and (msgcontains(msg, "spouse") or msgcontains(msg, "girlfriend")) then
		npcHandler:say("Bom ... Eu o conheci um pouco .. mas n�o foi nada s�rio.", cid)
		npcHandler.topic[cid] = 5
	elseif npcHandler.topic[cid] == 5 and msgcontains(msg, "fruit") then
		npcHandler:say("Eu me lembro das uvas, eram suas favoritas. Ele quase era viciado nelas.", cid)
		npcHandler.topic[cid] = nil
	elseif msgcontains(msg, "how") and msgcontains(msg, "are") and msgcontains(msg, "you") then
		npcHandler:say("Obrigada. Que legal voc� se preocupando comigo. Estou bem, obrigada.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "sell") then
		npcHandler:say("Desculpe, eu n�o tenho nada para vender.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "job") or msgcontains(msg, "chat") then
		npcHandler:say("Eu fa�o algum tipo de trabalho aqui e ali. Nada incomum. Ent�o me sobra muito tempo para conversar. Se estiver interessado em algum t�pico espec�fico apenas pergunte.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "name") then
		if Sex == PLAYERSEX_FEMALE then
			npcHandler:say("Eu sou Aruda.", cid)
		else
			npcHandler:say("Estou um pouco triste, at� voc� se esqueceu de mim bonit�o. Eu sou Aruda.", cid)
		end
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "aruda") then
		if Sex == PLAYERSEX_FEMALE then
			npcHandler:say("Sim, essa sou eu!", cid)
		else
			npcHandler:say("Mhmm, eu gosto da maneira como voc� diz meu nome.", cid)
		end
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "time") then
		npcHandler:say("Por favor n�o seja t�o rude olhando para o rel�gio quando estiver falando comigo.", cid)
		npcHandler.topic[cid] = 3
	elseif msgcontains(msg, "help") then
		npcHandler:say("Estou profundamente triste, n�o posso te ajudar.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "monster") or msgcontains(msg, "dungeon") then
		npcHandler:say("UH! Que conversa assustadora. Por favor, vamos falar sobre algo mais agrad�vel, eu sou uma mulher pequena e fraca no fim das contas.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "sewer") then
		npcHandler:say("O que te da a impress�o de que eu sou o tipo de mulher encontrada em esgostos?", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "god") then
		npcHandler:say("Voc� devia perguntar por isso em algum templo.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "king") then
		npcHandler:say("O Rei, que vive naquele castelo fascinante? Eu acho ele fofo naquelas t�nicas luxuosas, voc� n�o?", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 10
	elseif msgcontains(msg, "sam") then
		if Sex == PLAYERSEX_FEMALE then
			npcHandler:say("Ele � t�aaaaao forte! Quantos m�sculos! Que corp�o! Voc� j� o chamou pra sair?", cid)
		else
			npcHandler:say("Ele � t�aaaaao forte! Quantos m�sculos! Que corp�o! Por outro lado, comparando ele a voc�, confesso que ele fica bem insignificante.", cid)
		end
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "benjamin") then
		npcHandler:say("Ele � um cara bem simples, mas sempre est� bem-vestido e de bom humor.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "gorn") then
		npcHandler:say("Ele realmente poderia vender alguns vestidos elegantes ou algo do g�nero. N�s Tibianos nunca usaremos uma roupa da moda, isso � uma pouca vergonha!", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "quentin") then
		npcHandler:say("Eu n�o entendo esses monges solit�rios. Eu gosto muito de companhia para me tornar uma. Hehehe!", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "bozo") then
		npcHandler:say("Oh, ele n�o � engra�ado? Eu podia ficar ouvindo ele o dia todo.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "oswald") then
		npcHandler:say("Pelo pouco que eu sei, ele est� trabalhando no castelo.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "rumour") or msgcontains(msg, "rumor") or msgcontains(msg, "gossip") then
		npcHandler:say("Eu sou um pouco t�mida shy e n�o ou�o muitos rumores.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "kiss") and Sex == PLAYERSEX_MALE then
		npcHandler:say("Ei! Seu safadinho, pare de falar coisas desse tipo! <corando>", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 20
	elseif msgcontains(msg, "weapon") then
		npcHandler:say("Eu conhe�o muito pouco sobre armas. Voc� pode me dizer algo sobre elas, por favor?", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "magic") then
		npcHandler:say("Eu acredito que o amor seja mais forte que a magia, voc� n�o concorda?", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "thief") or msgcontains(msg, "theft") then
		npcHandler:say("Oh, me desculpe, preciso ir! Adeus!", cid)
		npcHandler.topic[cid] = nil
		Price[cid] = nil
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)
	elseif msgcontains(msg, "tibia") then
		npcHandler:say("Eu gostaria de ir a praia mais vezes, mas acho muito perigoso.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "castle") then
		npcHandler:say("Eu amo esse castelo. � muito bonito!", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "muriel") then
		npcHandler:say("Feiticeiros poderosos me assustam um pouco.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "elane") then
		npcHandler:say("Pessoalmente acho inapropriado que mulheres virem guerreiras. O que voc� acha?", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "marvik") then
		npcHandler:say("Druids raramente visitam a cidade, o que voc� sabe sobre eles?", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "gregor") then
		npcHandler:say("Gosto de bravos guerreiros como ele.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "noodles") then
		npcHandler:say("Ohh, ele � t�o fofoooo!", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "dog") or msgcontains(msg, "poodle") then
		npcHandler:say("Eu gosto de cachorros, os pequenos pelo menos. Voc� tamb�m gosta?", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 5
	elseif msgcontains(msg, "excalibug") then
		npcHandler:say("Oh, Eu sou apenas uma garota e n�o sei nada sobre espadas m�gicas e esse tipo de coisa.", cid)
		npcHandler.topic[cid] = 2
		Price[cid] = 10
	elseif msgcontains(msg, "partos") then
		npcHandler:say("Eu ... n�o conhe�o ningu�m com esse nome.", cid)
		npcHandler.topic[cid] = 4
		Price[cid] = nil
	elseif msgcontains(msg, "yenny") then
		npcHandler:say("Yenny? N�o conhe�o nenhuma Yenny, nunca ouvi falar desse nome! Voc� me confundiu com outra pessoa.", cid)
		npcHandler.topic[cid] = nil
		Price[cid] = nil
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)
	end
	return true
end

npcHandler:setMessage(MESSAGE_WALKAWAY, "Espero ver voc� em breve.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, |PLAYERNAME|. Eu realmente espero que nos falemos novamente em breve.")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
