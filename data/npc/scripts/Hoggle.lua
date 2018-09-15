local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Oh, essa mis�ria...'} }
npcHandler:addModule(VoiceModule:new(voices))

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo a minha humilde casa!")
npcHandler:setMessage(MESSAGE_FAREWELL, "At� breve.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "At� breve.")

npcHandler:addModule(FocusModule:new())
