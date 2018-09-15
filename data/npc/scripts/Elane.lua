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
			npcHandler:say("Oh, minha tiara alada? Essas são tradicionalmente concedidas após completar uma difícil tarefa {task} para nossa guild, apenas para aspirantes femininas. Homens guerreiros vão receber uma hooded cloak.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "task") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Então você está dizendo que gostaria de provar que merece vestir a hooded cloak?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "crossbow") then
		if player:getStorageValue(Storage.OutfitQuest.HunterHatAddon) == 1 then
			npcHandler:say("Estou tão excitada! Você realmente encontrou meu crossbow?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif msgcontains(msg, "leather") then
		if player:getStorageValue(Storage.OutfitQuest.HunterHatAddon) == 2 then
			npcHandler:say("Você me trouxe 100 peças de lizard leather e 100 peças de red dragon leather?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "chicken wing") then
		if player:getStorageValue(Storage.OutfitQuest.HunterHatAddon) == 3 then
			npcHandler:say("Você foi capaz de encontar as 5 enchanted chicken wings?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "steel") then
		if player:getStorageValue(Storage.OutfitQuest.HunterHatAddon) == 4 then
			npcHandler:say("Ah, você me trouxe uma peça de royal steel, draconian steel e hell steel?", cid)
			npcHandler.topic[cid] = 7
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Tudo bem, eu vou dar uma chance à você. Preste muita atenção no que vou dizer a você agora. ...",
				"Recentemente, um dos nossos membros se mudou para Liberty Bay do nada, tagalerando sobre algum tipo de culto estranho. Mas esse não é o ponto, o problema é que ele levou meu crossbow favorito consigo. ...",
				"Por favor encontre meu crossbow. Ele tem uma gravação feita com o meu nome, além de ser muito especial pra mim. ...",
				"Em segundo lugar, nós precisamos de bastante leather para os novos quivers. 100 peças de lizard leather e 100 peças de red dragon leather serão o suficiente. ...",
				"Terceiro, já que esamos oferecendo tiaras, nós estamos sempre precisando de enchanted chicken wings. Por favor, traga-me 5, isso deve ser o suficiente e irá realmente nos ajudar. ...",
				"Por ultimo, para as pontas de nossas flechas, precisamos de muito ferro. O melhor seria uma piece of royal steel, uma piece of draconian steel e uma piece of hell steel. ...",
				"Você entendeu tudo o que eu disse? Está disposto a completar essa tarefa?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Esse é o espirito! Espero que você encontre meu crossbow, |PLAYERNAME|!", cid)
			player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 1)
			player:setStorageValue(Storage.OutfitQuest.DefaultStart, 1) --this for default start of Outfit and Addon Quests
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5947, 1) then
				npcHandler:say("Sim! Eu posso beijar você bem aqui e até ali! A propósito, você é muito bonito. <risos> Por favor traga para mim 100 peças de lizard leather e 100 peças de red dragon leather agora!", cid)
				player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 2)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Você não tem as peças...", cid)
			end
		elseif npcHandler.topic[cid] == 5 then
			if player:getItemCount(5876) >= 100 and player:getItemCount(5948) >= 100  then
				npcHandler:say("Bem trabalho, |PLAYERNAME|! Esse couro será o suficiente para muitos sturdy quivers. Agora, por favor traga-me 5 enchanted chicken wings.", cid)
				player:removeItem(5876, 100)
				player:removeItem(5948, 100)
				player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 3)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Você não tem as peças...", cid)
			end
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(5891, 5) then
				npcHandler:say("Perfeito! Agora nós podemos criar bem mais Tiaras. Se elas apenas não fossem tão caras... Bom, de qualquer modo, por favor obtenha uma piece of royal steel, draconian steel e hell steel.", cid)
				player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 4)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Você não tem as peças...", cid)
			end
		elseif npcHandler.topic[cid] == 7 then
			if player:getItemCount(5887) >= 1 and player:getItemCount(5888) >= 1 and player:getItemCount(5889) >= 1  then
				npcHandler:say("Nossa, estou impressionada, |PLAYERNAME|. Você realmente é um membro de valor para a nossa paladin guild. Eu devo te conceder uma recompensa agora, vista-a com orgulho!", cid)
				player:removeItem(5887, 1)
				player:removeItem(5888, 1)
				player:removeItem(5889, 1)
				player:setStorageValue(Storage.OutfitQuest.HunterHatAddon, 5)
				player:addOutfitAddon(129, 1)
				player:addOutfitAddon(137, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Você não tem as peças...", cid)
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
keywordHandler:addKeyword({'sniper gloves'}, StdModule.say, {npcHandler = npcHandler, text = 'Estamos sempre procurando por sniper gloves. Elas são supostamente para aumentar a precisão. Caso encontre um par, traga-o aqui. Talvez eu posso oferecer a você uma boa troca.'}, function(player) return player:getItemCount(5875) == 0 end)

local function addGloveKeyword(text, condition, action)
	local gloveKeyword = keywordHandler:addKeyword({'sniper gloves'}, StdModule.say, {npcHandler = npcHandler, text = text[1]}, condition)
		gloveKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = text[2], reset = true}, function(player) return player:getItemCount(5875) == 0 end)
		gloveKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = text[3], reset = true}, nil, action)
		gloveKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = text[2], reset = true})
end

-- Free Account
addGloveKeyword({
		'Você encontrou a sniper gloves?! Incrível! Eu gostaria muito de garantir a sniper gloves como acessório a você, mas só posso fazer isso para guerreiros premium. Contudo, posso pagar 2000 gold pieces por elas. O que você acha?',
		'Talvez uma outra hora.',
		'Certo! Aqui está o seu dinheiro, muito obrigada.'
	}, function(player) return not player:isPremium() end, function(player) player:removeItem(5875, 1) player:addMoney(2000) end
)

-- Premium account with addon
addGloveKeyword({
		'Você encoutrou outra sniper gloves?! INCRÍVEL! Eu não posso te dar outro acessório, mas você não quer me vender por 2000 gold pieces?',
		'Talvez uma outra hora.',
		'Certo! Aqui está o seu dinheiro, muito obrigada.'
	}, function(player) return player:getStorageValue(Storage.OutfitQuest.Hunter.AddonGlove) == 1 end, function(player) player:removeItem(5875, 1) player:addMoney(2000) end
)

-- If you don't have the addon
addGloveKeyword({
		'Você encontrou uma sniper gloves?! Incrível! Escute, se você me der, posso te garantir o direito de usá-las como um acessório. O que você acha?',
		'Sem problema, talvez uma outra hora.',
		'Perfeito! Assim eu te concedo o direito de usar a sniper gloves como um acessório. Parabéns!'
	}, function(player) return player:getStorageValue(Storage.OutfitQuest.Hunter.AddonGlove) == -1 end, function(player) player:removeItem(5875, 1) player:setStorageValue(Storage.OutfitQuest.Hunter.AddonGlove, 1) player:addOutfitAddon(129, 2) player:addOutfitAddon(137, 1) player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end
)

-- Basic
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou a líder dos Paladins. Ajudo os nossos membros."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou a líder dos Paladins. Ajudo os nossos membros."})
keywordHandler:addKeyword({'paladins'}, StdModule.say, {npcHandler = npcHandler, text = "Paladins são grandes guerreiros mágicos. Além disso, somos excelentes atiradores. Muitas pessoas no Tibia querem juntar-se a nós."})
keywordHandler:addKeyword({'warriors'}, StdModule.say, {npcHandler = npcHandler, text = "É claro que não somos fortes como os guerreiros knights, mas nenhum druid ou sorcerer vai vencer um paladin com uma espada."})
keywordHandler:addKeyword({'magicians'}, StdModule.say, {npcHandler = npcHandler, text = "Existem muitas magias e runas que os paladins podem usar."})
keywordHandler:addKeyword({'missile'}, StdModule.say, {npcHandler = npcHandler, text = "Paladins são os melhores atiradores em todo o Tibia!"})
keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou uma Paladin, não uma contadora de histórias."})
keywordHandler:addKeyword({'members'}, StdModule.say, {npcHandler = npcHandler, text = "Todo paladin profita de sua vocação. Existem muitas vantagens em ser um paladin."})
keywordHandler:addKeyword({'advantages'}, StdModule.say, {npcHandler = npcHandler, text = "Nós todos vamos te ajudar a melhorar suas habilidades. Além disso, eu vendo magias para paladins."})
keywordHandler:addKeyword({'general'}, StdModule.say, {npcHandler = npcHandler, text = "Harkath Bloodblade é o royal general."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, text = "Alguns paladins servem no exército do Rei."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, text = "Ele tem algum potencial."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, text = "O quão mole você tem que ser para se tornar um bobo da corte?"})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, text = "Os McRonalds são simples fazendeiros."})
keywordHandler:addKeyword({'eclesius'}, StdModule.say, {npcHandler = npcHandler, text = "Ele devia ser bem habilidoso antes de ficar como está agora. Realmente uma pena."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, text = "Sim?"})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, text = "O Álcool que ele vende te deixa tonto tanto na mente quanto no olho."})
keywordHandler:addKeyword({'galuna'}, StdModule.say, {npcHandler = npcHandler, text = "Uma das mais importantes membras de nossa guild. Ela faz todos os arcos e flechas que precisamos."})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, text = "Ele vende muitos equipamentos úteis."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, text = "Ele e seus seguidores não tem a graça de um verdadeiro guerreiro."})
keywordHandler:addKeyword({'harkath bloodblade'}, StdModule.say, {npcHandler = npcHandler, text = "Um verdadeiro guerreiro e habilidoso general."})
keywordHandler:addKeyword({'king tibianus'}, StdModule.say, {npcHandler = npcHandler, text = "O Rei Tibianus é um governante muito sábio."})
keywordHandler:addKeyword({'lugri'}, StdModule.say, {npcHandler = npcHandler, text = "Um seguidor do mal que vai ter o que merece, um dia."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, text = "Mhm, um pouco boazinha demais para o meu gosto. Ainda assim, é incrível o jeito com que ela lida com todos aqueles homens perseguindo ela, especialmente o assustador Oswald."})
keywordHandler:addKeyword({'marvik'}, StdModule.say, {npcHandler = npcHandler, text = "Um curandeiro bem treinado, disso tenho certeza."})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, text = "Apenas mais um mago arrogante."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, text = "Se não houvessem poderes superiores protegendo ele..."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, text = "Um monge humilde, além de um sábio homem."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, text = "Homem forte. Mas um pouco vergonhoso."})

npcHandler:setMessage(MESSAGE_GREET, "Bem vindo a guild dos paladins, |PLAYERNAME|! Como posso ajudá-lo?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Mal educado, diga adeus da proxima vez, |PLAYERNAME|!.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
