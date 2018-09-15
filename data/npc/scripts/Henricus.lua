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
	local totalBlessPrice = getBlessingsCost(player:getLevel()) * 5 * 1.1

	if msgcontains(msg, "inquisitor") then
		npcHandler:say("A Igreja dos Deuses me confiaram uma enorme e importante tarefa de liderar a inquisição. Eu deixo o trabalho de campo com os inquisidores novatos e recruto outros que cruzam meu caminho.", cid)
	elseif msgcontains(msg, "join") then
		if player:getStorageValue(Storage.TheInquisition.Questline) < 1 then
			npcHandler:say("Você quer se juntar a inquisição {inquisition}?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "blessing") or msgcontains(msg, "bless") then
		if player:getStorageValue(Storage.TheInquisition.Questline) == 25 then --if quest is done
			npcHandler:say("Você quer receber a benção da inquisição - o que significa todas as cinco bençãos - por " .. totalBlessPrice .. " ouro?", cid)
			npcHandler.topic[cid] = 7
		else
			npcHandler:say("Você não pode pegar essas bençãos antes de terminar a {The Inquisition Quest}.", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "mission") or msgcontains(msg, "report") then
		if player:getStorageValue(Storage.TheInquisition.Questline) < 1 then
			npcHandler:say("Você quer se juntar a inquisição {inquisition}", cid)
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 1 then
			npcHandler:say({
				"Veremos se você vale a pena. Pegue o inquisitor's field guide na caixa, que está na sala de trás. ...",
				"Siga as intruções no guia para falar com os guardas de Thais que protegem as paredes e portões da cidade e teste sua lealdade. Então venha me conte sobre sua missão {mission}."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 2)
			player:setStorageValue(Storage.TheInquisition.Mission01, 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 2 then
			npcHandler:say("Sua missão atual é verificar a lealdade dos guardas. Você já completou essa missão?", cid)
			npcHandler.topic[cid] = 3
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 3 then
			npcHandler:say({
				"Escute, nós temos informações sobre o culto herege que se esconde na montanha chamada the Big Old One. As bruxas chegaram a esse lugar amaldiçoado em vassouras voadoras e pensaram que estariam a salvo lá. ...",
				"Eu arranjei um tapete voador que vai levar você para seu esconderijo. Viaje até Femor Hells e diga ao piloto a palavra secreta 'eclipse' ...",
				"Ele vai te levar até o seu destino. No seu ponto de encontro, você vai encontrar um caldeirão onde elas cozinham uma bebida proibida ...",
				"Use esse frasco de água benta para destruir a fermentação. E não se esqueça de roubar seu Grimoire e me trazer."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 4)
			player:setStorageValue(Storage.TheInquisition.Mission02, 1) -- The Inquisition Questlog- "Mission 2: Eclipse"
			player:addItem(7494, 1)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 5 then
			if player:removeItem(8702, 1) then
				npcHandler:say({
					"É hora de testar suas verdadeiras habilidades. Um de nossos aliados pediu assistência. Acho que você é a pessoa certa para ajudá-lo ...",
					"Storkus é um velho anão rabugenteo que trabalha como um caçador de vampiros há decadas. Ele é bom mas tem seus limites. ...",
					"Então, ocasionalmente nós o enviamos alguma ajuda. Em troca ele treina e testa nossos recrutas. É uma vantagem para os dois lados ...",
					"Você vai encontrá-lo na sua caverna na montanha fora de Kazordoon. Ele vai te dizer sobre sua próxima missão."
				}, cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 6)
				player:setStorageValue(Storage.TheInquisition.Mission02, 3) -- The Inquisition Questlog- "Mission 2: Eclipse"
				player:setStorageValue(Storage.TheInquisition.Mission03, 1) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say("Você precisa me trazer o witches' grimoire.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) > 5 and player:getStorageValue(Storage.TheInquisition.Questline) < 11 then
			npcHandler:say("Sua missão atual é ajudar o caçador de vampiros Storkus. Você já a completou? ", cid)
			npcHandler.topic[cid] = 4
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 11 then
			npcHandler:say({
				"Nós tivemos relatos de uma casa assombrada em Liberty Bay. Eu quero que você examine essa casa. Ela é a única ruína em Liberty Bay, então você não terá problemas em econtrá-la. ...",
				"Existe um mal em algum lugar. Eu creio que vai ser fácil encontrar o lugar certo a noite. Use esse frasco de água benta no lugar em que estiver o mal."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 12)
			player:setStorageValue(Storage.TheInquisition.Mission04, 1) -- The Inquisition Questlog- "Mission 4: The Haunted Ruin"
			player:addItem(7494, 1)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 12 or player:getStorageValue(Storage.TheInquisition.Questline) == 13 then
			npcHandler:say("Sua missão atual é exorcisar a casa assombrada em Liberty Bay. Já completou essa missão? ", cid)
			npcHandler.topic[cid] = 5
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 14 then
			npcHandler:say({
				"Você cuidou de hereges, bruxas, vampiros e fantasmas. Prepare-se para encarar as criaturas mais vís que lutamos há séculos contra - demonios (demons). Sua nova tarefa é extremamente simples, mas longe de fácil. ...",
				"Vá e mate criaturas demôníacas em qualquer lugar que você as encontrar. Traga-me 20 de suas essências como uma prova de seu empenho."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 15)
			player:setStorageValue(Storage.TheInquisition.Mission05, 1) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 15 then
			if player:removeItem(6500, 20) then
				npcHandler:say({
					"Você sem dúvidas é um dos mais empenhados seguidores que já tive. Não pare agora. Mate mais dessas criaturas quando puder. ...",
					"Eu tenho uma recompensa para seus grandes esforços. Fale comigo sobre o seu {demon hunter outfit} a qualquer hora a partir de agora. Depois, iremos falar sobre suas próximas missões."
				}, cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 16)
				player:setStorageValue(Storage.TheInquisition.Mission05, 2) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			else
				npcHandler:say("Você precisa de 20 essências.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 17 then
			npcHandler:say({
				"Nós tivemos relatos de algo muito perigoso acontecendo na ilha de Edron. Os demônios estão planejando algo ...",
				"Algo assim é problema para todos nós. Nossos pesquisadores conseguiram informações vitais antes de serem mortos por um demônio chamado Ungreez. ...",
				"Será sua missão matar esse demônio e trazer vingança aos nossos investigadores. Você irá encontrá-lo nos mais profundos locais de Edron. Boa sorte."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 18)
			player:setStorageValue(Storage.TheInquisition.Mission06, 1) -- The Inquisition Questlog- "Mission 6: The Demon Ungreez"
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 19 then
			npcHandler:say({
				"Então a besta finalmente está morta! Graças aos Deuses, e a você, é claro! Ao menos algumas coisas estão correndo a nosso favor ...",
				"Nossos outros operativos não tiveram tanta sorte assim. Mas você vai aprender mais sobre em sua próxima missão {mission}."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 20)
			player:setStorageValue(Storage.TheInquisition.Mission06, 3) -- The Inquisition Questlog- "Mission 6: The Demon Ungreez"
			player:addOutfitAddon(288, 1)
			player:addOutfitAddon(289, 1)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 20 then
			npcHandler:say("Destrua a shadow nexus usando esse frasco de água benta e mate todos os lordes demônios (demon lords).", cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 21)
			player:setStorageValue(Storage.TheInquisition.Mission07, 1) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
			player:addItem(7494, 1)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 21 or player:getStorageValue(Storage.TheInquisition.Questline) == 22 then
			npcHandler:say("Sua missão atual é destruir a shadow nexus na Demon Forge. Você já completou essa missão?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say("Então que assim seja. Agora você é membro da Inquisição. Você pode me perguntar sobre outra missão {mission} para aumentar minha estima.", cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 3 then
			if player:getStorageValue(Storage.TheInquisition.WalterGuard) == 1 and player:getStorageValue(Storage.TheInquisition.KulagGuard) == 1 and player:getStorageValue(Storage.TheInquisition.GrofGuard) == 1 and player:getStorageValue(Storage.TheInquisition.MilesGuard) == 1 and player:getStorageValue(Storage.TheInquisition.TimGuard) == 1 then
				npcHandler:say({
					"É claro, isso é exatamente o que meus outros contatos me disseram. É claro que eu reconhecia o resultado dessa investigação com antecedência. Isso foi apenas um dos testes. ...",
					"Bem, agora que você se provou ser útil, você pode me pedir outra missão {mission}. Vamos ver se você pode lidar com algum dever de campo também."
				}, cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 3)
				player:setStorageValue(Storage.TheInquisition.Mission01, 7) -- The Inquisition Questlog- "Mission 1: Interrogation"
			else
				npcHandler:say("Você ainda não completou sua missão.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 10 then
				npcHandler:say("Bom! Você retornou. Sua habilidade em questões práticas parece útil. Se você estiver pronto para outra missão, apenas pergunte. ", cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 11)
				player:setStorageValue(Storage.TheInquisition.Mission03, 6) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say("Você ainda não completou sua missão com {Storkus}.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 5 then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 13 then
				npcHandler:say("Bem, isso foi uma tarefa fácil, mas sua próxima missão será muito mais desafiadora. ", cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 14)
				player:setStorageValue(Storage.TheInquisition.Mission04, 3) -- The Inquisition Questlog- "Mission 4: The Haunted Ruin"
			else
				npcHandler:say("Você ainda não completou sua missão com {Storkus}.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 6 then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 22 then
				npcHandler:say({
					"Incrível! Você é um verdadeiro defensor da fé! Eu lhe concedo o título de High Inquisitor pelos seus nobres feitos. De agora em diante você pode conseguir as bençãos da inquisição que faz da peregrinação das cinzas completamente obsoleta ...",
					"As bençãos da inquisição concederá a você todas as cinco bençãos pelo valor de 60000 ouro. Também, não se esqueça de me perguntar sobre o seu {outfit} para receber seu addon final como demon hunter."
				}, cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 23)
				player:setStorageValue(Storage.TheInquisition.Mission07, 3) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
				player:addAchievement('High Inquisitor')
			else
				npcHandler:say("Volte quando destruir o shadow nexus.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 7 then
			if player:getBlessings() == 5 then
				npcHandler:say("Você já está abençoado!", cid)
			elseif player:removeMoney(totalBlessPrice) then
				npcHandler:say("Você foi abençoado por todos os cinco Deuses!, |PLAYERNAME|.", cid)
				for b = 1, 5 do
					player:addBlessing(b)
				end
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			else
				npcHandler:say("Volte quando tiver dinheiro o suficiente!", cid)
			end
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 0 then
			npcHandler:say("Então não.", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "outfit") then
		if player:getStorageValue(Storage.TheInquisition.Questline) == 16 then
			npcHandler:say("Aqui está seu demon hunters outfit. Você merece. Para conseguir os addons, complete mais missões.", cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 17)
			player:setStorageValue(Storage.TheInquisition.Mission05, 3) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			player:addOutfit(288, 0)
			player:addOutfit(289, 0)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 23 then
			npcHandler:say("Aqui está o ultimo addon para o seu demon hunter outfit. Parabéns!", cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 24)
			player:setStorageValue(Storage.TheInquisition.Mission07, 4) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
			player:addOutfitAddon(288, 1)
			player:addOutfitAddon(289, 1)
			player:addOutfitAddon(288, 2)
			player:addOutfitAddon(289, 2)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			player:addAchievement('Demonbane')
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, 'dark') then
		npcHandler:say({
			'A parte negra do Tibia sempre está presente. Se os humanos mostrarem apenas suas fraquezas, elas irão corrompê-lo e levá-lo para a escuridão. ...',
			'Devemos ter consciência do mal. Ele sempre vem disfarçado de algo bom.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'king') then
		npcHandler:say({
			'Os Reis de Thais são coroados por um representante da Igreja. Isso significa que Reinam em nome dos Deuses do bem e são parte do plano divino para a humanidade. ...',
			'Como chefe nominal da Igreja de Banor, os Reis não são apenas governantes, são mensageiros divinos. ...',
			'Os Reis financiam a inquisição e às vezes fornecem mão-de-obra em questões de extrema importância. A inquisição, em troca, protege o reino dos hereges e dos indivíduos que visam roubar o reinado sagrado dos reis.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'banor') then
		npcHandler:say({
			'No passado, a ordem de Banor era a única ordem de knighthood existente. Com o passar do tempo, a ordem concentrou-se cada vez mais em assuntos espirituais e não em mundanos. ...',			
			'Atualmente, a ordem de Banor sanciona novas ordens e oferece orientação espiritual aos combatentes do bem.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'fardos') then
		npcHandler:say('Os Sacerdotes de Fardos são místicos que se isolaram de assuntos mundanos. Outros fornecem orientação e cura às pessoas necessitadas nos templos..', cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'uman') then
		npcHandler:say({
			'A Igreja de Uman supervisiona a educação das massas, bem como as ações das guilds feiticeiras e druidas. Ela decide quais pesquisas estão de acordo com a vontade de Uman e quais não. ...',
			'Preocupados, nós da inquisição observamos as tentativas dessas guilds de se tornarem cada vez mais independentes e tomarem decisões próprias. ...',
			'Infelizmente, a guild dos magos(sorcerer guild) tornou-se perigosamente influente e, portanto, nossos sacerdotes estão ligadas por questões políticas ...',
			'Os druids recentemente afirmam que estão servindo a vontade de Crunor e não a de Uman. Tal heresia só poderia ser possível com a independência de Carlin do reino de Thaian. ...',
			'O centro espiritual dos druids agora fica em Carlin, lá eles têm muita influência e não podem ser supervisionados pela inquisição.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'fafnar') then
		npcHandler:say({
			'Fafnar é adorado pelos camponeses e agricultores das áreas rurais. ...',
			'The inquisition faz vista grossa de suas atividades. Pessoas simples tem tendência a misturar superstições com ensinamentos dos Deuses. Isso pode agravar subcultos héreges.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'edron') then
		npcHandler:say({
			'Edron mostra perfeitamente porque a inquisição é necessária e porque precisamos de mais fundos e pessoas. ...',
			'Nossos agentes estavam investigando certas ocorrências lá, quando alguns cavaleiros infiéis fugiram para ruínas profanas. ...',
			'Não conseguimos eliminá-lo, já que a ordem de cavalaria local foi de pouca ajuda. ...',
			'É quase certeza de que algo de ruim está acontecendo aqui, então temos de continuar atentos.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'ankrahmun') then
		npcHandler:say({
			'Mesmo que reivindiquem de forma diferente, essa cidade já está nas garras de Zathroth e seus malvados minions. Toda sua religião é uma zombaria de nossos Deuses ...',
			'Assim que reunirmos força, devemos esmagar essa cidade de uma vez por todas.'
		}, cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = 'É uma vergonha que hoje os paladins não usam seu poder para exercer e seguir a palavra dos Deuses. Muitos deles tornaram-se egoístas e gananciosos.'})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = 'Atualmente, muitos Knights parecem ter esquecido a nobre causa que lhes foi ensinada no passado. Apenas alguns mantiveram-se puros, servem os Deuses e seguem seus ensinamentos.'})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = 'Aqueles com grande poder têm que resistir a grandes tentações. Temos o fardo de eliminar todos aqueles que caírem nas tentações.'})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = 'Os druids daqui ainda seguem as velhas regras. Infelizmente, os druids de Carlin sairam do caminho certo nos últimos anos.'})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, text = 'Os anões são aliados de Thais, mas seguem sua própia e obscura religião. Contudo, os anões a mantém para sí mesmos, nós temos de observar essa aliança de perto.'})
keywordHandler:addKeyword({'kazordoon'}, StdModule.say, {npcHandler = npcHandler, text = 'Os anões são aliados de Thais, mas seguem sua própia e obscura religião. Contudo, os anões a mantém para sí mesmos, nós temos de observar essa aliança de perto.'})
keywordHandler:addKeyword({'elves'}, StdModule.say, {npcHandler = npcHandler, text = 'Esses elfos são muito mais civilizados do que orcs. Eles podem se tornar um problema para a humanidade a qualquer momento.'})
keywordHandler:addKeyword({'ab\'dendriel'}, StdModule.say, {npcHandler = npcHandler, text = 'Esses elfos são muito mais civilizados do que orcs. Eles podem se tornar um problema para a humanidade a qualquer momento.'})
keywordHandler:addKeyword({'venore'}, StdModule.say, {npcHandler = npcHandler, text = 'Venore é um pouco difícil de se lidar. Os mercadores tem um olho fechado nas nossas atividades em sua cidade, além de que nossa autoridade é limitada lá. Contudo, nós vamos usar todo a nossa influência para prevenir uma segunda Carlin.'})
keywordHandler:addKeyword({'drefia'}, StdModule.say, {npcHandler = npcHandler, text = 'Drefia sempre foi uma cidade de pecados e heresia, assim como Carlin é hoje. Um dia, os Deuses decidiram destruir a cidade e apagar todo o mal que lá habitava.'})
keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, text = 'Darashia é uma cidade sem Deus, cheia de loucos iludidos. Um dia, certamente vai partilhar do destino de sua irmã Drefia.'})
keywordHandler:addKeyword({'demon'}, StdModule.say, {npcHandler = npcHandler, text = 'Demônios são separados por varias espécies e níveis de poder. No geral, eles são servos dos Deuses Malignos e comandam um grande poder de destruição.'})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = 'Carlin é a cidade do pecado e heresia. Depois da reunião de Carlin com o Reino, a inquisição vai ter muito trabalho para purificar a cidade e seus habitantes.'})
keywordHandler:addKeyword({'zathroth'}, StdModule.say, {npcHandler = npcHandler, text = 'Nós podemos ver a influência do mal em praticamente todos os lugares. Mantenha seus olhos abertos ou o mal vai te levar pelo caminho errado e destruir você.'})
keywordHandler:addKeyword({'crunor'}, StdModule.say, {npcHandler = npcHandler, text = 'A Igreja de Crunor trabalha bem rente a guild dos druid. Isso faz a cooperação difícil algumas vezes.'})
keywordHandler:addKeyword({'gods'}, StdModule.say, {npcHandler = npcHandler, text = 'Devemos aos Deuses bons a nossa criação e perpetuação. Se não fosse por eles, nós concerteza nos rebaixariamos ao nivel de rezar para os Minions e Deuses sombrios e vis.'})
keywordHandler:addKeyword({'church'}, StdModule.say, {npcHandler = npcHandler, text = 'As Igrejas e os Deuses se uniram, formando uma aliança para lutar contra a heresia e a magia negra. Eles são os escudos divinos, enquanto a inquisição é a espada que combate o mal.'})
keywordHandler:addKeyword({'inquisitor'}, StdModule.say, {npcHandler = npcHandler, text = 'As igrejas dos Deuses me confiaram uma enorme tarefa, liderar a inquisição. Eu deixo o trabalho de campo para os inquisidores novos. Enquanto saio recrutando outros que cruzam meu caminho.'})
keywordHandler:addKeyword({'believer'}, StdModule.say, {npcHandler = npcHandler, text = 'Acredite nos Deuses e você encontrará seu caminho.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Como dito nas igrejas. Eu sou o Lorde Inquisitor.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu sou Henricus, o Lord Inquisitor.'})

npcHandler:setMessage(MESSAGE_GREET, "Saudações, amigo {believer} |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Sempre atento, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Sair correndo assim é muito suspeito!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
