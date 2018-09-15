local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Arcos, bestas e muni��o! Oferta especial somente hoje!.'} }
npcHandler:addModule(VoiceModule:new(voices))

npcHandler:setMessage(MESSAGE_GREET, "Oh, por favor entre, |PLAYERNAME|. Do que voc� precisa? Armas de dist�ncia? Eu vendo muitas.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "At� mais.")

npcHandler:addModule(FocusModule:new())
