local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Wooden Stake
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu acho que voc� se esqueceu de trazer sua estaca, meu filho.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 2 and player:getItemCount(5941) == 0 end)

local stakeKeyword = keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Sim, fui informado sobre o que fazer. Voc� est� preparado para receber minha linha da ora��o?'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 2 end)
	stakeKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Ent�o receba minha ora��o: "A esperan�a pode preencher seu cora��o - a d�vida deve ser banida". Agora, traga sua participa��o para Maealil no assento elven para a pr�xima linha da ora��o. Vou inform�-lo sobre o que fazer.', reset = true}, nil,
		function(player) player:setStorageValue(Storage.FriendsandTraders.TheBlessedStake, 3) player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end
	)
	stakeKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Eu vou te esperar.', reset = true})

keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� deveria visitar Maealil no assento elven agora, meu filho.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) == 3 end)
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� j� recebeu minha linha da ora��o, querido filho.'}, function(player) return player:getStorageValue(Storage.FriendsandTraders.TheBlessedStake) > 3 end)
keywordHandler:addKeyword({'stake'}, StdModule.say, {npcHandler = npcHandler, text = 'Uma besta aben�oada? Esse � um pedido estranho, meu filho. Talvez Quentin saiba mais, ele � um dos mais velhos monges depois de tudo.'})

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

addHealKeyword('Voc� est� queimando. Deixe-me apagar aquelas chamas.', CONDITION_FIRE, CONST_ME_MAGIC_GREEN)
addHealKeyword('Voc� est� envenenado. Deixe-me acalmar sua dor.', CONDITION_POISON, CONST_ME_MAGIC_RED)
addHealKeyword('Voc� est� eletrificado, meu filho. Deixe-me ajud�-lo a parar de tremir.', CONDITION_ENERGY, CONST_ME_MAGIC_GREEN)

keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� est� ferido, meu filho. Vou curar suas feridas.'},
	function(player) return player:getHealth() < 40 end,
	function(player)
		local health = player:getHealth()
		if health < 40 then player:addHealth(40 - health) end
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
)
keywordHandler:addKeyword({'heal'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� n�o est� t�o mal. Desculpe, n�o posso ajud�-lo. Mas se voc� estiver procurando uma prote��o adicional, voc� deve seguir a {pilgrimage} de cinzas ou obter a prote��o da {twisted of fate} aqui.'})

-- Basic
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Sou sacerdote do grande pante�o.'})
keywordHandler:addKeyword({'life'}, StdModule.say, {npcHandler = npcHandler, text = 'Os ensinamentos de Crunor nos dizem para honrar a vida e n�o prejudic�-la.'})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, text = '� minha miss�o trazer os ensinamentos dos deuses a todos.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = '� minha miss�o trazer os ensinamentos dos deuses a todos.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Meu nome � Tibra. Sua alma me diz que voc� � |PLAYERNAME|.'})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, text = 'A Rainha Eloise � s�bia para ouvir as propostas dos seguidores dru�dicos de Crunor.'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = 'A gra�a dos deuses deve ser obtida, n�o pode ser comprada!'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'O mundo do Tibia � a cria��o dos deuses.'})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = 'Agora, � exatamente |TIME|.'})
keywordHandler:addKeyword({'crypt'}, StdModule.say, {npcHandler = npcHandler, text = 'H� algo estranho em seu bairro. Mas quem iremos pedir ajuda se n�o os deuses?'})
keywordHandler:addKeyword({'monsters'}, StdModule.say, {npcHandler = npcHandler, text = 'Lembre: nem tudo o que voc� chama de monstro � maligno!'})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = 'A l�mina m�tica foi escondida na antiguidade. Dizem que salas poderosas o protegem.'})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = 'O ca�do deve ser lido, n�o temido.'})
keywordHandler:addKeyword({'lugri'}, StdModule.say, {npcHandler = npcHandler, text = 'Apenas um homem pode cair t�o baixo quanto ele. Sua alma apodreceu j�.'})
keywordHandler:addKeyword({'gods'}, StdModule.say, {npcHandler = npcHandler, text = 'Os deuses dos bons nos protejam e nos guiam, os deuses do mal querem destruir-nos e roubar nossas almas!'})
keywordHandler:addKeyword({'gods of good'}, StdModule.say, {npcHandler = npcHandler, text = 'Os deuses que chamamos de bons s�o Fardos, Uman, Elements, Suon, Crunor, Nornur, Bastesh, Kirok, Toth e Banor..'})
keywordHandler:addKeyword({'fardos'}, StdModule.say, {npcHandler = npcHandler, text = 'Fardos � o criador. O grande observador. Ele � nosso cuidador.'})
keywordHandler:addKeyword({'uman'}, StdModule.say, {npcHandler = npcHandler, text = 'Uman � o aspecto positivo da magia. Ele nos traz os segredos das artes arcanas.'})
keywordHandler:addKeyword({'air'}, StdModule.say, {npcHandler = npcHandler, text = 'O ar � uma das for�as elementares primitivas, �s vezes adoradas por xam�s tribais.'})
keywordHandler:addKeyword({'fire'}, StdModule.say, {npcHandler = npcHandler, text = 'O fogo � uma das for�as elementares primitivas, �s vezes adoradas por xam�s tribais.'})
keywordHandler:addKeyword({'sula'}, StdModule.say, {npcHandler = npcHandler, text = 'Sula � a ess�ncia do poder elementar da �gua.'})
keywordHandler:addKeyword({'suon'}, StdModule.say, {npcHandler = npcHandler, text = 'Suon � o sol vital�cio. Ele observa a cria��o com amor.'})
keywordHandler:addKeyword({'crunor'}, StdModule.say, {npcHandler = npcHandler, text = 'Crunor, a grande �rvore, � o pai de toda a vida vegetal. Ele � um deus proeminente para muitos druidas.'})
keywordHandler:addKeyword({'nornur'}, StdModule.say, {npcHandler = npcHandler, text = 'Nornur � o deus misterioso do destino. Quem sabe se ele � seu criador ou apenas um cronista?'})
keywordHandler:addKeyword({'bastesh'}, StdModule.say, {npcHandler = npcHandler, text = 'Bastesh, o profundo, � a deusa do mar e suas criaturas.'})
keywordHandler:addKeyword({'kirok'}, StdModule.say, {npcHandler = npcHandler, text = 'Kirok, o louco, � o deus dos cientistas e buf�es.'})
keywordHandler:addKeyword({'toth'}, StdModule.say, {npcHandler = npcHandler, text = 'Toth, o Senhor da Morte, � o guardi�o das almas, o guardi�o da vida ap�s a morte.'})
keywordHandler:addKeyword({'banor'}, StdModule.say, {npcHandler = npcHandler, text = 'Banor, o guerreiro celestial, � o patrono de todos os lutadores contra o mal. Ele � o dom dos deuses para inspirar a humanidade.'})
keywordHandler:addKeyword({'evil'}, StdModule.say, {npcHandler = npcHandler, text = 'Os deuses que chamamos de malignos s�o Zathroth, Fafnar, Brog, Urgith e os Archdemons!'})
keywordHandler:addKeyword({'zathroth'}, StdModule.say, {npcHandler = npcHandler, text = 'O Zathroth � o aspecto destrutivo da magia. Ele � o enganador e o ladr�o das almas.'})
keywordHandler:addKeyword({'fafnar'}, StdModule.say, {npcHandler = npcHandler, text = 'Fafner no sol abrasador. Ela observa a cria��o com �dio e ci�me.'})
keywordHandler:addKeyword({'brog'}, StdModule.say, {npcHandler = npcHandler, text = 'Brog, o furioso, � o grande destruidor. O berserk da escurid�o.'})
keywordHandler:addKeyword({'urgith'}, StdModule.say, {npcHandler = npcHandler, text = 'O bonemaster Urgith � o senhor dos mortos-vivos e detentor das malditas almas.'})
keywordHandler:addKeyword({'archdemons'}, StdModule.say, {npcHandler = npcHandler, text = 'Os dem�nios s�o seguidores de Zathroth. Os mais cru�is s�o conhecidos como os sete implac�veis.'})
keywordHandler:addKeyword({'ruthless seven'}, StdModule.say, {npcHandler = npcHandler, text = 'N�o quero falar sobre esse assunto!'})

npcHandler:setMessage(MESSAGE_GREET, 'Bem-vindo no nome dos deuses, peregrino |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'At� mais, |PLAYERNAME|. Que os deuses estejam com voc� para proteg�-lo e gui�-lo, meu filho!')

npcHandler:addModule(FocusModule:new())
