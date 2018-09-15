local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Eu gosto da paz e da solid�o daqui. Voc� � bem-vindo para ser meu convidado enquanto voc� se comportar de uma maneira tranquila e toler�vel.'} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'here'}, StdModule.say, {npcHandler = npcHandler, text = "Alguns me chamam de whisperer {animal}. Outros dizem que estou apenas louco. Refiro-me a mim mesmo como um detentor simples {stable}."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Alguns me chamam de whisperer {animal}. Outros dizem que estou apenas louco. Refiro-me a mim mesmo como um detentor simples {stable}."})
keywordHandler:addKeyword({'animal'}, StdModule.say, {npcHandler = npcHandler, text = "Eu amo todos os animais, pequenos ou grandes. Eu tamb�m acredito que cada um, mesmo o ser mais selvagem e feroz, pode ser falado, compreendido e {tamed}."})
keywordHandler:addKeyword({'stable'}, StdModule.say, {npcHandler = npcHandler, text = "� meu sonho abrigar muitos animais domesticados diferentes. Talvez um dia esse sonho se torne realidade."})
keywordHandler:addKeyword({'tamed'}, StdModule.say, {npcHandler = npcHandler, text = "Bem, geralmente voc� pode domesticar os animais com a ajuda de alguns itens simples. Se voc� encontrou um {item}, mostre-o e eu poderia ajud�-lo com instru��es sobre o processo de domestica��o."})
keywordHandler:addKeyword({'item'}, StdModule.say, {npcHandler = npcHandler, text = "Bem? Qual item voc� encontrou e exige conselhos para?"})
keywordHandler:addKeyword({'bag of apple slices'}, StdModule.say, {npcHandler = npcHandler, text = "Esse � um dos alimentos favoritos dos burros, tanto quanto eu sei. � uma pena que eu realmente n�o tenha visto nenhum burro. Poderia exigir um truque m�gico para realmente conhecer um."})
keywordHandler:addKeyword({'bamboo leaves'}, StdModule.say, {npcHandler = npcHandler, text = "As pandas adoram comer folhas de bambu, mas os pandas Tiquandan na verdade n�o s�o t�o habilidosos na escalada, ent�o eles t�m dificuldade em conseguir alguns para si. Voc� pode domar um com eles."})
keywordHandler:addKeyword({'carrot on a stick'}, StdModule.say, {npcHandler = npcHandler, text = "Ouvi dizer que os p�ssaros do terror realmente adoram as cenouras. Eu tentaria agitar isso na frente de um desses."})
keywordHandler:addKeyword({'decorative ribbon'}, StdModule.say, {npcHandler = npcHandler, text = "Ah, que fita bonita. Lembra-me dos indescrit�veis - s�o bastante elegantes e v�o. Eles provavelmente receberiam um elemento decorativo. Algumas vezes s�o vistos durante as erup��es do vulc�o."})
keywordHandler:addKeyword({'diapason'}, StdModule.say, {npcHandler = npcHandler, text = "Que min�sculo manequim elvish. Voc� sabia que um diapason funciona com vibra��es para criar som? Na verdade, acho que isso poderia funcionar com uma criatura feita de cristais."})
keywordHandler:addKeyword({'fist on a stick'}, StdModule.say, {npcHandler = npcHandler, text = "Estou contra a viol�ncia contra qualquer criatura. Ouvi dizer que os b�rbaros no deserto o usam para dromed�rios desobedientes."})
keywordHandler:addKeyword({'four-leaf clover'}, StdModule.say, {npcHandler = npcHandler, text = "Oh, que plantazinha agrad�vel! Voc� sabia que deveria trazer sorte? Ent�o, � o erro da senhora. Ambos podem realmente ir bem juntos."})
keywordHandler:addKeyword({'foxtail'}, StdModule.say, {npcHandler = npcHandler, text = "Eu ouvi dizer que havia uma vez uma gangue de cavaleiros de manta ray que gostaram de adornar suas mantas com um foxtail. N�o me pergunte por que, talvez eles gostem de como ele flutua no vento quando corre muito r�pido?"})
keywordHandler:addKeyword({'golem wrench'}, StdModule.say, {npcHandler = npcHandler, text = "Que dispositivo estranho! Isso parece uma ferramenta para algu�m que cria golems e modifica criaturas vivas. Voc� provavelmente poderia domesticar uma criatura modificada com isso, mas eu duvido que eles vivam na natureza."})
keywordHandler:addKeyword({'giant shrimp'}, StdModule.say, {npcHandler = npcHandler, text = "Ah, esse � um dos alimentos favoritos de um crustacea gigantica. Eu acho que voc� pode apenas distra�-lo com a comida e rapidamente pular nas costas."})
keywordHandler:addKeyword({'glow wine'}, StdModule.say, {npcHandler = npcHandler, text = "Voc� j� encontrou um rastreador de magma? Eles s� comem e bebem coisas muito gostosas. Voc� provavelmente poderia tentar fazer uma bebida com um pouco de vinho brilhante - e mont�-la rapidamente enquanto estiver b�bada."})
keywordHandler:addKeyword({'golden can of oil'}, StdModule.say, {npcHandler = npcHandler, text = "Hm. Que interessante achado. Isso definitivamente n�o � usado para qualquer tipo de animal. Talvez um ve�culo? Eu posso imaginar que poderia ser usado para uma bicicleta de algum tipo."})
keywordHandler:addKeyword({'harness'}, StdModule.say, {npcHandler = npcHandler, text = "Parece que pode ser um draptor. Se voc� puder se aproximar o suficiente para um para peg�-lo, simplesmente tentaria coloc�-lo enquanto sussurrava palavras calmantes."})
keywordHandler:addKeyword({'hunting horn'}, StdModule.say, {npcHandler = npcHandler, text = "O som de um chifre de ca�a � muitas vezes intimidante para as criaturas da floresta, mas eu ouvi que os javalis realmente gostam disso."})
keywordHandler:addKeyword({'iron loadstone'}, StdModule.say, {npcHandler = npcHandler, text = "Ironblights consistem principalmente em pedra e ferro. Com um forte �m�, voc� basicamente pode for��-lo a caminhar na dire��o em que voc� est� querendo."})
keywordHandler:addKeyword({'leather whip'}, StdModule.say, {npcHandler = npcHandler, text = "Tente pegar uma pantera da meia-noite usando essa. N�o toque na pantera, tenha em mente voc�. Apenas deixe o chicote quebrar no ar - eu acho que vai funcionar."})
keywordHandler:addKeyword({'leech'}, StdModule.say, {npcHandler = npcHandler, text = "Tanto quanto eu sei, sanguessugas podem ser encontradas em �reas terrestres e pantanosas. As sanguessugas geralmente ajudam grandes animais, como b�falos de �gua, a eliminar os parasitas."})
keywordHandler:addKeyword({'maxilla maximus'}, StdModule.say, {npcHandler = npcHandler, text = "Voc� deve mostrar esse maxilar gigante para uma criatura que se parece com a pessoa que voc� obteve. Ele ir� respeitar voc� quando v� os dentes assustadores."})
keywordHandler:addKeyword({'music box'}, StdModule.say, {npcHandler = npcHandler, text = "Onde voc� conseguiu isso? O que � um deleite raro. Isso deve ter sido elaborado por algu�m que realmente ama m�sica e animais. N�o posso dizer nada sobre isso."})
keywordHandler:addKeyword({'nail case'}, StdModule.say, {npcHandler = npcHandler, text = "Oh, um caso de unha ..., eu odeio esconder as unhas. Mas eu ouvi gravediggers confiar quando eles recebem o tratamento certo."})
keywordHandler:addKeyword({'nightmare horn'}, StdModule.say, {npcHandler = npcHandler, text = "Qu�o impressionante, um chifre de pesadelo. Voc� j� encontrou uma cabe�a de choque? Tente hipnotiz�-los com o seu chifre."})
keywordHandler:addKeyword({'reins'}, StdModule.say, {npcHandler = npcHandler, text = "Voc� provavelmente poderia montar uma ovelha negra com estes. Fale com ele suavemente e cuidadosamente coloque as r�deas."})
keywordHandler:addKeyword({'scorpion sceptre'}, StdModule.say, {npcHandler = npcHandler, text = "Uau, isso � uma raridade. Voc� j� conheceu um desses escorpi�es de arenito? Eles s�o bastante impressionantes. Voc� precisa de um tal cetro para mostrar a um que voc� � seu novo mestre."})
keywordHandler:addKeyword({'slingshot'}, StdModule.say, {npcHandler = npcHandler, text = "Essa pode ser a �nica maneira de domar um urso. Tem um ponto sens�vel bem entre as orelhas que o acalmar�, mas voc� n�o � forte o suficiente para uma acupress�o simples. Usar o estilingue � suscept�vel de ajud�-lo com isso."})
keywordHandler:addKeyword({'slug drug'}, StdModule.say, {npcHandler = npcHandler, text = "Como o nome indica - isso pode ser usado para fazer uma lesma muito mais r�pido do que normalmente �! Uma vez que voc� tenha domesticado, ele ir� corr�-lo onde quer que voc� v�."})
keywordHandler:addKeyword({'sugar oat'}, StdModule.say, {npcHandler = npcHandler, text = "Crie a aveia de a��car simplesmente misturando um monte de cana com um monte de trigo. Todos os cavalos adoram aveia com a��car! �s vezes, quando os cavalos da esta��o do cavalo em Thais est�o soltos, os cavalos selvagens se misturam com o rebanho. Talvez eles possam ser domesticados?"})
keywordHandler:addKeyword({'sweet smelling bait'}, StdModule.say, {npcHandler = npcHandler, text = "A parte interessante sobre essa isca n�o � a coisa doce - s�o as moscas atra�das pelo cheiro doce. As aranhas adoram comer moscas, especialmente as zaoanas."})
keywordHandler:addKeyword({'tin key'}, StdModule.say, {npcHandler = npcHandler, text = "Hm! Agora, isso � interessante. De onde voc� conseguiu isso? Eu poderia imaginar que isso soasse em uma f�brica, mas definitivamente n�o � um animal normal."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Est� na porta."})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	if msgcontains(msg, "control unit") then
		npcHandler:say({
			'Isso � interessante, nada como eu j� me vi. O que voc� descreve � um dispositivo do qual eu ouvi dizer que ele concede literalmente o controle completo sobre algum tipo de ... coisa artificial? ...',
			'Bem, se voc� virar um pouco de sorte e encontrar tal coisa - use-o em um suporte adequado, provavelmente ser� mec�nico, conduzido por ... algo.'
		}, cid)
	elseif msgcontains(msg, "golden fir cone") then
		npcHandler:say({
			'Voc� sabia que voc� tamb�m pode criar isso sozinho? Troque um lingote de ouro com os ciclopes suados em Ab\'Dendriel para uma x�cara de ouro fundido. Se voc� usa isso em uma �rvore de abeto, voc� tem uma pequena chance de obter um cone dourado de abeto. ...',
			'Esses s�o necess�rios para impressionar os cervos brancos que vagam por Ab\'Dendriel �s vezes, mas espero at� que voc� possa enriquecer um para se certificar de que ele tem a for�a necess�ria para lev�-lo.'
		}, cid)
	elseif msgcontains(msg, "melting horn") then
		npcHandler:say({
			'Dizem que criaturas ferozes j� prosperaram em ilhas exuberantes no extremo norte do mar. Eles morreram ontem atr�s, quando chegaram tempos de grande frio e formaram os res�duos gelados de Svargrond como os conhecemos hoje. ...',
			'Viajantes do norte contaram hist�rias dessas criaturas, observando-as dentro do gelo nas cavernas mais profundas, ainda vigilantes como se congeladas no tempo. Ursagrodon\' eles os chamaram. ...',
			'Com tinder e um tipo de m�quina de prova de prova, voc� pode criar um dispositivo para derreter o gelo ao redor de seus restos e ver por si mesmo o que � isso.'
		}, cid)
	elseif isInArray({"arkarra", "stampor"}, msg) then
		npcHandler:say({
			'O stampor nas costas? Ela � minha amiga, mas ela veio at� mim por sua pr�pria vontade. Devo admitir que nunca consegui domar qualquer outro stampor....',
			'Ouvi dizer que existe algum tipo de magia voodoo que permita que voc� invoque um stampor, mas n�o sou um especialista voodoo, ent�o eu n�o saberia.'
		}, cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo � minha cabana humilde,|PLAYERNAME|. O que te traz aqui {here}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Cuide-se.")
npcHandler:addModule(FocusModule:new())
