local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Comprando e vendendo todos os tipos de armas e armaduras!!'} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Estou comprando armas e armaduras."})

npcHandler:setMessage(MESSAGE_GREET, "Ol� |PLAYERNAME|! Voc� precisa dos meus servi�os?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus. Venha aqui sempre que quiser vender alguma coisa.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus. Venha aqui sempre que quiser vender alguma coisa.")

npcHandler:addModule(FocusModule:new())
