local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou apenas um humilde druida como tantos outros aqui. Talvez eu n�o seja o mais talentoso dos curandeiros, mas eu sou talentoso com uma alian�a especial aos elementos."})
keywordHandler:addKeyword({'nature'}, StdModule.say, {npcHandler = npcHandler, text = "Para mim, a natureza � a harmonia dos elementos. Essa harmonia pode ser perturbada por certos eventos, mas a natureza sempre encontra seu caminho de volta � harmonia no final."})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, "elements") then
		npcHandler:say({
			'Como posso explicar minha conex�o com os elementos para que voc� possa entend�-lo? Hmmm, � como uma melodia fraca, uma m�sica, que est� sempre l�. ...',
			'Ouvi essa melodia mudando no tempo com as mudan�as nos elementos. Com tantos anos de escuta, aprendi a interpretar essas mudan�as e, portanto, a uma compreens�o mais profunda dos elementos. ...',
			'Foi um passo natural para eu me tornar respons�vel pela pesquisa de lendas elementais. Procuro aprender o m�ximo que posso e compartilho com meus colegas druidas. ...',
			'Infelizmente, muito do meu entendimento � instintivo, e nossa linguagem simplesmente n�o cont�m as palavras certas para eu expressar as coisas que eu sinto adequadamente.'
		}, cid)
	elseif msgcontains(msg, "song") then
		npcHandler:say({
			'� dif�cil de explicar. Claro, n�o � uma m�sica real como voc� entenderia isso. Eu n�o entendo isso com meus ouvidos, mas sim eu sinto isso no fundo de mim. ...',
			'Ligar uma m�sica ou melodia � o melhor que posso fazer para descrev�-la para aqueles que n�o compartilham esse tipo de percep��o. ...',
			'Isso tamb�m me ajuda a expressar e entender algo para o qual nosso idioma n�o possui uma express�o apropriada. ...',
			'Voc� sabe, somos t�o dependentes de palavras que n�o podemos pensar nos conceitos quando n�o temos palavras para eles. ...',
			'�s vezes penso que as palavras se tornaram um obst�culo t�o grande quanto uma ajuda. ...',
			'Talvez f�ssemos melhor se apenas estiv�ssemos esquecidas e trat�ssemos puramente de sentimentos. Ent�o, talvez todos n�s possamos ouvir a maravilhosa melodia da natureza.'
		}, cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Sauda��es meu amigo!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Que Crunor aben�oe e guie voc�, |PLAYERNAME|.")
npcHandler:addModule(FocusModule:new())
