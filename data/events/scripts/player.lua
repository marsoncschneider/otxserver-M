-- Internal Use
STONE_SKIN_AMULET = 2197
ITEM_STORE_INBOX = 26052
GOLD_POUNCH = 26377

-- No move items with actionID 8000
NOT_MOVEABLE_ACTION = 8000

-- Players cannot throw items on teleports if set to true
local blockTeleportTrashing = true

local townsrange = {
	{fromPos = Position(32953, 32072, 7), toPos = Position(32963, 32081, 7), townId = 1},
	{fromPos = Position(32364, 32231, 7), toPos = Position(32374, 32243, 7), townId = 2},
	{fromPos = Position(32642, 31921, 11), toPos = Position(32656, 31929, 11), townId = 3},
	{fromPos = Position(32356, 31775, 7), toPos = Position(32364, 31787, 7), townId = 4},
	{fromPos = Position(32718, 31628, 7), toPos = Position(32736, 31639, 7), townId = 5},
	{fromPos = Position(32313, 32818, 7), toPos = Position(32322, 32830, 7), townId = 7},
	{fromPos = Position(32590, 32740, 7), toPos = Position(32600, 32750, 7), townId = 8},
	{fromPos = Position(33188, 32844, 8), toPos = Position(33201, 32857, 8), townId = 9},
	{fromPos = Position(33210, 32450, 1), toPos = Position(33217, 32457, 1), townId = 10},
	{fromPos = Position(33208, 31803, 8), toPos = Position(33225, 31819, 8), townId = 11},
	{fromPos = Position(32207, 31127, 7), toPos = Position(32218, 31138, 7), townId = 12},
	{fromPos = Position(32785, 31274, 7), toPos = Position(32789, 31279, 7), townId = 13},
	{fromPos = Position(33018, 31514, 11), toPos = Position(33032, 31531, 11), townId = 14},
	{fromPos = Position(33442, 31312, 9), toPos = Position(33454, 31326, 9), townId = 28},
	{fromPos = Position(33510, 32360, 6), toPos = Position(33516, 32366, 6), townId = 29},
	{fromPos = Position(33586, 31895, 6), toPos = Position(33603, 31903, 6), townId = 33}
}

local titles = {
	{storageID = 14960, title = " Scout"},
	{storageID = 14961, title = " Sentinel"},
	{storageID = 14962, title = " Steward"},
	{storageID = 14963, title = " Warden"},
	{storageID = 14964, title = " Squire"},
	{storageID = 14965, title = " Warrior"},
	{storageID = 14966, title = " Keeper"},
	{storageID = 14967, title = " Guardian"},
	{storageID = 14968, title = " Sage"},
	{storageID = 14969, title = " Tutor"},
	{storageID = 14970, title = " Senior Tutor"},
	{storageID = 14971, title = " King"},
}

local function getTitle(uid)
	local player = Player(uid)
	if not player then return false end

	for i = #titles, 1, -1 do
		if player:getStorageValue(titles[i].storageID) == 1 then
			return titles[i].title
		end
	end

	return false
end

function Player:onBrowseField(position)
	return true
end

local function getHours(seconds)
	return math.floor((seconds/60)/60)
end

local function getMinutes(seconds)
	return math.floor(seconds/60)
end

local function getTime(seconds)
	local hours, minutes = getHours(seconds), getMinutes(seconds)
	if (minutes > 59) then
		minutes = minutes-hours*60
	end

	if (minutes < 10) then
		minutes = "0" ..minutes
	end

	return hours..":"..minutes.. "h"
end

function Player:onLook(thing, position, distance)
	local description = 'You see '
	if thing:isItem() then
		if thing.actionid == 5640 then
			description = description .. 'a honeyflower patch.'
		elseif thing.actionid == 5641 then
			description = description .. 'a banana palm.'
		elseif thing.itemid >= ITEM_HEALTH_CASK_START and thing.itemid <= ITEM_HEALTH_CASK_END 
		or thing.itemid >= ITEM_MANA_CASK_START and thing.itemid <= ITEM_MANA_CASK_END 
		or thing.itemid >= ITEM_SPIRIT_CASK_START and thing.itemid <= ITEM_SPIRIT_CASK_END 
		or thing.itemid >= ITEM_KEG_START and thing.itemid <= ITEM_KEG_END then
			description = description .. thing:getDescription(distance)
			local charges = thing:getCharges()
			if charges then
			description = string.format('%s\nIt has %d refillings left.', description, charges)
			end
		else
			description = description .. thing:getDescription(distance)
		end

		local itemType = thing:getType()
		if (itemType and itemType:getImbuingSlots() > 0) then
			local imbuingSlots = "Imbuements: ("
			for i = 1, itemType:getImbuingSlots() do
				local specialAttr = thing:getSpecialAttribute(i)
				local time = 0
				if (thing:getSpecialAttribute(i+3)) then
					time = getTime(thing:getSpecialAttribute(i+3))
				end

				if (specialAttr and specialAttr ~= 0) then
					if (i ~= itemType:getImbuingSlots()) then
						imbuingSlots = imbuingSlots.. "" ..specialAttr.." " ..time..", "
					else
						imbuingSlots = imbuingSlots.. "" ..specialAttr.." " ..time..")."
					end
				else
					if (i ~= itemType:getImbuingSlots()) then
						imbuingSlots = imbuingSlots.. "Free Slot, "
					else
						imbuingSlots = imbuingSlots.. "Free Slot)."
					end
				end
			end
			description = string.gsub(description, "It weighs", imbuingSlots.. "\nIt weighs")
		end
	else
		description = description .. thing:getDescription(distance)
	end

	if self:getGroup():getAccess() then
		if thing:isItem() then
			description = string.format('%s\nItem ID: %d', description, thing.itemid)

			local actionId = thing.actionid
			if actionId ~= 0 then
				description = string.format('%s, Action ID: %d', description, actionId)
			end

			local uniqueId = thing:getAttribute(ITEM_ATTRIBUTE_UNIQUEID)
			if uniqueId > 0 and uniqueId < 65536 then
				description = string.format('%s, Unique ID: %d', description, uniqueId)
			end

			description = description .. '.'
			local itemType = thing:getType()

			local transformEquipId = itemType:getTransformEquipId()
			local transformDeEquipId = itemType:getTransformDeEquipId()
			if transformEquipId ~= 0 then
				description = string.format('%s\nTransforms to: %d (onEquip)', description, transformEquipId)
			elseif transformDeEquipId ~= 0 then
				description = string.format('%s\nTransforms to: %d (onDeEquip)', description, transformDeEquipId)
			end

			local decayId = itemType:getDecayId()
			if decayId ~= -1 then
				description = string.format('%s\nDecays to: %d', description, decayId)
			end
		elseif thing:isCreature() then
			local str = '%s\nHealth: %d / %d'
			if thing:getMaxMana() > 0 then
				str = string.format('%s, Mana: %d / %d', str, thing:getMana(), thing:getMaxMana())
			end
			description = string.format(str, description, thing:getHealth(), thing:getMaxHealth()) .. '.'
		end

		local position = thing:getPosition()
		description = string.format(
			'%s\nPosition: %d, %d, %d',
			description, position.x, position.y, position.z
		)

		if thing:isCreature() and thing:isPlayer() then
			description = string.format('%s\nIP: %s.', description, Game.convertIpToString(thing:getIp()))
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInBattleList(creature, distance)
	local description = "You see " .. creature:getDescription(distance)
	if self:getGroup():getAccess() then
		local str = "%s\nHealth: %d / %d"
		if creature:getMaxMana() > 0 then
			str = string.format("%s, Mana: %d / %d", str, creature:getMana(), creature:getMaxMana())
		end
		description = string.format(str, description, creature:getHealth(), creature:getMaxHealth()) .. "."

		local position = creature:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if creature:isPlayer() then
			description = string.format("%s\nIP: %s", description, Game.convertIpToString(creature:getIp()))
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
	self:sendTextMessage(MESSAGE_INFO_DESCR, "You see " .. item:getDescription(distance))
end

function Player:onLookInShop(itemType, count)
	return true
end

local config = {
	maxItemsPerSeconds = 1,
	exhaustTime = 2000,
}

if not pushDelay then
	pushDelay = { }
end

local function antiPush(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if toPosition.x == CONTAINER_POSITION then
		return true
	end

	local tile = Position(toPosition):getTile()
	if not tile then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	local cid = self:getId()
	if not pushDelay[cid] then
		pushDelay[cid] = {items = 0, time = 0}
	end

	pushDelay[cid].items = pushDelay[cid].items + 1

	local currentTime = os.mtime()
	if pushDelay[cid].time == 0 then
		pushDelay[cid].time = currentTime
	elseif pushDelay[cid].time == currentTime then
		pushDelay[cid].items = pushDelay[cid].items + 1
	elseif currentTime > pushDelay[cid].time then
		pushDelay[cid].time = 0
		pushDelay[cid].items = 0
	end

	if pushDelay[cid].items > config.maxItemsPerSeconds then
		pushDelay[cid].time = currentTime + config.exhaustTime
	end

	if pushDelay[cid].time > currentTime then
		self:sendCancelMessage("You can't move that item so fast.")
		return false
	end

	return true
end

function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	 --if item:getId() and toPosition.y then
           local playerPos9, isInTemple9, temple9, townId9 = self:getPosition(), false
		   for i = 1, #townsrange do
			temple9 = townsrange[i]
			if isInRange(toPosition, temple9.fromPos, temple9.toPos) then
			self:sendCancelMessage("Por favor mantenha o templo limpo.")
			return false
			
			end
			
			
			end
			--[[ for i = 1, #townsrange do
		local temple = config[i]
		if isInRange(fromPosition, temple.fromPosition, temple.toPosition) then
			if Tile(toPosition):hasFlag(TILESTATE_PROTECTIONZONE) then
				isInTemple, townId = true, temple.townId
				self:sendCancelMessage("move on temple")
			end
		end
		   end]]
			
			if item:getId() == 1775 and getTilePzInfo(getCreaturePosition(self)) then
			--item:remove()
			end
				if (os.time() - self:getStorageValue(61923)) >= 1 then
                self:setStorageValue(61923, os.time())
				--self:setStorageValue(61923, os.time())
            else
				--self:setStorageValue(61923, -1)
                self:sendCancelMessage("Push com bot")
				--self:remove()
                return false
            end
       -- end
	 if item:getId() == 2197 and toPosition.y == CONST_SLOT_NECKLACE then
            if (os.time() - self:getStorageValue(61922)) >= 1 then
                self:setStorageValue(61922, os.time())
            else
                self:sendCancelMessage("You can't push stone skin amulet so fast!")
                return false
            end
        end
	local tile = Tile(toPosition)
    if tile and tile:getItemCount() > 20 then
        self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end
	--- LIONS ROCK START 
	if self:getStorageValue(lionrock.storages.playerCanDoTasks) - os.time() < 0 then
		local p, i = lionrock.positions, lionrock.items
		local checkPr = false
		if item:getId() == lionrock.items.ruby and toPosition.x == p.ruby.x and toPosition.y == p.ruby.y  and toPosition.z == p.ruby.z then
			-- Ruby
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You place the ruby on the small socket. A red flame begins to burn.")
				checkPr = true
			if lionrock.taskactive.ruby ~= true then
				lionrock.taskactive.ruby = true
			end

			local tile = Tile(p.ruby)
			if tile:getItemCountById(i.redflame) < 1 then
				Game.createItem(i.redflame, 1, p.ruby)
			end
		end

		if item:getId() == lionrock.items.sapphire and toPosition.x == p.sapphire.x and toPosition.y == p.sapphire.y  and toPosition.z == p.sapphire.z then
			-- Sapphire
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You place the sapphire on the small socket. A blue flame begins to burn.")
				checkPr = true
			if lionrock.taskactive.sapphire ~= true then
				lionrock.taskactive.sapphire = true
			end

			local tile = Tile(p.sapphire)
			if tile:getItemCountById(i.blueflame) < 1 then
				Game.createItem(i.blueflame, 1, p.sapphire)
			end
		end

		if item:getId() == lionrock.items.amethyst and toPosition.x == p.amethyst.x and toPosition.y == p.amethyst.y  and toPosition.z == p.amethyst.z then
			-- Amethyst
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You place the topaz on the small socket. A yellow flame begins to burn.")
				checkPr = true
			if lionrock.taskactive.amethyst ~= true then
				lionrock.taskactive.amethyst = true
			end

			local tile = Tile(p.amethyst)
			if tile:getItemCountById(i.yellowflame) < 1 then
				Game.createItem(i.yellowflame, 1, p.amethyst)
			end
		end

		if item:getId() == lionrock.items.topaz and toPosition.x == p.topaz.x and toPosition.y == p.topaz.y  and toPosition.z == p.topaz.z then
			-- Topaz
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You place the amethyst on the small socket. A violet flame begins to burn.")
				checkPr = true
			if lionrock.taskactive.topaz ~= true then
				lionrock.taskactive.topaz = true
			end

			local tile = Tile(p.topaz)
			if tile:getItemCountById(i.violetflame) < 1 then
				Game.createItem(i.violetflame, 1, p.topaz)
			end
		end

		if checkPr == true then
			-- Adding the Fountain which gives present
			if lionrock.taskactive.ruby == true and lionrock.taskactive.sapphire == true and lionrock.taskactive.amethyst == true and lionrock.taskactive.topaz == true then
				local fountain = Game.createItem(i.rewardfountain, 1, { x=33073, y=32300, z=9})
				fountain:setActionId(41357)
				local stone = Tile({ x=33073, y=32300, z=9}):getItemById(3608)
				if stone ~= nil then
					stone:remove()
				end
				self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Something happens at the centre of the room ...");
			end

			-- Removing Item
			item:remove(1)
		end
	end
	---- LIONS ROCK END

	-- SSA exhaust
	local exhaust = { }
	if toPosition.x == CONTAINER_POSITION and toPosition.y == CONST_SLOT_NECKLACE and item:getId() == STONE_SKIN_AMULET then
		local pid = self:getId()
		if exhaust[pid] then
			self:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
			return false
		else
			exhaust[pid] = true
			addEvent(function() exhaust[pid] = false end, 2000, pid)
			return true
		end
	end

	-- Store Inbox
	local containerIdFrom = fromPosition.y - 64
	local containerFrom = self:getContainerById(containerIdFrom)
	if (containerFrom) then
		if (containerFrom:getId() == ITEM_STORE_INBOX and toPosition.y >= 1 and toPosition.y <= 11 and toPosition.y ~= 3) then
			self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
			return false
		end
	end

	local containerTo = self:getContainerById(toPosition.y-64)
	if (containerTo) then
		if (containerTo:getId() == ITEM_STORE_INBOX) then
			self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
			return false
		end
		-- Gold Pounch
		if (containerTo:getId() == GOLD_POUNCH) then
			if (not (item:getId() == ITEM_CRYSTAL_COIN or item:getId() == ITEM_PLATINUM_COIN or item:getId() == ITEM_GOLD_COIN)) then
				self:sendCancelMessage("You can move only money to this container.")
				return false
			end
		end
	end

	-- No move gold pounch
	if item:getId() == GOLD_POUNCH then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	-- No move items with actionID 8000
	if item:getActionId() == NOT_MOVEABLE_ACTION then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	-- Check two-handed weapons
	if toPosition.x ~= CONTAINER_POSITION then
		return true
	end

	if item:getTopParent() == self and bit.band(toPosition.y, 0x40) == 0 then
		local itemType, moveItem = ItemType(item:getId())
		if bit.band(itemType:getSlotPosition(), SLOTP_TWO_HAND) ~= 0 and toPosition.y == CONST_SLOT_LEFT then
			moveItem = self:getSlotItem(CONST_SLOT_RIGHT)
		elseif itemType:getWeaponType() == WEAPON_SHIELD and toPosition.y == CONST_SLOT_RIGHT then
			moveItem = self:getSlotItem(CONST_SLOT_LEFT)
			if moveItem and bit.band(ItemType(moveItem:getId()):getSlotPosition(), SLOTP_TWO_HAND) == 0 then
				return true
			end
		end

		if moveItem then
			local parent = item:getParent()
			if parent:getSize() == parent:getCapacity() then
				self:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM))
				return false
			else
				return moveItem:moveTo(parent)
			end
		end
	end

	-- Reward System
	if toPosition.x == CONTAINER_POSITION then
		local containerId = toPosition.y - 64
		local container = self:getContainerById(containerId)
		if not container then
			return true
		end

		-- Do not let the player insert items into either the Reward Container or the Reward Chest
		local itemId = container:getId()
		if itemId == ITEM_REWARD_CONTAINER or itemId == ITEM_REWARD_CHEST then
			self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			return false
		end

		-- The player also shouldn't be able to insert items into the boss corpse
		local tile = Tile(container:getPosition())
		for _, item in ipairs(tile:getItems() or { }) do
			if item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 and item:getName() == container:getName() then
				self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				return false
			end
		end
	end

	-- Do not let the player move the boss corpse.
	if item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return false
	end

	-- Players cannot throw items on reward chest
	local tile = Tile(toPosition)
	if tile and tile:getItemById(ITEM_REWARD_CHEST) then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	-- Players cannot throw items on teleports
	if blockTeleportTrashing and toPosition.x ~= CONTAINER_POSITION then
		local thing = Tile(toPosition):getItemByType(ITEM_TYPE_TELEPORT)
		if thing then
			self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
			self:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
	end

	-- No move parcel very heavy
	if item:getWeight() > 90000 and item:getId() == ITEM_PARCEL then
		self:sendCancelMessage('YOU CANNOT MOVE PARCELS TOO HEAVY.')
		return false
	end

	if tile and tile:getItemById(370) then -- Trapdoor
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if not antiPush(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder) then
		return false
	end

	return true
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	return true
end

-- Temporal disable
--[[function Player:onReportRuleViolation(targetName, reportType, reportReason, comment, translation)
	local name = self:getName()
	local pendingReport = function () local f = io.open(string.format("data/reports/players/%s-%s-%d.txt", name, targetName, reportType), "r") ; if f then io.close(f) return true else return false end end
	if pendingReport() then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your report is being processed.")
		return
	end

	local file = io.open(string.format("data/reports/players/%s-%s-%d.txt", name, targetName, reportType), "a")
	if not file then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There was an error when processing your report, please contact a gamemaster.")
		return
	end

	io.output(file)
	io.write("------------------------------\n")
	io.write("Complainter: " .. name .. "\n")
	io.write("Reported: " .. targetName .. "\n")
	io.write("Type: " .. reportType .. "\n")
	io.write("Reason: " .. reportReason .. "\n")
	io.write("Comment: " .. comment .. "\n")
	if reportType ~= REPORT_TYPE_BOT then
		io.write("Translation: " .. translation .. "\n")
	end
	io.write("------------------------------\n")
	io.close(file)
	self:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Thank you for reporting %s. Your report will be processed by %s team as soon as possible.", targetName, configManager.getString(configKeys.SERVER_NAME)))
	return
end]]

function Player:onReportBug(message, position, category)
	local name = self:getName()
	local file = io.open("data/reports/bugs/" .. name .. " report.txt", "a")

	if not file then
		self:sendTextMessage(MESSAGE_EVENT_DEFAULT, "There was an error when processing your report, please contact a gamemaster.")
		return true
	end

	io.output(file)
	io.write("------------------------------\n")
	io.write("Name: " .. name)
	if category == BUG_CATEGORY_MAP then
		io.write(" [Map position: " .. position.x .. ", " .. position.y .. ", " .. position.z .. "]")
	end
	local playerPosition = self:getPosition()
	io.write(" [Player Position: " .. playerPosition.x .. ", " .. playerPosition.y .. ", " .. playerPosition.z .. "]\n")
	io.write("Comment: " .. message .. "\n")
	io.close(file)

	self:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Your report has been sent to " .. configManager.getString(configKeys.SERVER_NAME) .. ".")
	return true
end

function Player:onTurn(direction)
	if self:getGroup():getAccess() and self:getDirection() == direction then
		local nextPosition = self:getPosition()
		nextPosition:getNextPosition(direction)

		self:teleportTo(nextPosition, true)
	end

	return true
end

function Player:onTradeRequest(target, item)
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	return true
end

local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
soulCondition:setTicks(4 * 60 * 1000)
soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)

function useStaminaImbuing(playerId, itemuid)
	local player = Player(playerId)
	if not player then
		return false
	end

	local item = Item(itemuid)
	if not item then
		return false
	end

	for i = 1, item:getType():getImbuingSlots() do
		if (item:isActiveImbuement(i+3)) then
			local staminaMinutes = item:getSpecialAttribute(i+3)/60
			if (staminaMinutes > 0) then
				local currentTime = os.time()
				local timePassed = currentTime - item:getSpecialAttribute(i+6)
				if timePassed > 0 then
					if timePassed > 60 then
						if staminaMinutes > 2 then
							staminaMinutes = staminaMinutes - 2
						else
							staminaMinutes = 0
						end

						item:setSpecialAttribute(i+6, currentTime + 120)
					else
						staminaMinutes = staminaMinutes - 1
						item:setSpecialAttribute(i+6, currentTime + 60)
					end
				end

				item:setSpecialAttribute(i+3, staminaMinutes*60)
				if (staminaMinutes <= 0) then
					player:removeCondition(CONDITION_HASTE, item:getId() + i)
					player:removeCondition(CONDITION_ATTRIBUTES, item:getId() + i)
					item:setSpecialAttribute(i, 0, i+3, 0, i+6, 0)
				end
			end
		end
	end
end

local function useStamina(player)
	local staminaMinutes = player:getStamina()
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	local currentTime = os.time()
	local timePassed = currentTime - nextUseStaminaTime[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseStaminaTime[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseStaminaTime[playerId] = currentTime + 60
	end
	player:setStamina(staminaMinutes)
end

local function useStaminaXp(player)
	local staminaMinutes = player:getExpBoostStamina() / 60
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	local currentTime = os.time()
	local timePassed = currentTime - nextUseXpStamina[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseXpStamina[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseXpStamina[playerId] = currentTime + 60
	end
	player:setExpBoostStamina(staminaMinutes * 60)
end

-- useStaminaPrey
local function useStaminaPrey(player, name)
	for i = 1, 3 do
		if (player:isActiveByName(i-1, name)) then
			local staminaMinutes = player:getPreyStamina(i-1)/60
			if (staminaMinutes > 0) then
				local playerId = player:getId()+i
				local currentTime = os.time()
				local timePassed = currentTime - nextUseStaminaPrey[playerId].Time
				if timePassed > 0 then
					if timePassed > 60 then
						if staminaMinutes > 2 then
							staminaMinutes = staminaMinutes - 2
						else
							staminaMinutes = 0
						end

						nextUseStaminaPrey[playerId].Time = currentTime + 120
					else
						staminaMinutes = staminaMinutes - 1
						nextUseStaminaPrey[playerId].Time = currentTime + 60
					end
				end

				player:setPreyStamina(i-1, staminaMinutes*60)
				player:sendPreyTimeLeft(i-1, staminaMinutes*60)
			end
		end
	end
end

function Player:onUseWeapon(normalDamage, elementType, elementDamage)
	-- Imbuement
	local weapon = self:getSlotItem(CONST_SLOT_LEFT)
	if not weapon or weapon:getType():getWeaponType() == WEAPON_SHIELD then
		weapon = self:getSlotItem(CONST_SLOT_RIGHT)
		if not weapon or weapon:getType():getWeaponType() == WEAPON_SHIELD then
			weapon = nil
		end
	end

	for slot = 1, 10 do
		local nextEquip = self:getSlotItem(slot)
		if nextEquip and nextEquip:getType():getImbuingSlots() > 0 then
			for i = 1, nextEquip:getType():getImbuingSlots() do
				local slotEnchant = nextEquip:getSpecialAttribute(i)
				if (slotEnchant) then
					local percentDamage, enchantPercent = 0, nextEquip:getImbuementPercent(slotEnchant)
					local typeEnchant = nextEquip:getImbuementType(i) or ""
					if (typeEnchant ~= "" and typeEnchant ~= "skillShield" and not typeEnchant:find("absorb") and typeEnchant ~= "speed") then
						useStaminaImbuing(self:getId(), nextEquip:getUniqueId())
					end

					if (typeEnchant ~= "hitpointsleech" and typeEnchant ~= "manapointsleech" and typeEnchant ~= "criticaldamage" 
						and typeEnchant ~= "skillShield" and typeEnchant ~= "magiclevelpoints" and not typeEnchant:find("absorb") and typeEnchant ~= "speed") then
						local weaponType = nextEquip:getType():getWeaponType()
						if weaponType ~= WEAPON_NONE and weaponType ~= WEAPON_SHIELD and weaponType ~= WEAPON_AMMO then
							percentDamage = normalDamage*(enchantPercent/100)
							normalDamage = normalDamage - percentDamage
							elementDamage = nextEquip:getType():getAttack()*(enchantPercent/100)
						end
					end

					if (typeEnchant == "hitpointsleech") then
						local healAmountHP = normalDamage*(enchantPercent/100)
						self:addHealth(math.abs(healAmountHP))
					elseif (typeEnchant == "manapointsleech") then
						local healAmountMP = normalDamage*(enchantPercent/100)
						self:addMana(math.abs(healAmountMP))
					end

					if (typeEnchant == "firedamage") then
						elementType = COMBAT_FIREDAMAGE
					elseif (typeEnchant == "earthdamage") then
						elementType = COMBAT_EARTHDAMAGE
					elseif (typeEnchant == "icedamage") then
						elementType = COMBAT_ICEDAMAGE
					elseif (typeEnchant == "energydamage") then
						elementType = COMBAT_ENERGYDAMAGE
					elseif (typeEnchant == "deathdamage") then
						elementType = COMBAT_DEATHDAMAGE
					end
				end
			end
		end
	end
	
	return normalDamage, elementType, elementDamage
end

function Player:onCombatSpell(normalDamage, elementDamage, elementType, changeDamage)
	-- Imbuement
	local weapon = self:getSlotItem(CONST_SLOT_LEFT)
	if not weapon or weapon:getType():getWeaponType() == WEAPON_SHIELD then
		weapon = self:getSlotItem(CONST_SLOT_RIGHT)
		if not weapon or weapon:getType():getWeaponType() == WEAPON_SHIELD then
			weapon = nil
		end
	end

	if normalDamage < 0 then
		for slot = 1, 10 do
			local nextEquip = self:getSlotItem(slot)
			if nextEquip and nextEquip:getType():getImbuingSlots() > 0 then
				for i = 1, nextEquip:getType():getImbuingSlots() do
					local slotEnchant = nextEquip:getSpecialAttribute(i)
					if (slotEnchant and type(slotEnchant) == 'string') then
						local percentDamage, enchantPercent = 0, nextEquip:getImbuementPercent(slotEnchant)
						local typeEnchant = nextEquip:getImbuementType(i) or ""
						if (typeEnchant ~= "" and typeEnchant ~= "skillShield" and not typeEnchant:find("absorb") and typeEnchant ~= "speed") then
							useStaminaImbuing(self:getId(), nextEquip:getUniqueId())
						end

						if (typeEnchant == "firedamage" or typeEnchant == "earthdamage" or typeEnchant == "icedamage" or typeEnchant == "energydamage" or typeEnchant == "deathdamage") then
							local weaponType = nextEquip:getType():getWeaponType()
							if weaponType ~= WEAPON_NONE and weaponType ~= WEAPON_SHIELD and weaponType ~= WEAPON_AMMO then
								percentDamage = normalDamage*(enchantPercent/100)
								normalDamage = normalDamage - percentDamage
								elementDamage = nextEquip:getType():getAttack()*(enchantPercent/100)
							end
						end

						if (typeEnchant == "firedamage") then
							elementType = COMBAT_FIREDAMAGE
						elseif (typeEnchant == "earthdamage") then
							elementType = COMBAT_EARTHDAMAGE
						elseif (typeEnchant == "icedamage") then
							elementType = COMBAT_ICEDAMAGE
						elseif (typeEnchant == "energydamage") then
							elementType = COMBAT_ENERGYDAMAGE
						elseif (typeEnchant == "deathdamage") then
							elementType = COMBAT_DEATHDAMAGE
						end
					end
				end
			end
		end
	end

	return normalDamage, elementDamage, elementType, changeDamage
end

function Player:onMove()
	if getTilePzInfo(getCreaturePosition(self)) then
			self:setTarget(nil)
			self:setFollowCreature(nil)
		return true
		end
	local haveImbuingBoots = self:getSlotItem(CONST_SLOT_FEET) and self:getSlotItem(CONST_SLOT_FEET):getType():getImbuingSlots() or 0
	if haveImbuingBoots > 0 then
		local bootsItem = self:getSlotItem(CONST_SLOT_FEET)
		for slot = 1, haveImbuingBoots do
			local slotEnchant = bootsItem:getSpecialAttribute(slot)
			if (slotEnchant and type(slotEnchant) == 'string') then
				local typeEnchant = bootsItem:getImbuementType(slot) or ""
				if (typeEnchant == "speed") then
					useStaminaImbuing(self:getId(), bootsItem:getUniqueId())
				end
			end
		end
	end
	return true
end

function Player:onEquipImbuement(item)
	local itemType = item:getType()
	for i = 1, itemType:getImbuingSlots() do
		local slotEnchant = item:getSpecialAttribute(i)
		if (slotEnchant and type(slotEnchant) == 'string') then
			conditionHaste = Condition(CONDITION_HASTE, item:getId() + i)
			conditionSkill = Condition(CONDITION_ATTRIBUTES, item:getId() + i)
			local skillValue = item:getImbuementPercent(slotEnchant)
			local typeEnchant = item:getImbuementType(i) or ""
			if (typeEnchant == "skillSword") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_SWORD, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "skillAxe") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_AXE, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "skillClub") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_CLUB, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "skillDist") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_DISTANCE, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "skillShield") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_SHIELD, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "magiclevelpoints") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "speed") then
				conditionHaste:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionHaste:setParameter(CONDITION_PARAM_SPEED, self:getSpeed() * (skillValue/100))
				self:addCondition(conditionHaste)
			elseif (typeEnchant == "criticaldamage") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 10)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "hitpointsleech") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 100)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, skillValue)
				self:addCondition(conditionSkill)
			elseif (typeEnchant == "manapointsleech") then
				conditionSkill:setParameter(CONDITION_PARAM_TICKS, -1)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 100)
				conditionSkill:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, skillValue)
				self:addCondition(conditionSkill)
			end
		end
	end

	return true
end

function Player:onDeEquipImbuement(item)
	for i = 1, item:getType():getImbuingSlots() do
		self:removeCondition(CONDITION_HASTE, item:getId() + i)
		self:removeCondition(CONDITION_ATTRIBUTES, item:getId() + i)
	end

	return true
end

function Player:onGainExperience(source, exp, rawExp)
	if not source or source:isPlayer() then
		return exp
	end
	-- experience boost
	local xboost = math.max(self:getStorageValue(61921) - os.time(), 0)
	if xboost == 0 then
	else
	exp = exp * 1.30
	end
	-- Soul regeneration
	local vocation = self:getVocation()
	if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
		soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks() * 1000)
		self:addCondition(soulCondition)
	end

	-- Apply experience stage multiplier
	exp = exp * Game.getExperienceStage(self:getLevel())
	for i = 1, 3 do
		if (self:isActive(i-1)) then
			local bonusInfo = self:getBonusInfo(i-1)
			if (bonusInfo.Type == 2 and source:getName() == bonusInfo.Name) then
				exp = exp + math.floor(exp * (bonusInfo.Value/100))
				break
			end
		end
	end

	if (self:getExpBoostStamina() <= 0 and self:getStoreXpBoost() > 0) then
		self:setStoreXpBoost(0) -- reset xp boost to 0
	end

	-- More compact, after checking before (reset) it only of xp if you have
	if (self:getStoreXpBoost() > 0) then
		exp = exp + (exp * (self:getStoreXpBoost()/100)) -- Exp Boost
	end

	local party = self:getParty()
	if (party) then
		if (party:isSharedExperienceActive() and
			party:isSharedExperienceEnabled()) then
			local tableVocs = {}
			local count = 0
			local totalCount = 0
			local leaderId = party:getLeader():getVocation():getId()
			if (leaderId) then
				tableVocs[leaderId] = 1
				count = count + 1
				totalCount = totalCount + 1
			end
			for i, v in pairs(party:getMembers()) do
				local vocId = v:getVocation():getId()
				if (tableVocs[vocId] == nil) then
					tableVocs[vocId] = 1
					count = count + 1
				end
				totalCount = totalCount + 1
			end

			if (totalCount <= 10 and
				count >= 4) then
				exp = exp * 2
			end
		end
	end

	-- Prey Stamina Modifier
	useStaminaPrey(self, source:getName())

	-- Exp Boost Modifier
	useStaminaXp(self)

	-- Exp stats
	local staminaMinutes = self:getStamina()
	local Boost = self:getExpBoostStamina()
	if staminaMinutes > 2400 and self:isPremium() and Boost > 0 then
		self:setBaseXpGain(200) -- 200 = 1.0x, 200 = 2.0x, ... premium account		
	elseif staminaMinutes > 2400 and self:isPremium() and Boost <= 0 then
		self:setBaseXpGain(150) -- 150 = 1.0x, 150 = 1.5x, ... premium account	
	elseif staminaMinutes <= 2400 and staminaMinutes > 840 and self:isPremium() and Boost > 0 then
		self:setBaseXpGain(150) -- 150 = 1.5x		premium account
	elseif staminaMinutes > 840 and Boost > 0 then
		self:setBaseXpGain(150) -- 150 = 1.5x		free account
	elseif staminaMinutes <= 840 and Boost > 0 then
		self:setBaseXpGain(100) -- 50 = 0.5x	all players	
	elseif staminaMinutes <= 840 then
		self:setBaseXpGain(50) -- 50 = 0.5x	all players	
	end

	-- Stamina modifier
	if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		useStamina(self)

		local staminaMinutes = self:getStamina()
		if staminaMinutes > 2400 and self:isPremium() then
			exp = exp * 1.5
		elseif staminaMinutes <= 840 then
			exp = exp * 0.5
		end
	end

	return exp
end

function Player:onLoseExperience(exp)
	return exp
end

function Player:onGainSkillTries(skill, tries)
	local timer = 0
	local ganho = 1 -- manter 1 aqui
	local vocation = self:getVocation():getBase():getId()
	local melee, x, magic, z = {}, {}, {}, {}
	
	if vocation == 1 then -- sorcerer
		magic, z = {0, 20, 40, 60, 80}, {16, 12, 10, 9, 8}
		melee, x = {10, 15, 20, 30, 40}, {60, 50, 40, 35, 30}
	elseif vocation == 2 then -- druid
		magic, z = {0, 20, 40, 60, 80}, {16, 12, 10, 9, 8}
		melee, x = {10, 15, 20, 30, 40}, {60, 50, 40, 35, 30}
	elseif vocation == 3 then -- paladin
		magic, z = {0, 6, 10, 16, 20}, {16, 12, 10, 9, 8}
		melee, x = {10, 40, 60, 80, 100}, {60, 55, 50, 45, 30}
	elseif vocation == 4 then -- knight
		magic, z = {0, 3, 5, 8, 10}, {16, 12, 10, 9, 8}
		melee, x = {10, 40, 60, 80, 100}, {60, 55, 50, 45, 30}
	else --rookgaard or others
		magic, z = {0, 20, 40, 60, 80}, {8, 8, 8, 8, 8}
		melee, x = {10, 40, 60, 80, 100}, {30, 30, 30, 30, 30}
	end
		
	if APPLY_SKILL_MULTIPLIER == false then
		return tries
	end
	
	if skill == SKILL_MAGLEVEL then
		local playerml = getPlayerMagLevel(self)
		for i = 1, #magic do
			if playerml >= magic[i] then
				timer = timer + 1
			end
		end
		if timer >= 1 then
			ganho = z[timer]
		end
		return (tries * ganho)
	end
	
	local playerme = self:getSkillLevel(skill)
	for i = 1, #melee do
		if playerme >= melee[i] then
			timer = timer + 1
		end
	end
	if timer >= 1 then
		ganho = x[timer]
	end
	return (tries * ganho)
end
