local STORAGE = 61920
local STORAGE2 = 61921
function onSay(player, words, param)
 local cur = math.max(player:getStorageValue(STORAGE) - os.time(), 0)
 local cur2 = math.max(player:getStorageValue(STORAGE2) - os.time(), 0)
 if cur == 0 and cur2 == 0 then
  player:sendTextMessage(MESSAGE_INFO_DESCR, "You have no Regen Boost time left.")
  return false
 end
 local days = math.floor(cur / (60 * 60 * 24))
 cur = cur - days * 60 * 60 * 24
 local hours = math.floor(cur / (60 * 60))
 cur = cur - hours * 60 * 60
 local minutes = math.floor(cur / 60)
 --player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have %d days, %d hours and %d minutes left on Regen Boost.", days, hours, minutes))
 local days2 = math.floor(cur / (60 * 60 * 24))
 cur = cur2 - days2 * 60 * 60 * 24
 local hours2 = math.floor(cur / (60 * 60))
 cur2 = cur2 - hours2 * 60 * 60
 local minutes2 = math.floor(cur2 / 60)
 player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have %d days, %d hours and %d minutes left on Regen Boost. You have %d days, %d hours and %d minutes left on Exp Boost.", days, hours, minutes, days2, hours2, minutes2))
 return false
end
