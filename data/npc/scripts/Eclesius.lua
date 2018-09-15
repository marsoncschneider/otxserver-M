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
	{ text = "Entre! Mas tenha cuidado com a porta m�gica." },
	{ text = "Me desculpe... Eu prometo que isso n�o ir� acontecer novamente. O problema � que, eu realmente n�o me lembro onde errei..." },
	{ text = "Atualmnete, EU CONTINUO a ter uma prefer�ncia por assistentes inexperientes. S�o mais f�ceis de controlar, al�m de n�o tentarem te apunhalar pelas costas." },
	{ text = "Muito trabalho a fazer, muito trabalho... uh... por onde eu deveria come�ar?" }
}

npcHandler:addModule(VoiceModule:new(voices))

npcHandler:setMessage(MESSAGE_GREET, "Quem � voc�? O que voc� quer? Voc� parece experiente para se tornar meu assistente. Por favor v� embora.")

npcHandler:addModule(FocusModule:new())
