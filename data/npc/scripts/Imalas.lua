local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = "Eu ofere�o muita comida. Pe�a-me um {trade} se voc� estiver com fome"})

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|! O que voc� precisa? Se for comida {food}, voc� veio ao lugar certo.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Sim, d� uma boa olhada.")
npcHandler:addModule(FocusModule:new())
