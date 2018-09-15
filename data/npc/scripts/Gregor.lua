local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Cheguem mais pertos, jovens knights! Vou ensinar algumas magias!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	local addonProgress = player:getStorageValue(Storage.OutfitQuest.Knight.AddonHelmet)
	if msgcontains(msg, 'task') then
		if not player:isPremium() then
			npcHandler:say('Desculpe, mas nossas tarefas s�o apenas para premium knights.', cid)
			return true
		end

		if addonProgress < 1 then
			npcHandler:say('Voc� disse que quer provar que realmeente merece usar essee tipo de capacete (helmet)?', cid)
			npcHandler.topic[cid] = 1
		elseif addonProgress == 1 then
			npcHandler:say('Sua tarefa atual � me trazer 100 perfect behemoth fangs, |PLAYERNAME|.', cid)
		elseif addonProgress == 2 then
			npcHandler:say('Sua tarefa atual � me trazer o helmet of Ramsay the Reckless de Banuta, |PLAYERNAME|.', cid)
		elseif addonProgress == 3 then
			npcHandler:say('Sua tarefa atual � conseguir um flask of warrior\'s sweat, |PLAYERNAME|.', cid)
		elseif addonProgress == 4 then
			npcHandler:say('Sua tarefa atual � me trazer um royal steel, |PLAYERNAME|.', cid)
		elseif addonProgress == 5 then
			npcHandler:say('Por favor, fale com Sam e diga a eele quee eu mandei voc�. Estou certo de que ele vai ficar feliz em refinar seu helmet (capacete), |PLAYERNAME|.', cid)
		else
			npcHandler:say('Voc� j� completou essa tarefa e agora vou consider�-lo um verdadeiro guerreiro, |PLAYERNAME|.', cid)
		end

	elseif msgcontains(msg, 'behemoth fang') then
		if addonProgress == 1 then
			npcHandler:say('Voc� realmente conseguiu cumprir essa tarefa? Me trouxe as 100 perfect behemoth fangs?', cid)
			npcHandler.topic[cid] = 3
		else
			npcHandler:say('Voc� n�o est� falando s�rio n�? Est�? Elas vem dos behemoths � claro. A n�o ser que sejam coelhosmoths. D��.', cid)
		end

	elseif msgcontains(msg, 'ramsay') then
		if addonProgress == 2 then
			npcHandler:say('Voc� recebeu o capacete de Ramsay the Reckless?', cid)
			npcHandler.topic[cid] = 4
		else
			npcHandler:say('Esses macacos idiotas roubam tudo o que conseguem colocar as m�os.', cid)
		end

	elseif msgcontains(msg, 'sweat') then
		if addonProgress == 3 then
			npcHandler:say('Voc� foi capaz de conseguir o flask with pure warrior\'s sweat?', cid)
			npcHandler.topic[cid] = 5
		else
			npcHandler:say('Warrior\'s sweat pode ser m�gicamente extra�do dos len�os usados por um verdadeiro guerreiro, mas somente em pequenas quantidades. Djinns s�o citados como bons extraidores m�gicos, se � que essa palavra existe.', cid)
		end

	elseif msgcontains(msg, 'royal steel') then
		if addonProgress == 4 then
			npcHandler:say('Ah, voc� trouxe o royal steel?', cid)
			npcHandler.topic[cid] = 6
		else
			npcHandler:say('Royal steel s� pode ser refinado por ferreiros muito bem treinados.', cid)
		end

	elseif npcHandler.topic[cid] == 1 then
		if msgcontains(msg, 'yes') then
			npcHandler:say({
				'Bom, ent�o escute com aten��o. Primeiramente, voc� ter� que provar que � um guerreiro feroz, animal, trazendo-me 100 perfect behemoth fangs. ...',
				'Em segundo lugar. Recupere um capacete que perdemos h� muito tempo. O Famoso Ramsay the Reckless o usava enquanto explorava um local cheio de macacos. ...',
				'Terceiro, n�s precisamos de um novo flask of warrior\'s sweat. N�s ficamos sem recentemente, mas precisanos de uma peequena quantia para apresentar as batalhas em nossa arena. ...',
				'Por ultimo, eu vou encontrar o ferreiro que ir� refinar seu capacete (helmet) se voc� me trouxer uma royal steel, um metal muito nobre. ...',
				'Voc� entendeu tudo o que eu disse a voc�? Vai aceitar a tarefa?'
			}, cid)
			npcHandler.topic[cid] = 2
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Bah. Ent�o voc� ter� de esperar o dia em que esses capacetes (helmets) forem vendidos em lojas, mas isso n�o ir� acontecer at� que o inferno congele.', cid)
			npcHandler.topic[cid] = 0
		end

	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'yes') then
			player:setStorageValue(Storage.OutfitQuest.Ref, math.max(0, player:getStorageValue(Storage.OutfitQuest.Ref)) + 1)
			player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmet, 1)
			player:setStorageValue(Storage.OutfitQuest.Knight.MissionHelmet, 1)
			npcHandler:say('Tudo bem ent�o. Volte para mim quando voc� tiver coletado as 100 perfect behemoth fangs.', cid)
			npcHandler.topic[cid] = 0
		elseif msgcontains(msg, 'no') then
			npcHandler:say('Gostaria que eu repetisse os requesitos para a tarefa?', cid)
			npcHandler.topic[cid] = 1
		end

	elseif npcHandler.topic[cid] == 3 then
		if msgcontains(msg, 'yes') then
			if not player:removeItem(5893, 100) then
				npcHandler:say('Mentir � contra a honra, |PLAYERNAME|. Tenho vergonha de voc�.', cid)
				return true
			end

			player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmet, 2)
			player:setStorageValue(Storage.OutfitQuest.Knight.MissionHelmet, 2)
			player:setStorageValue(Storage.OutfitQuest.Knight.RamsaysHelmetDoor, 1)
			npcHandler:say('Estou profundamente impressionado, bravo Knight |PLAYERNAME|. Eu n�o esperava nada a menos de voc�. Agora, por favor traga o Ramsay\'s helmet.', cid)
		elseif msgcontains(msg, 'no') then
			npcHandler:say('N�o precisa ter pressa.', cid)
		end
		npcHandler.topic[cid] = 0

	elseif npcHandler.topic[cid] == 4 then
		if msgcontains(msg, 'yes') then
			if not player:removeItem(5924, 1) then
				npcHandler:say('Mentir � contra a honra, |PLAYERNAME|. Tenho vergonha de voc�.', cid)
				return true
			end

			player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmet, 3)
			player:setStorageValue(Storage.OutfitQuest.Knight.MissionHelmet, 3)
			npcHandler:say('Bom trabalho, bravo Knight |PLAYERNAME|! Embora isso esteja danificado, tem um monte de significados sentimentais. Agora, por favor me traga o warrior\'s sweat.', cid)
		elseif msgcontains(msg, 'no') then
			npcHandler:say('N�o � necess�rio correr.', cid)
		end
		npcHandler.topic[cid] = 0

	elseif npcHandler.topic[cid] == 5 then
		if msgcontains(msg, 'yes') then
			if not player:removeItem(5885, 1) then
				npcHandler:say('Mentir � contra a honra, |PLAYERNAME|. Tenho vergonha de voc�.', cid)
				return true
			end

			player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmet, 4)
			player:setStorageValue(Storage.OutfitQuest.Knight.MissionHelmet, 4)
			npcHandler:say('Isso � uma agrad�vel surpresa, bravo Knight |PLAYERNAME|! Tem somente uma tarefa restando agora: Consiga um royal steel para ter seu capacete (helmet) refinado.', cid)
		elseif msgcontains(msg, 'no') then
			npcHandler:say('N�o � necess�rio tanta pressa.', cid)
		end
		npcHandler.topic[cid] = 0

	elseif npcHandler.topic[cid] == 6 then
		if msgcontains(msg, 'yes') then
			if not player:removeItem(5887, 1) then
				npcHandler:say('Mentir � contra a honra, |PLAYERNAME|. Tenho vergonha de voc�.', cid)
				return true
			end

			player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmet, 5)
			player:setStorageValue(Storage.OutfitQuest.Knight.MissionHelmet, 5)
			npcHandler:say('Voc� realmente merece usar esse capacete adornado, bravo Knight |PLAYERNAME|. Por favor fale com Sam e diga que eu enviei voc�. Estou certo de que ele vai ficar muito feliz em modificar seu capacete (helmet).', cid)
		elseif msgcontains(msg, 'no') then
			npcHandler:say('N�o h� necessidade de sair correndo.', cid)
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addSpellKeyword({'find', 'person'}, {npcHandler = npcHandler, spellName = 'Find Person', price = 80, level = 8, vocation = 4})
keywordHandler:addSpellKeyword({'light'}, {npcHandler = npcHandler, spellName = 'Light', price = 0, level = 8, vocation = 4})
keywordHandler:addSpellKeyword({'cure', 'poison'}, {npcHandler = npcHandler, spellName = 'Cure Poison', price = 150, level = 10, vocation = 4})
keywordHandler:addSpellKeyword({'wound', 'cleansing'}, {npcHandler = npcHandler, spellName = 'Wound Cleansing', price = 0, level = 8, vocation = 4})
keywordHandler:addSpellKeyword({'great', 'light'}, {npcHandler = npcHandler, spellName = 'Great Light', price = 500, level = 13, vocation = 4})

keywordHandler:addKeyword({'healing', 'spells'}, StdModule.say, {npcHandler = npcHandler, text = "Nessa categoria eu tenho Limpar Feridas '{Wound Cleansing}' e Curar Veneno '{Cure Poison}'."})
keywordHandler:addKeyword({'support', 'spells'}, StdModule.say, {npcHandler = npcHandler, text = "Nessa categoria eu tenho Luz '{Light}', Encontrar Pessoa'{Find Person}' e Grande Luz '{Great Light}'."})
keywordHandler:addKeyword({'spells'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu posso te ensinar magias de cura {healing spells} e magias de suporte {support spells}. Que tipo de magia voc� gostaria de aprender? Voc� tamb�m pode me dizer o level desejado das magias, se preferir assim.'})

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou o primeiro Knight. Treinei muitos her�is das historias e contos do Tibia."})
keywordHandler:addKeyword({'heroes'}, StdModule.say, {npcHandler = npcHandler, text = "� claro, voc� escutou sobre eles. Knights s�o os melhores lutadores em todo o Tibia."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, text = "Viva ao Rei!"})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Voc� est� brincando, n�? � claro que voc� sabe quem eu sou. Eu sou Gregor, o primeiro Knight."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, text = "Um �timo nome, n�o acha?"})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = "Lindo Tibia. E com nossa junta, esse lindo mundo est� a salvo."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "� hora de voc� se juntar aos Knights!"})
keywordHandler:addKeyword({'knights'}, StdModule.say, {npcHandler = npcHandler, text = "Knights s�o os guerreiros do Tibia. Sem a gente, ningu�m est� seguro. Todo bravo homem ou mulher pode juntar-se a n�s."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, text = "Algum dia algu�m vai fazer algo de bom acontecer com ele..."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, text = "Um arco pode ser um bom equipamento para algu�m n�o t�o forte para usar um equipamento de verdade."})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, text = "Eu e meus estudantes vamos frequentemente a Taverna do Frodo para beber."})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, text = "Est� sempre preocupado com seu lucro. Que perca de tempo! Ele se aventurou com baxter nos velhos tempos."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, text = "J� foi aventureiro um dia."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, text = "Antes de se tornar um padre, ela ganhou o Miss Tibia tr�s vezes seguidas."})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, text = "Fazeendeiros de paz."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = "Um bom jogo dee ca�as. Mas tenha cuidado, ele usa hack!"})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, text = "Bah, v� embora com esses truques de magiago away with these sorcerer tricks. Only cowards use tricks."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, text = "Um idiota."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, text = "Nunca vou entender esses monges pac�ficos e padres."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, text = "Tem m�sculos, mas n�o bolas."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, text = "Viva ao Rei!"})
keywordHandler:addKeyword({'outfit'}, StdModule.say, {npcHandler = npcHandler, text = "Somente os mais bravos guerreiros podem vestir meus capacetes reforjados. Tradicionalmente eles s�o recompensados depois de completar uma dif�cil tarefa para nossa guild."})
keywordHandler:addKeyword({'helmet'}, StdModule.say, {npcHandler = npcHandler, text = "Somente os mais bravos guerreiros podem vestir meus capacetes reforjados. Tradicionalmente eles s�o recompensados depois de completar uma dif�cil tarefa para nossa guild."})

npcHandler:setMessage(MESSAGE_GREET, "Sauda��es, |PLAYERNAME|. O que voc� quer?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Seja cuidadoso em suas jornadas.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Seja cuidadoso em suas jornadas.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
