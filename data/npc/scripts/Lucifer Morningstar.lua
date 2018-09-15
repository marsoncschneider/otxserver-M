function getItemAttack(uid)
       return getItemAttribute(uid,'attack')
    end
    function getItemDefense(uid)
       return getItemAttribute(uid,'defense')
    end
    function getItemArmor(uid)
       if type(uid) == 'number' then
          return getItemAttribute(uid,'armor')
       else
          return getItemInfo(uid.itemid).armor
       end
    end
-- funções npc forja
local itemFunctions = {
	["actionid"] = { isActive = true, targetFunction = function (item, target) return item:setActionId(target) end },
	["action"] = { isActive = true, targetFunction = function (item, target) return item:setActionId(target) end },
	["aid"] = { isActive = true, targetFunction = function (item, target) return item:setActionId(target) end },
	["description"] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, target) end },
	["desc"] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, target) end },
	["name"] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_NAME, target) end },
	["remove"] = { isActive = true, targetFunction = function (item, target) return item:remove() end },
	["decay"] = { isActive = true, targetFunction = function (item, target) return item:decay() end },
	["transform"] = { isActive = true, targetFunction = function (item, target) return item:transform(target) end },
	["clone"] = { isActive = true, targetFunction = function (item, target) return item:clone() end },
	["attack"] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_ATTACK, target) end },
	["extraattack"] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_EXTRAATACK, target) end },
	["defense"] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_DEFENSE, target) end },
	["extradefense"] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE, target) end },
	["armor"] = { isActive = true, targetFunction = function (item, target) return item:setAttribute(ITEM_ATTRIBUTE_ARMOR, target) end }
}
-- funções npc forja
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local voices = {
		{ text = 'Traga seus materias e venha melhorar seus Itens!' },
		{ text = 'Na União Soviética, as forjas forjam VOCÊ!!' },
		{ text = 'Venha consertar o seu escudo. Fale comigo se quiser saber mais!' }
}
npcHandler:addModule(VoiceModule:new(voices))

-- Greeting and Farewell
keywordHandler:addGreetKeyword({'hi'}, {npcHandler = npcHandler, text = 'Olá, companheiro aventureiro. Qual a sua necessidade? Diga comercio {trade} e em breve abriremos um negócio. Ou me pergunte sobre {potions}, wands} ou {runes}.'}, function(player) return player:getSex() == PLAYERSEX_FEMALE end)
keywordHandler:addAliasKeyword({'hello'})

-- All keywords
keywordHandler:addKeyword({'hint'}, StdModule.rookgaardHints, {npcHandler = npcHandler})
keywordHandler:addKeyword({'materiais'}, StdModule.say, {npcHandler = npcHandler, text = '{mace}, {sword} e {plate shield}'})

local function greetCallback(cid)
	local player = Player(cid)
	if player then
		npcHandler:setMessage(MESSAGE_GREET, player:getName() ..", Eu trabalho como Ferreiro. Basta me trazer os {materiais} e posso melhorar seus {itens} se quiser.")
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local getitem, player = nil, Player(cid)
	
	if npcHandler.topic[cid] == 0 then
		if msgcontains(msg, "itens") then
		local option, id, produtos = 1, nil, {"Mace", "Sword", "Plate Shield"}
			getitem = (player:getItemById(2510, true) or player:getItemById(2376, true) or player:getItemById(2398, true))
			if getitem == nil or not getitem then
				npcHandler:say("Para forjar você precisa ter: " .. produtos[1] .. ", " .. produtos[2] .. " ou  " .. produtos[3] .. " para derretermos na forja...\nE é facil encontrar. Volte logo. ", cid)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Muito bem... o item será derretido. Você ter até {+10} adicionais de: {Attack} para Armas, {Defense} para Escudos e {Armor} para o Set.\nLembre-se que existe uma chance de não dar certo.", cid)
				npcHandler.topic[cid] = 1
			end
		end
	end
	--if npcHandler.topic[cid] == 1 and (msgcontains(msg, "attack") or msgcontains(msg, "defense") or msgcontains(msg, "armor")) then--or msgcontains(msg, "armor") then --or npcHandler.topic[cid] == 2 or npcHandler.topic[cid] == 3 then
	if npcHandler.topic[cid] == 1 and not msgcontains(msg, "itens") then--or msgcontains(msg, "armor") then --or npcHandler.topic[cid] == 2 or npcHandler.topic[cid] == 3 then
		if msgcontains(msg, "attack") then
			tag, mtag = "attack", "ATTACK"
		elseif msgcontains(msg, "defense") then
			tag, mtag = "defense", "DEFENSE"
		elseif msgcontains(msg, "armor") then
			tag, mtag = "armor", "ARMOR"
		else
			npcHandler:say("error", cid)
			return false
		end
		
		getitem = (player:getItemById(2510, true) or player:getItemById(2376, true) or player:getItemById(2398, true))
		if getitem == nil or not getitem then
			npcHandler:say("erro! item nao encontrado", cid)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return false
		end		
		local iremove, text = nil, "Atributo " .. tag .. ""	
		
		-- forge system
		local position = player:getPosition()
		position:getNextPosition(player:getDirection(), 1)
		if player:getDirection() ~= DIRECTION_EAST then
			npcHandler:say("error! você precisa estar virado para a bancada", cid)
			npcHandler.topic[cid] = 1
			return false
		end
		local itemFunction = itemFunctions[tag]
		if(itemFunction and itemFunction.isActive) then
		
		local item = Tile(position):getTopVisibleThing(player)
			if(not item or not item:isItem()) then
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Item not found.")
			return false
			end
		local value = math.random(10)
		local fullattack, fulldefense, fullarmor
		
		fullattack = item:getAttribute(ITEM_ATTRIBUTE_ATTACK)
		fulldefense = item:getAttribute(ITEM_ATTRIBUTE_DEFENSE)
		fullarmor = item:getAttribute(ITEM_ATTRIBUTE_ARMOR)
		if fullattack <= 0 then
		fullattack = item:getType():getAttack()
		end
		if fulldefense <= 0 then
		fulldefense = item:getType():getDefense()
		end
		if fullarmor <= 0 then
		fullarmor = item:getType():getArmor()
		
		end
		
		-- real gain
		local gainattack = fullattack - item:getType():getAttack()
		local gaindefense = fulldefense - item:getType():getDefense()
		local gainarmor = fullarmor - item:getType():getArmor()
		if player:getItemCount(2510) > 0 then
			iremove = 2510
		elseif player:getItemCount(2376) > 0 then
			iremove = 2376
		elseif player:getItemCount(2398) > 0 then
			iremove = 2398
		end
		
			if tag == "attack" then
				if item:getType():getAttack() == 0 or item:getType():getAttack() == nil then
					npcHandler:say("Este item nao pode receber o atributo ATAQUE", cid)
				return false
				end
				
				if value - gainattack > 5 then
				--npcHandler:say("FALHOU! a forja aqueceu o suficiente para produzir itens de ataque + " .. value .. " então sua arma nao foi alterada, tente novamente. tente aumentar no maximo de 5 em 5 ou entao sua arma quebrará", cid)
				--player:removeItem(iremove, 1)
				--return false
				value = math.random(5)
				end
				if value < gainattack then
				npcHandler:say("FALHOU! a forja aqueceu o suficiente para produzir itens {+} {" .. value .. "} então sua arma nao foi alterada, tente novamente", cid)
				player:removeItem(iremove, 1)
				return false
				end
				total = value + item:getType():getAttack()
			end
			if tag == "defense" then
				if item:getType():getDefense() == 0 or item:getType():getDefense() == nil then
					npcHandler:say("Este item nao pode receber o atributo DEFESA", cid)
				player:removeItem(iremove, 1)
				return false
				end
				
				if value - gaindefense > 5 then
				--npcHandler:say("FALHOU! a forja aqueceu o suficiente para produzir itens de ataque + " .. value .. " então sua arma nao foi alterada, tente novamente. tente aumentar no maximo de 5 em 5 ou entao sua arma quebrará", cid)
				--player:removeItem(iremove, 1)
				--return false
				value = math.random(5)
				end
				if value < gaindefense then
				npcHandler:say("FALHOU! a forja aqueceu o suficiente para produzir itens {+} {" .. value .. "} então sua arma nao foi alterada, tente novamente", cid)
				player:removeItem(iremove, 1)
				return false
				end
				total = value + item:getType():getDefense()
			end
			if tag == "armor" then
				if item:getType():getArmor() == 0 or item:getType():getArmor() == nil then
					npcHandler:say("Este item nao pode receber o atributo ARMOR", cid)
				player:removeItem(iremove, 1)
				return false
				end
				
				if value - gainarmor > 5 then
				--npcHandler:say("FALHOU! a forja aqueceu o suficiente para produzir itens de ataque + " .. value .. " então sua arma nao foi alterada, tente novamente. tente aumentar no maximo de 5 em 5 ou entao sua arma quebrará", cid)
				--player:removeItem(iremove, 1)
				--return false
				value = math.random(5)
				end
				if value < gainarmor then
				npcHandler:say("FALHOU! a forja aqueceu o suficiente para produzir itens de {+} {" .. value .. "} então sua arma nao foi alterada, tente novamente", cid)
				player:removeItem(iremove, 1)
				return false
				end
				total = value + item:getType():getArmor()
				player:removeItem(iremove, 1)
			end
		
		if(itemFunction.targetFunction(item, total))then
			position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			--item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "LAST FORGE: + ".. value .. " ".. tag .. " by "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y").." "..(os.date("%A"))..".")
			item:setAttribute(ITEM_ATTRIBUTE_NAME, "FORGED ".. item:getType():getName() .. "")
		else
			npcHandler:say("You cannot add that attribute to this item.", cid)
		end
		-- marson
		--local fullattack = item:getAttribute(ITEM_ATTRIBUTE_ATTACK, target)
		--local fullattack, fulldefense, fullarmor
		
		fullattack = item:getAttribute(ITEM_ATTRIBUTE_ATTACK)
		fulldefense = item:getAttribute(ITEM_ATTRIBUTE_DEFENSE)
		fullarmor = item:getAttribute(ITEM_ATTRIBUTE_ARMOR)
		if fullattack <= 0 then
		fullattack = item:getType():getAttack()
		end
		if fulldefense <= 0 then
		fulldefense = item:getType():getDefense()
		end
		if fullarmor <= 0 then
		fullarmor = item:getType():getArmor()
		
		end
		
		-- real gain
		local gainattack = fullattack - item:getType():getAttack()
		local gaindefense = fulldefense - item:getType():getDefense()
		local gainarmor = fullarmor - item:getType():getArmor()
		-- description
		if gainattack > 0 and gaindefense > 0 and gainattack < 10 and gaindefense < 10 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Forge: Atk: +".. gainattack .. " Def: +".. gaindefense .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		elseif gainattack > 0 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Forge: Atk: +".. gainattack .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		elseif gaindefense > 0 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Forge: Def: +".. gaindefense .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		end
		if gainarmor > 0 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Forge: Arm: +".. gainarmor .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		end
		if gainattack == 10 and gaindefense == 0 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "PERFECT ATK!! Forge: Atk: +".. gainattack .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		end
		if gainattack == 0 and gaindefense == 10 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "PERFECT DEF!! Forge: Def: +".. gaindefense .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		end
		if gainattack > 0 and gaindefense == 10 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "PERFECT DEF!! Forge: Atk: +".. gainattack .. " Def: +".. gaindefense .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		end
		if gainattack == 10 and gaindefense > 0 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "PERFECT ATK!! Forge: Atk: +".. gainattack .. " Def: +".. gaindefense .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		end
		if gainattack == 10 and gaindefense == 10 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "PERFECT ATK+DEF!! Forge: Atk: +".. gainattack .. " Def: +".. gaindefense .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		end
		if gainarmor == 10 then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "PERFECT!! Forge: Arm: +".. gainarmor .. ". By "..player:getName().. ".\n"..(os.date("%d")).." "..(os.date("%B")).." "..os.date("%Y")..".")
		end
		
		--description
		-- forge system
		npcHandler:say("Forjado com sucesso. Adicionado novo atributo: " .. tag .. " + " .. value .. " MODO DEBUG: fullattack, fulldefense, fullarmor, gainattack, gaindefense, gainarmor:" .. fullattack .. " " .. fulldefense .. " " .. fullarmor .. " " .. gainattack .. ", " .. gaindefense .. ", " .. gainarmor .. ".", cid)
		local textPosition = player:getPosition()
		--textPosition:getNextPosition(player:getDirection(), 1)
		local spectators = Game.getSpectators(textPosition, false, true, 3, 3)
		for i = 1, #spectators do
			player:say("NPC Chaleira: \n" .. " FORGED WITH + " .. value .. " "  .. mtag ..".", TALKTYPE_MONSTER_SAY, isInGhostMode, spectators[i], textPosition)
		end
			
		
		return false
end
	return true
end
end

--local function onAddFocus(cid)
--end
--local function onReleaseFocus(cid)
--end

--npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
--npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "Boa caçada!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Tome cuidado!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())