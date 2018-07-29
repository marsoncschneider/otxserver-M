local LEVEL_LOWER, LEVEL_SAME, LEVEL_HIGHER = 1, 2, 3
local DISTANCE_BESIDE, DISTANCE_CLOSE, DISTANCE_FAR, DISTANCE_VERYFAR = 1, 2, 3, 4

local directions = {
	[DIRECTION_NORTH] = "north",
	[DIRECTION_SOUTH] = "south",
	[DIRECTION_EAST] = "east",
	[DIRECTION_WEST] = "west",
	[DIRECTION_NORTHEAST] = "north-east",
	[DIRECTION_NORTHWEST] = "north-west",
	[DIRECTION_SOUTHEAST] = "south-east",
	[DIRECTION_SOUTHWEST] = "south-west"
}

local messages = {
	[DISTANCE_BESIDE] = {
		[LEVEL_LOWER] = " is below you.",
		[LEVEL_SAME] = " is standing next to you.",
		[LEVEL_HIGHER] = " is above you."
	},
	[DISTANCE_CLOSE] = {
		[LEVEL_LOWER] = " is on a lower level to the ",
		[LEVEL_SAME] = " is to the ",
		[LEVEL_HIGHER] = " is on a higher level to the "
	},
	[DISTANCE_FAR] = " is far to the ",
	[DISTANCE_VERYFAR] =  " is very far to the "
}

local spoofids = {10, 11, 12}
local locais = {
	Position(32375, 31895, 7), --pos1
	Position(32378, 31895, 7), --pos2 ...
	Position(32378, 31895, 7)
	}

function onCastSpell(creature, variant)
	local targetPosition, targetPlayer, returnMessage, spoof
	local playerId = getPlayerGUIDByName(variant:getString())
	local checkspoofid = db.storeQuery("SELECT `player_id` FROM `players_online` WHERE `player_id` = " .. playerId .. ";")
	targetPlayer = Player(variant:getString())
			
	for i = 1, #spoofids do
		if not targetPlayer and checkspoofid then
			if getPlayerGUIDByName(variant:getString()) == spoofids[i] then
				spoof = checkspoofid
				targetPosition = locais[i]
			end
		end
	end
	
	if spoof ~= checkspoofid then
		if not targetPlayer then
			creature:sendCancelMessage(RETURNVALUE_PLAYERWITHTHISNAMEISNOTONLINE)
			return false
		end

		if targetPlayer:getGroup():getAccess() and not creature:getGroup():getAccess() then
			creature:sendCancelMessage(RETURNVALUE_PLAYERWITHTHISNAMEISNOTONLINE)
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
	
		targetPosition = targetPlayer:getPosition()
		returnMessage = targetPlayer:getName()
	end
	
	local playerPosition = creature:getPosition()
	local tmp = variant:getString():lower()
    returnMessage = tmp:sub(1, 1):upper() .. tmp:sub(2)
	
	local offset = {
		x = playerPosition.x - (targetPosition.x),
		y = playerPosition.y - (targetPosition.y),
		z = playerPosition.z - (targetPosition.z)
	}

	local level = LEVEL_SAME
	if offset.z > 0 then
		level = LEVEL_HIGHER
	elseif offset.z < 0 then
		level = LEVEL_LOWER
	end

	local direction
	local distanceOutput = DISTANCE_VERYFAR
	if math.abs(offset.x) < 4 and math.abs(offset.y) < 4 then
		distanceOutput = DISTANCE_BESIDE
	else
		local distanceFormula = math.pow(offset.x, 2) + math.pow(offset.y, 2)
		if distanceFormula < 1000 then
			distanceOutput = DISTANCE_CLOSE
		elseif distanceFormula < math.pow(274, 2) then
			distanceOutput = DISTANCE_FAR
		end

		local distanceValue = offset.x ~= 0 and (offset.y / offset.x) or 10
		local absValue = math.abs(distanceValue)
		if absValue < 0.4142 then
			direction = offset.x > 0 and DIRECTION_WEST or DIRECTION_EAST
		elseif absValue < 2.4142 then
			if distanceValue > 0 then
				direction = offset.y > 0 and DIRECTION_NORTHWEST or DIRECTION_SOUTHEAST
			else
				direction = offset.x > 0 and DIRECTION_SOUTHWEST or DIRECTION_NORTHEAST
			end
		else
			direction = offset.y > 0 and DIRECTION_NORTH or DIRECTION_SOUTH
		end
	end
	
	if distanceOutput == DISTANCE_BESIDE then
		returnMessage = returnMessage .. messages[distanceOutput][level]
	elseif distanceOutput == DISTANCE_CLOSE then
		returnMessage = returnMessage .. messages[distanceOutput][level] .. directions[direction] .. "."
	else
		returnMessage = returnMessage .. messages[distanceOutput] .. directions[direction] .. "."
	end
	
	creature:sendTextMessage(MESSAGE_INFO_DESCR, returnMessage)
	playerPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end