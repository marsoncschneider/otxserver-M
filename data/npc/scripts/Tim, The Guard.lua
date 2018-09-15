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
	if msgcontains(msg, "trouble") and player:getStorageValue(Storage.TheInquisition.TimGuard) < 1 and player:getStorageValue(Storage.TheInquisition.Mission01) ~= -1 then
		npcHandler:say("Ah, bem. Dê manhã minha nova escova de dentes caiu na privada, que pena.", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "authorities") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("O que quis dizer com isso? É claro que eles vão imediatamente enviar alguem com braços extra longos e fininhos para recuperá-los! ", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "avoided") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say("Seu humor pode acabar com sua vida, em um beco escuro. Eu não acho que alguém conseguiria impedir aquele acidente! ", cid)
			npcHandler.topic[cid] = 3
		end
	elseif msgcontains(msg, "gods would allow") then
		if npcHandler.topic[cid] == 3 then
			npcHandler:say("Isso não é drama!! Eu acho que aqui não tem nenhum Deus responsável por segurança de escovas de dente, isso é tudo ... ", cid)
			npcHandler.topic[cid] = 0
			if player:getStorageValue(Storage.TheInquisition.TimGuard) < 1 then
				player:setStorageValue(Storage.TheInquisition.TimGuard, 1)
				player:setStorageValue(Storage.TheInquisition.Mission01, player:getStorageValue(Storage.TheInquisition.Mission01) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			end
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
