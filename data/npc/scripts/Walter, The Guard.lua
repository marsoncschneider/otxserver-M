local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if(msgcontains(msg, "trouble") and player:getStorageValue(Storage.TheInquisition.WalterGuard) < 1 and player:getStorageValue(Storage.TheInquisition.Mission01) ~= -1) then
		npcHandler:say("Acho que temos um trombadinha na cidade.", cid)
		npcHandler.topic[cid] = 1
	elseif(msgcontains(msg, "authorities")) then
		if(npcHandler.topic[cid] == 1) then
			npcHandler:say("Bom, cedo ou tarde vamos ter que dar cabo desse deliquente. Disso tenho certeza.", cid)
			npcHandler.topic[cid] = 2
		end
	elseif(msgcontains(msg, "avoided")) then
		if(npcHandler.topic[cid] == 2) then
			npcHandler:say("Pela aparência não podemos dizer que a pessoa é ou não um trombadinha. Você simplesmente não pode fechar os portões da cidade para todos.", cid)
			npcHandler.topic[cid] = 3
		end
	elseif(msgcontains(msg, "gods allow")) then
		if(npcHandler.topic[cid] == 3) then
			npcHandler:say("Se os Deuses tivessem criado o mundo como um paraiso, ninguém seria ladrão.", cid)
			npcHandler.topic[cid] = 0
			if(player:getStorageValue(Storage.TheInquisition.WalterGuard) < 1) then
				player:setStorageValue(Storage.TheInquisition.WalterGuard, 1)
				player:setStorageValue(Storage.TheInquisition.Mission01, player:getStorageValue(Storage.TheInquisition.Mission01) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
