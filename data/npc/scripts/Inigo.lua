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
		{ text = 'Se sentindo perdido? Fale comigo se precisar de instruções!' },
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
		{ text = 'Cabelo de Troll, pele lobo, pedaços de sujeira - traga-os para mim!' },
		{ text = 'Precisamos de você para defender Dawnport!' },
		{ text = 'Cuidado lá fora! Certifique-se de saquear os monstros por coisas valiosas!' },
		{ text = 'Venha até mim se precisar de ajuda!' },
		{ text = 'Você vai sair? Certifique-se de que você tem uma corda com você!!' },
		{ text = 'Compro todos os tipos de produtos de monstros!' },
		{ text = 'Ei, jovem aventureiro! Precisa de uma dica?' },
		{ text = 'Conheço os caminhos e as camadas de Dawnport. Fale comigo se quiser saber mais!' }
}
npcHandler:addModule(VoiceModule:new(voices))

-- Greeting and Farewell
keywordHandler:addGreetKeyword({'hi'}, {npcHandler = npcHandler, text = 'Olá, companheiro aventureiro. Qual a sua necessidade? Diga comercio {trade} e em breve abriremos um negócio. Ou me pergunte sobre {potions}, wands} ou {runes}.'}, function(player) return player:getSex() == PLAYERSEX_FEMALE end)
keywordHandler:addAliasKeyword({'hello'})

-- All keywords
keywordHandler:addKeyword({'hint'}, StdModule.rookgaardHints, {npcHandler = npcHandler})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, mas antes da ajuda que eu mencionei - você deve pegar uma pá {shovel}, amigo. Ela virá a calhar quando você começar a procurar entradas secretas para masmorras ou tesouros escondidos - muitas coisas úteis jazem escondidas entre terra, areia ou pedras!'})
keywordHandler:addKeyword({'shovel'}, StdModule.say, {npcHandler = npcHandler, text = 'Segunda melhor coisa para se ter é uma corda - uma pá revelará entradas secretas enterradas sob pilhas de pedra soltas, ou debaixo de areia, ou terra ... você verá! ...', 'As pás podem ser compradas com Richard\'s, como os outros equipamentos, ou comida. Se você ainda não tem dinheiro, saia e mata alguns monstros lá fora - e talvez você até encontre uma pá, quem sabe!'})
keywordHandler:addKeyword({'richard'}, StdModule.say, {npcHandler = npcHandler, text = 'Richard veio aqui como um carpinteiro naufragado, e agora vende ferramentas e alimentos para todos os aventureiros. Se você precisa de uma {rope} ou {shovel], uma vara de pesca ou algumas provisões para uma caçada, você deve trocar com ele!'})
keywordHandler:addKeyword({'tools'}, StdModule.say, {npcHandler = npcHandler, text = 'No Tibia, você pode usar diferentes {tools} em seu ambiente ou para missões. As ferramentas mais importantes são {rope} e {shovel}. A {fishing rod} também é boa quando você precisa comer, e está perto de um rio ou do mar.'})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = 'O alimento é muito importante para sua saúde e mana. Se você está ferido em uma briga com um {monstro}, selecione \'Usar\' em alimentos como queijo, presunto ou carne para comê-lo. Isso irá recarregar lentamente sua saúde e mana. Aqui no posto avançado, você pode comprar comida de {Richard}.'})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, text = 'Maravilhoso exemplar que temos aqui no Dawnport! Apenas tenha cuidado quando você vai caçá-los, {dying} machuca no Tibia! Eu felizmente comprarei produtos da criatura que você possa encontrar.'})
keywordHandler:addKeyword({'dying', 'death'}, StdModule.say, {npcHandler = npcHandler, text = 'Não se deixe enganar por seus belos olhares - Tibia é um mundo difícil. Se você morrer, você perderá habilidade e experiência e talvez até alguns itens, e outros jogadores podem roubar seu cadáver. ...', 'No Continente, você pode comprar {blessings} de NPCs {temple} para evitar perda de itens, mas você sempre perderá algumas habilidades e experiência, então tenha cuidado. ...', 'Tenha sempre uma {rope} com você, para começar. A {rope} é essencial.'})
keywordHandler:addKeyword({'blessing'}, StdModule.say, {npcHandler = npcHandler, text = 'As bênçãos dos deuses irão protegê-lo da perda de itens e aliviar a habilidade e perda de experiência quando você morrer. Mas você terá que empreender a Peregrinação das Cinzas no continente para obter as bençãos. ...', 'Se você morrer {die} em uma luta contra o ataque de um monstro, suas bênçãos serão perdidas, e você terá que conquistá-las novamente...', 'Há também uma benção que irá protegê-lo especificamente das perdas em uma luta PvP. Esta bênção você precisará voltar quando você for morto em uma luta PvP. ...', 'Aqui em Dawnport, você está protegido contra perdas em uma luta PvP pela Bênção do Aventureiro - a menos que você ataque outro jogador. Se você atacar outro jogador ou atingir o nível 21, você perderá essa benção.'})
keywordHandler:addKeyword({'die'}, StdModule.say, {npcHandler = npcHandler, text = 'Tibia é um mundo duro. Se você morrer, você perde alguns de seus itens - e suas habilidades! E qualquer um de passagem pode roubar seu cadáver antes de voltar. Por isso tem cuidado. ...', 'Muitos aventureiros morrem simplesmente porque eles não tinham uma corda com ele quando ele desceu um buraco cheio de monstros. Certifique-se sempre de ter uma {rope} com você para sair das cavernas rapidamente!'})
keywordHandler:addKeyword({'mainland'}, StdModule.say, {npcHandler = npcHandler, text = 'O continente abriga as cidades mais antigas de {Tibia}, e muitos perigos e aventuras também. Quando você nos ajudou a defender {Dawnport}, e aprendeu o suficiente de maneiras de Tibia para atingir o nível 8 pelo menos, você deveria sair para o continente. ...', 'Lá, você pode continuar a combater o mal - e acredite em mim, há muito disso em nosso mundo, infelizmente. <suspiro> ...', 'Os aventureiros Premium também podem navegar para as muitas ilhas que cercam o continente, que oferecem muitos outros perigos e mistérios a serem explorados; e você pode fazer quests para montar montarias e vestir-se com uma variedade de roupas novas.'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'É aí que estamos - o mundo do Tibia. Estamos em uma pequena ilha chamada {Dawnport}, não muito longe da costa do Tibiano {Continente}, para ser preciso.'})
keywordHandler:addKeyword({'temple'}, StdModule.say, {npcHandler = npcHandler, text = 'Quando você morrer, você será ressuscitado no templo da cidade que você escolheu como sua casa. Tem {NPCs}, como {Oressa} aqui em{Dawnport}, pode curá-lo se você estiver ferido ou envenenado. Alguns NPC especiais do templo também podem {bles} você...', 'Para ser completamente abençoado, você deve começar a Peregrinação de Cinzas em um guia local no porto, uma vez que você tenha chegado ao continente.'})
keywordHandler:addKeyword({'talk', 'npcs'}, StdModule.say, {npcHandler = npcHandler, text = 'NPC significa alguém como eu ou {Hamish} ou {Coltrayne}, por exemplo. Você pode facilmente discernir-nos de jogadores como você, porque há uma bolha de discurso ao lado do nosso nome. ...', 'Todos nós temos nossas maneiras diferentes, mas, normalmente, abordar um NPC com "Hi" ou "Hello" abrirá uma conversa. ...', 'Alguns NPCs terão palavras secretas às quais eles reagem e não estão destacados em sua conversa. Nesse caso, você precisa digitar sua pergunta. ...', 'Para fazer isso, abra o canal de bate-papo do NPC e clique no espaço vazio abaixo do diálogo dos NPCs e comece a digitar. ...', 'Você pode tentar isso perguntando a um NPC sobre seu {job}, pois esta é uma palavra-chave que a maioria reagirá. Se você tiver outras {questions}, diga-me.'})
keywordHandler:addKeyword({'questions'}, StdModule.say, {npcHandler = npcHandler, text = 'Posso dar-lhe instruções sobre como fazer {play}, algumas dicas de sobrevivência básicas e {combat}, ou explicar {PvP}, ...', 'Também posso dizer-lhe como conversar com outros {players} ou {NPCs}, ou posso informá-lo sobre {questing} ou {spells}. ...', 'Eu também tenho uma lista de pequenos {hints} se você preferir isso, e posso dizer-lhe algo sobre as {people} daqui. Apenas me diga o que você quer saber. ...', 'Oh, mas primeiro que a ajuda que mencionei - você deve obter uma {shovel}, amigo. Ela virá a calhar quando você começar a procurar entradas secretas para masmorras ou tesouros escondidos - muitas coisas úteis jazem escondidas entre terra, areia ou pedras!'})
keywordHandler:addKeyword({'people'}, StdModule.say, {npcHandler = npcHandler, text = 'Bem, os outros companheiros que você vê aqui, vendendo coisas e assim por diante. Diga um {name} e eu vou te dizer o que eu sei sobre ele ou ela.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, nos tempos antigos, eu me chamava Inigo Verasquiriz, mas duvido que minha família me reconhecesse. Isto é, aqueles que ainda estão vivos.'})
keywordHandler:addKeyword({'spells'}, StdModule.say, {npcHandler = npcHandler, text = 'Toda vocação tem feitiços específicos que só podem ser usados se você tiver essa vocação. Sorcerer\'s e Druida\'s, é claro, dependem fortemente de feitiços, enquanto os cavaleiros têm apenas alguns deles à disposição. ...', 'Como um aventureiro no treinamento, você tem alguns feitiços à sua disposição no início, mas mais ficará disponível à medida que você progride. ...', 'Uma vez que você está no nível 8, novos feitiços ficam disponíveis no andar de cima dos formadores de magi {Garamond} e {Tybald}. Eles podem te dizer mais.'})
keywordHandler:addKeyword({'play'}, StdModule.say, {npcHandler = npcHandler, text = 'Nosso mundo {Tibia} é enxameado por muitos monstros perigosos, então {fighting} é algo que você terá que aprender e dominar rapidamente. Você pode lutar como Sorcerer, Druida, Paladino ou Knight. ...', 'Precisamos de sua ajuda para manter os monstros à margem - saia de um dos quatro portões aqui, e você receberá uma das quatro {vocations} e suas habilidades para experimentar e lutar contra monstros. ...', '{Dawnport} é apenas uma ilha pequena, mas perigosa. Você terá que atingir o nível 8 pelo menos e escolher sua definitiva {vocation} antes de partir para o continente. Para atingir o nível 8, você terá que {fight} contra alguns {monsters} para progredir. ...', 'A luta é essencial no Tibia, e embora Dawnport seja bastante seguro em comparação com o continente, tenha cuidado para não morrer, a morte MACHUCA. ...', 'Se você tiver outras {questions}, diga-me.'})
keywordHandler:addKeyword({'fight', 'fighting', 'fighter'}, StdModule.say, {npcHandler = npcHandler, text = 'Atravesse um dos portões abertos neste andar e você estará equipado com armas de treinamento e feitiços de uma {vocation} específica. ...', 'Existem quatro vocações em {Tibia}: {Knight}, {Druid}, {Paladin} e {Sorcerer}. Cada uma tem suas habilidades, pontos fortes e fracos únicos. Basta experimentá-los para ver qual é a melhor para você. ...', 'Precisamos de sua ajuda na nossa batalha. Combata monstros para ganhar experiência e melhores habilidades, até atingir o nível 8 pelo menos. Certifique-se de que você sempre tenha não só uma {weapon}, mas também uma {rope} com você! ...', 'Uma vez que você alcançou o nível 8 ou maior, você precisa escolher uma vocação como sua vocação definitiva antes de poder partir para o Continente Tibiano {mainland}, onde mais perigos esperam por você. ...', 'Para escolher sua definitiva {vocation}, fale com {Oressa} no andar de baixo do templo. Ela também pode curá-lo se estiver gravemente ferido ou envenenado - apenas diga "heal" ou "help" para ela. ...', 'Se você tiver outras {questions}, diga-me.'})
keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, text = 'Para se defender contra inimigos, você precisará de uma arma. Você pode comprar armas na loja de {Coltrayne}.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu costumava ser um caçador com armadilhas, mas esses ossos ficaram cansados. Eu agora compro peles e troco produtos de criaturas. E eu posso ajudá-lo a encontrar seu caminho se precisar de instruções.'})
keywordHandler:addKeyword({'pvp'}, StdModule.say, {npcHandler = npcHandler, text = 'Dependendo do mundo que você escolheu no Tibia, os jogadores podem atacá-lo em todos os momentos ou somente se você concordar. ...', 'Em um mundo PvP opcional, o PvP só é possível se ambos os jogadores concordarem com isso; mas em mundos Open PvP ou Hardcore PvP, qualquer jogador pode sempre atacá-lo, então fique atento. ...', 'Uma moldura marrom em torno de um jogador indica que ele ou ela está em uma situação PvP. Uma {skull} ao lado de um nome de jogador significa que ele ou ela atacou ou matou outro jogador. ...', 'Aqui em Dawnport, o PvP não é permitido dentro do posto avançado, e não é possível até que você tenha alcançado o nível 8 pelo menos. Se você tiver outras {questions}, diga-me.'})
keywordHandler:addKeyword({'skull'}, StdModule.say, {npcHandler = npcHandler, text = 'Um crânio branco significa que este jogador atacou e talvez matou outro jogador sem justificação. ...', 'Um crânio vermelho significa que alguém matou muitos outros jogadores, enquanto um crânio preto descreve alguém em uma séria série de matança - então fique atento!'})
keywordHandler:addKeyword({'player'}, StdModule.say, {npcHandler = npcHandler, text = 'Para conversar com outros jogadores, você pode clicar em um dos canais de bate-papo e ver quem está conversando por lá. ...', 'Se você deseja enviar um jogador específico, clique com o botão direito do mouse em seu nome e selecione \'Message to <nome do jogador>\'. Isso abrirá um canal de bate-papo onde você pode digitar sua mensagem para ele ou ela.'})
keywordHandler:addKeyword({'portal'}, StdModule.say, {npcHandler = npcHandler, text = 'Parece emanar uma camada mágica ou um pulso que desenha todo tipo de criaturas para ele - nenhuma ofensa significou. Quando a encontramos pela primeira vez, ficamos maravilhados - achamos que talvez um feiticeiro louco tivesse construído, ou um culto, para invocar algo maligno. ...', 'Mas não encontramos sugestões conclusivas. {Menesto} e alguns outros se ofereceram para proteger o portal dos monstros desta ilha. Você diz que você veio através dele de seu mundo! Surpreendente. ...', 'Você não poderia ter escolhido um melhor momento. Nós realmente precisamos de ajuda contra os monstros que enxaguam esta ilha e todo o mundo de {Tibia}. Se você não tiver certeza de como ajudar exatamente, posso dar-lhe {directions}.'})
keywordHandler:addKeyword({'menesto'}, StdModule.say, {npcHandler = npcHandler, text = 'Não esteve conosco por muito tempo. Muito interessado em todas as coisas místicas, então Menesto foi enviado para proteger o estranho portal de cristal que encontramos aqui. ...', '... Mas é claro, você o conheceu. ... Então é realmente um {portal}, e você veio através dele de outro plano de existência! Nunca acreditei nos contos da idade, na verdade não. Mas agora ... é maravilhoso, verdadeiramente maravilhoso. ...', 'Bem, se você tiver alguma questão quanto a este plano de existência, que chamamos de {Tibia}, basta me perguntar. Posso dar {directions}, sugestões, você o nomeia. <piscada para você>'})
keywordHandler:addKeyword({'hamish'}, StdModule.say, {npcHandler = npcHandler, text = 'Algum tipo de gênio equivocado, penso eu. Brilhante nas poções e runas, mas não conseguiu continuar com seu mestre ou com os outros alunos. Correu e criou seu próprio laboratório, vendendo para os viajantes ao longo da estrada. ...', 'Foi roubado e deixado para morrer por alguns saqueadores, quando Morris o encontrou. {Morris} remendou-o e disse que poderia usá-lo, então Hamish veio aqui. Se você precisa de uma Varinha, Runa ou Poção, Hamish é seu homem.'})
keywordHandler:addKeyword({'morris', 'mr morris'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, há muitas histórias sobre Morris. Gosta de insistir no "Mr.". Ninguém sabe seu primeiro nome, e diz que ele jogou com um demônio e perdeu seu primeiro nome para ele. ...', 'Diz-se que o demônio libertou Morris para que ele possa recuperá-lo no final de sua vida, entretanto, se divertindo assistindo a luta de Morris por dificuldades e aventuras. ...', 'De qualquer forma. De uma maneira ou de outra, Morris nos escolheu todos e nos reuniu aqui. Não tenho certeza de que enviar outros em missões é realmente tudo para ele, mas se você está procurando uma {quest}, pergunte a Morris por uma.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = 'Se você está procurando uma missão ou tarefa, você deve conversar com {Morris} no andar de cima. Ele é o líder dessa multidão de aventureiros e sempre pode precisar de uma mãozinha ajudando em um de seus esquemas.'})
keywordHandler:addKeyword({'ser tybald'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu não tenho certeza de que esse seja o verdadeiro nome dele, mas acho que ele tem boas razões para se manter incógnito aqui. Em qualquer caso, ele é um lutador formidável e conhece {spells} úteis para {knights} e {paladins}.'})
keywordHandler:addKeyword({'garamond'}, StdModule.say, {npcHandler = npcHandler, text = 'Formado como professor na academia de magia em Edron, eu acredito. Gosta de ver lugares diferentes, então ele se juntou ao nosso pequeno grupo ilustre. Vende feitiços para Sorcerer\'s e Druida\'s para nossos formandos.'})
keywordHandler:addKeyword({'gold'}, StdModule.say, {npcHandler = npcHandler, text = 'O ouro é importante, pois você precisará reabastecer os suprimentos. Você pode ganhar uma quantidade razoável de ouro lutando contra {monstros} e pegando as coisas que eles carregam. Em {Dawnport}, estou comprando algumas dessas pilhagens, basta me pedir um {trade} veja por si mesmo.', 'Coltrayne não diz muito sobre si mesmo. O que recebi dos 15 anos que o conheci é que ele foi criado por um ferreiro como um fundador. ...', 'Quando um incêndio destruiu a sua casa de família adotiva, ele tomou uma vida instável, sempre vagando. Então ele conheceu {Morris} e decidiu se aventurar com ele.'})
keywordHandler:addKeyword({'oressa'}, StdModule.say, {npcHandler = npcHandler, text = 'Nossa curandeira local. Não sei por que essa menina druida decidiu que queria a vida instável de um aventureiro, mas ela é bastante robusta, para dizer a verdade. Uma vez eu vi ela confrontar um urso polar ... mas estou me deixando levar. ...', 'Se você precisar de cura, vá vê-la. Oressa também pode ajudá-lo a decidir se deseja escolher sua {vocation} para sair para {Mainland}.'})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = 'Druidas são magos da natureza. Sua especialidade é lançar magia de gelo e terra, além de proporcionar cura para os outros.'})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = 'Os Knights são combatentes de combate corpo-a-corpo, a vocação mais dura de todas. Geralmente usam armas de combate corpo a corpo, como espadas, machados ou clubes.'})
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = 'Os Paladinos são lutadores a distância bem treinados e podem lançar magia sagrada. Você geralmente os verá usando arcos ou bestas.'})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = 'Os Sorcerers são magos elementares. Dominaram o fogo, a energia e a magia da morte.'})

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
npcHandler:setMessage(MESSAGE_FAREWELL, "Boa caçada!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Tome cuidado!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())