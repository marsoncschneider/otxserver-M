local posdotpz = {x = 32253, y = 31372, z = 14}

function MoveStonez() --creates wall back
local criistal1z = getTileItemById(posdotpz, 1304)
   if not criistal1z then 
    doCreateItem(1304,1,posdotpz)-- Stone pos
	else 
	doCreateItem(1304,1,posdotpz)
   end 
   return true
end

function ReMoveStonez()
    local cristalz = getTileItemById(posdotpz, 1304) -- Id of the blue crystal that disappears to give place to tp
    if cristalz then
        doRemoveItem(cristalz.uid, 1)
    end
    return true
end

function onKill(cid, target, damage, flags, corpse)
	if(isMonster(target)) then
		if(string.lower(getCreatureName(target)) == "the hunger") then
		    addEvent(ReMoveStonez, 5 * 1000)
     	    addEvent(MoveStonez, 300 * 1000)
		end
	end
	return true
end


