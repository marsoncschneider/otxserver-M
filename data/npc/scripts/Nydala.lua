local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'furniture'}, StdModule.say, {npcHandler = npcHandler, text = "Bem, como voc� pode ver, eu vendo m�veis. Pe�a-me um {trade} se voc� estiver interessado em ver meus produtos."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome � Nydala. Eu administra esta loja."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "Agora � |TIME|. Voc� precisa de um rel�gio para a sua casa?"})

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo � Carlin Furniture Store, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "D� uma olhada. A maioria dos m�veis vem em kits acess�veis. Basta us�-los em sua casa para montar o mobili�rio. Voc� quer ver apenas um certo tipo {type} de mobili�rio?")
npcHandler:addModule(FocusModule:new())
