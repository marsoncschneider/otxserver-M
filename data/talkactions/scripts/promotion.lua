local config = {
promotion = 1, -- promotion level, default = 1 . Ignore if you don't have new vocations.
minLevel = 20, -- Level needed to buy promotion
cost = 20000, -- Promotion cost in gp
premium = "yes"  -- is premium needed to buy promotion?
}
 
local disabledVocations = {0}
 
--config.premium = getBooleanFromString(config.premium)
 
function onSay(cid, words, param)
local player = Player(cid)
local promotion = player:getVocation():getPromotion()
if(isInArray(disabledVocations, getPlayerVocation(cid)) == TRUE) then
doPlayerSendCancel(cid, "Your vocation cannot buy promotion.")
elseif(config.premium == TRUE and isPremium(cid) == FALSE) then
doPlayerSendCancel(cid, "Voce precisa ser donate para comprar promotion.")
elseif(getPlayerVocation(cid) >= 5) then
doPlayerSendCancel(cid, "You are already promoted.")
elseif(cid:getLevel() < 20) then
doPlayerSendCancel(cid, "You need level 20 to be promoted.")
elseif(doPlayerRemoveMoney(cid, 20000) ~= TRUE) then
if cid:getBankBalance() >= 20000 then
cid:setBankBalance(cid:getBankBalance()-20000)
player:setVocation(promotion)
doPlayerSendCancel(cid, "You have been succesful promoted.")
return true
end
doPlayerSendCancel(cid, "You dont have money.")
else
player:setVocation(promotion)
doPlayerSendCancel(cid, "You have been succesful promoted.")
end
return TRUE
end