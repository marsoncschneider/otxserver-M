local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Pare e descanse um pouco, aventureiro! Dê uma olhada em minhas mercadorias!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	local addonProgress = player:getStorageValue(Storage.OutfitQuest.Citizen.AddonBackpack)
	if msgcontains(msg, 'addon') or msgcontains(msg, 'outfit')
			or (addonProgress == 1 and msgcontains(msg, 'leather'))
			or ((addonProgress == 1 or addonProgress == 2) and msgcontains(msg, 'backpack')) then
		if addonProgress < 1 then
			npcHandler:say('Desculpe, essa backpack que uso não está a venda. Foi feita a mão por um raro couro de minotauro.', cid)
			npcHandler.topic[cid] = 1
		elseif addonProgress == 1 then
			npcHandler:say('Ah, certo, quase me esqueci sobre a backpack! Você me trouxe 100 pieces of minotaur leather como eu pedi?', cid)
			npcHandler.topic[cid] = 3
		elseif addonProgress == 2 then
			if player:getStorageValue(Storage.OutfitQuest.Citizen.AddonBackpackTimer) < os.time() then
				npcHandler:say('Bem na hora! Sua backpack está pronta. Aqui está, espero que você goste.', cid)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				player:setStorageValue(Storage.OutfitQuest.Ref, math.min(0, player:getStorageValue(Storage.OutfitQuest.Ref) - 1))
				player:setStorageValue(Storage.OutfitQuest.Citizen.MissionBackpack, 0)
				player:setStorageValue(Storage.OutfitQuest.Citizen.AddonBackpack, 3)

				player:addOutfitAddon(136, 1)
				player:addOutfitAddon(128, 1)
			else
				npcHandler:say('Uh... Eu não esperava que você voltasse tão rápido. Me desculpe, mas eu ainda não finalizei sua backpack. Estou fazendo meu melhor, eu prometo.', cid)
			end
		elseif addonProgress == 3 then
			npcHandler:say('Desculpe-me, mas eu faço somente uma backpack dessas por pessoa, se não teria de fechar minha loja e abrir uma fábrica de couro de minotauro.', cid)
		end
		return true
	end

	if npcHandler.topic[cid] == 1 then
		if msgcontains(msg, 'backpack') or msgcontains(msg, 'minotaur') or msgcontains(msg, 'leather') then
			npcHandler:say('Bem, se você realmente quer essa backpack, eu posso fazer uma pra você, mas couro de minotauro é dificil de se encontrar. Você está disposto a dar duro nisso?', cid)
			npcHandler.topic[cid] = 2
		end

	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'yes') then
			player:setStorageValue(Storage.OutfitQuest.Ref, math.max(0, player:getStorageValue(Storage.OutfitQuest.Ref)) + 1)
			player:setStorageValue(Storage.OutfitQuest.Citizen.AddonBackpack, 1)
			player:setStorageValue(Storage.OutfitQuest.Citizen.MissionBackpack, 1)
			npcHandler:say('Então, se você me trazer 100 pieces of fine minotaur leather, verei o que posso fazer por você. Você provavelmente vai ter que matar muitos minotauros... então, boa sorte!', cid)
			npcHandler:releaseFocus(cid)
		else
			npcHandler:say('Desculpe-me, mas eu não tenho um escritório de assistência, você sabe, sem dor, sem ganhos.', cid)
		end
		npcHandler.topic[cid] = 0

	elseif npcHandler.topic[cid] == 3 then
		if msgcontains(msg, 'yes') then
			if player:getItemCount(5878) < 100 then
				npcHandler:say('Me desculpe, mas isso não é couro o suficiente para fazer uma backpack igual a minha. Você gostaria de comprar uma backpack normal por 10 gold?', cid)
			else
				npcHandler:say('Perfeito! Certo, eu preciso de um tempo para terminar essa backpack para vocÊ. Venha me ver mais tarde, okay?', cid)

				player:removeItem(5878, 100)

				player:setStorageValue(Storage.OutfitQuest.Citizen.MissionBackpack, 2)
				player:setStorageValue(Storage.OutfitQuest.Citizen.AddonBackpack, 2)
				player:setStorageValue(Storage.OutfitQuest.Citizen.AddonBackpackTimer, os.time() + 2 * 60 * 60)
			end
		else
			npcHandler:say('Eu sei, deu trabalho. Não perca o foco agora, apenas continue matando mais minotauros e você eventualmente vai ter sorte. Você gostaria de comprar uma backpack normal por 10 gold?', cid)
		end
		npcHandler.topic[cid] = 0
	end
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Estou vendendo equipamentos para aventureiros. Se você precisar de algo, deixe-me saber.'})
keywordHandler:addKeyword({'dog'}, StdModule.say, {npcHandler = npcHandler, text = 'Esse é meu cachorro Ruffy, por favor não o faça mal.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu vendo tochas, varas de pesca, minhocas, cordas, agua, mochilas, maçãs e mapas.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu sou Lubo, o dono desta loja.'})
keywordHandler:addKeyword({'maps'}, StdModule.say, {npcHandler = npcHandler, text = 'Oh! Me desculpe, eu vendi o último alguns minutos atrás.'})
keywordHandler:addKeyword({'hat'}, StdModule.say, {npcHandler = npcHandler, text = 'Meu chapéu? Hanna o para mim.'})
keywordHandler:addKeyword({'finger'}, StdModule.say, {npcHandler = npcHandler, text = 'Oh, você realmente conhece a história do velho Dago, que perdeu seus dedos quando conjurou um dragão.'})
keywordHandler:addKeyword({'pet'}, StdModule.say, {npcHandler = npcHandler, text = 'Existem algumas historias estranhas sobre os mágicos de pets. Pergunte ao Hoggle sobre isso.'})

npcHandler:setMessage(MESSAGE_GREET, 'Bem-vindo a minha loja para aventureiros, |PLAYERNAME|! Do que precisa? Me chame para negociar {trade} para olhar minhas bugigangas.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Adeus, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
