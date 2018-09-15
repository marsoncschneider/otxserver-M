function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local brinde = {2152, 2160}
	local choice = math.random(#brinde)
	local multi = {100, 10}
	local x
	
	if choice then
	x = math.random(0, multi[choice])
	end
	
	--local x = 1
	if not player or not player:isPlayer() then
		return true
	end
	
	if item.itemid == item.itemid then
		if item.actionid == 2017 then
			if true then
			--local wow = brinde[choice]
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				
					local edited
					edited = player:addItem(brinde[choice], x) 
				
				
				player:sendTextMessage(MESSAGE_INFO_DESCR, "Parabens! voce ganhou ".. x .." ".. edited:getType():getName() .. "!")
				item:remove()
			end
		end		
	return true
end
end