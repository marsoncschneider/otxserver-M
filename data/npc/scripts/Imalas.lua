local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = "Eu ofereço muita comida. Peça-me um {trade} se você estiver com fome"})

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|! O que você precisa? Se for comida {food}, você veio ao lugar certo.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Sim, dê uma boa olhada.")
npcHandler:addModule(FocusModule:new())
