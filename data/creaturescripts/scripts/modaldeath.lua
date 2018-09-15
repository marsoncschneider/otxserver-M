-- revive system by zbizu
-- config
    local deathStorage = 250120
    local counterStorage = 250121 -- res expiration timestamp
    local deathGroupId = 0
    local reviveStone = 2362 -- The Carrot of Doom, change it
    local resTime = 1 * 15 -- 15 seconds
    local showCountdown = true -- shows timer above dead player
	
	local corpo1 = 3065
	local corpo2 = 3058
	
	--[[local corpo1 = 27738 -- feminino --16107, 13921, 19701 boi, 8059 lapide, 26174 espera energia, 26174 esfera muda de cor, energy wall 29076,
	local corpo2 = 26738 --masculino]]
-- end of config
 
local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(-1)
 
function Player:setHealth(value)
    if not self:isPlayer() then return false end
    self:addHealth(value - self:getHealth())
return true
end
 
function Player:setMana(value)
    if not self:isPlayer() then return false end
    self:addMana(value - self:getMana(), false)
return true
end
 
 
function buildModalWindow(cid)
    local player = Player(cid)
	local resitem = player:getItemCount(reviveStone)
	
	
    local modal = ModalWindow(999, "Você morreu!", "Bravo aventureiro, você conheceu um destino triste.\nMas não se desespere, pois os deuses te trarão de volta\npara o mundo em troca de um pequeno sacrifício. " .. (resitem > 0 and "\n\n" .. ItemType(reviveStone):getName() .. " x" .. resitem or "") .. "\n\nSe você optar por morrer, sair ou seu tempo acabar,\nA pena de morte será aplicada. \n\n Você tem 15 segundos para comprar o REVIVER na store.")
 
    modal:addButton(1, "Morrer")
    --modal:setDefaultEnterButton(1)
    modal:addButton(2, "STORE")
    modal:setDefaultEscapeButton(2)
	modal:addButton(3, "AGORA")
 
    --if resitem > 0 then
       -- modal:addButton(3, "Item")
    --end
 
    return modal:sendToPlayer(player)
	
end
 
function Player:isDead()
    return self:getGroup():getId() == deathGroupId
end
 
function Player:die()
    self:toggleDeath()
	self:setStorageValue(250122, -1)
    self:setStorageValue(counterStorage, -1)
    self:setStorageValue(deathStorage, 1)
    self:addHealth(-(self:getMaxHealth()))
    return true
end
 
function sendDeathWindowOnMove(cid, lockPos)
    local player = Player(cid)
    if not player then return false end
    if not player:isDead() then
        return false
    end
	if player:getStorageValue(250122) == 1 then
		return false
	end
    if os.time() > player:getStorageValue(counterStorage) then
        if player:getStorageValue(250122) ~= 1 then
		player:die()
		else
		player:setGroup(Group(1))
        player:setHiddenHealth(false)
           
        player:addMana(math.ceil(player:getMaxMana()) - player:getMana(), false)
        player:addHealth(math.ceil(player:getMaxHealth()) - player:getHealth())
        player:removeCondition(CONDITION_OUTFIT)
		if player:getSpeed() ~= player:getBaseSpeed() then
		
		local basespeed = player:getBaseSpeed() - player:getSpeed()
		
		player:changeSpeed(basespeed) -- aqui tinha menos...
		end
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você ressuscitou, " .. player:getName() .. ", pelo valor de 12 coins.")
		end
		player:setStorageValue(250122, -1)
        return true
    end
   
    addEvent(sendDeathWindowOnMove, 100, cid, lockPos)
   
    if player:getPosition() ~= lockPos then
        player:teleportTo(lockPos)
        buildModalWindow(cid)
    end
   
    return true
end
 
function sendReviveCountdown(cid)
    if not showCountdown then return false end
    local player = Player(cid)
    if not player then return false end
    if not player:isDead() then
        return false
    end
   
    local timeleft = os.date("!%X",player:getStorageValue(counterStorage) - os.time()):split(":")
	--if player:getSpeed() == player:getBaseSpeed() then
		local basespeed = player:getBaseSpeed()
		doChangeSpeed(player, basespeed*10)
	--end
	if player:getStorageValue(250122) ~= 1 then
		condition:setOutfit(player:getSex() == PLAYERSEX_FEMALE and 3065 or 3058)
	else
		condition:setOutfit({lookType = 266})
	end
	player:addCondition(condition)
	
	
	if os.time() > player:getStorageValue(counterStorage) then
        if player:getStorageValue(250122) ~= 1 then
			player:die()
		else
		player:setGroup(Group(1))
        player:setHiddenHealth(false)
           
        player:addMana(math.ceil(player:getMaxMana()) - player:getMana(), false)
        player:addHealth(math.ceil(player:getMaxHealth()) - player:getHealth())
        player:removeCondition(CONDITION_OUTFIT)
		--if player:getSpeed() ~= player:getBaseSpeed() then
		--local basespeed = player:getBaseSpeed()*10
		--basespeed == 150 - 1000
		local basespeed = player:getBaseSpeed() - player:getSpeed()
		--doChangeSpeed(player, -basespeed)
		player:changeSpeed(basespeed)
		--end
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "GOD de: " .. player:getName() .. ", chegou ao fim.")
		end
	player:setStorageValue(250122, -1)
    return true
	else
	local name = player:getName()
	player:say(name .. ": " .. timeleft[2] .. ":" .. timeleft[3], TALKTYPE_MONSTER_SAY)
	if player:getStorageValue(250122) ~= 1 then
	condition:setOutfit(player:getSex() == PLAYERSEX_FEMALE and corpo1 or corpo2)
	else
	condition:setOutfit({lookType = 266})
	end
	player:addCondition(condition)
    addEvent(sendReviveCountdown, 1000, cid)
    end
	
    return true
end
 
function Player:toggleDeath(countdown)

    if self:isDead() then
        self:setGroup(Group(1))
        self:setHiddenHealth(false)
        self:setHealth(math.ceil(self:getMaxHealth() * 0.3))
        self:setMana(math.ceil(self:getMaxMana() * 0.3))
        self:removeCondition(CONDITION_OUTFIT)
        return true
    end
   
    if countdown then
        self:setStorageValue(counterStorage, os.time() + countdown)
    end
   
    self:setGroup(Group(deathGroupId))
    self:setHiddenHealth(true)
    --if self:getSpeed() == self:getBaseSpeed() then
	buildModalWindow(self:getId())
	--end
   
    local pos = self:getPosition()
    --if self:getSpeed() == self:getBaseSpeed() then
	if self:getStorageValue(250122) ~= 1 then
	sendDeathWindowOnMove(self:getId(), pos)
	end
    sendReviveCountdown(self:getId())
	
   
    local npos = Position(pos.x + 1, pos.y, pos.z)
    if not Tile(npos) then
        Game.createTile(npos)
    end
   
    self:teleportTo(npos, true)
    return true
end

function Player:toggleDeath2(countdown)
    if self:isDead() then
        self:setGroup(Group(1))
        self:setHiddenHealth(false)
        self:setHealth(math.ceil(self:getMaxHealth() * 0.3))
        self:setMana(math.ceil(self:getMaxMana() * 0.3))
        self:removeCondition(CONDITION_OUTFIT)
        return true
    end
   
    if countdown then
        self:setStorageValue(counterStorage, os.time() + countdown)
    end
   
    self:setGroup(Group(deathGroupId))
    self:setHiddenHealth(true)
    --buildModalWindow(self:getId())
   
    local pos = self:getPosition()
    --sendDeathWindowOnMove(self:getId(), pos)
    sendReviveCountdown(self:getId())
   
    local npos = Position(pos.x + 1, pos.y, pos.z)
    if not Tile(npos) then
        Game.createTile(npos)
    end
   
    self:teleportTo(npos, true)
	if self:getStorageValue(250122) ~= 1 then
	condition:setOutfit(self:getSex() == PLAYERSEX_FEMALE and corpo1 or corpo2)
	else
	condition:setOutfit({lookType = 266})
	end
	self:addCondition(condition)
	--if self:getSpeed() == self:getBaseSpeed() then
	local basespeed = self:getBaseSpeed()
	--doChangeSpeed(self, basespeed*10)
	self:changeSpeed(basespeed*10)
	--end
	return true
end
 
function onLogin(player)
    player:registerEvent("modalDeath")
    player:registerEvent("deathMW")
    player:registerEvent("loginDeath")
 
    if player:isDead() then
        if player:getStorageValue(counterStorage) == -1 then
            player:toggleDeath()
            return true
        end
       
        if os.time() > player:getStorageValue(counterStorage) then
            if player:getStorageValue(250122) ~= 1 then
			player:die()
			else
			player:setGroup(Group(1))
        player:setHiddenHealth(false)
           
        player:addMana(math.ceil(player:getMaxMana()) - player:getMana(), false)
        player:addHealth(math.ceil(player:getMaxHealth()) - player:getHealth())
        player:removeCondition(CONDITION_OUTFIT)
		--if player:getSpeed() ~= player:getBaseSpeed() then
		--local basespeed = player:getBaseSpeed()*10
		--basespeed == 150 - 1000
		local basespeed = player:getBaseSpeed() - player:getSpeed()
		--doChangeSpeed(player, -basespeed)
		player:changeSpeed(basespeed) -- aqui tinha menos...
		--end
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "GOD de: " .. player:getName() .. ", chegou ao fim.")
			end
			player:setStorageValue(250122, -1)
            return true
        end
       
        player:setHiddenHealth(true)
		if player:getStorageValue(250122) ~= 1 then
        sendDeathWindowOnMove(player:getId(), player:getPosition())
		end
		sendReviveCountdown(player:getId())
    end
 
    return true
end
 
function onPrepareDeath(creature, killer)
	local resitem = creature:getItemCount(reviveStone)
	--if creature:getCoinsBalance() >= 12 or resitem > 0 then
	--else
	--return true
	--end
-- pvp kills may act weird
	if killer then
	if killer:isPlayer() then
        --return true
    end
	end
    --if not creature:isPlayer() then
       -- return true
    --end
   
    if creature:getStorageValue(deathStorage) == 1 then
        creature:setStorageValue(deathStorage, -1)
        return true
    end
   
    creature:toggleDeath(resTime)
	if creature:getStorageValue(250122) ~= 1 then
    condition:setOutfit(creature:getSex() == PLAYERSEX_FEMALE and corpo1 or corpo2)
	else
	condition:setOutfit({lookType = 266})
	end
    creature:addCondition(condition)
    return false
end
 
function onModalWindow(player, modalWindowId, buttonId, choiceId)
    if modalWindowId ~= 999 then
        return false
    end
   
    if not player:isDead() then
        return false
    end
   
    if buttonId == 1 then
        player:die()
		player:setStorageValue(250122, -1)
        return true
    elseif buttonId == 2 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você decidiu Comprar pela store. Caso nao tenha o saldo, Mova-se em qualquer direção para abrir novamente a janela do avivamento.")
        --[[local amount = 12
		if player:getCoinsBalance() >= amount then   
        player:removeCoinsBalance(amount)
		player:setGroup(Group(1))
        player:setHiddenHealth(false)
           
        player:addMana(math.ceil(player:getMaxMana()) - player:getMana(), false)
        player:addHealth(math.ceil(player:getMaxHealth()) - player:getHealth())
        player:removeCondition(CONDITION_OUTFIT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você ressuscitou, " .. player:getName() .. ", pelo valor de 12 coins.")
		end]]
		return true
	elseif buttonId == 3 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você decidiu Comprar pela store. Caso nao tenha o saldo, Mova-se em qualquer direção para abrir novamente a janela do avivamento.")
        local amount = 12
		if player:getCoinsBalance() >= amount then   
        player:removeCoinsBalance(amount)
		player:setGroup(Group(1))
        player:setHiddenHealth(false)
           
        player:addMana(math.ceil(player:getMaxMana()) - player:getMana(), false)
        player:addHealth(math.ceil(player:getMaxHealth()) - player:getHealth())
        player:removeCondition(CONDITION_OUTFIT)
		local basespeed = player:getBaseSpeed() - player:getSpeed()
		--local basespeed2 = player:getSpeed() * -1
		--doChangeSpeed(player, -basespeed)
		player:changeSpeed(basespeed)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você ressuscitou, " .. player:getName() .. ", pelo valor de 12 coins.")
		end
		return true
    elseif buttonId == 4 then
        if player:getItemCount(reviveStone) == 0 then
            player:sendCancelMessage("Você não tem nenhum item para se reviver.")
            return true
        end
       
        player:getItemById(reviveStone, true):remove(1)
        player:toggleDeath()
        local revst = ItemType(reviveStone)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você se reviveu com " .. revst:getArticle() .. " " .. revst:getName() .. ".")
    end
    return true
end