local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'furniture'}, StdModule.say, {npcHandler = npcHandler, text = "Bem, como você pode ver, eu vendo móveis. Peça-me um {trade} se você estiver interessado em ver meus produtos."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome é Nydala. Eu administra esta loja."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "Agora é |TIME|. Você precisa de um relógio para a sua casa?"})

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo à Carlin Furniture Store, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Dê uma olhada. A maioria dos móveis vem em kits acessíveis. Basta usá-los em sua casa para montar o mobiliário. Você quer ver apenas um certo tipo {type} de mobiliário?")
npcHandler:addModule(FocusModule:new())
