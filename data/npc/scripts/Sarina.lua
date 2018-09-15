local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Equipamentos gerais e todo tipo de bens. Visite minha loja!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	if msgcontains(msg, "football") then
		npcHandler:say("Você quer comprar uma bola de futebol por 111 de ouro?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			local player = Player(cid)
			if player:removeMoney(111) then
				npcHandler:say("Aqui está.", cid)
				player:addItem(2109, 1)
			else
				npcHandler:say("Você não tem dinheiro suficiente.", cid)
			end
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Oh, por favor, entre, |PLAYERNAME|. O que posso fazer para você? Se você precisa de equipamentos para sua aventura, peça-me um comércio {trade}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Claro, basta navegar pelos meus produtos. Bolas de futebol {football} tem que ser comprado separadamente.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
