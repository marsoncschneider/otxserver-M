local table =
{	-- [level] = type = "item", id = {ITEM_ID, QTD}, msg = "MSG"},
	-- [level] = type = "bank", id = {QTD, 0}, msg = "MSG"},
	-- [level] = type = "addon", id = {ID_ADDON_FEMALE, ID_ADDON_MALE}, msg = "MSG"},
	-- [level] = type = "mount", id = {ID_MOUNT, 0}, msg = "MSG"},	
	
	[2] = {type = "item", id = {9931, 1}, msg = "You have received one Regeneration Shoes for advancing to level 2."},
	[7] = {type = "bank", id = {10000, 0}, msg = "You have received 10000 gold in your bank for advancing to Level 7."},
	[8] = {type = "mount", id = {13, 0}, msg = "You have received a Donkey Mount for advancing to Level 8."},
	[9] = {type = "item", id = {28577, 500}, msg = "You have received a health potion keg for advancing to Level 9."},
	[10] = {type = "item", id = {28582, 500}, msg = "You have received a mana potion keg for advancing to Level 10."},
	[20] = {type = "bank", id = {20000, 0}, msg = "You have received 20000 gold in your bank for advancing to Level 20."},
	[50] = {type = "bank", id = {10000, 0}, msg = "You have received 10000 gold in your bank for advancing to Level 50."},
	[75] = {type = "bank", id = {10000, 0}, msg = "You have received 10000 gold in your bank for advancing to Level 75."},
	[80] = {type = "mount", id = {35, 0}, msg = "You have received a Water Buffalo mount for advancing to Level 80."},
	[150] = {type = "item", id = {5942, 1}, msg = "You have received one blessed wooden stake because you reached level 150."},
	[200] = {type = "item", id = {2195, 1}, msg = "You have been awarded with 1 boots of haste for reaching level 200."},
}

local storage = 99963

function onAdvance(player, skill, oldLevel, newLevel)

	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return true
	end

	for level, _ in pairs(table) do
		if newLevel >= level and player:getStorageValue(storage) < level then
			if table[level].type == "item" then	
				player:addItem(table[level].id[1], table[level].id[2])
			elseif table[level].type == "bank" then
				player:setBankBalance(player:getBankBalance() + table[level].id[1])
			elseif table[level].type == "addon" then
				player:addOutfitAddon(table[level].id[1], 3)
				player:addOutfitAddon(table[level].id[2], 3)
			elseif table[level].type == "mount" then
				player:addMount(table[level].id[1])
			else
				return false
			end

			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, table[level].msg)
			player:setStorageValue(storage, level)
		end
	end

	player:save()

	return true
end