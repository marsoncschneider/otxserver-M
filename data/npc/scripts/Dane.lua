local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou o dono deste lugar de relaxamento."})
keywordHandler:addKeyword({'wave cellar'}, StdModule.say, {npcHandler = npcHandler, text = "É bonito, não é?"})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou dane."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "É exatamente |TIME|."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = "Eu posso te oferecer Leite, água e Limonada."})
keywordHandler:addKeyword({'alcohol'}, StdModule.say, {npcHandler = npcHandler, text = "O álcool torna as pessoas muito agressivas. Não precisamos de tal coisa em Carlin."})
keywordHandler:addKeyword({'beer'}, StdModule.say, {npcHandler = npcHandler, text = "O álcool torna as pessoas muito agressivas. Não precisamos de tal coisa em Carlin."})
keywordHandler:addKeyword({'wine'}, StdModule.say, {npcHandler = npcHandler, text = "O álcool torna as pessoas muito agressivas. Não precisamos de tal coisa em Carlin."})

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo à Adega das Ondas {wave cellar}, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Volte de vez em quando.")
npcHandler:addModule(FocusModule:new())
