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
	if msgcontains(msg, "trouble") and npcHandler.topic[cid] ~= 3 and player:getStorageValue(Storage.TheInquisition.MilesGuard) < 1 and player:getStorageValue(Storage.TheInquisition.Mission01) ~= -1 then
		npcHandler:say("Estou bem, não tenho nenhum problema no momento.", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "foresight of the authorities") and npcHandler.topic[cid] == 1 then
		npcHandler:say("Bom, concerteza vivemos pacíficamente.", cid)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, "also for the gods") and npcHandler.topic[cid] == 2 then
		npcHandler:say("Acho que os Deuses estão olhando por nós e suas mãos nos protegem do mau.", cid)
		npcHandler.topic[cid] = 3
	elseif msgcontains(msg, "trouble will arise in the near future") and npcHandler.topic[cid] == 3 then
		npcHandler:say("Creio que os Deuses e as Autoridades fazem seu melhor para manter a paz no futuro.", cid)
		npcHandler.topic[cid] = 0
		if player:getStorageValue(Storage.TheInquisition.MilesGuard) < 1 then
			player:setStorageValue(Storage.TheInquisition.MilesGuard, 1)
			player:setStorageValue(Storage.TheInquisition.Mission01, player:getStorageValue(Storage.TheInquisition.Mission01) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
			player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
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
