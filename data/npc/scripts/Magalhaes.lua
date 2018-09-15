local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local voices = {
		{ text = 'Traga seus produtos de criaturas e venha jogar comigo!' },
		{ text = 'Ganhe a montaria ROTWORM, TROLL e GHOUL. Fale comigo se quiser saber mais!' }
}
npcHandler:addModule(VoiceModule:new(voices))

-- Greeting and Farewell
keywordHandler:addGreetKeyword({'hi'}, {npcHandler = npcHandler, text = 'Olá, companheiro aventureiro. Qual a sua necessidade? Diga comercio {trade} e em breve abriremos um negócio. Ou me pergunte sobre {potions}, wands} ou {runes}.'}, function(player) return player:getSex() == PLAYERSEX_FEMALE end)
keywordHandler:addAliasKeyword({'hello'})

-- All keywords
keywordHandler:addKeyword({'hint'}, StdModule.rookgaardHints, {npcHandler = npcHandler})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, mas antes da ajuda que eu mencionei - você deve pegar uma pá {shovel}, amigo. Ela virá a calhar quando você começar a procurar entradas secretas para masmorras ou tesouros escondidos - muitas coisas úteis jazem escondidas entre terra, areia ou pedras!'})

local function greetCallback(cid)
	local player = Player(cid)
	if player then
		npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", Eu posso dar as montarias: {rotworm}, {troll} e {ghoul}.\nBasta me ganhar em simples jogo de dados. Você tem sorte? Basta tirar o numero {6} no Jogo.")
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local getitem = nil
	local player = Player(cid)
	if npcHandler.topic[cid] == 0 then
		
		if msgcontains(msg, "rotworm") or msgcontains(msg, "troll") or msgcontains(msg, "ghoul") and npcHandler.topic[cid] == 0 then
			local option = 0
			local id = nil
			
			local produtos = {"lump of dirt", "bunch of troll hair", "ghoul snack"}
						
			if msgcontains(msg, "rotworm") then
				option, id = 1, 10609
			elseif msgcontains(msg, "troll") then
				option, id = 2, 10606
			elseif msgcontains(msg, "ghoul") then
				option, id = 3, 12423
			end
			
			getitem = player:getItemById(id, true)
			
			if not getitem then
			npcHandler:say("Para jogar você precisa ter " .. produtos[option] .. " x1 ... E é facil encontrar. Lembre-se, {Lump of dirt}, {Bunch of troll hair} e {Ghoul snack}.\n Não seja Noob e volte logo. ", cid)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			npcHandler.topic[cid] = 0
			else
			npcHandler:say("Rolarei o dado... Você precisa do numero {6} para ganhar, logicamente. \n No entanto " .. produtos[option] .. " 1x será sacrificado a cada rodada. De acordo?", cid)
			--if option == 1 then
			npcHandler.topic[cid] = option
			--end
			--if option == 2 then
			--npcHandler.topic[cid] = 2
			--end
			--if option == 3 then
			--npcHandler.topic[cid] = 3
			--end
			end
		end
	end
	if npcHandler.topic[cid] == 1 or npcHandler.topic[cid] == 2 or npcHandler.topic[cid] == 3 then
		local option2, addmount, iremove, text
		option2 = npcHandler.topic[cid]
		if option2 == 1 then
		addmount, iremove, text = 119, 10609, "Jogo valendo rotworm mount"
		elseif option2 == 2 then
		addmount, iremove, text = 128, 10606, "Jogo valendo troll mount"
		elseif option2 == 3 then
		addmount, iremove, text = 129, 12423, "Jogo valendo ghoul mount"
		end
		if msgcontains(msg, "yes") then
			npcHandler:say("Deseja jogar novamente? " .. text .. ".", cid)
			local dicePosition = player:getPosition()
			local value = math.random(6)
			local spectators = Game.getSpectators(dicePosition, false, true, 3, 3)
			for i = 1, #spectators do
				player:say("NPC Magalhães: \n" .. " rolled a " .. value .. ".", TALKTYPE_MONSTER_SAY, isInGhostMode, spectators[i], dicePosition)
			end
			player:removeItem(iremove, 1)
			if value == 6 then
			npcHandler:say('Ok, here we go ... 6! You have won a mount, congratulations.', cid)
			player:addMount(addmount)
			npcHandler.topic[cid] = 0
			return true
			--npcHandler.topic[cid] = 0
			end
			npcHandler.topic[cid] = option2
			end
		end
		--[[	if npcHandler.topic[cid] == 2 then
		if msgcontains(msg, "yes") then
			npcHandler:say("Vamos jogar2.", cid)
			local dicePosition = player:getPosition()
			local value = math.random(6)
			local spectators = Game.getSpectators(dicePosition, false, true, 3, 3)
			player:removeItem(10606, 1)
			for i = 1, #spectators do
				player:say("NPC Magalhães" .. " rolled a " .. value .. ".", TALKTYPE_MONSTER_SAY, isInGhostMode, spectators[i], dicePosition)
			end
			if value == 6 then
			npcHandler:say('Ok, here we go ... 6! You have won a mount, congratulations.', cid)
			player:addMount(128)
			end
			npcHandler.topic[cid] = 0
			end
		end
			if npcHandler.topic[cid] == 3 then
		if msgcontains(msg, "yes") then
			npcHandler:say("Vamos jogar3.", cid)
			local dicePosition = player:getPosition()
			local value = math.random(6)
			local spectators = Game.getSpectators(dicePosition, false, true, 3, 3)
			player:removeItem(12423, 1)
			for i = 1, #spectators do
				player:say("NPC Magalhães" .. " rolled a " .. value .. ".", TALKTYPE_MONSTER_SAY, isInGhostMode, spectators[i], dicePosition)
			end
			if value == 6 then
			npcHandler:say('Ok, here we go ... 6! You have won a mount, congratulations.', cid)
			player:addMount(129)
			end
			npcHandler.topic[cid] = 0
			end
		end
			]]
	return true
end

local function onAddFocus(cid)
	town[cid] = 0
	vocation[cid] = 0
end

local function onReleaseFocus(cid)
	town[cid] = nil
	vocation[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "Boa caçada!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Tome cuidado!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())