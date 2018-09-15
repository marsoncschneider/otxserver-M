local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou apenas um humilde druida como tantos outros aqui. Talvez eu não seja o mais talentoso dos curandeiros, mas eu sou talentoso com uma aliança especial aos elementos."})
keywordHandler:addKeyword({'nature'}, StdModule.say, {npcHandler = npcHandler, text = "Para mim, a natureza é a harmonia dos elementos. Essa harmonia pode ser perturbada por certos eventos, mas a natureza sempre encontra seu caminho de volta à harmonia no final."})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, "elements") then
		npcHandler:say({
			'Como posso explicar minha conexão com os elementos para que você possa entendê-lo? Hmmm, é como uma melodia fraca, uma música, que está sempre lá. ...',
			'Ouvi essa melodia mudando no tempo com as mudanças nos elementos. Com tantos anos de escuta, aprendi a interpretar essas mudanças e, portanto, a uma compreensão mais profunda dos elementos. ...',
			'Foi um passo natural para eu me tornar responsável pela pesquisa de lendas elementais. Procuro aprender o máximo que posso e compartilho com meus colegas druidas. ...',
			'Infelizmente, muito do meu entendimento é instintivo, e nossa linguagem simplesmente não contém as palavras certas para eu expressar as coisas que eu sinto adequadamente.'
		}, cid)
	elseif msgcontains(msg, "song") then
		npcHandler:say({
			'É difícil de explicar. Claro, não é uma música real como você entenderia isso. Eu não entendo isso com meus ouvidos, mas sim eu sinto isso no fundo de mim. ...',
			'Ligar uma música ou melodia é o melhor que posso fazer para descrevê-la para aqueles que não compartilham esse tipo de percepção. ...',
			'Isso também me ajuda a expressar e entender algo para o qual nosso idioma não possui uma expressão apropriada. ...',
			'Você sabe, somos tão dependentes de palavras que não podemos pensar nos conceitos quando não temos palavras para eles. ...',
			'Às vezes penso que as palavras se tornaram um obstáculo tão grande quanto uma ajuda. ...',
			'Talvez fôssemos melhor se apenas estivéssemos esquecidas e tratássemos puramente de sentimentos. Então, talvez todos nós possamos ouvir a maravilhosa melodia da natureza.'
		}, cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Saudações meu amigo!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Que Crunor abençoe e guie você, |PLAYERNAME|.")
npcHandler:addModule(FocusModule:new())
