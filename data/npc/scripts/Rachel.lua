local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = "Ok, então, navegue por todos os meus produtos."})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	local items = {[1] = 2190, [2] = 2182}
	local itemId = items[player:getVocation():getBase():getId()]
	if msgcontains(msg, 'first rod') or msgcontains(msg, 'first wand') then
		if player:isMage() then
			if player:getStorageValue(Storage.firstMageWeapon) == -1 then
				npcHandler:say('Então você me pede uma {' .. ItemType(itemId):getName() .. '} para começar sua aventura?', cid)
				npcHandler.topic[cid] = 1
			else
				npcHandler:say('O que? Eu já lhe dei uma {' .. ItemType(itemId):getName() .. '}!', cid)
			end
		else
			npcHandler:say('Desculpe, você não é um druida nem um feiticeiro.', cid)
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			player:addItem(itemId, 1)
			npcHandler:say('Aqui você é um jovem adepto, cuide-se.', cid)
			player:setStorageValue(Storage.firstMageWeapon, 1)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		npcHandler:say('Ok então.', cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Bem vindo |PLAYERNAME|! Do que você precisa?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Claro, basta navegar pelos meus produtos. Ou você quer olhar apenas para {potions}, {wands} ou {runes}?")
npcHandler:addModule(FocusModule:new())
