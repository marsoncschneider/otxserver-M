local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Corajosos aventureiros, venham comprar suas armas e armaduras aqui!'} }
npcHandler:addModule(VoiceModule:new(voices))


npcHandler:setMessage(MESSAGE_GREET, "Olá, caro |PLAYERNAME|. Posso ajudar em alguma coisa? Apenas fale comigo se quiser negociar {trade} armas ou armaduras.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, |PLAYERNAME|. Volte sempre!.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus, |PLAYERNAME|. Volte sempre!.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "É claro, fique a vontade para olhar entre minhas mercadorias.")

npcHandler:addModule(FocusModule:new())
