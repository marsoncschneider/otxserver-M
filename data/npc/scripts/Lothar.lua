local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Eu gosto da paz e da solidão daqui. Você é bem-vindo para ser meu convidado enquanto você se comportar de uma maneira tranquila e tolerável.'} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'here'}, StdModule.say, {npcHandler = npcHandler, text = "Alguns me chamam de whisperer {animal}. Outros dizem que estou apenas louco. Refiro-me a mim mesmo como um detentor simples {stable}."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Alguns me chamam de whisperer {animal}. Outros dizem que estou apenas louco. Refiro-me a mim mesmo como um detentor simples {stable}."})
keywordHandler:addKeyword({'animal'}, StdModule.say, {npcHandler = npcHandler, text = "Eu amo todos os animais, pequenos ou grandes. Eu também acredito que cada um, mesmo o ser mais selvagem e feroz, pode ser falado, compreendido e {tamed}."})
keywordHandler:addKeyword({'stable'}, StdModule.say, {npcHandler = npcHandler, text = "É meu sonho abrigar muitos animais domesticados diferentes. Talvez um dia esse sonho se torne realidade."})
keywordHandler:addKeyword({'tamed'}, StdModule.say, {npcHandler = npcHandler, text = "Bem, geralmente você pode domesticar os animais com a ajuda de alguns itens simples. Se você encontrou um {item}, mostre-o e eu poderia ajudá-lo com instruções sobre o processo de domesticação."})
keywordHandler:addKeyword({'item'}, StdModule.say, {npcHandler = npcHandler, text = "Bem? Qual item você encontrou e exige conselhos para?"})
keywordHandler:addKeyword({'bag of apple slices'}, StdModule.say, {npcHandler = npcHandler, text = "Esse é um dos alimentos favoritos dos burros, tanto quanto eu sei. É uma pena que eu realmente não tenha visto nenhum burro. Poderia exigir um truque mágico para realmente conhecer um."})
keywordHandler:addKeyword({'bamboo leaves'}, StdModule.say, {npcHandler = npcHandler, text = "As pandas adoram comer folhas de bambu, mas os pandas Tiquandan na verdade não são tão habilidosos na escalada, então eles têm dificuldade em conseguir alguns para si. Você pode domar um com eles."})
keywordHandler:addKeyword({'carrot on a stick'}, StdModule.say, {npcHandler = npcHandler, text = "Ouvi dizer que os pássaros do terror realmente adoram as cenouras. Eu tentaria agitar isso na frente de um desses."})
keywordHandler:addKeyword({'decorative ribbon'}, StdModule.say, {npcHandler = npcHandler, text = "Ah, que fita bonita. Lembra-me dos indescritíveis - são bastante elegantes e vão. Eles provavelmente receberiam um elemento decorativo. Algumas vezes são vistos durante as erupções do vulcão."})
keywordHandler:addKeyword({'diapason'}, StdModule.say, {npcHandler = npcHandler, text = "Que minúsculo manequim elvish. Você sabia que um diapason funciona com vibrações para criar som? Na verdade, acho que isso poderia funcionar com uma criatura feita de cristais."})
keywordHandler:addKeyword({'fist on a stick'}, StdModule.say, {npcHandler = npcHandler, text = "Estou contra a violência contra qualquer criatura. Ouvi dizer que os bárbaros no deserto o usam para dromedários desobedientes."})
keywordHandler:addKeyword({'four-leaf clover'}, StdModule.say, {npcHandler = npcHandler, text = "Oh, que plantazinha agradável! Você sabia que deveria trazer sorte? Então, é o erro da senhora. Ambos podem realmente ir bem juntos."})
keywordHandler:addKeyword({'foxtail'}, StdModule.say, {npcHandler = npcHandler, text = "Eu ouvi dizer que havia uma vez uma gangue de cavaleiros de manta ray que gostaram de adornar suas mantas com um foxtail. Não me pergunte por que, talvez eles gostem de como ele flutua no vento quando corre muito rápido?"})
keywordHandler:addKeyword({'golem wrench'}, StdModule.say, {npcHandler = npcHandler, text = "Que dispositivo estranho! Isso parece uma ferramenta para alguém que cria golems e modifica criaturas vivas. Você provavelmente poderia domesticar uma criatura modificada com isso, mas eu duvido que eles vivam na natureza."})
keywordHandler:addKeyword({'giant shrimp'}, StdModule.say, {npcHandler = npcHandler, text = "Ah, esse é um dos alimentos favoritos de um crustacea gigantica. Eu acho que você pode apenas distraí-lo com a comida e rapidamente pular nas costas."})
keywordHandler:addKeyword({'glow wine'}, StdModule.say, {npcHandler = npcHandler, text = "Você já encontrou um rastreador de magma? Eles só comem e bebem coisas muito gostosas. Você provavelmente poderia tentar fazer uma bebida com um pouco de vinho brilhante - e montá-la rapidamente enquanto estiver bêbada."})
keywordHandler:addKeyword({'golden can of oil'}, StdModule.say, {npcHandler = npcHandler, text = "Hm. Que interessante achado. Isso definitivamente não é usado para qualquer tipo de animal. Talvez um veículo? Eu posso imaginar que poderia ser usado para uma bicicleta de algum tipo."})
keywordHandler:addKeyword({'harness'}, StdModule.say, {npcHandler = npcHandler, text = "Parece que pode ser um draptor. Se você puder se aproximar o suficiente para um para pegá-lo, simplesmente tentaria colocá-lo enquanto sussurrava palavras calmantes."})
keywordHandler:addKeyword({'hunting horn'}, StdModule.say, {npcHandler = npcHandler, text = "O som de um chifre de caça é muitas vezes intimidante para as criaturas da floresta, mas eu ouvi que os javalis realmente gostam disso."})
keywordHandler:addKeyword({'iron loadstone'}, StdModule.say, {npcHandler = npcHandler, text = "Ironblights consistem principalmente em pedra e ferro. Com um forte ímã, você basicamente pode forçá-lo a caminhar na direção em que você está querendo."})
keywordHandler:addKeyword({'leather whip'}, StdModule.say, {npcHandler = npcHandler, text = "Tente pegar uma pantera da meia-noite usando essa. Não toque na pantera, tenha em mente você. Apenas deixe o chicote quebrar no ar - eu acho que vai funcionar."})
keywordHandler:addKeyword({'leech'}, StdModule.say, {npcHandler = npcHandler, text = "Tanto quanto eu sei, sanguessugas podem ser encontradas em áreas terrestres e pantanosas. As sanguessugas geralmente ajudam grandes animais, como búfalos de água, a eliminar os parasitas."})
keywordHandler:addKeyword({'maxilla maximus'}, StdModule.say, {npcHandler = npcHandler, text = "Você deve mostrar esse maxilar gigante para uma criatura que se parece com a pessoa que você obteve. Ele irá respeitar você quando vê os dentes assustadores."})
keywordHandler:addKeyword({'music box'}, StdModule.say, {npcHandler = npcHandler, text = "Onde você conseguiu isso? O que é um deleite raro. Isso deve ter sido elaborado por alguém que realmente ama música e animais. Não posso dizer nada sobre isso."})
keywordHandler:addKeyword({'nail case'}, StdModule.say, {npcHandler = npcHandler, text = "Oh, um caso de unha ..., eu odeio esconder as unhas. Mas eu ouvi gravediggers confiar quando eles recebem o tratamento certo."})
keywordHandler:addKeyword({'nightmare horn'}, StdModule.say, {npcHandler = npcHandler, text = "Quão impressionante, um chifre de pesadelo. Você já encontrou uma cabeça de choque? Tente hipnotizá-los com o seu chifre."})
keywordHandler:addKeyword({'reins'}, StdModule.say, {npcHandler = npcHandler, text = "Você provavelmente poderia montar uma ovelha negra com estes. Fale com ele suavemente e cuidadosamente coloque as rédeas."})
keywordHandler:addKeyword({'scorpion sceptre'}, StdModule.say, {npcHandler = npcHandler, text = "Uau, isso é uma raridade. Você já conheceu um desses escorpiões de arenito? Eles são bastante impressionantes. Você precisa de um tal cetro para mostrar a um que você é seu novo mestre."})
keywordHandler:addKeyword({'slingshot'}, StdModule.say, {npcHandler = npcHandler, text = "Essa pode ser a única maneira de domar um urso. Tem um ponto sensível bem entre as orelhas que o acalmará, mas você não é forte o suficiente para uma acupressão simples. Usar o estilingue é susceptível de ajudá-lo com isso."})
keywordHandler:addKeyword({'slug drug'}, StdModule.say, {npcHandler = npcHandler, text = "Como o nome indica - isso pode ser usado para fazer uma lesma muito mais rápido do que normalmente é! Uma vez que você tenha domesticado, ele irá corrê-lo onde quer que você vá."})
keywordHandler:addKeyword({'sugar oat'}, StdModule.say, {npcHandler = npcHandler, text = "Crie a aveia de açúcar simplesmente misturando um monte de cana com um monte de trigo. Todos os cavalos adoram aveia com açúcar! Às vezes, quando os cavalos da estação do cavalo em Thais estão soltos, os cavalos selvagens se misturam com o rebanho. Talvez eles possam ser domesticados?"})
keywordHandler:addKeyword({'sweet smelling bait'}, StdModule.say, {npcHandler = npcHandler, text = "A parte interessante sobre essa isca não é a coisa doce - são as moscas atraídas pelo cheiro doce. As aranhas adoram comer moscas, especialmente as zaoanas."})
keywordHandler:addKeyword({'tin key'}, StdModule.say, {npcHandler = npcHandler, text = "Hm! Agora, isso é interessante. De onde você conseguiu isso? Eu poderia imaginar que isso soasse em uma fábrica, mas definitivamente não é um animal normal."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Está na porta."})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	if msgcontains(msg, "control unit") then
		npcHandler:say({
			'Isso é interessante, nada como eu já me vi. O que você descreve é um dispositivo do qual eu ouvi dizer que ele concede literalmente o controle completo sobre algum tipo de ... coisa artificial? ...',
			'Bem, se você virar um pouco de sorte e encontrar tal coisa - use-o em um suporte adequado, provavelmente será mecânico, conduzido por ... algo.'
		}, cid)
	elseif msgcontains(msg, "golden fir cone") then
		npcHandler:say({
			'Você sabia que você também pode criar isso sozinho? Troque um lingote de ouro com os ciclopes suados em Ab\'Dendriel para uma xícara de ouro fundido. Se você usa isso em uma árvore de abeto, você tem uma pequena chance de obter um cone dourado de abeto. ...',
			'Esses são necessários para impressionar os cervos brancos que vagam por Ab\'Dendriel às vezes, mas espero até que você possa enriquecer um para se certificar de que ele tem a força necessária para levá-lo.'
		}, cid)
	elseif msgcontains(msg, "melting horn") then
		npcHandler:say({
			'Dizem que criaturas ferozes já prosperaram em ilhas exuberantes no extremo norte do mar. Eles morreram ontem atrás, quando chegaram tempos de grande frio e formaram os resíduos gelados de Svargrond como os conhecemos hoje. ...',
			'Viajantes do norte contaram histórias dessas criaturas, observando-as dentro do gelo nas cavernas mais profundas, ainda vigilantes como se congeladas no tempo. Ursagrodon\' eles os chamaram. ...',
			'Com tinder e um tipo de máquina de prova de prova, você pode criar um dispositivo para derreter o gelo ao redor de seus restos e ver por si mesmo o que é isso.'
		}, cid)
	elseif isInArray({"arkarra", "stampor"}, msg) then
		npcHandler:say({
			'O stampor nas costas? Ela é minha amiga, mas ela veio até mim por sua própria vontade. Devo admitir que nunca consegui domar qualquer outro stampor....',
			'Ouvi dizer que existe algum tipo de magia voodoo que permita que você invoque um stampor, mas não sou um especialista voodoo, então eu não saberia.'
		}, cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo à minha cabana humilde,|PLAYERNAME|. O que te traz aqui {here}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Cuide-se.")
npcHandler:addModule(FocusModule:new())
