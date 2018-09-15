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
			"Eu realmente gostaria de reconstruir minha reputa��o um dia e talvez encontrar uma gatinha. Caso voc� encontre alguns pergaminhos scrolls of heroic deeds ou addresses of lovely maidens n�o deixe de me avisar!",
			"Oh n�o, isso n�o importa. O nome que estiver no pergaminho n�o faz diferen�a, eu sou bem flex�vel! E dinheiro, eu posso pagar. Meu erm ... tio morreu faz pouco tempo e me deixou uma bela heran�a."
		}, cid)
	end
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "E eu... sou um viajante. Apenas me deixe sozinho se voc� n�o tem nada de interessante {interesting} para falar."})
keywordHandler:addKeyword({'want'}, StdModule.say, {npcHandler = npcHandler, text = "E eu... sou um viajante. Apenas me deixe sozinho se voc� n�o tem nada de interessante {interesting} para falar."})
keywordHandler:addKeyword({'head'}, StdModule.say, {npcHandler = npcHandler, text = "Uhhh ohhhh uma das cervejas do outro dia n�o caiu bem."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome? E eu To... ahm... hum... Meu nome � {Hugo}."})
keywordHandler:addKeyword({'hugo'}, StdModule.say, {npcHandler = npcHandler, text = "Sim, esse � meu nome, concerteza."})
keywordHandler:addKeyword({'todd'}, StdModule.say, {npcHandler = npcHandler, text = "Uh .. E... Eu conheco um Todd na estrada. Ele me disse que estava viajando para Venore, olha aqui seu Todd."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, text = "Eu amo essa cidade."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = "Eu nunca estive aqui. Agora me deixe sozinho."})
keywordHandler:addKeyword({'resistance'}, StdModule.say, {npcHandler = npcHandler, text = "Resist�ncia � in�til! Ah... nem sei de onde tirei essa frase. Mhmm... minha cabe�a..."})
keywordHandler:addKeyword({'money'}, StdModule.say, {npcHandler = npcHandler, text = "N�o sei nada sobre nenhum dinheiro, que esteja faltando ou n�o."})
keywordHandler:addKeyword({'eclesius'}, StdModule.say, {npcHandler = npcHandler, text = "Ele dif�cilmente vem aqui. Mas sua constante confus�o me da uma dor de cabe�a ainda maior do que a cerveja do Frodo. Eu prefiro evita-lo."})
keywordHandler:addKeyword({'karl'}, StdModule.say, {npcHandler = npcHandler, text = "Uhm, nunca escutei sobre ele... e voc� n�o pode provar o contr�rio."})
keywordHandler:addKeyword({'william'}, StdModule.say, {npcHandler = npcHandler, text = "Esse � um nome bem comum, talvez eu tenha conhecido um William, n�o tenho certeza disso."})

npcHandler:setMessage(MESSAGE_GREET, "Uhm ol� |PLAYERNAME|... n�o fale t�o alto, nem fa�a barulhos por favor... minha cabe�a {head}... O que ... voc� quer {want}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Sim, adeus |PLAYERNAME|, apenas me deixe sozinho.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Pelo menos agora terei sil�ncio.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
