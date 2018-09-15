local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local voices = {
		{ text = 'Se sentindo perdido? Fale comigo se precisar de instru��es!' },
		{ text = 'eu posso te levar para ROOKGAARD!' },
		{ text = 'eu posso te levar para ROOKGAARD!' },
		{ text = 'eu posso te levar para ROOKGAARD!' },
		{ text = 'eu posso te levar para ROOKGAARD!' },
		{ text = 'eu posso te levar para ROOKGAARD!' },
		{ text = 'eu posso te levar para ROOKGAARD!' },
		{ text = 'eu posso te levar para ROOKGAARD!' },
		{ text = 'eu posso te levar para ROOKGAARD!' },
		{ text = 'eu posso te levar para ROOKGAARD!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'eu posso te levar para ROOKGAARD, porem voce precisa ser level 1 e sem vocacao... crie ja seu char!' },
		{ text = 'Cabelo de Troll, pele lobo, peda�os de sujeira - traga-os para mim!' },
		{ text = 'Precisamos de voc� para defender Dawnport!' },
		{ text = 'Cuidado l� fora! Certifique-se de saquear os monstros por coisas valiosas!' },
		{ text = 'Venha at� mim se precisar de ajuda!' },
		{ text = 'Voc� vai sair? Certifique-se de que voc� tem uma corda com voc�!!' },
		{ text = 'Compro todos os tipos de produtos de monstros!' },
		{ text = 'Ei, jovem aventureiro! Precisa de uma dica?' },
		{ text = 'Conhe�o os caminhos e as camadas de Dawnport. Fale comigo se quiser saber mais!' }
}
npcHandler:addModule(VoiceModule:new(voices))

-- Greeting and Farewell
keywordHandler:addGreetKeyword({'hi'}, {npcHandler = npcHandler, text = 'Ol�, companheiro aventureiro. Qual a sua necessidade? Diga comercio {trade} e em breve abriremos um neg�cio. Ou me pergunte sobre {potions}, wands} ou {runes}.'}, function(player) return player:getSex() == PLAYERSEX_FEMALE end)
keywordHandler:addAliasKeyword({'hello'})

-- All keywords
keywordHandler:addKeyword({'hint'}, StdModule.rookgaardHints, {npcHandler = npcHandler})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, mas antes da ajuda que eu mencionei - voc� deve pegar uma p� {shovel}, amigo. Ela vir� a calhar quando voc� come�ar a procurar entradas secretas para masmorras ou tesouros escondidos - muitas coisas �teis jazem escondidas entre terra, areia ou pedras!'})
keywordHandler:addKeyword({'shovel'}, StdModule.say, {npcHandler = npcHandler, text = 'Segunda melhor coisa para se ter � uma corda - uma p� revelar� entradas secretas enterradas sob pilhas de pedra soltas, ou debaixo de areia, ou terra ... voc� ver�! ...', 'As p�s podem ser compradas com Richard\'s, como os outros equipamentos, ou comida. Se voc� ainda n�o tem dinheiro, saia e mata alguns monstros l� fora - e talvez voc� at� encontre uma p�, quem sabe!'})
keywordHandler:addKeyword({'richard'}, StdModule.say, {npcHandler = npcHandler, text = 'Richard veio aqui como um carpinteiro naufragado, e agora vende ferramentas e alimentos para todos os aventureiros. Se voc� precisa de uma {rope} ou {shovel], uma vara de pesca ou algumas provis�es para uma ca�ada, voc� deve trocar com ele!'})
keywordHandler:addKeyword({'tools'}, StdModule.say, {npcHandler = npcHandler, text = 'No Tibia, voc� pode usar diferentes {tools} em seu ambiente ou para miss�es. As ferramentas mais importantes s�o {rope} e {shovel}. A {fishing rod} tamb�m � boa quando voc� precisa comer, e est� perto de um rio ou do mar.'})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = 'O alimento � muito importante para sua sa�de e mana. Se voc� est� ferido em uma briga com um {monstro}, selecione \'Usar\' em alimentos como queijo, presunto ou carne para com�-lo. Isso ir� recarregar lentamente sua sa�de e mana. Aqui no posto avan�ado, voc� pode comprar comida de {Richard}.'})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, text = 'Maravilhoso exemplar que temos aqui no Dawnport! Apenas tenha cuidado quando voc� vai ca��-los, {dying} machuca no Tibia! Eu felizmente comprarei produtos da criatura que voc� possa encontrar.'})
keywordHandler:addKeyword({'dying', 'death'}, StdModule.say, {npcHandler = npcHandler, text = 'N�o se deixe enganar por seus belos olhares - Tibia � um mundo dif�cil. Se voc� morrer, voc� perder� habilidade e experi�ncia e talvez at� alguns itens, e outros jogadores podem roubar seu cad�ver. ...', 'No Continente, voc� pode comprar {blessings} de NPCs {temple} para evitar perda de itens, mas voc� sempre perder� algumas habilidades e experi�ncia, ent�o tenha cuidado. ...', 'Tenha sempre uma {rope} com voc�, para come�ar. A {rope} � essencial.'})
keywordHandler:addKeyword({'blessing'}, StdModule.say, {npcHandler = npcHandler, text = 'As b�n��os dos deuses ir�o proteg�-lo da perda de itens e aliviar a habilidade e perda de experi�ncia quando voc� morrer. Mas voc� ter� que empreender a Peregrina��o das Cinzas no continente para obter as ben��os. ...', 'Se voc� morrer {die} em uma luta contra o ataque de um monstro, suas b�n��os ser�o perdidas, e voc� ter� que conquist�-las novamente...', 'H� tamb�m uma ben��o que ir� proteg�-lo especificamente das perdas em uma luta PvP. Esta b�n��o voc� precisar� voltar quando voc� for morto em uma luta PvP. ...', 'Aqui em Dawnport, voc� est� protegido contra perdas em uma luta PvP pela B�n��o do Aventureiro - a menos que voc� ataque outro jogador. Se voc� atacar outro jogador ou atingir o n�vel 21, voc� perder� essa ben��o.'})
keywordHandler:addKeyword({'die'}, StdModule.say, {npcHandler = npcHandler, text = 'Tibia � um mundo duro. Se voc� morrer, voc� perde alguns de seus itens - e suas habilidades! E qualquer um de passagem pode roubar seu cad�ver antes de voltar. Por isso tem cuidado. ...', 'Muitos aventureiros morrem simplesmente porque eles n�o tinham uma corda com ele quando ele desceu um buraco cheio de monstros. Certifique-se sempre de ter uma {rope} com voc� para sair das cavernas rapidamente!'})
keywordHandler:addKeyword({'mainland'}, StdModule.say, {npcHandler = npcHandler, text = 'O continente abriga as cidades mais antigas de {Tibia}, e muitos perigos e aventuras tamb�m. Quando voc� nos ajudou a defender {Dawnport}, e aprendeu o suficiente de maneiras de Tibia para atingir o n�vel 8 pelo menos, voc� deveria sair para o continente. ...', 'L�, voc� pode continuar a combater o mal - e acredite em mim, h� muito disso em nosso mundo, infelizmente. <suspiro> ...', 'Os aventureiros Premium tamb�m podem navegar para as muitas ilhas que cercam o continente, que oferecem muitos outros perigos e mist�rios a serem explorados; e voc� pode fazer quests para montar montarias e vestir-se com uma variedade de roupas novas.'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = '� a� que estamos - o mundo do Tibia. Estamos em uma pequena ilha chamada {Dawnport}, n�o muito longe da costa do Tibiano {Continente}, para ser preciso.'})
keywordHandler:addKeyword({'temple'}, StdModule.say, {npcHandler = npcHandler, text = 'Quando voc� morrer, voc� ser� ressuscitado no templo da cidade que voc� escolheu como sua casa. Tem {NPCs}, como {Oressa} aqui em{Dawnport}, pode cur�-lo se voc� estiver ferido ou envenenado. Alguns NPC especiais do templo tamb�m podem {bles} voc�...', 'Para ser completamente aben�oado, voc� deve come�ar a Peregrina��o de Cinzas em um guia local no porto, uma vez que voc� tenha chegado ao continente.'})
keywordHandler:addKeyword({'talk', 'npcs'}, StdModule.say, {npcHandler = npcHandler, text = 'NPC significa algu�m como eu ou {Hamish} ou {Coltrayne}, por exemplo. Voc� pode facilmente discernir-nos de jogadores como voc�, porque h� uma bolha de discurso ao lado do nosso nome. ...', 'Todos n�s temos nossas maneiras diferentes, mas, normalmente, abordar um NPC com "Hi" ou "Hello" abrir� uma conversa. ...', 'Alguns NPCs ter�o palavras secretas �s quais eles reagem e n�o est�o destacados em sua conversa. Nesse caso, voc� precisa digitar sua pergunta. ...', 'Para fazer isso, abra o canal de bate-papo do NPC e clique no espa�o vazio abaixo do di�logo dos NPCs e comece a digitar. ...', 'Voc� pode tentar isso perguntando a um NPC sobre seu {job}, pois esta � uma palavra-chave que a maioria reagir�. Se voc� tiver outras {questions}, diga-me.'})
keywordHandler:addKeyword({'questions'}, StdModule.say, {npcHandler = npcHandler, text = 'Posso dar-lhe instru��es sobre como fazer {play}, algumas dicas de sobreviv�ncia b�sicas e {combat}, ou explicar {PvP}, ...', 'Tamb�m posso dizer-lhe como conversar com outros {players} ou {NPCs}, ou posso inform�-lo sobre {questing} ou {spells}. ...', 'Eu tamb�m tenho uma lista de pequenos {hints} se voc� preferir isso, e posso dizer-lhe algo sobre as {people} daqui. Apenas me diga o que voc� quer saber. ...', 'Oh, mas primeiro que a ajuda que mencionei - voc� deve obter uma {shovel}, amigo. Ela vir� a calhar quando voc� come�ar a procurar entradas secretas para masmorras ou tesouros escondidos - muitas coisas �teis jazem escondidas entre terra, areia ou pedras!'})
keywordHandler:addKeyword({'people'}, StdModule.say, {npcHandler = npcHandler, text = 'Bem, os outros companheiros que voc� v� aqui, vendendo coisas e assim por diante. Diga um {name} e eu vou te dizer o que eu sei sobre ele ou ela.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, nos tempos antigos, eu me chamava Inigo Verasquiriz, mas duvido que minha fam�lia me reconhecesse. Isto �, aqueles que ainda est�o vivos.'})
keywordHandler:addKeyword({'spells'}, StdModule.say, {npcHandler = npcHandler, text = 'Toda voca��o tem feiti�os espec�ficos que s� podem ser usados se voc� tiver essa voca��o. Sorcerer\'s e Druida\'s, � claro, dependem fortemente de feiti�os, enquanto os cavaleiros t�m apenas alguns deles � disposi��o. ...', 'Como um aventureiro no treinamento, voc� tem alguns feiti�os � sua disposi��o no in�cio, mas mais ficar� dispon�vel � medida que voc� progride. ...', 'Uma vez que voc� est� no n�vel 8, novos feiti�os ficam dispon�veis no andar de cima dos formadores de magi {Garamond} e {Tybald}. Eles podem te dizer mais.'})
keywordHandler:addKeyword({'play'}, StdModule.say, {npcHandler = npcHandler, text = 'Nosso mundo {Tibia} � enxameado por muitos monstros perigosos, ent�o {fighting} � algo que voc� ter� que aprender e dominar rapidamente. Voc� pode lutar como Sorcerer, Druida, Paladino ou Knight. ...', 'Precisamos de sua ajuda para manter os monstros � margem - saia de um dos quatro port�es aqui, e voc� receber� uma das quatro {vocations} e suas habilidades para experimentar e lutar contra monstros. ...', '{Dawnport} � apenas uma ilha pequena, mas perigosa. Voc� ter� que atingir o n�vel 8 pelo menos e escolher sua definitiva {vocation} antes de partir para o continente. Para atingir o n�vel 8, voc� ter� que {fight} contra alguns {monsters} para progredir. ...', 'A luta � essencial no Tibia, e embora Dawnport seja bastante seguro em compara��o com o continente, tenha cuidado para n�o morrer, a morte MACHUCA. ...', 'Se voc� tiver outras {questions}, diga-me.'})
keywordHandler:addKeyword({'fight', 'fighting', 'fighter'}, StdModule.say, {npcHandler = npcHandler, text = 'Atravesse um dos port�es abertos neste andar e voc� estar� equipado com armas de treinamento e feiti�os de uma {vocation} espec�fica. ...', 'Existem quatro voca��es em {Tibia}: {Knight}, {Druid}, {Paladin} e {Sorcerer}. Cada uma tem suas habilidades, pontos fortes e fracos �nicos. Basta experiment�-los para ver qual � a melhor para voc�. ...', 'Precisamos de sua ajuda na nossa batalha. Combata monstros para ganhar experi�ncia e melhores habilidades, at� atingir o n�vel 8 pelo menos. Certifique-se de que voc� sempre tenha n�o s� uma {weapon}, mas tamb�m uma {rope} com voc�! ...', 'Uma vez que voc� alcan�ou o n�vel 8 ou maior, voc� precisa escolher uma voca��o como sua voca��o definitiva antes de poder partir para o Continente Tibiano {mainland}, onde mais perigos esperam por voc�. ...', 'Para escolher sua definitiva {vocation}, fale com {Oressa} no andar de baixo do templo. Ela tamb�m pode cur�-lo se estiver gravemente ferido ou envenenado - apenas diga "heal" ou "help" para ela. ...', 'Se voc� tiver outras {questions}, diga-me.'})
keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, text = 'Para se defender contra inimigos, voc� precisar� de uma arma. Voc� pode comprar armas na loja de {Coltrayne}.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu costumava ser um ca�ador com armadilhas, mas esses ossos ficaram cansados. Eu agora compro peles e troco produtos de criaturas. E eu posso ajud�-lo a encontrar seu caminho se precisar de instru��es.'})
keywordHandler:addKeyword({'pvp'}, StdModule.say, {npcHandler = npcHandler, text = 'Dependendo do mundo que voc� escolheu no Tibia, os jogadores podem atac�-lo em todos os momentos ou somente se voc� concordar. ...', 'Em um mundo PvP opcional, o PvP s� � poss�vel se ambos os jogadores concordarem com isso; mas em mundos Open PvP ou Hardcore PvP, qualquer jogador pode sempre atac�-lo, ent�o fique atento. ...', 'Uma moldura marrom em torno de um jogador indica que ele ou ela est� em uma situa��o PvP. Uma {skull} ao lado de um nome de jogador significa que ele ou ela atacou ou matou outro jogador. ...', 'Aqui em Dawnport, o PvP n�o � permitido dentro do posto avan�ado, e n�o � poss�vel at� que voc� tenha alcan�ado o n�vel 8 pelo menos. Se voc� tiver outras {questions}, diga-me.'})
keywordHandler:addKeyword({'skull'}, StdModule.say, {npcHandler = npcHandler, text = 'Um cr�nio branco significa que este jogador atacou e talvez matou outro jogador sem justifica��o. ...', 'Um cr�nio vermelho significa que algu�m matou muitos outros jogadores, enquanto um cr�nio preto descreve algu�m em uma s�ria s�rie de matan�a - ent�o fique atento!'})
keywordHandler:addKeyword({'player'}, StdModule.say, {npcHandler = npcHandler, text = 'Para conversar com outros jogadores, voc� pode clicar em um dos canais de bate-papo e ver quem est� conversando por l�. ...', 'Se voc� deseja enviar um jogador espec�fico, clique com o bot�o direito do mouse em seu nome e selecione \'Message to <nome do jogador>\'. Isso abrir� um canal de bate-papo onde voc� pode digitar sua mensagem para ele ou ela.'})
keywordHandler:addKeyword({'portal'}, StdModule.say, {npcHandler = npcHandler, text = 'Parece emanar uma camada m�gica ou um pulso que desenha todo tipo de criaturas para ele - nenhuma ofensa significou. Quando a encontramos pela primeira vez, ficamos maravilhados - achamos que talvez um feiticeiro louco tivesse constru�do, ou um culto, para invocar algo maligno. ...', 'Mas n�o encontramos sugest�es conclusivas. {Menesto} e alguns outros se ofereceram para proteger o portal dos monstros desta ilha. Voc� diz que voc� veio atrav�s dele de seu mundo! Surpreendente. ...', 'Voc� n�o poderia ter escolhido um melhor momento. N�s realmente precisamos de ajuda contra os monstros que enxaguam esta ilha e todo o mundo de {Tibia}. Se voc� n�o tiver certeza de como ajudar exatamente, posso dar-lhe {directions}.'})
keywordHandler:addKeyword({'menesto'}, StdModule.say, {npcHandler = npcHandler, text = 'N�o esteve conosco por muito tempo. Muito interessado em todas as coisas m�sticas, ent�o Menesto foi enviado para proteger o estranho portal de cristal que encontramos aqui. ...', '... Mas � claro, voc� o conheceu. ... Ent�o � realmente um {portal}, e voc� veio atrav�s dele de outro plano de exist�ncia! Nunca acreditei nos contos da idade, na verdade n�o. Mas agora ... � maravilhoso, verdadeiramente maravilhoso. ...', 'Bem, se voc� tiver alguma quest�o quanto a este plano de exist�ncia, que chamamos de {Tibia}, basta me perguntar. Posso dar {directions}, sugest�es, voc� o nomeia. <piscada para voc�>'})
keywordHandler:addKeyword({'hamish'}, StdModule.say, {npcHandler = npcHandler, text = 'Algum tipo de g�nio equivocado, penso eu. Brilhante nas po��es e runas, mas n�o conseguiu continuar com seu mestre ou com os outros alunos. Correu e criou seu pr�prio laborat�rio, vendendo para os viajantes ao longo da estrada. ...', 'Foi roubado e deixado para morrer por alguns saqueadores, quando Morris o encontrou. {Morris} remendou-o e disse que poderia us�-lo, ent�o Hamish veio aqui. Se voc� precisa de uma Varinha, Runa ou Po��o, Hamish � seu homem.'})
keywordHandler:addKeyword({'morris', 'mr morris'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, h� muitas hist�rias sobre Morris. Gosta de insistir no "Mr.". Ningu�m sabe seu primeiro nome, e diz que ele jogou com um dem�nio e perdeu seu primeiro nome para ele. ...', 'Diz-se que o dem�nio libertou Morris para que ele possa recuper�-lo no final de sua vida, entretanto, se divertindo assistindo a luta de Morris por dificuldades e aventuras. ...', 'De qualquer forma. De uma maneira ou de outra, Morris nos escolheu todos e nos reuniu aqui. N�o tenho certeza de que enviar outros em miss�es � realmente tudo para ele, mas se voc� est� procurando uma {quest}, pergunte a Morris por uma.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = 'Se voc� est� procurando uma miss�o ou tarefa, voc� deve conversar com {Morris} no andar de cima. Ele � o l�der dessa multid�o de aventureiros e sempre pode precisar de uma m�ozinha ajudando em um de seus esquemas.'})
keywordHandler:addKeyword({'ser tybald'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu n�o tenho certeza de que esse seja o verdadeiro nome dele, mas acho que ele tem boas raz�es para se manter inc�gnito aqui. Em qualquer caso, ele � um lutador formid�vel e conhece {spells} �teis para {knights} e {paladins}.'})
keywordHandler:addKeyword({'garamond'}, StdModule.say, {npcHandler = npcHandler, text = 'Formado como professor na academia de magia em Edron, eu acredito. Gosta de ver lugares diferentes, ent�o ele se juntou ao nosso pequeno grupo ilustre. Vende feiti�os para Sorcerer\'s e Druida\'s para nossos formandos.'})
keywordHandler:addKeyword({'gold'}, StdModule.say, {npcHandler = npcHandler, text = 'O ouro � importante, pois voc� precisar� reabastecer os suprimentos. Voc� pode ganhar uma quantidade razo�vel de ouro lutando contra {monstros} e pegando as coisas que eles carregam. Em {Dawnport}, estou comprando algumas dessas pilhagens, basta me pedir um {trade} veja por si mesmo.', 'Coltrayne n�o diz muito sobre si mesmo. O que recebi dos 15 anos que o conheci � que ele foi criado por um ferreiro como um fundador. ...', 'Quando um inc�ndio destruiu a sua casa de fam�lia adotiva, ele tomou uma vida inst�vel, sempre vagando. Ent�o ele conheceu {Morris} e decidiu se aventurar com ele.'})
keywordHandler:addKeyword({'oressa'}, StdModule.say, {npcHandler = npcHandler, text = 'Nossa curandeira local. N�o sei por que essa menina druida decidiu que queria a vida inst�vel de um aventureiro, mas ela � bastante robusta, para dizer a verdade. Uma vez eu vi ela confrontar um urso polar ... mas estou me deixando levar. ...', 'Se voc� precisar de cura, v� v�-la. Oressa tamb�m pode ajud�-lo a decidir se deseja escolher sua {vocation} para sair para {Mainland}.'})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = 'Druidas s�o magos da natureza. Sua especialidade � lan�ar magia de gelo e terra, al�m de proporcionar cura para os outros.'})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = 'Os Knights s�o combatentes de combate corpo-a-corpo, a voca��o mais dura de todas. Geralmente usam armas de combate corpo a corpo, como espadas, machados ou clubes.'})
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = 'Os Paladinos s�o lutadores a dist�ncia bem treinados e podem lan�ar magia sagrada. Voc� geralmente os ver� usando arcos ou bestas.'})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = 'Os Sorcerers s�o magos elementares. Dominaram o fogo, a energia e a magia da morte.'})

local function greetCallback(cid)
	local player = Player(cid)
	local level = player:getLevel()
	local vocation = player:getVocation():getId()
	if level < 0 then
		npcHandler:say("CRIANCA! Volte quando voce crescer!", cid)
		npcHandler:resetNpc(cid)
		return false
	
	elseif vocation > 0 then
		npcHandler:say(player:getName() ..", ja e tarde demais... Para ir para {Rookgaard} voce {NAO} pode ter vocacao!", cid)
		npcHandler:resetNpc(cid)
		return false
	elseif level > 1 then
		npcHandler:say(player:getName() ..", para ir para {Rookgaard} seu level nao pode ser maior que 1!", cid)
		npcHandler:resetNpc(cid)
		return false
	else
		npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", VOCE QUER IR PARA ROOKGAARD? DIGA {ROOKGAARD}")
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if npcHandler.topic[cid] == 0 then
		if msgcontains(msg, "rookgaard") then
			npcHandler:say("ESTA DECISAO E IRREVERSIVEL. VOCE TEM... CERTEZA?", cid)
			npcHandler.topic[cid] = 1
		end
	
	elseif npcHandler.topic[cid] == 1 then
		if msgcontains(msg, "yes") then
			npcHandler:say("ENTAO QUE SEJA!", cid)
			
			player:setTown(Town(6))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Town(6):getTemplePosition())
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			local edited
			edited = player:addItem(2382) 
			edited:setAttribute(ITEM_ATTRIBUTE_ATTACK, 10)
			--edited:setAttribute(ITEM_ATTRIBUTE_EXTRAATACK, 3)
			edited:setAttribute(ITEM_ATTRIBUTE_NAME, "Hellbra ".. edited:getType():getName() .. "")
			
		else
			npcHandler:say("ENTAO OQUE?", cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

local function onAddFocus(cid)
	town[cid] = 0
	vocation[cid] = 0
end

local function onReleaseFocus(cid)
	town[cid] = nil
	vocation[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "Boa ca�ada!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Tome cuidado!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())