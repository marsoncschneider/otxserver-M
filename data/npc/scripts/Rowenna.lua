local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Vendendo e comprando armas de qualidade!'} }
npcHandler:addModule(VoiceModule:new(voices))

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo ao melhor armário da terra, |PLAYERNAME|! Diga-me se você está procurando um bom comércio {trade}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus. Volte logo.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus. Volte logo.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Claro, basta navegar pelos meus produtos.")
npcHandler:addModule(FocusModule:new())
