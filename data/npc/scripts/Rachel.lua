local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = "Ok, ent�o, navegue por todos os meus produtos."})

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
				npcHandler:say('Ent�o voc� me pede uma {' .. ItemType(itemId):getName() .. '} para come�ar sua aventura?', cid)
				npcHandler.topic[cid] = 1
			else
				npcHandler:say('O que? Eu j� lhe dei uma {' .. ItemType(itemId):getName() .. '}!', cid)
			end
		else
			npcHandler:say('Desculpe, voc� n�o � um druida nem um feiticeiro.', cid)
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			player:addItem(itemId, 1)
			npcHandler:say('Aqui voc� � um jovem adepto, cuide-se.', cid)
			player:setStorageValue(Storage.firstMageWeapon, 1)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		npcHandler:say('Ok ent�o.', cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Bem vindo |PLAYERNAME|! Do que voc� precisa?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Claro, basta navegar pelos meus produtos. Ou voc� quer olhar apenas para {potions}, {wands} ou {runes}?")
npcHandler:addModule(FocusModule:new())
