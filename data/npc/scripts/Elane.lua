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
	if msgcontains(msg, "addon") or msgcontains(msg, "outfit") then
		if player:getStorageValue(Storage.OutfitQuest.HunterHatAddon) < 1 then
			npcHandler:say("Oh, minha tiara alada? Essas s�o tradicionalmente concedidas ap�s completar uma dif�cil tarefa {task} para nossa guild, apenas para aspirantes femininas. Homens guerreiros v�o receber uma hooded cloak.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "task") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Ent�o voc� est� dizendo que gostaria de provar que merece vestir a hooded cloak?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "crossbow") then
		if player:getStorageValue(Storage.OutfitQuest.HunterHatAddon) == 1 then
			npcHandler:say("Estou t�o excitada! Voc� realmente encontrou meu crossbow?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "leather") then
		if player:getStorageValue(Storage.OutfitQuest.HunterHatAddon) == 2 then
			npcHandler:say("Voc� me trouxe 100 pe�as de lizard leather e 100 pe�as de red dragon leather?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "chicken wing") then
		if player:getStorageValue(Storage.OutfitQuest.HunterHatAddon) == 3 then
			npcHandler:say("Voc� foi capaz de encontar as 5 enchanted chicken wings?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "steel") then
		if player:getStorageValue(Storage.OutfitQuest.HunterHatAddon) == 4 then
			npcHandler:say("Ah, voc� me trouxe uma pe�a de royal steel, draconian steel e hell steel?", cid)
			npcHandler.topic[cid] = 7
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Tudo bem, eu vou dar uma chance � voc�. Preste muita aten��o no que vou dizer a voc� agora. ...",
				"Recentemente, um dos nossos membros se mudou para Liberty Bay do nada, tagalerando sobre algum tipo de culto estranho. Mas esse n�o � o ponto, o problema � que ele levou meu crossbow favorito consigo. ...",
				"Por favor encontre meu crossbow. Ele tem uma grava��o feita com o meu nome, al�m de ser muito especial pra mim. ...",
				"Em segundo lugar, n�s precisamos de bastante leather para os novos quivers. 100 pe�as de lizard leather e 100 pe�as de red dragon leather ser�o o suficiente. ...",
				"Terceiro, j� que esamos oferecendo tiaras, n�s estamos sempre precisando de enchanted chicken wings. Por favor, traga-me 5, isso deve ser o suficiente e ir� realmente nos ajudar. ...",
				"Por ultimo, para as pontas de nossas flechas, precisamos de muito ferro. O melhor seria uma piece of royal steel, uma piece of draconian steel e uma piece of hell steel. ...",
				"Voc� entendeu tudo o que eu disse? Est� disposto a completar essa tarefa?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Esse � o espirito! Espero que voc� encontre meu crossbow, |PLAYERNAME|!", cid)
			player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 1)
			player:setStorageValue(Storage.OutfitQuest.DefaultStart, 1) --this for default start of Outfit and Addon Quests
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5947, 1) then
				npcHandler:say("Sim! Eu posso beijar voc� bem aqui e at� ali! A prop�sito, voc� � muito bonito. <risos> Por favor traga para mim 100 pe�as de lizard leather e 100 pe�as de red dragon leather agora!", cid)
				player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Voc� n�o tem as pe�as...", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:getItemCount(5876) >= 100 and player:getItemCount(5948) >= 100  then
				npcHandler:say("Bem trabalho, |PLAYERNAME|! Esse couro ser� o suficiente para muitos sturdy quivers. Agora, por favor traga-me 5 enchanted chicken wings.", cid)
				player:removeItem(5876, 100)
				player:removeItem(5948, 100)
				player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Voc� n�o tem as pe�as...", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(5891, 5) then
				npcHandler:say("Perfeito! Agora n�s podemos criar bem mais Tiaras. Se elas apenas n�o fossem t�o caras... Bom, de qualquer modo, por favor obtenha uma piece of royal steel, draconian steel e hell steel.", cid)
				player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 4)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Voc� n�o tem as pe�as...", cid)
			end
		elseif npcHandler.topic[cid] == 7 then
			if player:getItemCount(5887) >= 1 and player:getItemCount(5888) >= 1 and player:getItemCount(5889) >= 1  then
				npcHandler:say("Nossa, estou impressionada, |PLAYERNAME|. Voc� realmente � um membro de valor para a nossa paladin guild. Eu devo te conceder uma recompensa agora, vista-a com orgulho!", cid)
				player:removeItem(5887, 1)
				player:removeItem(5888, 1)
				player:removeItem(5889, 1)
				player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 5)
				player:addOutfitAddon(129, 1)
				player:addOutfitAddon(137, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Voc� n�o tem as pe�as...", cid)
			end
		end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then no.", cid)
			npcHandler.topic[cid] = 0
		end
	return true
	end
end

-- Sniper Gloves
keywordHandler:addKeyword({'sniper gloves'}, StdModule.say, {npcHandler = npcHandler, text = 'Estamos sempre procurando por sniper gloves. Elas s�o supostamente para aumentar a precis�o. Caso encontre um par, traga-o aqui. Talvez eu posso oferecer a voc� uma boa troca.'}, function(player) return player:getItemCount(5875) == 0 end)

local function addGloveKeyword(text, condition, action)
	local gloveKeyword = keywordHandler:addKeyword({'sniper gloves'}, StdModule.say, {npcHandler = npcHandler, text = text[1]}, condition)
		gloveKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = text[2], reset = true}, function(player) return player:getItemCount(5875) == 0 end)
		gloveKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = text[3], reset = true}, nil, action)
		gloveKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = text[2], reset = true})
end

-- Free Account
addGloveKeyword({
		'Voc� encontrou a sniper gloves?! Incr�vel! Eu gostaria muito de garantir a sniper gloves como acess�rio a voc�, mas s� posso fazer isso para guerreiros premium. Contudo, posso pagar 2000 gold pieces por elas. O que voc� acha?',
		'Talvez uma outra hora.',
		'Certo! Aqui est� o seu dinheiro, muito obrigada.'
	}, function(player) return not player:isPremium() end, function(player) player:removeItem(5875, 1) player:addMoney(2000) end
)

-- Premium account with addon
addGloveKeyword({
		'Voc� encoutrou outra sniper gloves?! INCR�VEL! Eu n�o posso te dar outro acess�rio, mas voc� n�o quer me vender por 2000 gold pieces?',
		'Talvez uma outra hora.',
		'Certo! Aqui est� o seu dinheiro, muito obrigada.'
	}, function(player) return player:getStorageValue(Storage.OutfitQuest.Hunter.AddonGlove) == 1 end, function(player) player:removeItem(5875, 1) player:addMoney(2000) end
)

-- If you don't have the addon
addGloveKeyword({
		'Voc� encontrou uma sniper gloves?! Incr�vel! Escute, se voc� me der, posso te garantir o direito de us�-las como um acess�rio. O que voc� acha?',
		'Sem problema, talvez uma outra hora.',
		'Perfeito! Assim eu te concedo o direito de usar a sniper gloves como um acess�rio. Parab�ns!'
	}, function(player) return player:getStorageValue(Storage.OutfitQuest.Hunter.AddonGlove) == -1 end, function(player) player:removeItem(5875, 1) player:setStorageValue(Storage.OutfitQuest.Hunter.AddonGlove, 1) player:addOutfitAddon(129, 2) player:addOutfitAddon(137, 1) player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end
)

-- Basic
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou a l�der dos Paladins. Ajudo os nossos membros."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou a l�der dos Paladins. Ajudo os nossos membros."})
keywordHandler:addKeyword({'paladins'}, StdModule.say, {npcHandler = npcHandler, text = "Paladins s�o grandes guerreiros m�gicos. Al�m disso, somos excelentes atiradores. Muitas pessoas no Tibia querem juntar-se a n�s."})
keywordHandler:addKeyword({'warriors'}, StdModule.say, {npcHandler = npcHandler, text = "� claro que n�o somos fortes como os guerreiros knights, mas nenhum druid ou sorcerer vai vencer um paladin com uma espada."})
keywordHandler:addKeyword({'magicians'}, StdModule.say, {npcHandler = npcHandler, text = "Existem muitas magias e runas que os paladins podem usar."})
keywordHandler:addKeyword({'missile'}, StdModule.say, {npcHandler = npcHandler, text = "Paladins s�o os melhores atiradores em todo o Tibia!"})
keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou uma Paladin, n�o uma contadora de hist�rias."})
keywordHandler:addKeyword({'members'}, StdModule.say, {npcHandler = npcHandler, text = "Todo paladin profita de sua voca��o. Existem muitas vantagens em ser um paladin."})
keywordHandler:addKeyword({'advantages'}, StdModule.say, {npcHandler = npcHandler, text = "N�s todos vamos te ajudar a melhorar suas habilidades. Al�m disso, eu vendo magias para paladins."})
keywordHandler:addKeyword({'general'}, StdModule.say, {npcHandler = npcHandler, text = "Harkath Bloodblade � o royal general."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, text = "Alguns paladins servem no ex�rcito do Rei."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, text = "Ele tem algum potencial."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, text = "O qu�o mole voc� tem que ser para se tornar um bobo da corte?"})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, text = "Os McRonalds s�o simples fazendeiros."})
keywordHandler:addKeyword({'eclesius'}, StdModule.say, {npcHandler = npcHandler, text = "Ele devia ser bem habilidoso antes de ficar como est� agora. Realmente uma pena."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, text = "Sim?"})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, text = "O �lcool que ele vende te deixa tonto tanto na mente quanto no olho."})
keywordHandler:addKeyword({'galuna'}, StdModule.say, {npcHandler = npcHandler, text = "Uma das mais importantes membras de nossa guild. Ela faz todos os arcos e flechas que precisamos."})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, text = "Ele vende muitos equipamentos �teis."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, text = "Ele e seus seguidores n�o tem a gra�a de um verdadeiro guerreiro."})
keywordHandler:addKeyword({'harkath bloodblade'}, StdModule.say, {npcHandler = npcHandler, text = "Um verdadeiro guerreiro e habilidoso general."})
keywordHandler:addKeyword({'king tibianus'}, StdModule.say, {npcHandler = npcHandler, text = "O Rei Tibianus � um governante muito s�bio."})
keywordHandler:addKeyword({'lugri'}, StdModule.say, {npcHandler = npcHandler, text = "Um seguidor do mal que vai ter o que merece, um dia."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, text = "Mhm, um pouco boazinha demais para o meu gosto. Ainda assim, � incr�vel o jeito com que ela lida com todos aqueles homens perseguindo ela, especialmente o assustador Oswald."})
keywordHandler:addKeyword({'marvik'}, StdModule.say, {npcHandler = npcHandler, text = "Um curandeiro bem treinado, disso tenho certeza."})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, text = "Apenas mais um mago arrogante."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, text = "Se n�o houvessem poderes superiores protegendo ele..."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, text = "Um monge humilde, al�m de um s�bio homem."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, text = "Homem forte. Mas um pouco vergonhoso."})

npcHandler:setMessage(MESSAGE_GREET, "Bem vindo a guild dos paladins, |PLAYERNAME|! Como posso ajud�-lo?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Mal educado, diga adeus da proxima vez, |PLAYERNAME|!.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
