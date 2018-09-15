local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou o arquiteto de Carlin. Eu mantenho os segredos de nossa ordem."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome é Lea."})
--keywordHandler:addKeyword({'spell'}, StdModule.say, {npcHandler = npcHandler, text = "Sorry, I only sell spells to sorcerers."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "O tempo é uma força que os feiticeiros dominarão um dia."})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = "Qualquer feiticeiro dedica toda a sua vida ao estudo das artes arcanas."})
keywordHandler:addKeyword({'power'}, StdModule.say, {npcHandler = npcHandler, text = "Nós feiticeiros exercemos poderes arcanos além da compreensão dos homens."})
keywordHandler:addKeyword({'arcane'}, StdModule.say, {npcHandler = npcHandler, text = "Nós feiticeiros exercemos poderes arcanos além da compreensão dos homens."})

npcHandler:setMessage(MESSAGE_GREET, "Saudações, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Cuidado em suas jornadas.")
npcHandler:addModule(FocusModule:new())
