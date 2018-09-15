local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Embeleze sua casa com flores!'} }
npcHandler:addModule(VoiceModule:new(voices))

npcHandler:setMessage(MESSAGE_GREET, "Bem-Vindo, |PLAYERNAME|. O que posso fazer para te ajudar?")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Claro, basta navegar pelos meus produtos.")
npcHandler:addModule(FocusModule:new())
