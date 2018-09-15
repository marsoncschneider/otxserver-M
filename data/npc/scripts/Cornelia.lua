local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Armaduras de qualidade à venda!'} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu trabalho com esse arsenal. Se quiser proteger a sua vida, é melhor comprar meus produtos."})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if isInArray({"addon", "armor"}, msg) then
		if player:getStorageValue(Storage.OutfitQuest.WarriorShoulderAddon) == 5 then
			player:setStorageValue(Storage.OutfitQuest.WarriorShoulderAddon, 6)
			player:setStorageValue(Storage.OutfitQuest.WarriorShoulderTimer, os.time() + (player:getSex() == PLAYERSEX_FEMALE and 3600 or 7200))
			npcHandler:say('Ah, você deve ser o herói que Trisha falou. Eu vou preparar os espinhas do ombro para você. Por favor, me dê algum tempo para terminar.', cid)
		elseif player:getStorageValue(Storage.OutfitQuest.WarriorShoulderAddon) == 6 then
			if player:getStorageValue(Storage.OutfitQuest.WarriorShoulderTimer) > os.time() then
				npcHandler:say('Ainda não terminei. Seja tão paciente quanto você é corajoso.', cid)
			elseif player:getStorageValue(Storage.OutfitQuest.WarriorShoulderTimer) > 0 and player:getStorageValue(Storage.OutfitQuest.WarriorShoulderTimer) < os.time() then
				player:addOutfitAddon(142, 1)
				player:addOutfitAddon(134, 1)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				player:setStorageValue(Storage.OutfitQuest.WarriorShoulderAddon, 7)
				player:addAchievementProgress('Wild Warrior', 2)
				npcHandler:say('Acabado! Como você é um homem, pensei que você provavelmente queria dois. Os homens sempre querem esse pequeno símbolo de status extra. <risos>', cid)
			else
				npcHandler:say('Eu estou vendendo leather armors, chain armor e brass armors. Peça-me um comércio {trade} se quiser dar uma olhada.', cid)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo à melhor loja de armaduras nesta terra, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Até mais ver, volte em breve")
npcHandler:addModule(FocusModule:new())