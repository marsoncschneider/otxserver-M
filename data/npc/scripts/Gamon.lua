local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'A qualquer hora é hora de comprar mobília!'} }
npcHandler:addModule(VoiceModule:new(voices))

-- Wooden Stake
local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Fazer uma estaca a partir de uma cadeira? Você é louco??! Eu não vou desperdiçar minhas cadeiras com você de graça! Você terá de pagar por isso, além disso. Eu considero isso uma blasfêmia, você terá de pagar 5000 moedas de ouro. Certo?'},
		function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) ~= -1 end
	)

	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Argh... meu coração está triste! Tudo bem... uma promessa é uma promessa. Aqui - pegue esse wooden stake, e agora suma daqui.', ungreet = true},
		function(player) return player:getMoney() >= 5000 end,
		function(player) player:removeMoney(5000) player:addItem(5941, 1) end
	)

	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Você não pode nem pagar por isso.', reset = true})
	stakeKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Phew. Não vou matar minhas cadeiras.', reset = true})

-- Others
npcHandler:setMessage(MESSAGE_GREET, 'Bom conhecer você, Mister |PLAYERNAME|! Procurando por mobília? Veio ao lugar certo!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Você vai voltar. Eu sei.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Adeus.')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Dê uma olhada. Muita mobília vem na minha loja. Fique a vontade para usá-las em sua casa. Quer ver algum tipo específico de mobília?')

npcHandler:addModule(FocusModule:new())
