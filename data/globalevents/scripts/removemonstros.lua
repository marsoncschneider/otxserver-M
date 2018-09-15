 local function isInArea(fromPos, toPos)
	local mensagem = true
	
	local monsters1 = {"Dark Faun", "Twisted Pooka", "Boogy", "Butterfly"} --monstros que podem nascer durante a noite
	local monsters2 = {"Pooka", "Faun", "Butterfly"} --monstros que podem nascer durante o dia
	local worldTime = getWorldTime()
	local hours = math.floor(worldTime / 60)
	local minutes = worldTime % 60
	if minutes < 10 then
		minutes = '0' .. minutes
	end
	local tag = "nulo"
	if hours < 12 then
	tag = "Day"
	elseif hours > 12 then
	tag = "Night"
	end
	if (isMonster(creature.uid)) or (isNpc(creature.uid)) then
	for i = 1, #monsters1 do
	if getCreatureName(creature.uid) == monsters1[i] and hours > 12 then
	return true
	end
	end
	for i = 1, #monsters2 do
	if getCreatureName(creature.uid) == monsters2[i] and hours < 12 then
	return true
	end
	end
	
	if mensagem == true then
	local spectators = Game.getSpectators(getCreaturePosition(creature.uid), false, true, 3, 3)
				for i = 1, #spectators do
					spectators[i]:say(getCreatureName(creature.uid) .. " dead because " .. hours .. ":" .. minutes .. " is " .. tag .. ".", TALKTYPE_MONSTER_SAY, isInGhostMode, spectators[i], getCreaturePosition(creature.uid))
				end
	end
	
	doRemoveCreature(creature.uid)
	return true
	end
end 
 
function isInAreabase()
	local fromPos = Position(33359, 32135, 7) --area inicial (valor menor)
	local toPos = Position(33601, 32333, 7) --area final (valor maior)
    
	for _x = fromPos.x, toPos.x do
        for _y = fromPos.y, toPos.y do
            for _z = fromPos.z, toPos.z do
                creature = getTopCreature({x = _x, y = _y, z = _z})
                isInArea(fromPos, toPos)
			end
        end
    end
	addEvent(isInAreabase, 1 * 5 * 1000) -- check 2 each second
	return true
end

function onStartup()
    addEvent(isInAreabase, 1 * 1 * 1000) --delay de 10 segundos inicial.
	return true
end
 