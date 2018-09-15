function onSay(player, words, param)
local resultId = db.storeQuery("SELECT `id` FROM `players` WHERE `name` = " .. db.escapeString(player:getName():lower()))
local accountId = result.getDataInt(resultId, "id")
		
	
		--db.query("UPDATE `players` SET lastlogin = 'os.time()' WHERE `players`.`id` = " .. accountId)



--local cur = (os.time() - player:getLastLoginSaved())
local cur = math.max(os.time() - player:getLastLoginSaved(), 0)
local timer = player:getStorageValue(250129)

if cur > 1800 then
cur = 1800
end
local days = math.floor(cur / (60 * 60 * 24))
 cur = cur - days * 60 * 60 * 24
 local hours = math.floor(cur / (60 * 60))
 cur = cur - hours * 60 * 60
 local minutes = math.floor(cur / 60)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'timer: "' .. timer .. '".')	
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have %d days, %d hours and %d minutes online. debug %d", days, hours, minutes, cur))
end