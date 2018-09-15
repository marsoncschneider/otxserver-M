local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local fire = Condition(CONDITION_FIRE)
fire:setParameter(CONDITION_PARAM_DELAYED, true)
fire:setParameter(CONDITION_PARAM_FORCEUPDATE, true)
fire:addDamage(25, 9000, -10)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			player:setStorageValue(Storage.secretService.Quest, 1)
			npcHandler:say('Ainda estou um pouco ca�tica, mas bem, bem-vindo a brigada das meninas.', cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			if player:removeItem(8190, 1) then
				player:setStorageValue(Storage.secretService.CGBMission01, 2)
				player:setStorageValue(Storage.secretService.Quest, 3)
				npcHandler:say('Qu�o desnecessariamente complicado, mas assim que s�o os cidad�os de Thais. No final, conseguimos o que queriamos e eles n�o podem fazer nada sobre isso.', cid)
			else
				npcHandler:say('Traga-me o livro de feiti�os {spellbook}.', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 3 then
			if player:removeItem(7736, 1) then
				player:setStorageValue(Storage.secretService.CGBMission02, 2)
				player:setStorageValue(Storage.secretService.Quest, 5)
				npcHandler:say('Eu acho que os druidas ficar�o satisfeitos por saber que a amea�a imediata foi evitada.', cid)
			else
				npcHandler:say('Traga-me o cora��o como prova.', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			player:setStorageValue(Storage.secretService.CGBMission03, 3)
			player:setStorageValue(Storage.secretService.Quest, 7)
			npcHandler:say('�timo! Este golpe os atingiu onde mais d�i: no lucro.', cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(7702, 1) then
				player:setStorageValue(Storage.secretService.CGBMission04, 2)
				player:setStorageValue(Storage.secretService.Quest, 9)
				npcHandler:say('Espero que nossos artes�os possam fazer algo com essas coisas. Para mim, n�o faz sentido.', cid)
			else
				npcHandler:say('Voc� precisa me trazer esses planos!', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(7703, 1) then
				player:setStorageValue(Storage.secretService.CGBMission05, 2)
				player:setStorageValue(Storage.secretService.Quest, 11)
				npcHandler:say('Vou ter essa correspond�ncia examinada por nossos especialistas. Estou certo de que eles s�o bastante reveladores.', cid)
			else
				npcHandler:say('Me traga algumas sugest�es ou algo assim!', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 7 then
			if player:removeItem(7704, 1) then
				player:setStorageValue(Storage.secretService.CGBMission06, 2)
				player:setStorageValue(Storage.secretService.Quest, 13)
				npcHandler:say('Espero que esse livro antigo far� essas pesquisas qualquer coisa boa. Pessoalmente, vejo pouco uso para provar algumas linhagens depois de cortarmos todos os la�os com os tailandeses.', cid)
			else
				npcHandler:say('Voc� precisa nos trazer aquele livro de �rvores geneal�gicas!', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 8 then
			if player:removeItem(7699, 1) then
				player:setStorageValue(Storage.secretService.Mission07, 2)
				player:setStorageValue(Storage.secretService.Quest, 15)
				player:addItem(7961, 1)
				npcHandler:say({
				'Excelente. A rainha n�o se divertiu com essa amea�a. � bom que voc� tenha salvo a cidade ...',
				'Infelizmente, como somos agentes secretos, n�o podemos desfilar por voc� ou algo assim, mas deixe-me expressar nossa gratid�o por tudo o que voc� fez pela nossa cidade ...',
				'Tome este sinal de gratid�o. Voc� saber� quando usar isso!'
				}, cid)
			else
				npcHandler:say('Por favor me traga a prova da derrota dos tecnomancers loucos!', cid)
			end
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, 'no') then
		npcHandler:say('As you wish.', cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'join') then
		if player:getStorageValue(Storage.secretService.Quest) < 1 then
			npcHandler:say({
				player:getSex() == PLAYERSEX_FEMALE and
				'A brigada das meninas � a principal frente em que lutamos contra os in�meros inimigos da nossa cidade...',
				'� uma corrida constante para ficar � frente de nossos inimigos. A lealdade absoluta e a vontade de colocar a vida em jogo s�o atributos vitais para esta brigada ...',
				'Se voc� se juntar, voc� dedica seu servi�o a Carlin sozinho! Voc� realmente acha que � menina o suficiente para se juntar � brigada?'
				or
				'Um homem na brigada das meninas? Venha, isso � divertido, isso � praticamente est�pido, isso �...',
				'exatamente o que ningu�m esperaria. Mhm, segundo o pensamento, o elemento de surpresa pode compensar sua inferioridade masculina.',
				'Se voc� se juntar, voc� dedica seu servi�o a Carlin sozinho! Voc� realmente acha que � menina o suficiente para se juntar � brigada?'
			}, cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'mission') then
		if player:getStorageValue(Storage.secretService.Quest) == 1 and player:getStorageValue(Storage.secretService.TBIMission01) < 1 and player:getStorageValue(Storage.secretService.CGBMission01) < 1 then
			player:setStorageValue(Storage.secretService.Quest, 2)
			player:setStorageValue(Storage.secretService.CGBMission01, 1)
			npcHandler:say({
			'Nossas rela��es com os tailandeses podem ser chamados de tensas, na melhor das hip�teses. Portanto, n�o � realmente surpreendente que o Thaian tenha financiado a academia de Edron, mas se recusem a compartilhar algum conhecimento com nossos druidas ..',
			'Mas n�s n�o aceitamos isso com tanta facilidade. Com a ajuda da adivinha��o, aprendemos que o conhecimento que nossos druidas est�o procurando � encontrado em um determinado livro ...',
			'Ser� sua tarefa entrar na academia e roubar este livro para n�s.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission01) == 1 then
			npcHandler:say('Voc� foi bem sucedido?', cid)
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(Storage.secretService.CGBMission01) == 2 and player:getStorageValue(Storage.secretService.Quest) == 3 then
			player:setStorageValue(Storage.secretService.Quest, 4)
			player:setStorageValue(Storage.secretService.CGBMission02, 1)
			npcHandler:say({
				'Os druidas pediram um favor � brigada. Dado que confiamos fortemente em seus recursos e s�o apoiantes importantes de nossas cidades, n�o podemos negar o pedido ...',
				'Um druida errante visitou recentemente o P�ntano das Garras Verdes, localizado a noroeste daquele buraco do inferno corrompido, Venore. Ao reunir ervas, ele notou alguma presen�a maligna na referida �rea ...',
				'Procurando a fonte do mal l�, ele detectou alguma antiga ru�na. De repente, ele foi atacado por bonelords e seus minions mortos-vivos. Ele mal conseguiu escapar vivo ...',
				'A evid�ncia que ele encontrou deixou-o concluir que os bonelords nas ru�nas estavam criando as chamadas �rvores da morte. Essas �rvores est�o cheias de energia negativa e lentamente, mas corrompem constantemente seus arredores ...',
				'Ap�s o retorno do druida a Carlin, a adivinha��o confirmou seus pressupostos perturbadores sobre a exist�ncia dessas �rvores ...',
				'Ao longo dos anos, centenas foram v�timas do p�ntano, conservado pela lama e pela �gua para a eternidade. Com a ajuda das �rvores da morte, os bonelords se esfor�am para um ex�rcito de mortos-vivos. Isso n�o pode ser tolerado ...',
				'Viaja para o Green Swamp Claw e arranca o cora��o da �rvore principal. Sem isso, as �rvores n�o naturais ir�o desaparecer em breve. Traga-me o cora��o como prova.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission02) == 1 then
			npcHandler:say('Voc� foi bem sucedido??', cid)
			npcHandler.topic[cid] = 3
		elseif player:getStorageValue(Storage.secretService.CGBMission02) == 2 and player:getStorageValue(Storage.secretService.Quest) == 5 then
			player:setStorageValue(Storage.secretService.Quest, 6)
			player:setStorageValue(Storage.secretService.CGBMission03, 1)
			player:addItem(7698, 1)
			npcHandler:say({
				'Os venenosos intrigantes s�o um espinho constante do nosso lado. Eles fornecem nossos inimigos com todo o tipo de equipamentos para aumentar a amea�a que representam para nossa liberdade. Ser� sua tarefa impedir as futuras entregas de armas significativamente...',
				'Os druidas nos forneceram alguns insetos ex�ticos. Eles s�o chamados de erros de ferrugem e eles n�o receberam esse nome por sua cor ...',
				'Pegue esta caixa de erros de ferrugem e use-os no orif�cio da ferr�o na Ironhouse. Esses {pets} v�o arruinar todo o metal l� e levar� um tempo para se livrar deles.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission03) == 2 then
			npcHandler:say('Have you been successful?', cid)
			npcHandler.topic[cid] = 4
		elseif player:getStorageValue(Storage.secretService.CGBMission03) == 3 and player:getStorageValue(Storage.secretService.Quest) == 7 then
			player:setStorageValue(Storage.secretService.Quest, 8)
			player:setStorageValue(Storage.secretService.CGBMission04, 1)
			npcHandler:say({
				'Venore tem planos para um novo tipo de navio. Ser� mais r�pido e mais resiliente do que qualquer outro navio conhecido. Isso certamente melhorar� seu dom�nio sobre o com�rcio mar�timo. A menos que obtenhamos esses planos para n�s mesmos ...',
				'E � a� que voc� entra em jogo. Encontre os planos do navio no estaleiro veneziano ou talvez no porto e traga-os aqui imediatamente.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission04) == 1 then
			npcHandler:say('Voc� j� foi bem sucedido?', cid)
			npcHandler.topic[cid] = 5
		elseif player:getStorageValue(Storage.secretService.CGBMission04) == 2 and player:getStorageValue(Storage.secretService.Quest) == 9 then
			player:setStorageValue(Storage.secretService.Quest, 10)
			player:setStorageValue(Storage.secretService.CGBMission05, 1)
			npcHandler:say({
			'As ru�nas de alguma catedral antiga s�o encontradas a sudoeste de Venore. Foi um projeto que os tailandeses nunca terminaram. No entanto, nossos escoteiros relataram algumas atividades suspeitas l� ...',
			'H� um andamento cont�nuo que sugere algo grande escondido l�. N�s pedimos que voc� entre nas ru�nas da catedral e descubra o que todas essas pessoas est�o fazendo l� ...',
			'Voc� pode encontrar v�rias dicas, mas tenho certeza que voc� saber� exatamente quando voc� encontrou o que estamos procurando.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission05) == 1 then
			npcHandler:say('Voc� j� foi bem sucedido?', cid)
			npcHandler.topic[cid] = 6
		elseif player:getStorageValue(Storage.secretService.CGBMission05) == 2 and player:getStorageValue(Storage.secretService.Quest) == 11 then
			player:setStorageValue(Storage.secretService.Quest, 12)
			player:setStorageValue(Storage.secretService.CGBMission06, 1)
			npcHandler:say({
				'Como voc� pode saber, uma vez que a antiga aristocracia da nossa cidade compartilhou la�os de sangue com os nobres dos tailandeses. H� muitas reivindica��es n�o resolvidas de t�tulos e rel�quias familiares e o Thais faz pouco para ajudar neste assunto ...',
				'De qualquer forma, n�s tomaremos as coisas com nossas pr�prias m�os. H� um t�mulo nas criptas na Ilha dos Reis em que assumimos um livro que cont�m antigas hist�rias familiares e �rvores geneal�gicas ...',
				'Precisamos deste livro! N�o perguntaremos como voc� o adquiriu.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission06) == 1 then
			npcHandler:say('Voc� foi bem sucedido??', cid)
			npcHandler.topic[cid] = 7
		elseif player:getStorageValue(Storage.secretService.CGBMission06) == 2 and player:getStorageValue(Storage.secretService.Quest) == 13 then
			player:setStorageValue(Storage.secretService.Quest, 14)
			player:setStorageValue(Storage.secretService.Mission07, 1)
			npcHandler:say({
				'Tenho m�s not�cias: um an�o louco amea�ou destruir nossa amada cidade. Ele afirma ter inventado algum dispositivo que lhe permita destruir toda a cidade ...',
				'Ele tem um laborat�rio em algum lugar em Kazordoon, provavelmente em algum lugar perto do sal�o do technomancer. Encontre-o e mate-o! Traga-me a barba como prova!'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission06) == 2 and player:getStorageValue(Storage.secretService.Mission07) == 1 then
			npcHandler:say('Voc� foi bem sucedido??', cid)
			npcHandler.topic[cid] = 8
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
