local function doCheckHouses()

    local dias = 5
    local tempo = os.time() - (dias * 24 * 60 * 60) 
    local registros = db.storeQuery("SELECT `houses`.`owner`, `houses`.`id` FROM `houses`,`players` WHERE `houses`.`owner` != 0 AND `houses`.`owner` = `players`.`id` AND `players`.`lastlogin` <= " .. tempo .. ";")
    
    if registros ~= false then
    
        local count = 0
        
        print('house leave code')
        
        repeat
            count = count + 1
            
            local owner = result.getNumber(registros, "owner")
            local houseId = result.getNumber(registros, "id")
            local house = House(houseId)
            
            if house and (owner > 0) then
                print(house:getName())
                house:setOwnerGuid(0)
            end
            
        until not result.next(registros)
        
        print('house leave house count:' .. count)
        
        result.free(registros)
    end
	--[[if registros == false then
    registros = db.storeQuery("SELECT  `houses`.`owner` ,  `houses`.`id` FROM  `houses` ,  `players` WHERE NOT  `houses`.`owner`;")
        local count = 0
        
        print('LIMPANDO A PORRA DAS HOUSES SEM DONO')
        
        repeat
            count = count + 1
            
            local owner = result.getNumber(registros, "owner")
            local houseId = result.getNumber(registros, "id")
            local house = House(houseId)
            
            if house then
                --print(house:getName())
				
                --house:setOwnerGuid(0)
				if house:getOwnerGuid(0) then
				house:setOwnerGuid(6)
				--print('ALTERADO PRA 6')
				if house:getOwnerGuid(6) then
				house:setOwnerGuid(0)
				--print('ALTERADO PRA 0')
				end
				end
				
				--house:kickPlayer()
				
            end
            
        until not result.next(registros)
        
        print('CASAS LIMPAS:' .. count)
        
        result.free(registros)
    end]]
end

function onStartup()
    addEvent(doCheckHouses, 10 * 1000)
    
    return true
end
function onThink(interval)
addEvent(doCheckHouses, 1 * 1000)
    
    return true
end