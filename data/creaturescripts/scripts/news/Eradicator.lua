local posdotpzzz = {x = 32317, y = 31284, z = 14}

function MoveStonezzz() --creates wall back
local criistal1zzz = getTileItemById(posdotpzzz, 1304)
   if not criistal1zzz then 
    doCreateItem(1304,1,posdotpzzz)-- Stone pos
	else 
	doCreateItem(1304,1,posdotpzzz)
   end 
   return true
end

function ReMoveStonezzz()
    local cristalzzz = getTileItemById(posdotpzzz, 1304) -- Id of the blue crystal that disappears to give place to tp
    if cristalzzz then
        doRemoveItem(cristalzzz.uid, 1)
    end
    return true
end

function onKill(cid, target, damage, flags, corpse)
	if(isMonster(target)) then
		if(string.lower(getCreatureName(target)) == "eradicatorr") then
		    addEvent(ReMoveStonezzz, 5 * 1000)
     	    addEvent(MoveStonezzz, 300 * 1000)
		end
	end
	return true
end


