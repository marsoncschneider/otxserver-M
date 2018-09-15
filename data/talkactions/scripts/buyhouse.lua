local lvl_to_buy_house = 50

function onSay(player, words, param)
	local housePrice = configManager.getNumber(configKeys.HOUSE_PRICE)
	if housePrice == -1 then
		return true
	end
		
	if player:getLevel() < lvl_to_buy_house then
           player:sendCancelMessage("Você precisa ser level "..lvl_to_buy_house.." para alugar uma casa.")
        return false
    end
	
	if not player:isPremium() then
		player:sendCancelMessage("Você precisa de uma conta premium para alugar a casa.")
		return false
	end
	
	local position = player:getPosition()
	position:getNextPosition(player:getDirection())

	local tile = Tile(position)
	local house = tile and tile:getHouse()
	
	if not house then
		player:sendCancelMessage("Por favor fique de frente para a porta da casa que gostaria de alugar.")
		return false
	end
	
	if house == player:getHouse() then
		player:sendCancelMessage("Você já é dono de uma casa.")
		return false
	end
	
	if house:getOwnerGuid() > 0 then
		player:sendCancelMessage("Esta casa já tem um dono.")
		return false
	end
	
	if player:getHouse() then
		player:sendCancelMessage("Você alugou " .. player:getHouse():getName() .. ".")
		return false
	end

	local price = tonumber(house:getTileCount() * housePrice)
	
	if (player:getBankBalance() >= price) then
		player:setBankBalance(player:getBankBalance() - price)
		if house:getOwnerGuid(0) then
			house:setOwnerGuid(120)
			if house:getOwnerGuid(120) then
				house:setOwnerGuid(player:getGuid())
			end
		end
		
		
		local rentPeriod = configManager.getString(configKeys.HOUSE_RENT_PERIOD)
	
		if rentPeriod ~= "never" then
			rentString = " Esteja certo em ter " .. price .. " ouro em sua conta no banco " .. rentPeriod .. " alugada."
		else
			rentString = ""
		end
		
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você comprou " .. house:getName(tile) .. " por " .. price .. " ouro de sua conta bancária." .. rentString)
		return true
	
	
	
	elseif (player:getMoney() >= price) then
		player:removeMoney(price)
		if house:getOwnerGuid(0) then
			house:setOwnerGuid(120)
			if house:getOwnerGuid(120) then
				house:setOwnerGuid(player:getGuid())
			end
		end
		
		
		local rentPeriod = configManager.getString(configKeys.HOUSE_RENT_PERIOD)
	
		if rentPeriod ~= "never" then
			rentString = " Esteja certo em ter " .. price .. " ouro em sua conta no banco " .. rentPeriod .. " alugada."
		else
			rentString = ""
		end
		
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você comprou " .. house:getName(tile) .. " por " .. price .. " ouro." .. rentString)
		return true
		else
		player:sendCancelMessage("Você não tem dinheiro suficiente.")
		return false
	end
	
	return false
end
