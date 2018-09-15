function onSay(player, words, param)
	local timer, timer2, timer3, timer4, timer5, timer6, timer7, timer8 = 0, 0, 0, 0, 0, 0, 0, 0, 0
	local ganho, ganho2, ganho3, ganho4, ganho5, ganho6, ganho7, ganho8 = 1, 1, 1, 1, 1, 1, 1, 1, 1 -- manter 1 aqui
	local vocation = player:getVocation():getBase():getId()
	local melee, x, magic, z = {}, {}, {}, {}
	local playerml = getPlayerMagLevel(player)
	local player0 = player:getSkillLevel(0)
	local player1 = player:getSkillLevel(1)
	local player2 = player:getSkillLevel(2)
	local player3 = player:getSkillLevel(3)
	local player4 = player:getSkillLevel(4)
	local player5 = player:getSkillLevel(5)
	local player6 = player:getSkillLevel(6)
	
	
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
	
	for i = 1, #magic do
			if playerml >= magic[i] then
			timer = timer + 1
			end
	end
	if timer >= 1 then
		ganho = z[timer]
	end
	for i = 1, #melee do
			if player0 >= melee[i] then
				timer2 = timer2 + 1
			end
			if player1 >= melee[i] then
			timer3 = timer3 + 1
			end
			if player2 >= melee[i] then
			timer4 = timer4 + 1
			end
			if player3 >= melee[i] then
			timer5 = timer5 + 1
			end
			if player4 >= melee[i] then
			timer6 = timer6 + 1
			end
			if player5 >= melee[i] then
			timer7 = timer7 + 1
			end
			if player6 >= melee[i] then
			timer8 = timer8 + 1
			end
			
	end
	if timer2 >= 1 then
		ganho2 = x[timer2]
	end
	if timer3 >= 1 then
		ganho3 = x[timer3]
	end
	if timer4 >= 1 then
		ganho4 = x[timer4]
	end
	if timer5 >= 1 then
		ganho5 = x[timer5]
	end
	if timer6 >= 1 then
		ganho6 = x[timer6]
	end
	if timer7 >= 1 then
		ganho7 = x[timer7]
	end
	if timer8 >= 1 then
		ganho8 = x[timer8]
	end
	
	mlrate = ganho
	
	
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Server Info:"
					.. " Exp: " .. Game.getExperienceStage(player:getLevel())
					.. " Fist: " .. ganho2
					.. " Club: " .. ganho3
					.. " Sword " .. ganho4
					.. " Axe: " .. ganho5
					.. " Distance: " .. ganho6
					.. " Shielding: " .. ganho7
					.. " Fishing: " .. ganho8
					.. " Magic: " .. mlrate
					.. " Loot: " .. configManager.getNumber(configKeys.RATE_LOOT))
	return false
end
