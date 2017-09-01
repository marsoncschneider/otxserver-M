 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function greetCallback(cid)
	local player = Player(cid)
	local level = player:getLevel()
	if level < 8 then
		npcHandler:say("CHILD! COME BACK WHEN YOU HAVE GROWN UP!", cid)
		npcHandler:resetNpc(cid)
		return false
	elseif level > 10 then
		npcHandler:say(player:getName() ..", I CAN'T LET YOU LEAVE - YOU ARE TOO STRONG ALREADY! YOU CAN ONLY LEAVE WITH LEVEL 9 OR LOWER.", cid)
		npcHandler:resetNpc(cid)
		return false
	else
		npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", ARE YOU PREPARED TO FACE YOUR DESTINY?")
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if npcHandler.topic[cid] == 0 then
		if msgcontains(msg, "yes") then
			npcHandler:say("THIS DECISION IS IRREVERSIBLE. YOU SURE?", cid)
			npcHandler.topic[cid] = 1
		end
	
	elseif npcHandler.topic[cid] == 1 then
		if msgcontains(msg, "yes") then
			npcHandler:say("SO BE IT!", cid)
			
			player:setTown(Town(37))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Town(37):getTemplePosition())
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			
		else
			npcHandler:say("THEN WHAT?", cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

local function onAddFocus(cid)
	town[cid] = 0
	vocation[cid] = 0
end

local function onReleaseFocus(cid)
	town[cid] = nil
	vocation[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())