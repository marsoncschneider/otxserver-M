local msg = true


local function makeXp()
	if msg then
	--Game.broadcastMessage('Xp added, next in 1 hour.', MESSAGE_STATUS_WARNING)
	end
    end

function onThink(interval)

	for _, player in ipairs(Game.getPlayers()) do
	--player:sendTextMessage(MESSAGE_STATUS_SMALL, '!DEBUG "' .. (math.floor(player:getHealth()/player:getMaxHealth()*100)) .. '" % de health')
	--[[if player:removeItem(2148, 100) then player:addItem(2152, 1)
	end
	if player:removeItem(2152, 100) then player:addItem(2160, 1)
	end]]
	local voc = player:getVocation():getBase():getId()
	local exhaust = Condition(CONDITION_EXHAUST_HEAL)
	exhaust:setParameter(CONDITION_PARAM_TICKS, (configManager.getNumber(configKeys.EX_ACTIONS_DELAY_INTERVAL) - 1000))
	local count = player:getStorageValue(250124)
	local count2 = player:getStorageValue(250125)
	

	if count >= 1 or count2 >= 1 then
	
	if count >= 1 and player:getHealth() < (player:getMaxHealth() * count/100) then
	
	
	--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'BOT: Abaixo de "' .. count .. '" % de health')
	player:sendTextMessage(MESSAGE_STATUS_SMALL, 'BOT: HP:' .. (math.floor(player:getHealth()/player:getMaxHealth()*100)) .. '% MP:' .. (math.floor(player:getMana()/player:getMaxMana()*100)) .. '%')
	if player:getCondition(CONDITION_EXHAUST_HEAL) then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_YOUAREEXHAUSTED))
		return true
	end
	if 	voc == 4 or voc == 8 then -- knight and ek
	if player:removeItem(26031,1) and player:getLevel() >= 200 then -- supreme potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(925)
	return true
	end
	if player:removeItem(8473,1) and player:getLevel() >= 130 then -- ultimate potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(750)
	return true
	end
	if player:removeItem(7591,1) and player:getLevel() >= 80 then -- great potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(500)
	return true
	end
	if player:removeItem(7588,1) and player:getLevel() >= 50 then -- strong potion
	player:addItem(7634, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(300)
	return true
	end
	if player:removeItem(7618,1) then -- health potion
	player:addItem(7636, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(170)
	return true
	end
	end
	
	if 	voc == 3 or voc == 7 then -- paladin and rp
	if player:removeItem(26030,1) and player:getLevel() >= 130 then -- ultimate spirit potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(500)
	player:addMana(200)
	return true
	end
	if player:removeItem(8472,1) and player:getLevel() >= 80 then -- great spirit potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(300)
	player:addMana(150)
	return true
	end
	if player:removeItem(7618,1) then -- health potion
	player:addItem(7636, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(170)
	return true
	end
	end
	
	if 	voc == 2 or voc == 6 then -- druid and ed
	if player:removeItem(7618,1) then -- health potion
	player:addItem(7636, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(170)
	return true
	end
	end
	
	if 	voc == 1 or voc == 5 then -- sorc and ms
	if player:removeItem(7618,1) then -- health potion
	player:addItem(7636, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(170)
	return true
	end
	end
	
	if 	voc == 0 or voc == 10 then -- no and rook
	if player:removeItem(7618,1) then -- health potion
	player:addItem(7636, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(170)
	return true
	end
	end
	
	
	
	
	
	
	else
	--player:sendTextMessage(MESSAGE_STATUS_SMALL, "maior que 60% de health")
	end
	
	
	
	if count2 >= 1 and player:getMana() < (player:getMaxMana() * count2/100) then
	--player:sendTextMessage(MESSAGE_STATUS_SMALL, "menor que % de mana")
	--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'BOT: "' .. (math.floor(player:getMana()/player:getMaxMana()*100)) .. '" % of mana.')
	player:sendTextMessage(MESSAGE_STATUS_SMALL, 'BOT: HP:' .. (math.floor(player:getHealth()/player:getMaxHealth()*100)) .. '% MP:' .. (math.floor(player:getMana()/player:getMaxMana()*100)) .. '%')
	--player:sendTextMessage(MESSAGE_STATUS_SMALL, 'BOT: Abaixo de "' .. count2 .. '" % de mana')
	if player:getCondition(CONDITION_EXHAUST_HEAL) then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_YOUAREEXHAUSTED))
		return true
	end
	if 	voc == 4 or voc == 8 then -- knight and ek
	
	if player:removeItem(7620,1) then -- mana potion
	player:addItem(7636, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(100)
	return true
	end
	end
	
	if 	voc == 3 or voc == 7 then -- paladin and rp
	if player:removeItem(7618,1) then -- mana potion
	player:addItem(7636, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(100)
	return true
	end
	if player:removeItem(7589,1) and player:getLevel() >= 50 then -- strong mana potion
	player:addItem(7634, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(150)
	return true
	end
	if player:removeItem(8472,1) and player:getLevel() >= 80 then -- great spirit potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(300)
	player:addMana(150)
	return true
	end
	if player:removeItem(26030,1) and player:getLevel() >= 130 then -- ultimate spirit potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addHealth(500)
	player:addMana(200)
	return true
	end
	

	end
	
	if 	voc == 2 or voc == 6 then -- druid and ed
	if player:removeItem(26029,1) and player:getLevel() >= 130 then -- ultimate mana potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(500)
	return true
	end
	if player:removeItem(7590,1) and player:getLevel() >= 80 then -- great mana potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(200)
	return true
	end
	if player:removeItem(7589,1) and player:getLevel() >= 50 then -- strong mana potion
	player:addItem(7634, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(150)
	return true
	end
	if player:removeItem(7620,1) then -- mana potion
	player:addItem(7636, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(100)
	return true
	end
	end
	
	if 	voc == 1 or voc == 5 then -- sorc and ms
	if player:removeItem(26029,1) and player:getLevel() >= 130 then -- ultimate mana potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(500)
	return true
	end
	if player:removeItem(7590,1) and player:getLevel() >= 80 then -- great mana potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(200)
	return true
	end
	if player:removeItem(7589,1) and player:getLevel() >= 50 then -- strong mana potion
	player:addItem(7634, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(150)
	return true
	end
	if player:removeItem(7620,1) then -- mana potion
	player:addItem(7636, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(100)
	return true
	end
	end
	
	if 	voc == 0 or voc == 10 then -- no and rook
	if player:removeItem(7618,1) then -- mana potion
	player:addItem(7635, 1)
	player:addCondition(exhaust)
	doCreatureSayWithRadius(player, 'Aaaah...', TALKTYPE_MONSTER_SAY, 2, 2)
	player:addMana(100)
	return true
	end
	end
	
	
	
	
	
	
	else
	--player:sendTextMessage(MESSAGE_STATUS_SMALL, "maior que 60% de health")
	end
	
	
	--if player:removeItem(9692, 1) then player:addItem(9692, 1)
	--local skillId = xp
	--local sort = math.random(1,100)
	
	--player:addExperience(sort*15)
	--doCreatureSay(cid, "AFK: "..param..".", TALKTYPE_ORANGE_1)
	--end
	
	
	
	
	end
	end
	--addEvent(makeXp, 600)
	return true
end