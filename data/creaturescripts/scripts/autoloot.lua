local function scanContainer(cid, position)
    local player = Player(cid)
    if not player then
        return
    end

    local corpse = Tile(position):getTopDownItem()
    if not corpse or not corpse:isContainer() then
        return
    end

    if corpse:getType():isCorpse() and corpse:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == cid then
        
		for i = corpse:getSize() - 1, 0, -1 do
            local containerItem = corpse:getItem(i)
            if containerItem then
                for i = AUTOLOOT_STORAGE_START, AUTOLOOT_STORAGE_END do
                    if player:getStorageValue(i) == containerItem:getId() then
                        containerItem:moveTo(player)
						if player:getStorageValue(i) == containerItem:getId() and containerItem:getId() == 2148 and player:getItemCount(2148) >= 100 then --if player:getItemCount(2148) >= 100 then
						player:removeItem(2148, 100)
						player:addItem(2152, 1)
						end
						if player:getStorageValue(i) == containerItem:getId() and containerItem:getId() == 2152 and player:getItemCount(2152) >= 100 then --if player:getItemCount(2148) >= 100 then
						player:removeItem(2152, 100)
						player:addItem(2160, 1)
						end
                    end
                end
            end
        end
    end
end

function onKill(player, target)
    if not target:isMonster() then
        return true
    end

    addEvent(scanContainer, 100, player:getId(), target:getPosition())
    return true
end