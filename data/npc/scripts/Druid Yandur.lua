local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg) end
function onThink()					npcHandler:onThink() end
 
item = 'You do not have the required Level or You Already have a Vocation!.'
done2 = 'Congratulations now you are druid, Go to the dungeon and take your items and hunt.'
 local function greetCallback(cid)
	local player = Player(cid)
	local level = player:getLevel()
	
		npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", Do you Want to become a Druid? {Yes}?")
	
	return true
end
function creatureSayCallback(cid, type, msg)
	local player = Player(cid)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
 
	if msgcontains(msg, 'yes') then
                        if (getPlayerLevel(cid) < 10) then                   
			selfSay('Say it Proudly: Yes, I Want to Become a {Druid}!', cid)
			talk_state = 1
		else
			selfSay('You do not have the required Level or You Already have a Vocation!.', cid)
			talk_state = 0
		end
	elseif msgcontains(msg, 'druid') and talk_state == 1 then
		talk_state = 0
                if player:getStorageValue(43211) > -1 then
			selfSay(done2, cid)
			doPlayerSetVocation(cid, 2)
                       player:setStorageValue(43211, 2)
                        doSendMagicEffect(getCreaturePosition(cid), 14)
		else
			selfSay(item, cid)
		end
	elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 5) then
		selfSay('Ok than.')
		talk_state = 0
	end
	return true
end
 npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())