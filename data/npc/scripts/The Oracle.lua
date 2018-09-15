local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}

local config = {
	
	towns = {
		["venore"] = 1,
		["thais"] = 2,
		["kazordoon"] = 3,
		["carlin"] = 4,
		["ab dendriel"] = 5,
		["abdendriel"] = 5,
		["ab'dendriel"] = 5
	}
}

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
		elseif level > 31 then
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
			npcHandler:say("YOU SURE?", cid)
			npcHandler.topic[cid] = 1
		end
	elseif npcHandler.topic[cid] == 1 then
		if msgcontains(msg, "yes") then
			player:setTown(Town(32))
			player:teleportTo(Town(32):getTemplePosition())
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			npcHandler:say("ESTAMOS TRABALHANDO EM ISLAND OF DESTINY", cid)
			
		end
	else
		npcHandler:say("???????", cid)
		
		
		--player:setVocation(Vocation(vocation[cid]))
		
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		--player:teleportTo(Town(town[cid]):getTemplePosition())
		--player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received a backpack with starting items for reaching the mainlands.")
		
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