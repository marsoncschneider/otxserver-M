local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Runas, wands, rods, po��es de vida e mana! D� uma olhada!'} }
npcHandler:addModule(VoiceModule:new(voices))

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
				npcHandler:say('Ent�o voc� quer uma {' .. ItemType(itemId):getName() .. '} para continuar sua aventura?', cid)
				npcHandler.topic[cid] = 1
			else
				npcHandler:say('O que? Eu j� te deu uma {' .. ItemType(itemId):getName() .. '}!', cid)
			end
		else
			npcHandler:say('Desculpe, voc� n�o � um druid nem um sorcerer.', cid)
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			player:addItem(itemId, 1)
			npcHandler:say('Aqui est� novato, cuide-se.', cid)
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
npcHandler:setMessage(MESSAGE_GREET, "Ol�, caro |PLAYERNAME|. Como eu posso te ajudar? Se precisar de equipamento m�gico como runas ou wands, � s� me chamar para negociar {trade}. ")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, |PLAYERNAME|. Volte sempre!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus, |PLAYERNAME|. Volte sempre!")
npcHandler:addModule(FocusModule:new())
