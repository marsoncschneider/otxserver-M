local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'Pessoas de Thais, tragam honra para nosso Rei lutando na guerra dos orcs!' },
	{ text = 'Os orcs estão se preparando para a guerra!!!' }
}

npcHandler:addModule(VoiceModule:new(voices))

npcHandler:setMessage(MESSAGE_GREET, "VIDA LONGA AO REI TIBIANUS!")
npcHandler:setMessage(MESSAGE_FAREWELL, "VIDA LONGA AO REI!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "VIDA LONGA AO REI!")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Você trouxe ratos recém-mortos? Pago 1 gold para cada um. Por sinal, eu compro orc teeth e outros produtos de monstros tirados de seus corpos... Digo... bom, você sabe o que eu quis dizer.")

npcHandler:addModule(FocusModule:new())
