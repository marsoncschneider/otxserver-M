local destination = Position(33591, 32320, 10)
local s = 19001 
local t = 1 * 24 * 60 * 60 * 1000 
local blabla = 1 / 24 / 60 / 60 / 100
local o = os.time()
local pos = getCreaturePosition(cid)
local timelast = getPlayerStorageValue(cid, s)-- + blabla
local tilepos = {x=33592, y=32308, z=10} 
local sq = 3 
local monster = "Demon"
local time = 10

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(50737) == -1 then
		player:teleportTo(destination)
		position:sendMagicEffect(CONST_ME_TELEPORT)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You not have permission to pass here.')
	return true
	end
	
	if sq < 3 or sq%2 == 0 then
		return error("SOMENTE NUMEROS IMPARES MAIORES QUE 2")
	end
	local uids = getUidsInArea(tilepos, {x=tilepos.x+sq-1, y=tilepos.y+sq-1, z=tilepos.z})
	if #uids == 0 then
		for y = tilepos.y, tilepos.y+sq-1 do
			for x = tilepos.x, tilepos.x+sq-1 do
				if y == tilepos.y+(sq-1)/2 and x == tilepos.x+(sq-1)/2 then
					doTeleportThing(cid, {x=x, y=y, z=tilepos.z})
				else
					summonAndRemove(monster, {x=x, y=y, z=tilepos.z}, time*60)
				end
			end
		end
	else
		doTeleportThing(cid,frompos,true)
		return doPlayerSendCancel(cid, "There are people inside right now.")
	end
  
 if getPlayerStorageValue(cid, s) > os.time() then
   doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You can enter again in "..timelast.." hours.")
    doTeleportThing(cid, fromPosition)
     doSendMagicEffect(pos, CONST_ME_POFF)
      else
     setPlayerStorageValue(cid, s, o + t)
   doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
  end
	return true
end

function getUidsInArea(extr1, extr2)
	local dat = {}
	for y = extr1.y, extr2.y do
		for x = extr1.x, extr2.x do
			if isCreature(getThingFromPos({x=x, y=y, z=extr1.z, stackpos=255}).uid) then
				table.insert(dat, getThingFromPos({x=x, y=y, z=extr1.z, stackpos=255}).uid)
			end
		end
	end
	return dat
end

function summonAndRemove(monster, pos, t)
	local function removeCreatureEvent(uid)
		if isCreature(uid) then
			doRemoveCreature(uid)
		end
	end
	local uid = doSummonCreature(monster, pos)
	addEvent(removeCreatureEvent, t*1000, uid)
end