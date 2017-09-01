function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local chess = item:getUniqueId()
	--knight
	if chess == 61900 and player:getStorageValue(61900) ~= 1 then
	player:setStorageValue(61900, 1)
	player:addItem(2481, 1)
	elseif chess == 61901 and player:getStorageValue(61901) ~= 1 then
	player:setStorageValue(61901, 1)
	player:addItem(2465, 1)
	elseif chess == 61902 and player:getStorageValue(61902) ~= 1 then
	player:setStorageValue(61902, 1)
	player:addItem(2478, 1)
	elseif chess == 61903 and player:getStorageValue(61903) ~= 1 then
	player:setStorageValue(61903, 1)
	player:addItem(2509, 1)
	--paladin
	elseif chess == 61907 and player:getStorageValue(61907) ~= 1 then
	player:setStorageValue(61907, 1)
	player:addItem(2660, 1)
	elseif chess == 61908 and player:getStorageValue(61908) ~= 1 then
	player:setStorageValue(61908, 1)
	player:addItem(8923, 1)
	elseif chess == 61909 and player:getStorageValue(61909) ~= 1 then
	player:setStorageValue(61909, 1)
	player:addItem(2456, 1)
	elseif chess == 61910 and player:getStorageValue(61910) ~= 1 then
	player:setStorageValue(61910, 1)
	player:addItem(23839, 100)
	--sorcerer
	elseif chess == 61911 and player:getStorageValue(61911) ~= 1 then
	player:setStorageValue(61902, 1)
	player:addItem(2175, 1)
	elseif chess == 61912 and player:getStorageValue(61912) ~= 1 then
	player:setStorageValue(61912, 1)
	player:addItem(2190, 1)
	elseif chess == 61913 and player:getStorageValue(61913) ~= 1 then
	player:setStorageValue(61913, 1)
	player:addItem(8820, 1)
	elseif chess == 61914 and player:getStorageValue(61914) ~= 1 then
	player:setStorageValue(61914, 1)
	player:addItem(8819, 1)
	--druid
	elseif chess == 61915 and player:getStorageValue(61915) ~= 1 then
	player:setStorageValue(61915, 1)
	player:addItem(2175, 1)
	elseif chess == 61916 and player:getStorageValue(61916) ~= 1 then
	player:setStorageValue(61916, 1)
	player:addItem(2180, 1)
	elseif chess == 61917 and player:getStorageValue(61917) ~= 1 then
	player:setStorageValue(61917, 1)
	player:addItem(8820, 1)
	elseif chess == 61918 and player:getStorageValue(61918) ~= 1 then
	player:setStorageValue(61917, 1)
	player:addItem(8819, 1)
	end
	return true
end