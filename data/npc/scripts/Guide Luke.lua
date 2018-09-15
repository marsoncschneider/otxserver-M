local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'Escolta grátis até o depot para novatos!' },
	{ text = 'Olá, essa é a sua primeira visita a Thais? Eu posso te mostrar as redondezas.' },
	{ text = 'Precisa de ajuda para encontrar seu caminho através de Thais? Eu posso ajudar.' },
	{ text = 'Fale comigo se você precisar de alguma orientação.' }
}

npcHandler:addModule(VoiceModule:new(voices))

local configMarks = {
	{mark = "shops", position = Position(32367, 32197, 7), markId = MAPMARK_BAG, description = "Shops"},
	{mark = "depot", position = Position(32321, 32212, 7), markId = MAPMARK_LOCK, description = "Depot"},
	{mark = "temple", position = Position(32369, 32241, 7), markId = MAPMARK_TEMPLE, description = "Temple"}
}

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if isInArray({"map", "marks"}, msg) then
		npcHandler:say("Você gostaria que eu marcasse os locais em seu mapa? Por exemplo, o depósito, o banco e algumas lojas?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 1 then
		npcHandler:say("Prontinho, aqui está.", cid)
		local mark
		for i = 1, #configMarks do
			mark = configMarks[i]
			player:addMapMark(mark.position, mark.markId, mark.description)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "no") and npcHandler.topic[cid] >= 1 then
		npcHandler:say("Bom, não há nada de errado em preferir explorar a cidade por si só. Deixe-me ajudar caso precise de alguma coisa!", cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'information'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu posso dizer a você tudo sobre a cidade {town}, seu templo {temple}, o {bank}, suas lojas {shops}, treinadores de magias {spell trainers} e o depósito {depot}, além do estado do mundo {world status}.'})
keywordHandler:addKeyword({'temple'}, StdModule.say, {npcHandler = npcHandler, text = 'O templo fica no centro de Thais. Ande até o leste do porto e passe pelo depósito {depot} até chegar à infame encruzilhada, depois vá seguindo pelo sul.'})
keywordHandler:addKeyword({'bank'}, StdModule.say, {npcHandler = npcHandler, text = 'Nós temos dois bancários, Suzy e Naji. Naji está no próprio depósito. Já Suzi, para encontrá-la você precisa sair do depósito {depot} pelo sul, seguir pelo oeste e depois pelo sudoeste. Não se esqueça de que posso marcar {mark} locais importantes em seu mapa.'})
keywordHandler:addKeyword({'shops'}, StdModule.say, {npcHandler = npcHandler, text = 'Você pode comprar armas {weapons}, armaduras {armor}, ferramentas {tools}, gemas {gems}, equipamento mágico {magical}, mobília {furniture} e comida {food} aqui.'})
keywordHandler:addKeyword({'depot'}, StdModule.say, {npcHandler = npcHandler, text = 'O depósito é o lugar onde você pode guardar seus pertences com mais segurança. Além disso, lá você está protegido contra ataques. Eu escolto {escort} novatos aqui.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu sou um guia, trabalho muito por pouco dinheiro. Eu posso marcar locais importantes em seu mapa e dar algumas informações sobre a cidade, além do estado do mundo.'})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, text = 'Thais é uma das mais velhas colonizações no Tibia. Você vai escutar suas histórias como sussurros quando estiver andando pelas ruas. Tenha cuidado com os criminosos, mas fora isso, é uma boa cidade..'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu sou Luke, sem brincadeiras, por favor, eu sempre escuto todas elas <triste>'})

npcHandler:setMessage(MESSAGE_GREET, "Olá, |PLAYERNAME|, seja bem-vindo a Thais! Você gostaria de alguma informação {information} e um mapa {map}?")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus! Aproveite sua estadia em Thais, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
