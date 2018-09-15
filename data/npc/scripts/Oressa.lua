local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local vocationsOutfits = {
	-- sorcerer
	[1] = {
		lookBody = 109,
		lookAddons = 0,
		lookTypeName = {Mage}, -- {male, female}
		lookTypeEx = 130,
		lookTypeFm = 138,
		lookHead = 95,
		lookMount = 0,
		lookLegs = 112,
		lookFeet = 128
	},
	-- druid
	[2] = {
		lookBody = 123,
		lookAddons = 0,
		lookTypeName = {Mage}, -- {male, female}
		lookTypeEx = 130,
		lookTypeFm = 138,
		lookHead = 95,
		lookMount = 0,
		lookLegs = 9,
		lookFeet = 118
	},
	-- paladin
	[3] = {
		lookBody = 117,
		lookAddons = 0,
		lookTypeName = {Hunter}, -- {male, female}
		lookTypeEx = 129,
		lookTypeFm = 137,
		lookHead = 95,
		lookMount = 0,
		lookLegs = 98,
		lookFeet = 78
	},
	-- knight
	[4] = {
		lookBody = 38,
		lookAddons = 0,
		lookTypeName = {Knight}, -- {male, female}
		lookTypeEx = 131,
		lookTypeFm = 139,
		lookHead = 95,
		lookMount = 0,
		lookLegs = 94,
		lookFeet = 115,
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
		npcHandler:say("Para sair de Dawnport Voce precisa ter pelomenos level 8!", cid)
		npcHandler:resetNpc(cid)
		return false
	elseif level > 20 then
		npcHandler:say("Apos o level 20, nao eh mais permitido sair de Dawnport!", cid)
		npcHandler:resetNpc(cid)
		return false
	elseif player:getStorageValue(32907) == 2 then
		npcHandler:say(player:getName() ..", Voce ja escolheu sua vocacao. Siga para a porta correspondente.", cid)
		local positions = {Position(32055, 31886, 6), Position(32073, 31886, 6), Position(32059, 31886, 6), Position(32069, 31886, 6)}
		for i = 1, 4 do
			if player:getVocation():getId() == i then
				player:teleportTo(positions[i])
			end
		end
		npcHandler:resetNpc(cid)
		return false
	else
		npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", Voce esta preparado para seguir sua jornada?")
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	local player = Player(cid)
	local fromVocation = player:getVocation()
	if npcHandler.topic[cid] == 0 then
		npcHandler:say("IN ".. string.upper(msg) .."! E qual profissao voce escolheu? {KNIGHT}, {PALADIN}, {SORCERER}, OU {DRUID}?", cid)
		npcHandler.topic[cid] = 2
	elseif npcHandler.topic[cid] == 2 then
		local vocationTable2 = {"sorcerer", "druid", "paladin", "knight", "SORCERER", "DRUID", "PALADIN", "KNIGHT"}
		for i = 1, 4 do
			if msgcontains(msg, vocationTable2[i]) then
				npcHandler:say("A ".. vocationTable2[i+4] .."! Voce tem certeza? Caso se arrependa, fale comigo novamente antes de pegar os itens da sua vocacao!", cid)
				vocation[cid] = i
				npcHandler.topic[cid] = 3
			end
		end
		--else
		--npcHandler:say("{KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
		--end
	elseif npcHandler.topic[cid] == 3 then
		if msgcontains(msg, "yes") then
			npcHandler:say("A porta para sua vocacao foi desbloqueada! Nao Perca tempo!", cid)
			for i = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
				local item = player:getSlotItem(i)
				if item then
					if item:isContainer() then
						deletar = {23723, 23722, 2510, 2397, 2398, 20104, 2526, 2484, 2388, 2482, 2406, 2449, 2386, 2458, 23839, 2545, 2384, 2448, 2380, 2467, 2389}
						for i = 1, #deletar do
							local del = player:getItemCount(deletar[i])
							if del >= 1 then
								player:removeItem(deletar[i], del)
							end
						end
						else
						item:remove()
					end
					
				end
			end
			
			player:setVocation(Vocation(vocation[cid]))
			local toVocation = Vocation(vocation[cid])
			-- recalculo
			player:setMaxHealth(130 + (player:getVocation():getHealthGain() * player:getLevel()))
			player:addHealth(player:getMaxHealth())
			player:setMaxMana(0 + (player:getVocation():getManaGain() * player:getLevel()))
			player:addMana(player:getMaxMana())
			player:setCapacity(40000 + (player:getVocation():getCapacityGain() * player:getLevel()))
			
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Parabens! Agora voce e %s.', player:getVocation():getName()))
			
			if true then
				local outfit = vocationsOutfits[vocation[cid]]
				if player:getSex() == PLAYERSEX_MALE then
					player:setOutfit(
						{
							lookBody = outfit.lookBody,
							lookAddons = outfit.lookAddons,
							lookTypeName = outfit.lookTypeName,
							lookType = outfit.lookTypeEx,
							lookHead = outfit.lookHead,
							lookMount = outfit.lookMount,
							lookLegs = outfit.lookLegs,
							lookFeet = outfit.lookFeet,
						}
					)
					else
					player:setOutfit(
						{
							lookBody = outfit.lookBody,
							lookAddons = outfit.lookAddons,
							lookTypeName = outfit.lookTypeName,
							lookType = outfit.lookTypeFm,
							lookHead = outfit.lookHead,
							lookMount = outfit.lookMount,
							lookLegs = outfit.lookLegs,
							lookFeet = outfit.lookFeet,
						}
					)
				end
				
				if player:getVocation():getId() == 1 then
					if player:getSkillLevel(1) < 11 and player:getSkillLevel(2) < 11 and player:getSkillLevel(3) < 11 and player:getSkillLevel(4) < 11 then
						player:setStorageValue(32907, 1)
						return false
					end
				elseif player:getVocation():getId() == 2 then
					if player:getSkillLevel(1) < 11 and player:getSkillLevel(2) < 11 and player:getSkillLevel(3) < 11 and player:getSkillLevel(4) < 11 then
						player:setStorageValue(32907, 1)
						return false
					end
				elseif player:getVocation():getId() == 3 then
					if player:getSkillLevel(1) < 11 and player:getSkillLevel(2) < 11 and player:getSkillLevel(3) < 11 and player:getMagicLevel() < 1 then
						player:setStorageValue(32907, 1)
						return false
					end
				elseif player:getVocation():getId() == 4 then
					if player:getSkillLevel(4) < 11 and player:getMagicLevel() < 1 then
						player:setStorageValue(32907, 1)
						return false
					end
				end
				
				local resultId = db.storeQuery("SELECT `id` FROM `players` WHERE `name` = " .. db.escapeString(player:getName():lower()))
				local accountId = result.getDataInt(resultId, "id")
				player:setStorageValue(32907, 1)
				player:remove()
				db.query("UPDATE `players` SET `maglevel` = '0', `manaspent` = '0', `skill_fist` = '10', `skill_fist_tries` = '0', `skill_club` = '10', `skill_club_tries` = '0', `skill_sword` = '10', `skill_sword_tries` = '0', `skill_axe` = '10', `skill_axe_tries` = '0', `skill_dist` = '10', `skill_dist_tries` = '0', `skill_shielding` = '10', `skill_shielding_tries` = '0', `skill_fishing` = '10', `skill_fishing_tries` = '0' WHERE `players`.`id` = " .. accountId)
				return true
				
			end
			-- end of recalculo
			
			--player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:setStorageValue(32907, 1)
			else
			npcHandler:say("ENTAO QUAL? {KNIGHT}, {PALADIN}, {SORCERER}, OU {DRUID}?", cid)
			npcHandler.topic[cid] = 2
		end
	end
	return true
end

local function onAddFocus(cid)
	vocation[cid] = 0
end

local function onReleaseFocus(cid)
	vocation[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())						