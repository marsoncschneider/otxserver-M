local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Wooden Stake
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu acho que você se esqueceu de trazer sua estaca, meu filho.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 2 and player:getItemCount(5941) == 0 end)

local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Sim, fui informado sobre o que fazer. Você está preparado para receber minha linha da oração?'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 2 end)
	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Então receba minha oração: "A esperança pode preencher seu coração - a dúvida deve ser banida". Agora, traga sua participação para Maealil no assento elven para a próxima linha da oração. Vou informá-lo sobre o que fazer.', reset = true}, nil,
		function(player) player:setStorageValue(Storage.FriendsandTraders.TheBlessedStake, 3) player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end
	)
	stakeKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Eu vou te esperar.', reset = true})

keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Você deveria visitar Maealil no assento elven agora, meu filho.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 3 end)
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Você já recebeu minha linha da oração, querido filho.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) > 3 end)
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Uma besta abençoada? Esse é um pedido estranho, meu filho. Talvez Quentin saiba mais, ele é um dos mais velhos monges depois de tudo.'})

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

addHealKeyword('Você está queimando. Deixe-me apagar aquelas chamas.', CONDITION_FIRE, CONST_ME_MAGIC_GREEN)
addHealKeyword('Você está envenenado. Deixe-me acalmar sua dor.', CONDITION_POISON, CONST_ME_MAGIC_RED)
addHealKeyword('Você está eletrificado, meu filho. Deixe-me ajudá-lo a parar de tremir.', CONDITION_ENERGY, CONST_ME_MAGIC_GREEN)

keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'Você está ferido, meu filho. Vou curar suas feridas.'},
	function(player) return player:getHealth() < 40 end,
	function(player)
		local health = player:getHealth()
		if health < 40 then player:addHealth(40 - health) end
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
)
keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'Você não está tão mal. Desculpe, não posso ajudá-lo. Mas se você estiver procurando uma proteção adicional, você deve seguir a {pilgrimage} de cinzas ou obter a proteção da {twisted of fate} aqui.'})

-- Basic
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Sou sacerdote do grande panteão.'})
keywordHandler:addKeyword({'life'}, StdModule.say, {npcHandler = npcHandler, text = 'Os ensinamentos de Crunor nos dizem para honrar a vida e não prejudicá-la.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, text = 'É minha missão trazer os ensinamentos dos deuses a todos.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = 'É minha missão trazer os ensinamentos dos deuses a todos.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Meu nome é Tibra. Sua alma me diz que você é |PLAYERNAME|.'})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, text = 'A Rainha Eloise é sábia para ouvir as propostas dos seguidores druídicos de Crunor.'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = 'A graça dos deuses deve ser obtida, não pode ser comprada!'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'O mundo do Tibia é a criação dos deuses.'})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = 'Agora, é exatamente |TIME|.'})
keywordHandler:addKeyword({'crypt'}, StdModule.say, {npcHandler = npcHandler, text = 'Há algo estranho em seu bairro. Mas quem iremos pedir ajuda se não os deuses?'})
keywordHandler:addKeyword({'monsters'}, StdModule.say, {npcHandler = npcHandler, text = 'Lembre: nem tudo o que você chama de monstro é maligno!'})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = 'A lâmina mítica foi escondida na antiguidade. Dizem que salas poderosas o protegem.'})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = 'O caído deve ser lido, não temido.'})
keywordHandler:addKeyword({'lugri'}, StdModule.say, {npcHandler = npcHandler, text = 'Apenas um homem pode cair tão baixo quanto ele. Sua alma apodreceu já.'})
keywordHandler:addKeyword({'gods'}, StdModule.say, {npcHandler = npcHandler, text = 'Os deuses dos bons nos protejam e nos guiam, os deuses do mal querem destruir-nos e roubar nossas almas!'})
keywordHandler:addKeyword({'gods of good'}, StdModule.say, {npcHandler = npcHandler, text = 'Os deuses que chamamos de bons são Fardos, Uman, Elements, Suon, Crunor, Nornur, Bastesh, Kirok, Toth e Banor..'})
keywordHandler:addKeyword({'fardos'}, StdModule.say, {npcHandler = npcHandler, text = 'Fardos é o criador. O grande observador. Ele é nosso cuidador.'})
keywordHandler:addKeyword({'uman'}, StdModule.say, {npcHandler = npcHandler, text = 'Uman é o aspecto positivo da magia. Ele nos traz os segredos das artes arcanas.'})
keywordHandler:addKeyword({'air'}, StdModule.say, {npcHandler = npcHandler, text = 'O ar é uma das forças elementares primitivas, às vezes adoradas por xamãs tribais.'})
keywordHandler:addKeyword({'fire'}, StdModule.say, {npcHandler = npcHandler, text = 'O fogo é uma das forças elementares primitivas, às vezes adoradas por xamãs tribais.'})
keywordHandler:addKeyword({'sula'}, StdModule.say, {npcHandler = npcHandler, text = 'Sula é a essência do poder elementar da água.'})
keywordHandler:addKeyword({'suon'}, StdModule.say, {npcHandler = npcHandler, text = 'Suon é o sol vitalício. Ele observa a criação com amor.'})
keywordHandler:addKeyword({'crunor'}, StdModule.say, {npcHandler = npcHandler, text = 'Crunor, a grande árvore, é o pai de toda a vida vegetal. Ele é um deus proeminente para muitos druidas.'})
keywordHandler:addKeyword({'nornur'}, StdModule.say, {npcHandler = npcHandler, text = 'Nornur é o deus misterioso do destino. Quem sabe se ele é seu criador ou apenas um cronista?'})
keywordHandler:addKeyword({'bastesh'}, StdModule.say, {npcHandler = npcHandler, text = 'Bastesh, o profundo, é a deusa do mar e suas criaturas.'})
keywordHandler:addKeyword({'kirok'}, StdModule.say, {npcHandler = npcHandler, text = 'Kirok, o louco, é o deus dos cientistas e bufões.'})
keywordHandler:addKeyword({'toth'}, StdModule.say, {npcHandler = npcHandler, text = 'Toth, o Senhor da Morte, é o guardião das almas, o guardião da vida após a morte.'})
keywordHandler:addKeyword({'banor'}, StdModule.say, {npcHandler = npcHandler, text = 'Banor, o guerreiro celestial, é o patrono de todos os lutadores contra o mal. Ele é o dom dos deuses para inspirar a humanidade.'})
keywordHandler:addKeyword({'evil'}, StdModule.say, {npcHandler = npcHandler, text = 'Os deuses que chamamos de malignos são Zathroth, Fafnar, Brog, Urgith e os Archdemons!'})
keywordHandler:addKeyword({'zathroth'}, StdModule.say, {npcHandler = npcHandler, text = 'O Zathroth é o aspecto destrutivo da magia. Ele é o enganador e o ladrão das almas.'})
keywordHandler:addKeyword({'fafnar'}, StdModule.say, {npcHandler = npcHandler, text = 'Fafner no sol abrasador. Ela observa a criação com ódio e ciúme.'})
keywordHandler:addKeyword({'brog'}, StdModule.say, {npcHandler = npcHandler, text = 'Brog, o furioso, é o grande destruidor. O berserk da escuridão.'})
keywordHandler:addKeyword({'urgith'}, StdModule.say, {npcHandler = npcHandler, text = 'O bonemaster Urgith é o senhor dos mortos-vivos e detentor das malditas almas.'})
keywordHandler:addKeyword({'archdemons'}, StdModule.say, {npcHandler = npcHandler, text = 'Os demônios são seguidores de Zathroth. Os mais cruéis são conhecidos como os sete implacáveis.'})
keywordHandler:addKeyword({'ruthless seven'}, StdModule.say, {npcHandler = npcHandler, text = 'Não quero falar sobre esse assunto!'})

npcHandler:setMessage(MESSAGE_GREET, 'Bem-vindo no nome dos deuses, peregrino |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Até mais, |PLAYERNAME|. Que os deuses estejam com você para protegê-lo e guiá-lo, meu filho!')

npcHandler:addModule(FocusModule:new())
