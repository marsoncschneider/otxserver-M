local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Sou apenas um velho, mas conhe�o muito sobre o Tibia.'} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Tenho sabedoria e conhecimento. Tamb�m sou astr�logo."})

npcHandler:setMessage(MESSAGE_GREET, "Oh, ol� |PLAYERNAME|! Que gratificante um jovem como voc� visitar um velho como eu.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Volte quando precisar de sabedoria.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Volte quando precisar de sabedoria.")

npcHandler:addModule(FocusModule:new())
