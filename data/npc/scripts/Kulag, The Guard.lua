local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "trouble") and player:getStorageValue(Storage.TheInquisition.KulagGuard) < 1 and player:getStorageValue(Storage.TheInquisition.Mission01) ~= -1 then
		npcHandler:say("Vocês aventureiros se tornam mais e mais perigosos do que uma peste.", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "authorities") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Eles deviam se jogar em uma jaula ao invés de ficaram dando a vocês essas tarefas e recompensas que um homem honesto apenas sonharia em ter.", cid)
			if player:getStorageValue(Storage.TheInquisition.KulagGuard) < 1 then
				player:setStorageValue(Storage.TheInquisition.KulagGuard, 1)
				player:setStorageValue(Storage.TheInquisition.Mission01, player:getStorageValue(Storage.TheInquisition.Mission01) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			end
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "É meu dever proteger a cidade."})

npcHandler:setMessage(MESSAGE_GREET, "VIDA LONGA AO REI!")
npcHandler:setMessage(MESSAGE_FAREWELL, "VIDA LONGA AO REI!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "VIDA LONGA AO REI!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
