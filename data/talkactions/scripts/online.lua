function onSay(player, words, param)
	local hasAccess = player:getGroup():getAccess()
	local players = Game.getPlayers()
	local playerCount = Game.getPlayerCount()+46 -- spoofing
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (130)') --1
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (133)') --2
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (137)') --3
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (138)') --4
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (139)') --5
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (140)') --6
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (141)') --7
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (142)') --8
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (143)') --9
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (144)') --10
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (145)') --11
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (146)') --12
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (147)') --13
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (148)') --14
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (149)') --15
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (150)') --16
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (151)') --17
	
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (152)') --18
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (153)') --19
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (154)') --20
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (155)') --21
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (156)') --22
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (157)') --23
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (158)') --24
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (160)') --25
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (161)') --26
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (162)') --27
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (163)') --28
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (164)') --29
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (165)') --30
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (166)') --31
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (167)') --32
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (168)') --33
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (169)') --34
	
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (170)') --35
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (171)') --36
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (172)') --37
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (173)') --38
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (174)') --39
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (175)') --40
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (176)') --41
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (177)') --42
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (178)') --43
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (179)') --44
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (180)') --45
	db.asyncQuery('INSERT INTO `players_online` (`player_id`) VALUES (181)') --46
	

	player:sendTextMessage(MESSAGE_INFO_DESCR, playerCount .. " players online.")

	--local i = 0
--	local msg = ""
	--for k, targetPlayer in ipairs(players) do
	--	if hasAccess or not targetPlayer:isInGhostMode() then
	--		if i > 0 then
	--	--		msg = msg .. ", "
	--		end
	--		msg = msg .. targetPlayer:getName() .. " [" .. targetPlayer:getLevel() .. "]"
	--		i = i + 1
	--	end

	--	if i == 10 then
			--if k == playerCount then
		--		msg = msg .. "."
		--	else
		--		msg = msg .. ","
		--	end
		--	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, msg)
		----	msg = ""
		--	i = 0
		--end
	--end

	--if i > 0 then
	--	msg = msg .. "."
	--	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, msg)
	--end
	return false
end
 