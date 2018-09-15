local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'Bem-vindo ao escritório dos correios' },
	{ text = 'Ei, envie uma carta para o seu amigo de vez em quando. Mantenha contato, você sabe.' },
	{ text = 'Se precisar de ajuda com cartas ou encomendas, pergunte-me. Posso explicar tudo.' },
	{ text = 'Não, não, não, não há erro de pacote, estou lhe dizendo!' }
}

npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "measurements") then
		if player:getStorageValue(Storage.postman.Mission07) >= 1 then
			npcHandler:say("Tenho um problema mais urgente para comparecer a isso. Esses falcões estão caçando meus pombos de porteiro. Traga-me 12 flechas e vou ver se eu tenho o tempo para esse absurdo. Você tem 12 arrow com você? ", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			if player:removeItem(2544, 12) then
				npcHandler:say("Ótimo! Agora vou ensinar-lhes uma lição ... Para essas medidas ... <lhe diz suas medidas> ", cid)
				player:setStorageValue(Storage.postman.Mission07, player:getStorageValue(Storage.postman.Mission07) + 1)
				npcHandler.topic[cid] = 0
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Olá. Como posso ajudá-lo |PLAYERNAME|? Peça-me um comércio {trade} se quiser comprar algo. Também posso explicar o sistema de correios {mail}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Foi um prazer ajudá-lo, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Foi um prazer ajudá-lo, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Aqui. Não se esqueça de que você também precisa comprar um rótulo {label} se quiser enviar um pacote. Sempre escreva o nome do {receptor} na primeira linha.")
npcHandler:addModule(FocusModule:new())
