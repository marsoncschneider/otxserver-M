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
			npcHandler:say('Ainda estou um pouco caótica, mas bem, bem-vindo a brigada das meninas.', cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			if player:removeItem(8190, 1) then
				player:setStorageValue(Storage.secretService.CGBMission01, 2)
				player:setStorageValue(Storage.secretService.Quest, 3)
				npcHandler:say('Quão desnecessariamente complicado, mas assim que são os cidadãos de Thais. No final, conseguimos o que queriamos e eles não podem fazer nada sobre isso.', cid)
			else
				npcHandler:say('Traga-me o livro de feitiços {spellbook}.', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 3 then
			if player:removeItem(7736, 1) then
				player:setStorageValue(Storage.secretService.CGBMission02, 2)
				player:setStorageValue(Storage.secretService.Quest, 5)
				npcHandler:say('Eu acho que os druidas ficarão satisfeitos por saber que a ameaça imediata foi evitada.', cid)
			else
				npcHandler:say('Traga-me o coração como prova.', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			player:setStorageValue(Storage.secretService.CGBMission03, 3)
			player:setStorageValue(Storage.secretService.Quest, 7)
			npcHandler:say('Ótimo! Este golpe os atingiu onde mais dói: no lucro.', cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(7702, 1) then
				player:setStorageValue(Storage.secretService.CGBMission04, 2)
				player:setStorageValue(Storage.secretService.Quest, 9)
				npcHandler:say('Espero que nossos artesãos possam fazer algo com essas coisas. Para mim, não faz sentido.', cid)
			else
				npcHandler:say('Você precisa me trazer esses planos!', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 6 then
			if player:removeItem(7703, 1) then
				player:setStorageValue(Storage.secretService.CGBMission05, 2)
				player:setStorageValue(Storage.secretService.Quest, 11)
				npcHandler:say('Vou ter essa correspondência examinada por nossos especialistas. Estou certo de que eles são bastante reveladores.', cid)
			else
				npcHandler:say('Me traga algumas sugestões ou algo assim!', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 7 then
			if player:removeItem(7704, 1) then
				player:setStorageValue(Storage.secretService.CGBMission06, 2)
				player:setStorageValue(Storage.secretService.Quest, 13)
				npcHandler:say('Espero que esse livro antigo fará essas pesquisas qualquer coisa boa. Pessoalmente, vejo pouco uso para provar algumas linhagens depois de cortarmos todos os laços com os tailandeses.', cid)
			else
				npcHandler:say('Você precisa nos trazer aquele livro de árvores genealógicas!', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 8 then
			if player:removeItem(7699, 1) then
				player:setStorageValue(Storage.secretService.Mission07, 2)
				player:setStorageValue(Storage.secretService.Quest, 15)
				player:addItem(7961, 1)
				npcHandler:say({
				'Excelente. A rainha não se divertiu com essa ameaça. É bom que você tenha salvo a cidade ...',
				'Infelizmente, como somos agentes secretos, não podemos desfilar por você ou algo assim, mas deixe-me expressar nossa gratidão por tudo o que você fez pela nossa cidade ...',
				'Tome este sinal de gratidão. Você saberá quando usar isso!'
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
				'A brigada das meninas é a principal frente em que lutamos contra os inúmeros inimigos da nossa cidade...',
				'É uma corrida constante para ficar à frente de nossos inimigos. A lealdade absoluta e a vontade de colocar a vida em jogo são atributos vitais para esta brigada ...',
				'Se você se juntar, você dedica seu serviço a Carlin sozinho! Você realmente acha que é menina o suficiente para se juntar à brigada?'
				or
				'Um homem na brigada das meninas? Venha, isso é divertido, isso é praticamente estúpido, isso é...',
				'exatamente o que ninguém esperaria. Mhm, segundo o pensamento, o elemento de surpresa pode compensar sua inferioridade masculina.',
				'Se você se juntar, você dedica seu serviço a Carlin sozinho! Você realmente acha que é menina o suficiente para se juntar à brigada?'
			}, cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'mission') then
		if player:getStorageValue(Storage.secretService.Quest) == 1 and player:getStorageValue(Storage.secretService.TBIMission01) < 1 and player:getStorageValue(Storage.secretService.CGBMission01) < 1 then
			player:setStorageValue(Storage.secretService.Quest, 2)
			player:setStorageValue(Storage.secretService.CGBMission01, 1)
			npcHandler:say({
			'Nossas relações com os tailandeses podem ser chamados de tensas, na melhor das hipóteses. Portanto, não é realmente surpreendente que o Thaian tenha financiado a academia de Edron, mas se recusem a compartilhar algum conhecimento com nossos druidas ..',
			'Mas nós não aceitamos isso com tanta facilidade. Com a ajuda da adivinhação, aprendemos que o conhecimento que nossos druidas estão procurando é encontrado em um determinado livro ...',
			'Será sua tarefa entrar na academia e roubar este livro para nós.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission01) == 1 then
			npcHandler:say('Você foi bem sucedido?', cid)
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(Storage.secretService.CGBMission01) == 2 and player:getStorageValue(Storage.secretService.Quest) == 3 then
			player:setStorageValue(Storage.secretService.Quest, 4)
			player:setStorageValue(Storage.secretService.CGBMission02, 1)
			npcHandler:say({
				'Os druidas pediram um favor à brigada. Dado que confiamos fortemente em seus recursos e são apoiantes importantes de nossas cidades, não podemos negar o pedido ...',
				'Um druida errante visitou recentemente o Pântano das Garras Verdes, localizado a noroeste daquele buraco do inferno corrompido, Venore. Ao reunir ervas, ele notou alguma presença maligna na referida área ...',
				'Procurando a fonte do mal lá, ele detectou alguma antiga ruína. De repente, ele foi atacado por bonelords e seus minions mortos-vivos. Ele mal conseguiu escapar vivo ...',
				'A evidência que ele encontrou deixou-o concluir que os bonelords nas ruínas estavam criando as chamadas árvores da morte. Essas árvores estão cheias de energia negativa e lentamente, mas corrompem constantemente seus arredores ...',
				'Após o retorno do druida a Carlin, a adivinhação confirmou seus pressupostos perturbadores sobre a existência dessas árvores ...',
				'Ao longo dos anos, centenas foram vítimas do pântano, conservado pela lama e pela água para a eternidade. Com a ajuda das árvores da morte, os bonelords se esforçam para um exército de mortos-vivos. Isso não pode ser tolerado ...',
				'Viaja para o Green Swamp Claw e arranca o coração da árvore principal. Sem isso, as árvores não naturais irão desaparecer em breve. Traga-me o coração como prova.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission02) == 1 then
			npcHandler:say('Você foi bem sucedido??', cid)
			npcHandler.topic[cid] = 3
		elseif player:getStorageValue(Storage.secretService.CGBMission02) == 2 and player:getStorageValue(Storage.secretService.Quest) == 5 then
			player:setStorageValue(Storage.secretService.Quest, 6)
			player:setStorageValue(Storage.secretService.CGBMission03, 1)
			player:addItem(7698, 1)
			npcHandler:say({
				'Os venenosos intrigantes são um espinho constante do nosso lado. Eles fornecem nossos inimigos com todo o tipo de equipamentos para aumentar a ameaça que representam para nossa liberdade. Será sua tarefa impedir as futuras entregas de armas significativamente...',
				'Os druidas nos forneceram alguns insetos exóticos. Eles são chamados de erros de ferrugem e eles não receberam esse nome por sua cor ...',
				'Pegue esta caixa de erros de ferrugem e use-os no orifício da ferrão na Ironhouse. Esses {pets} vão arruinar todo o metal lá e levará um tempo para se livrar deles.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission03) == 2 then
			npcHandler:say('Have you been successful?', cid)
			npcHandler.topic[cid] = 4
		elseif player:getStorageValue(Storage.secretService.CGBMission03) == 3 and player:getStorageValue(Storage.secretService.Quest) == 7 then
			player:setStorageValue(Storage.secretService.Quest, 8)
			player:setStorageValue(Storage.secretService.CGBMission04, 1)
			npcHandler:say({
				'Venore tem planos para um novo tipo de navio. Será mais rápido e mais resiliente do que qualquer outro navio conhecido. Isso certamente melhorará seu domínio sobre o comércio marítimo. A menos que obtenhamos esses planos para nós mesmos ...',
				'E é aí que você entra em jogo. Encontre os planos do navio no estaleiro veneziano ou talvez no porto e traga-os aqui imediatamente.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission04) == 1 then
			npcHandler:say('Você já foi bem sucedido?', cid)
			npcHandler.topic[cid] = 5
		elseif player:getStorageValue(Storage.secretService.CGBMission04) == 2 and player:getStorageValue(Storage.secretService.Quest) == 9 then
			player:setStorageValue(Storage.secretService.Quest, 10)
			player:setStorageValue(Storage.secretService.CGBMission05, 1)
			npcHandler:say({
			'As ruínas de alguma catedral antiga são encontradas a sudoeste de Venore. Foi um projeto que os tailandeses nunca terminaram. No entanto, nossos escoteiros relataram algumas atividades suspeitas lá ...',
			'Há um andamento contínuo que sugere algo grande escondido lá. Nós pedimos que você entre nas ruínas da catedral e descubra o que todas essas pessoas estão fazendo lá ...',
			'Você pode encontrar várias dicas, mas tenho certeza que você saberá exatamente quando você encontrou o que estamos procurando.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission05) == 1 then
			npcHandler:say('Você já foi bem sucedido?', cid)
			npcHandler.topic[cid] = 6
		elseif player:getStorageValue(Storage.secretService.CGBMission05) == 2 and player:getStorageValue(Storage.secretService.Quest) == 11 then
			player:setStorageValue(Storage.secretService.Quest, 12)
			player:setStorageValue(Storage.secretService.CGBMission06, 1)
			npcHandler:say({
				'Como você pode saber, uma vez que a antiga aristocracia da nossa cidade compartilhou laços de sangue com os nobres dos tailandeses. Há muitas reivindicações não resolvidas de títulos e relíquias familiares e o Thais faz pouco para ajudar neste assunto ...',
				'De qualquer forma, nós tomaremos as coisas com nossas próprias mãos. Há um túmulo nas criptas na Ilha dos Reis em que assumimos um livro que contém antigas histórias familiares e árvores genealógicas ...',
				'Precisamos deste livro! Não perguntaremos como você o adquiriu.'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission06) == 1 then
			npcHandler:say('Você foi bem sucedido??', cid)
			npcHandler.topic[cid] = 7
		elseif player:getStorageValue(Storage.secretService.CGBMission06) == 2 and player:getStorageValue(Storage.secretService.Quest) == 13 then
			player:setStorageValue(Storage.secretService.Quest, 14)
			player:setStorageValue(Storage.secretService.Mission07, 1)
			npcHandler:say({
				'Tenho más notícias: um anão louco ameaçou destruir nossa amada cidade. Ele afirma ter inventado algum dispositivo que lhe permita destruir toda a cidade ...',
				'Ele tem um laboratório em algum lugar em Kazordoon, provavelmente em algum lugar perto do salão do technomancer. Encontre-o e mate-o! Traga-me a barba como prova!'
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.secretService.CGBMission06) == 2 and player:getStorageValue(Storage.secretService.Mission07) == 1 then
			npcHandler:say('Você foi bem sucedido??', cid)
			npcHandler.topic[cid] = 8
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
