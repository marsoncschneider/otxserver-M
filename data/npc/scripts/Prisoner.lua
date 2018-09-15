local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = "Ahhhh!" },
	{ text = "Tenha misericórdia!" },
	{ text = "Eu confesso! Eu confesso!" },
	{ text = "Estou arrependido!" },
	{ text = "Nãooooo!" },
	{ text = "Por favor! Eu te imploro! Pare, por favor!" },
	{ text = "Tirem-no daqui! Por favor, tirem ele daqui!!" }
}

npcHandler:addModule(VoiceModule:new(voices))
npcHandler:addModule(FocusModule:new())
