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
	if msgcontains(msg, "interesting") then
		npcHandler:say({
			"Eu realmente gostaria de reconstruir minha reputação um dia e talvez encontrar uma gatinha. Caso você encontre alguns pergaminhos scrolls of heroic deeds ou addresses of lovely maidens não deixe de me avisar!",
			"Oh não, isso não importa. O nome que estiver no pergaminho não faz diferença, eu sou bem flexível! E dinheiro, eu posso pagar. Meu erm ... tio morreu faz pouco tempo e me deixou uma bela herança."
		}, cid)
	end
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "E eu... sou um viajante. Apenas me deixe sozinho se você não tem nada de interessante {interesting} para falar."})
keywordHandler:addKeyword({'want'}, StdModule.say, {npcHandler = npcHandler, text = "E eu... sou um viajante. Apenas me deixe sozinho se você não tem nada de interessante {interesting} para falar."})
keywordHandler:addKeyword({'head'}, StdModule.say, {npcHandler = npcHandler, text = "Uhhh ohhhh uma das cervejas do outro dia não caiu bem."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome? E eu To... ahm... hum... Meu nome é {Hugo}."})
keywordHandler:addKeyword({'hugo'}, StdModule.say, {npcHandler = npcHandler, text = "Sim, esse é meu nome, concerteza."})
keywordHandler:addKeyword({'todd'}, StdModule.say, {npcHandler = npcHandler, text = "Uh .. E... Eu conheco um Todd na estrada. Ele me disse que estava viajando para Venore, olha aqui seu Todd."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, text = "Eu amo essa cidade."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = "Eu nunca estive aqui. Agora me deixe sozinho."})
keywordHandler:addKeyword({'resistance'}, StdModule.say, {npcHandler = npcHandler, text = "Resistência é inútil! Ah... nem sei de onde tirei essa frase. Mhmm... minha cabeça..."})
keywordHandler:addKeyword({'money'}, StdModule.say, {npcHandler = npcHandler, text = "Não sei nada sobre nenhum dinheiro, que esteja faltando ou não."})
keywordHandler:addKeyword({'eclesius'}, StdModule.say, {npcHandler = npcHandler, text = "Ele difícilmente vem aqui. Mas sua constante confusão me da uma dor de cabeça ainda maior do que a cerveja do Frodo. Eu prefiro evita-lo."})
keywordHandler:addKeyword({'karl'}, StdModule.say, {npcHandler = npcHandler, text = "Uhm, nunca escutei sobre ele... e você não pode provar o contrário."})
keywordHandler:addKeyword({'william'}, StdModule.say, {npcHandler = npcHandler, text = "Esse é um nome bem comum, talvez eu tenha conhecido um William, não tenho certeza disso."})

npcHandler:setMessage(MESSAGE_GREET, "Uhm olá |PLAYERNAME|... não fale tão alto, nem faça barulhos por favor... minha cabeça {head}... O que ... você quer {want}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Sim, adeus |PLAYERNAME|, apenas me deixe sozinho.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Pelo menos agora terei silêncio.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
