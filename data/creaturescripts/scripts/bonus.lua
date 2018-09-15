local t = {seconds = 3, storage = 61920, bonusHealth = 10, bonusMana = 10}
local function save(cid)
	if not Player(cid) then
		return
	end
	local player = Player(cid)
	player:save()
	--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Anti-Rollback saved!")
	local timer = player:getStorageValue(250129)
	
	
	
	if timer >= 0 then
	player:setStorageValue(250129, player:getStorageValue(250129)+1)
	end
	if timer < 0 then
	player:setStorageValue(250129, 0)
	end
	
	if player:getStorageValue(250129) >= 1 and player:getStorageValue(250129) < 60 then
	local a = player:getStorageValue(250129)
	
	if a == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ganhe uma Caixa Misteriosa, a cada hora online.")
	end
	
	if a == 5 or a == 10 or a == 20 or a == 30 or a == 40 or a == 50 then
		--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ""..  player:getStorageValue(250129) .." minutos online! Permaneca mais "..  60-player:getStorageValue(250129) .." e ganhe uma Caixa Misteriosa e Tibia Coins.")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Permaneca mais "..  60-player:getStorageValue(250129) .." para ganhar uma Caixa Misteriosa.")
	end
	
	elseif player:getStorageValue(250129) == 60 then
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Parabens! voce ganhou uma Caixa Misteriosa! Continue Online para ganhar mais!!!")
	player:setStorageValue(250129, 0)
	
	player:addItem(24774, 1)
	
	local box = player:addItem(2596, 1)
	box:setActionId(2017)
	box:setAttribute(ITEM_ATTRIBUTE_NAME, "".. box:getType():getName() .. " Misteriosa")

	end
	
	
	--player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, '"Anti-Rollback!"')
	addEvent(save, 60*1000, player.uid)
end
local function bonusRegeneration(cid)

	if not Player(cid) then
		return
	end
	
	local player = Player(cid)
	
	addEvent(bonusRegeneration, 3*1000, player.uid)
	local cur = math.max(player:getStorageValue(61920) - os.time(), 0)
	if cur == 0 then
	return
	end
   if isPlayer(player) then
	 doCreatureAddHealth(player, t.bonusHealth)
     if t.bonusMana ~= 0 then
       doPlayerAddMana(player, t.bonusMana)
     end
     --addEvent(bonusRegeneration, 3*1000, player.uid) test changes
   end
end
 
function onLogin(cid)
local player = Player(cid)
	player:setStorageValue(250129, -1)
	bonusRegeneration(player)
	save(player)
   
   return true
end
 
function onLogout(cid)
local player = Player(cid)
stopEvent(save)
   if getPlayerStorageValue(player, t.storage) > 0 then
     stopEvent(bonusRegeneration)
   end
   return true
end