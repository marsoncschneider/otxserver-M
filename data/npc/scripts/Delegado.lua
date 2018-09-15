local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}
PRICE = 100

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function greetCallback(cid)
	local player = Player(cid)
	local curboost = math.max(player:getStorageValue(61924) - os.time(), 0)
	local level = player:getLevel()
	if player:getMoney() < PRICE and curboost > 0 then
		npcHandler:say("Infrator! Volte quando tiver dinheiro para fian�a ou quando sua pena acabar!", cid)
		npcHandler:resetNpc(cid)
		return false
	elseif level > 100000 then
		npcHandler:say(player:getName() ..", Eu n�o posso deixar voc� sair, hack � pra noob!.", cid)
		npcHandler:resetNpc(cid)
		return false
	else
		npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", Voc� poder� sair quando acabar a sua {pena} ou pagando {fian�a}, certo? diga {yes}")
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	local player = Player(cid)
	if not player then
	return false
	end
	local curboost = math.max(player:getStorageValue(61924) - os.time(), 0)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if npcHandler.topic[cid] == 0 then
		if msgcontains(msg, "yes") then
			if curboost > 0 then
			npcHandler:say("Sua pena ainda nao acabou... deseja pagar fian�a? diga {pagar}!", cid)
			npcHandler.topic[cid] = 1
			else
			npcHandler:say("SUA PENA ACABOU!", cid)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			local oldtown = player:getStorageValue(61922)
			player:setStorageValue(61924, -1)
			player:teleportTo(Town(oldtown):getTemplePosition())
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		end

	elseif npcHandler.topic[cid] == 1 then
	
		if msgcontains(msg, "pagar") then
		if player:removeMoney(PRICE) then
			npcHandler:say("Ent�o que seja!", cid)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			local oldtown = player:getStorageValue(61922)
			player:setStorageValue(61924, -1)
			player:teleportTo(Town(oldtown):getTemplePosition())
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
		else
			npcHandler:say("ENTAO OQU�? Cad� a grana?", cid)
			npcHandler.topic[cid] = 0
		
		end
	end
	return true
end

local function onAddFocus(cid)
	
end

local function onReleaseFocus(cid)
	
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "Volte aqui quando entender que {hack} e {bots} � pra noob!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ignora mesmo, animal, vai apodrecer na pris�o!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())