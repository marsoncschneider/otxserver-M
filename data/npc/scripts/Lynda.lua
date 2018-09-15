 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local function creatureSayCallback(cid, type, msg)
	npcHandler:say('O Sistema de casamentos está desabilitado.', cid)
    return false
end
 
local function confirmWedding(cid, message, keywords, parameters, node)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
 
    local player = Player(cid)
    local playerStatus = getPlayerMarriageStatus(player:getGuid())
    local candidate = getPlayerSpouse(player:getGuid())
    if playerStatus == PROPACCEPT_STATUS then
      --  local item3 = Item(doPlayerAddItem(cid,ITEM_Meluna_Ticket,2))
        setPlayerMarriageStatus(player:getGuid(), MARRIED_STATUS)
        setPlayerMarriageStatus(candidate, MARRIED_STATUS)
        setPlayerSpouse(player:getGuid(), candidate)
        setPlayerSpouse(candidate, player:getGuid())
        delayedSay('Caros amigos e familiares, nós estamos reunidos aqui hoje para apoiar e celebrar a união de ' .. getPlayerNameById(candidate) .. ' e ' .. player:getName() .. ' em um casamento.')
        delayedSay('Em todo esse tempo juntos, eles vieram a acreditar que podem realizar seus sonhos, esperanças e acreditam que seus objetivos serão mais facilmente alcançados através da combinação de suas almas e o amor;',5000)
        delayedSay('e então eles decidiram viver juntos, como marido e mulher. E agora, pelo poder a mim concedido pelos Deuses do Tibia, eu vos declaro marido e mulher.',15000)
        delayedSay('*Depois de uma benção, abre sua mão para ' .. player:getName() .. '* Pegue um desses anéis gravados e dê um a sua esposa.',22000)
        delayedSay('Pode beijar a noiva.',28000)
        local item1 = Item(doPlayerAddItem(cid,ITEM_ENGRAVED_WEDDING_RING,1))
        local item2 = Item(doPlayerAddItem(cid,ITEM_ENGRAVED_WEDDING_RING,1))
        item1:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, player:getName() .. ' & ' .. getPlayerNameById(candidate) .. ' juntos para sempre - casados desde ' .. os.date('%B %d, %Y.'))
        item2:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, player:getName() .. ' & ' .. getPlayerNameById(candidate) .. ' juntos para sempre - casados desde ' .. os.date('%B %d, %Y.'))
    else
        npcHandler:say('Seu parceiro não aceitou sua proposta ainda.', cid)
    end
    return true
end
		-- END --
	local function confirmRemoveEngage(cid, message, keywords, parameters, node)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
   
    local player = Player(cid)
    local playerStatus = getPlayerMarriageStatus(player:getGuid())
    local playerSpouse = getPlayerSpouse(player:getGuid())
    if playerStatus == PROPOSED_STATUS then
		
        npcHandler:say('Você tem certeza que quer remover sua proposta de casamento com {' .. getPlayerNameById(playerSpouse) .. '}?', cid)
        node:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 3, text = 'Ok, então vamos manter assim.'})
       
        local function removeEngage(cid, message, keywords, parameters, node)
            doPlayerAddItem(cid,ITEM_WEDDING_RING,1)
       doPlayerAddItem(cid,10503,1)
            setPlayerMarriageStatus(player:getGuid(), 0)
            setPlayerSpouse(player:getGuid(), -1)
            npcHandler:say(parameters.text, cid)
            keywordHandler:moveUp(parameters.moveup)
        end
        node:addChildKeyword({'yes'}, removeEngage, {moveup = 3, text = 'Ok, sua proposta de casamento para {' .. getPlayerNameById(playerSpouse) .. '} foi cancelada. Pegue seu anel.'})
    else
        npcHandler:say('Você não propôs a ninguém para cancelar uma proposta.', cid)
        keywordHandler:moveUp(2)
    end
    return true
end

local function confirmDivorce(cid, message, keywords, parameters, node)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
   
    local player = Player(cid)
    local playerStatus = getPlayerMarriageStatus(player:getGuid())
    local playerSpouse = getPlayerSpouse(player:getGuid())
    if playerStatus == MARRIED_STATUS then
        npcHandler:say('Você tem certeza que quer se divorciar de {' .. getPlayerNameById(playerSpouse) .. '}?', cid)
        node:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 3, text = 'Ótimo! Casamentos devem ser eternos.'})
       
        local function divorce(cid, message, keywords, parameters, node)
            local player = Player(cid)
            local spouse = getPlayerSpouse(player:getGuid())
            setPlayerMarriageStatus(player:getGuid(), 0)
            setPlayerSpouse(player:getGuid(), -1)
            setPlayerMarriageStatus(spouse, 0)
            setPlayerSpouse(spouse, -1)
            npcHandler:say(parameters.text, cid)
            keywordHandler:moveUp(parameters.moveup)
        end
        node:addChildKeyword({'yes'}, divorce, {moveup = 3, text = 'Ok, você se divorciou de {' .. getPlayerNameById(playerSpouse) .. '}. Pense melhor antes de se casar novamente com alguém.'})
    else
        npcHandler:say('Você não está casado para querer se divorciar.', cid)
        keywordHandler:moveUp(2)
    end
    return true
end

local node1 = keywordHandler:addKeyword({'marry'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você gostaria de se casar? Tenha certeza de trazer um anel de casamento wedding ring e uma roupa de casamenton {wedding outfit box} com você.'})
node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 1, text = 'Está bem.'})
local node2 = node1:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'E com quem você gostaria de se casar?'})
node2:addChildKeyword({'[%w]'}, tryEngage, {})

local node3 = keywordHandler:addKeyword({'celebration'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Todos os convidados de seu casamento estão aqui?.'})
node3:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 1, text = 'Então busque-os e traga-os aqui!.'})
local node4 = node3:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Bom, vamos começar {begin} então!.'}) --, confirmWedding, {})
node4:addChildKeyword({'begin'}, confirmWedding, {})


keywordHandler:addKeyword({'remove'}, confirmRemoveEngage, {})

keywordHandler:addKeyword({'divorce'}, confirmDivorce, {})

--keywordHandler:addKeyword({'celebration'}, confirmwedding,{})

npcHandler:setMessage(MESSAGE_GREET, "Seja bem-vindo em nome dos Deuses, peregrino |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Tenha cuidado em suas jornadas.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Tenha cuidado em suas jornadas.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
