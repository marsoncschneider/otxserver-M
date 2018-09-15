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
		npcHandler:say("A Igreja dos Deuses me confiaram uma enorme e importante tarefa de liderar a inquisi��o. Eu deixo o trabalho de campo com os inquisidores novatos e recruto outros que cruzam meu caminho.", cid)
	elseif msgcontains(msg, "join") then
		if player:getStorageValue(Storage.TheInquisition.Questline) < 1 then
			npcHandler:say("Voc� quer se juntar a inquisi��o {inquisition}?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "blessing") or msgcontains(msg, "bless") then
		if player:getStorageValue(Storage.TheInquisition.Questline) == 25 then --if quest is done
			npcHandler:say("Voc� quer receber a ben��o da inquisi��o - o que significa todas as cinco ben��os - por " .. totalBlessPrice .. " ouro?", cid)
			npcHandler.topic[cid] = 7
		else
			npcHandler:say("Voc� n�o pode pegar essas ben��os antes de terminar a {The Inquisition Quest}.", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "mission") or msgcontains(msg, "report") then
		if player:getStorageValue(Storage.TheInquisition.Questline) < 1 then
			npcHandler:say("Voc� quer se juntar a inquisi��o {inquisition}", cid)
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 1 then
			npcHandler:say({
				"Veremos se voc� vale a pena. Pegue o inquisitor's field guide na caixa, que est� na sala de tr�s. ...",
				"Siga as intru��es no guia para falar com os guardas de Thais que protegem as paredes e port�es da cidade e teste sua lealdade. Ent�o venha me conte sobre sua miss�o {mission}."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 2)
			player:setStorageValue(Storage.TheInquisition.Mission01, 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 2 then
			npcHandler:say("Sua miss�o atual � verificar a lealdade dos guardas. Voc� j� completou essa miss�o?", cid)
			npcHandler.topic[cid] = 3
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 3 then
			npcHandler:say({
				"Escute, n�s temos informa��es sobre o culto herege que se esconde na montanha chamada the Big Old One. As bruxas chegaram a esse lugar amaldi�oado em vassouras voadoras e pensaram que estariam a salvo l�. ...",
				"Eu arranjei um tapete voador que vai levar voc� para seu esconderijo. Viaje at� Femor Hells e diga ao piloto a palavra secreta 'eclipse' ...",
				"Ele vai te levar at� o seu destino. No seu ponto de encontro, voc� vai encontrar um caldeir�o onde elas cozinham uma bebida proibida ...",
				"Use esse frasco de �gua benta para destruir a fermenta��o. E n�o se esque�a de roubar seu Grimoire e me trazer."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 4)
			player:setStorageValue(Storage.TheInquisition.Mission02, 1) -- The Inquisition Questlog- "Mission 2: Eclipse"
			player:addItem(7494, 1)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 5 then
			if player:removeItem(8702, 1) then
				npcHandler:say({
					"� hora de testar suas verdadeiras habilidades. Um de nossos aliados pediu assist�ncia. Acho que voc� � a pessoa certa para ajud�-lo ...",
					"Storkus � um velho an�o rabugenteo que trabalha como um ca�ador de vampiros h� decadas. Ele � bom mas tem seus limites. ...",
					"Ent�o, ocasionalmente n�s o enviamos alguma ajuda. Em troca ele treina e testa nossos recrutas. � uma vantagem para os dois lados ...",
					"Voc� vai encontr�-lo na sua caverna na montanha fora de Kazordoon. Ele vai te dizer sobre sua pr�xima miss�o."
				}, cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 6)
				player:setStorageValue(Storage.TheInquisition.Mission02, 3) -- The Inquisition Questlog- "Mission 2: Eclipse"
				player:setStorageValue(Storage.TheInquisition.Mission03, 1) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say("Voc� precisa me trazer o witches' grimoire.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) > 5 and player:getStorageValue(Storage.TheInquisition.Questline) < 11 then
			npcHandler:say("Sua miss�o atual � ajudar o ca�ador de vampiros Storkus. Voc� j� a completou? ", cid)
			npcHandler.topic[cid] = 4
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 11 then
			npcHandler:say({
				"N�s tivemos relatos de uma casa assombrada em Liberty Bay. Eu quero que voc� examine essa casa. Ela � a �nica ru�na em Liberty Bay, ent�o voc� n�o ter� problemas em econtr�-la. ...",
				"Existe um mal em algum lugar. Eu creio que vai ser f�cil encontrar o lugar certo a noite. Use esse frasco de �gua benta no lugar em que estiver o mal."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 12)
			player:setStorageValue(Storage.TheInquisition.Mission04, 1) -- The Inquisition Questlog- "Mission 4: The Haunted Ruin"
			player:addItem(7494, 1)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 12 or player:getStorageValue(Storage.TheInquisition.Questline) == 13 then
			npcHandler:say("Sua miss�o atual � exorcisar a casa assombrada em Liberty Bay. J� completou essa miss�o? ", cid)
			npcHandler.topic[cid] = 5
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 14 then
			npcHandler:say({
				"Voc� cuidou de hereges, bruxas, vampiros e fantasmas. Prepare-se para encarar as criaturas mais v�s que lutamos h� s�culos contra - demonios (demons). Sua nova tarefa � extremamente simples, mas longe de f�cil. ...",
				"V� e mate criaturas dem�n�acas em qualquer lugar que voc� as encontrar. Traga-me 20 de suas ess�ncias como uma prova de seu empenho."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 15)
			player:setStorageValue(Storage.TheInquisition.Mission05, 1) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 15 then
			if player:removeItem(6500, 20) then
				npcHandler:say({
					"Voc� sem d�vidas � um dos mais empenhados seguidores que j� tive. N�o pare agora. Mate mais dessas criaturas quando puder. ...",
					"Eu tenho uma recompensa para seus grandes esfor�os. Fale comigo sobre o seu {demon hunter outfit} a qualquer hora a partir de agora. Depois, iremos falar sobre suas pr�ximas miss�es."
				}, cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 16)
				player:setStorageValue(Storage.TheInquisition.Mission05, 2) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			else
				npcHandler:say("Voc� precisa de 20 ess�ncias.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 17 then
			npcHandler:say({
				"N�s tivemos relatos de algo muito perigoso acontecendo na ilha de Edron. Os dem�nios est�o planejando algo ...",
				"Algo assim � problema para todos n�s. Nossos pesquisadores conseguiram informa��es vitais antes de serem mortos por um dem�nio chamado Ungreez. ...",
				"Ser� sua miss�o matar esse dem�nio e trazer vingan�a aos nossos investigadores. Voc� ir� encontr�-lo nos mais profundos locais de Edron. Boa sorte."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 18)
			player:setStorageValue(Storage.TheInquisition.Mission06, 1) -- The Inquisition Questlog- "Mission 6: The Demon Ungreez"
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 19 then
			npcHandler:say({
				"Ent�o a besta finalmente est� morta! Gra�as aos Deuses, e a voc�, � claro! Ao menos algumas coisas est�o correndo a nosso favor ...",
				"Nossos outros operativos n�o tiveram tanta sorte assim. Mas voc� vai aprender mais sobre em sua pr�xima miss�o {mission}."
			}, cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 20)
			player:setStorageValue(Storage.TheInquisition.Mission06, 3) -- The Inquisition Questlog- "Mission 6: The Demon Ungreez"
			player:addOutfitAddon(288, 1)
			player:addOutfitAddon(289, 1)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 20 then
			npcHandler:say("Destrua a shadow nexus usando esse frasco de �gua benta e mate todos os lordes dem�nios (demon lords).", cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 21)
			player:setStorageValue(Storage.TheInquisition.Mission07, 1) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
			player:addItem(7494, 1)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 21 or player:getStorageValue(Storage.TheInquisition.Questline) == 22 then
			npcHandler:say("Sua miss�o atual � destruir a shadow nexus na Demon Forge. Voc� j� completou essa miss�o?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say("Ent�o que assim seja. Agora voc� � membro da Inquisi��o. Voc� pode me perguntar sobre outra miss�o {mission} para aumentar minha estima.", cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 3 then
			if player:getStorageValue(Storage.TheInquisition.WalterGuard) == 1 and player:getStorageValue(Storage.TheInquisition.KulagGuard) == 1 and player:getStorageValue(Storage.TheInquisition.GrofGuard) == 1 and player:getStorageValue(Storage.TheInquisition.MilesGuard) == 1 and player:getStorageValue(Storage.TheInquisition.TimGuard) == 1 then
				npcHandler:say({
					"� claro, isso � exatamente o que meus outros contatos me disseram. � claro que eu reconhecia o resultado dessa investiga��o com anteced�ncia. Isso foi apenas um dos testes. ...",
					"Bem, agora que voc� se provou ser �til, voc� pode me pedir outra miss�o {mission}. Vamos ver se voc� pode lidar com algum dever de campo tamb�m."
				}, cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 3)
				player:setStorageValue(Storage.TheInquisition.Mission01, 7) -- The Inquisition Questlog- "Mission 1: Interrogation"
			else
				npcHandler:say("Voc� ainda n�o completou sua miss�o.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 10 then
				npcHandler:say("Bom! Voc� retornou. Sua habilidade em quest�es pr�ticas parece �til. Se voc� estiver pronto para outra miss�o, apenas pergunte. ", cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 11)
				player:setStorageValue(Storage.TheInquisition.Mission03, 6) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say("Voc� ainda n�o completou sua miss�o com {Storkus}.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 5 then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 13 then
				npcHandler:say("Bem, isso foi uma tarefa f�cil, mas sua pr�xima miss�o ser� muito mais desafiadora. ", cid)
				player:setStorageValue(Storage.TheInquisition.Questline, 14)
				player:setStorageValue(Storage.TheInquisition.Mission04, 3) -- The Inquisition Questlog- "Mission 4: The Haunted Ruin"
			else
				npcHandler:say("Voc� ainda n�o completou sua miss�o com {Storkus}.", cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 6 then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 22 then
				npcHandler:say({
					"Incr�vel! Voc� � um verdadeiro defensor da f�! Eu lhe concedo o t�tulo de High Inquisitor pelos seus nobres feitos. De agora em diante voc� pode conseguir as ben��os da inquisi��o que faz da peregrina��o das cinzas completamente obsoleta ...",
					"As ben��os da inquisi��o conceder� a voc� todas as cinco ben��os pelo valor de 60000 ouro. Tamb�m, n�o se esque�a de me perguntar sobre o seu {outfit} para receber seu addon final como demon hunter."
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
				npcHandler:say("Voc� j� est� aben�oado!", cid)
			elseif player:removeMoney(totalBlessPrice) then
				npcHandler:say("Voc� foi aben�oado por todos os cinco Deuses!, |PLAYERNAME|.", cid)
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
			npcHandler:say("Ent�o n�o.", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "outfit") then
		if player:getStorageValue(Storage.TheInquisition.Questline) == 16 then
			npcHandler:say("Aqui est� seu demon hunters outfit. Voc� merece. Para conseguir os addons, complete mais miss�es.", cid)
			player:setStorageValue(Storage.TheInquisition.Questline, 17)
			player:setStorageValue(Storage.TheInquisition.Mission05, 3) -- The Inquisition Questlog- "Mission 5: Essential Gathering"
			player:addOutfit(288, 0)
			player:addOutfit(289, 0)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 23 then
			npcHandler:say("Aqui est� o ultimo addon para o seu demon hunter outfit. Parab�ns!", cid)
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
			'A parte negra do Tibia sempre est� presente. Se os humanos mostrarem apenas suas fraquezas, elas ir�o corromp�-lo e lev�-lo para a escurid�o. ...',
			'Devemos ter consci�ncia do mal. Ele sempre vem disfar�ado de algo bom.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'king') then
		npcHandler:say({
			'Os Reis de Thais s�o coroados por um representante da Igreja. Isso significa que Reinam em nome dos Deuses do bem e s�o parte do plano divino para a humanidade. ...',
			'Como chefe nominal da Igreja de Banor, os Reis n�o s�o apenas governantes, s�o mensageiros divinos. ...',
			'Os Reis financiam a inquisi��o e �s vezes fornecem m�o-de-obra em quest�es de extrema import�ncia. A inquisi��o, em troca, protege o reino dos hereges e dos indiv�duos que visam roubar o reinado sagrado dos reis.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'banor') then
		npcHandler:say({
			'No passado, a ordem de Banor era a �nica ordem de knighthood existente. Com o passar do tempo, a ordem concentrou-se cada vez mais em assuntos espirituais e n�o em mundanos. ...',			
			'Atualmente, a ordem de Banor sanciona novas ordens e oferece orienta��o espiritual aos combatentes do bem.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'fardos') then
		npcHandler:say('Os Sacerdotes de Fardos s�o m�sticos que se isolaram de assuntos mundanos. Outros fornecem orienta��o e cura �s pessoas necessitadas nos templos..', cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'uman') then
		npcHandler:say({
			'A Igreja de Uman supervisiona a educa��o das massas, bem como as a��es das guilds feiticeiras e druidas. Ela decide quais pesquisas est�o de acordo com a vontade de Uman e quais n�o. ...',
			'Preocupados, n�s da inquisi��o observamos as tentativas dessas guilds de se tornarem cada vez mais independentes e tomarem decis�es pr�prias. ...',
			'Infelizmente, a guild dos magos(sorcerer guild) tornou-se perigosamente influente e, portanto, nossos sacerdotes est�o ligadas por quest�es pol�ticas ...',
			'Os druids recentemente afirmam que est�o servindo a vontade de Crunor e n�o a de Uman. Tal heresia s� poderia ser poss�vel com a independ�ncia de Carlin do reino de Thaian. ...',
			'O centro espiritual dos druids agora fica em Carlin, l� eles t�m muita influ�ncia e n�o podem ser supervisionados pela inquisi��o.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'fafnar') then
		npcHandler:say({
			'Fafnar � adorado pelos camponeses e agricultores das �reas rurais. ...',
			'The inquisition faz vista grossa de suas atividades. Pessoas simples tem tend�ncia a misturar supersti��es com ensinamentos dos Deuses. Isso pode agravar subcultos h�reges.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'edron') then
		npcHandler:say({
			'Edron mostra perfeitamente porque a inquisi��o � necess�ria e porque precisamos de mais fundos e pessoas. ...',
			'Nossos agentes estavam investigando certas ocorr�ncias l�, quando alguns cavaleiros infi�is fugiram para ru�nas profanas. ...',
			'N�o conseguimos elimin�-lo, j� que a ordem de cavalaria local foi de pouca ajuda. ...',
			'� quase certeza de que algo de ruim est� acontecendo aqui, ent�o temos de continuar atentos.'
		}, cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'ankrahmun') then
		npcHandler:say({
			'Mesmo que reivindiquem de forma diferente, essa cidade j� est� nas garras de Zathroth e seus malvados minions. Toda sua religi�o � uma zombaria de nossos Deuses ...',
			'Assim que reunirmos for�a, devemos esmagar essa cidade de uma vez por todas.'
		}, cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = '� uma vergonha que hoje os paladins n�o usam seu poder para exercer e seguir a palavra dos Deuses. Muitos deles tornaram-se ego�stas e gananciosos.'})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = 'Atualmente, muitos Knights parecem ter esquecido a nobre causa que lhes foi ensinada no passado. Apenas alguns mantiveram-se puros, servem os Deuses e seguem seus ensinamentos.'})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = 'Aqueles com grande poder t�m que resistir a grandes tenta��es. Temos o fardo de eliminar todos aqueles que ca�rem nas tenta��es.'})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = 'Os druids daqui ainda seguem as velhas regras. Infelizmente, os druids de Carlin sairam do caminho certo nos �ltimos anos.'})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, text = 'Os an�es s�o aliados de Thais, mas seguem sua pr�pia e obscura religi�o. Contudo, os an�es a mant�m para s� mesmos, n�s temos de observar essa alian�a de perto.'})
keywordHandler:addKeyword({'kazordoon'}, StdModule.say, {npcHandler = npcHandler, text = 'Os an�es s�o aliados de Thais, mas seguem sua pr�pia e obscura religi�o. Contudo, os an�es a mant�m para s� mesmos, n�s temos de observar essa alian�a de perto.'})
keywordHandler:addKeyword({'elves'}, StdModule.say, {npcHandler = npcHandler, text = 'Esses elfos s�o muito mais civilizados do que orcs. Eles podem se tornar um problema para a humanidade a qualquer momento.'})
keywordHandler:addKeyword({'ab\'dendriel'}, StdModule.say, {npcHandler = npcHandler, text = 'Esses elfos s�o muito mais civilizados do que orcs. Eles podem se tornar um problema para a humanidade a qualquer momento.'})
keywordHandler:addKeyword({'venore'}, StdModule.say, {npcHandler = npcHandler, text = 'Venore � um pouco dif�cil de se lidar. Os mercadores tem um olho fechado nas nossas atividades em sua cidade, al�m de que nossa autoridade � limitada l�. Contudo, n�s vamos usar todo a nossa influ�ncia para prevenir uma segunda Carlin.'})
keywordHandler:addKeyword({'drefia'}, StdModule.say, {npcHandler = npcHandler, text = 'Drefia sempre foi uma cidade de pecados e heresia, assim como Carlin � hoje. Um dia, os Deuses decidiram destruir a cidade e apagar todo o mal que l� habitava.'})
keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, text = 'Darashia � uma cidade sem Deus, cheia de loucos iludidos. Um dia, certamente vai partilhar do destino de sua irm� Drefia.'})
keywordHandler:addKeyword({'demon'}, StdModule.say, {npcHandler = npcHandler, text = 'Dem�nios s�o separados por varias esp�cies e n�veis de poder. No geral, eles s�o servos dos Deuses Malignos e comandam um grande poder de destrui��o.'})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = 'Carlin � a cidade do pecado e heresia. Depois da reuni�o de Carlin com o Reino, a inquisi��o vai ter muito trabalho para purificar a cidade e seus habitantes.'})
keywordHandler:addKeyword({'zathroth'}, StdModule.say, {npcHandler = npcHandler, text = 'N�s podemos ver a influ�ncia do mal em praticamente todos os lugares. Mantenha seus olhos abertos ou o mal vai te levar pelo caminho errado e destruir voc�.'})
keywordHandler:addKeyword({'crunor'}, StdModule.say, {npcHandler = npcHandler, text = 'A Igreja de Crunor trabalha bem rente a guild dos druid. Isso faz a coopera��o dif�cil algumas vezes.'})
keywordHandler:addKeyword({'gods'}, StdModule.say, {npcHandler = npcHandler, text = 'Devemos aos Deuses bons a nossa cria��o e perpetua��o. Se n�o fosse por eles, n�s concerteza nos rebaixariamos ao nivel de rezar para os Minions e Deuses sombrios e vis.'})
keywordHandler:addKeyword({'church'}, StdModule.say, {npcHandler = npcHandler, text = 'As Igrejas e os Deuses se uniram, formando uma alian�a para lutar contra a heresia e a magia negra. Eles s�o os escudos divinos, enquanto a inquisi��o � a espada que combate o mal.'})
keywordHandler:addKeyword({'inquisitor'}, StdModule.say, {npcHandler = npcHandler, text = 'As igrejas dos Deuses me confiaram uma enorme tarefa, liderar a inquisi��o. Eu deixo o trabalho de campo para os inquisidores novos. Enquanto saio recrutando outros que cruzam meu caminho.'})
keywordHandler:addKeyword({'believer'}, StdModule.say, {npcHandler = npcHandler, text = 'Acredite nos Deuses e voc� encontrar� seu caminho.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Como dito nas igrejas. Eu sou o Lorde Inquisitor.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu sou Henricus, o Lord Inquisitor.'})

npcHandler:setMessage(MESSAGE_GREET, "Sauda��es, amigo {believer} |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Sempre atento, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Sair correndo assim � muito suspeito!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
