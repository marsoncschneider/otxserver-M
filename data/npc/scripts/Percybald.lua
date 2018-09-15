local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, 'disguise') then
		if player:getStorageValue(Storage.thievesGuild.TheatreScript) < 0 then
			npcHandler:say({
				'Hmpf. Por que eu deveria perder meu tempo para ajudar alguns amadores? Tenho medo de oferecer apenas ajuda aos atores que são tão ótimos quanto eu.. ...',
				'No entanto, sua fútil tentativa de provar sua dignidade poderia ser divertida. Pegue uma cópia de um roteiro da sala de apoio na cave do teatro. Então fale comigo novamente sobre o seu teste!'
			}, cid)
			player:setStorageValue(Storage.thievesGuild.TheatreScript, 0)
		end
	elseif msgcontains(msg, 'test') then
		if player:getStorageValue(Storage.thievesGuild.Mission04) == 5 then
			npcHandler:say('Espero que você tenha aprendido seu papel! Eu vou lhe dizer uma linha do script e você terá que responder com a linha correspondente! Pronto?', cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say('Como você ousa? Você está louco? Eu mantenho a princesa refém, deixa suas armas. Você está perdido!', cid)
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say('Cavaleiro, chegou tarde demais. Você não pode parar mais o meu plano mestre!', cid)
			npcHandler.topic[cid] = 4
		elseif npcHandler.topic[cid] == 5 then
			npcHandler:say('O que é isso? Atrás do médico?', cid)
			npcHandler.topic[cid] = 6
		elseif npcHandler.topic[cid] == 7 then
			npcHandler:say('Grrr!', cid)
			npcHandler.topic[cid] = 8
		elseif npcHandler.topic[cid] == 9 then
			npcHandler:say('Você é um monstro!', cid)
			npcHandler.topic[cid] = 10
		elseif npcHandler.topic[cid] == 11 then
			npcHandler:say('Ah, acho que você passou no teste! Aqui está o seu kit de disfarce! Agora me perca, o destino me espera!', cid)
			player:setStorageValue(Storage.thievesGuild.Mission04, 6)
			player:addItem(8693, 1)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'Eu acho que não, querido doutor!') then
			npcHandler:say('Ok, ok. Você tem esse direito! Pronto para o próximo?', cid)
			npcHandler.topic[cid] = 3
		else
			npcHandler:say('Não não não! Isso não está correto!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 4 then
		if msgcontains(msg, 'Cuidado! É uma armadilha!') then
			npcHandler:say('Ok, ok. Você tem esse direito! Pronto para o próximo?', cid)
			npcHandler.topic[cid] = 5
		else
			npcHandler:say('Não não não! Isso não está correto!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 6 then
		if msgcontains(msg, 'Veja! É Lucky, o cachorro maravilha!') then
			npcHandler:say('Ok, ok. Você tem esse direito! Pronto para o próximo?', cid)
			npcHandler.topic[cid] = 7
		else
			npcHandler:say('Não não não! Isso não está correto!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 8 then
		if msgcontains(msg, 'Ahhhhhh!') then
			npcHandler:say('Ok, ok. Você tem esse direito! Pronto para o próximo?', cid)
			npcHandler.topic[cid] = 9
		else
			npcHandler:say('Não não não! Isso não está correto!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 10 then
		if msgcontains(msg, 'Hahaha! Agora, solte suas armas ou então...') then
			npcHandler:say('Ok, ok. Você tem esse direito! Pronto para o próximo?', cid)
			npcHandler.topic[cid] = 11
		else
			npcHandler:say('Não não não! Isso não está certo!', cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Seja saudado|PLAYERNAME|!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
