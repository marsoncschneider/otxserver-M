local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'A qualquer hora � hora de comprar mob�lia!'} }
npcHandler:addModule(VoiceModule:new(voices))

-- Wooden Stake
local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Fazer uma estaca a partir de uma cadeira? Voc� � louco??! Eu n�o vou desperdi�ar minhas cadeiras com voc� de gra�a! Voc� ter� de pagar por isso, al�m disso. Eu considero isso uma blasf�mia, voc� ter� de pagar 5000 moedas de ouro. Certo?'},
		function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) ~= -1 end
	)

	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Argh... meu cora��o est� triste! Tudo bem... uma promessa � uma promessa. Aqui - pegue esse wooden stake, e agora suma daqui.', ungreet = true},
		function(player) return player:getMoney() >= 5000 end,
		function(player) player:removeMoney(5000) player:addItem(5941, 1) end
	)

	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� n�o pode nem pagar por isso.', reset = true})
	stakeKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Phew. N�o vou matar minhas cadeiras.', reset = true})

-- Others
npcHandler:setMessage(MESSAGE_GREET, 'Bom conhecer voc�, Mister |PLAYERNAME|! Procurando por mob�lia? Veio ao lugar certo!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Voc� vai voltar. Eu sei.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus.')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'D� uma olhada. Muita mob�lia vem na minha loja. Fique a vontade para us�-las em sua casa. Quer ver algum tipo espec�fico de mob�lia?')

npcHandler:addModule(FocusModule:new())
