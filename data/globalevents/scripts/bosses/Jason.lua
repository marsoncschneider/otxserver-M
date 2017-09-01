local BOSSee = "Jason" -- boss name
local BOSS_POSee = {x = 32349, y = 32052, z = 8} -- boss spawn coord   
local roomee = {fromx = 32334, tox = 32345, fromy = 32048, toy = 32056, z = 8} -- boss room  32381, 32151, 7

function onTime()  


local bossee = 0
for x = roomee.fromx, roomee.tox do
for y = roomee.fromy, roomee.toy do
for z = roomee.z, roomee.z do

creatureee = {x = x, y = y, z = z}
mobee = getTopCreature(creatureee).uid

    if getCreatureName(mobee) == BOSSee then
        bossee = 1
    end
end
end
end

if bossee == 1 then
end

if bossee == 0 then
		broadcastMessage("Jason was born out of the darkness, run to help and get his reward!!", MESSAGE_STATUS_WARNING)
        Game.createMonster(BOSSee, BOSS_POSee)
  
end

return true
end
