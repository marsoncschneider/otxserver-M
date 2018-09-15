local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = "Estou procurando por um novo assistente!!" },
	{ text = "Err, o que? O que foi feito novamente? Era o que eu queria...?" },
	{ text = "Entre! Mas tenha cuidado com a porta mágica." },
	{ text = "Me desculpe... Eu prometo que isso não irá acontecer novamente. O problema é que, eu realmente não me lembro onde errei..." },
	{ text = "Atualmnete, EU CONTINUO a ter uma preferência por assistentes inexperientes. São mais fáceis de controlar, além de não tentarem te apunhalar pelas costas." },
	{ text = "Muito trabalho a fazer, muito trabalho... uh... por onde eu deveria começar?" }
}

npcHandler:addModule(VoiceModule:new(voices))

npcHandler:setMessage(MESSAGE_GREET, "Quem é você? O que você quer? Você parece experiente para se tornar meu assistente. Por favor vá embora.")

npcHandler:addModule(FocusModule:new())
