local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'Bem-vindo ao escritório dos correios' },
	{ text = 'Se precisar de ajuda com cartas ou encomendas, pergunte-me. Posso explicar tudo.' },
	{ text = 'Ei, envie uma carta para o seu amigo de vez em quando. Mantenha contato, você sabe.' }
}

npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	if msgcontains(msg, "measurements") then
		local player = Player(cid)
		if player:getStorageValue(Storage.postman.Mission07) >= 1 then
			npcHandler:say("Oh, eles não mudam tanto desde os velhos tempos como ... <conta uma história chata e confusa sobre um bolo, um pacote, ele e dois esquilos, pelo menos ele lhe diz suas medidas no final>", cid)
			player:setStorageValue(Storage.postman.Mission07, player:getStorageValue(Storage.postman.Mission07) + 1)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Olá. Como posso ajudá-lo |PLAYERNAME|? Peça-me um {trade} se quiser comprar algo. Também posso explicar o sistema de {mail}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Foi um prazer ajudá-lo, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
