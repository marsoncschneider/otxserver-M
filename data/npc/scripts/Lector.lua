local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'meat'}, StdModule.say, {npcHandler = npcHandler, text = "Posso oferecer-lhe presunto ou carne. Se você quiser verificar a qualidade dos meus produtos, peça-me um{trade}."})

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo à minha loja humilde {meat}, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Por favorm, venha e compre novamente, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Mas é claro, dê uma boa olhada em minha loja.")
npcHandler:addModule(FocusModule:new())
