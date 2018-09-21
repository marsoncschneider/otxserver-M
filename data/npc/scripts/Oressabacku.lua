local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local config = {
	
	towns = {
		["venore"] = 1,
		["thais"] = 2,
		["kazordoon"] = 3,
		["carlin"] = 4,
		["ab dendriel"] = 5,
		["abdendriel"] = 5,
		["ab'dendriel"] = 5
	},
	
	vocations = {
		["sorcerer"] = {
			text = "A SORCERER! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
			vocationId = 1,
			--equipment spellbook, wand of vortex, magician's robe, mage hat, studded legs, leather boots, scarf
			{{2175, 1}, {2190, 1}, {8819, 1}, {8820, 1}, {2468, 1}, {2643, 1}, {2661, 1}},
			--container rope, shovel, mana potion
			{{2120, 1}, {2554, 1}, {7620, 1}}
		},
		
		["druid"] = {
			text = "A DRUID! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
			vocationId = 2,
			--equipment spellbook, snakebite rod, magician's robe, mage hat, studded legs, leather boots scarf
			{{2175, 1}, {2182, 1}, {8819, 1}, {8820, 1}, {2468, 1}, {2643, 1}, {2661, 1}},
			--container rope, shovel, mana potion
			{{2120, 1}, {2554, 1}, {7620, 1}}
		},
		
		["paladin"] = {
			text = "A PALADIN! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
			vocationId = 3,
			--equipment dwrven shield, 5 spear, ranger's cloak, ranger legs scarf, legion helmet
			{{2525, 1}, {2389, 5}, {2660, 1}, {8923, 1}, {2643, 1}, {2661, 1}, {2480, 1}},
			--container rope, shovel, health potion, bow, 50 arrow
			{{2120, 1}, {2554, 1}, {7618, 1}, {2456, 1}, {2544, 50}}
		},
		
		["knight"] = {
			text = "A KNIGHT! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!",
			vocationId = 4,
			--equipment dwarven shield, steel axe, brass armor, brass helmet, brass legs scarf
			{{2525, 1}, {8601, 1}, {2465, 1}, {2460, 1}, {2478, 1}, {2643, 1}, {2661, 1}},
			--container jagged sword, daramian mace, rope, shovel, health potion
			{{8602, 1}, {2439, 1}, {2120, 1}, {2554, 1}, {7618, 1}}
		}
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
		elseif player:getStorageValue(32907) == 2 then
		npcHandler:say(player:getName() ..", Voce ja escolheu sua vocacao. Siga para a porta correspondente.", cid)
		if player:getVocation():getId() == 1 then
			local positions = {Position(32055, 31886, 6),Position(32073, 31886, 6),Position(32059, 31886, 6),Position(32069, 31886, 6)}
			player:teleportTo(Position(32055, 31886, 6))
			elseif player:getVocation():getId() == 2 then
			player:teleportTo(Position(32073, 31886, 6))
			elseif player:getVocation():getId() == 3 then
			player:teleportTo(Position(32059, 31886, 6))
			elseif player:getVocation():getId() == 4 then
			player:teleportTo(Position(32069, 31886, 6))
		end
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
	local fromVocation = player:getVocation()
	if npcHandler.topic[cid] == 0 then
		
		
		npcHandler:say("IN ".. string.upper(msg) .."! AND WHAT PROFESSION HAVE YOU CHOSEN: {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
		npcHandler.topic[cid] = 2
		
		elseif npcHandler.topic[cid] == 2 then
		local vocationTable = config.vocations[msg:lower()]
		if vocationTable then
			npcHandler:say(vocationTable.text, cid)
			npcHandler.topic[cid] = 3
			vocation[cid] = vocationTable.vocationId
			else
			npcHandler:say("{KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
		end
		elseif npcHandler.topic[cid] == 3 then
		if msgcontains(msg, "yes") then
			npcHandler:say("SUA PORTA FOI DESBLOQUEADA!", cid)
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
			
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Congratulations! Now you are %s.', player:getVocation():getName()))
			if fromVocation ~= toVocation then
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
		local targetVocation = config.vocations[Vocation(vocation[cid]):getName():lower()]
		for i = 1, #targetVocation[1] do
		
		end
		--local backpack = player:addItem(1988)
		--[[for i = 1, #targetVocation[2] do
		
		end]]
		else
		npcHandler:say("THEN WHAT? {KNIGHT}, {PALADIN}, {SORCERER}, OR {DRUID}?", cid)
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