 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local function creatureSayCallback(cid, type, msg)
	npcHandler:say('O Sistema de casamentos est� desabilitado.', cid)
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
        delayedSay('Caros amigos e familiares, n�s estamos reunidos aqui hoje para apoiar e celebrar a uni�o de ' .. getPlayerNameById(candidate) .. ' e ' .. player:getName() .. ' em um casamento.')
        delayedSay('Em todo esse tempo juntos, eles vieram a acreditar que podem realizar seus sonhos, esperan�as e acreditam que seus objetivos ser�o mais facilmente alcan�ados atrav�s da combina��o de suas almas e o amor;',5000)
        delayedSay('e ent�o eles decidiram viver juntos, como marido e mulher. E agora, pelo poder a mim concedido pelos Deuses do Tibia, eu vos declaro marido e mulher.',15000)
        delayedSay('*Depois de uma ben��o, abre sua m�o para ' .. player:getName() .. '* Pegue um desses an�is gravados e d� um a sua esposa.',22000)
        delayedSay('Pode beijar a noiva.',28000)
        local item1 = Item(doPlayerAddItem(cid,ITEM_ENGRAVED_WEDDING_RING,1))
        local item2 = Item(doPlayerAddItem(cid,ITEM_ENGRAVED_WEDDING_RING,1))
        item1:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, player:getName() .. ' & ' .. getPlayerNameById(candidate) .. ' juntos para sempre - casados desde ' .. os.date('%B %d, %Y.'))
        item2:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, player:getName() .. ' & ' .. getPlayerNameById(candidate) .. ' juntos para sempre - casados desde ' .. os.date('%B %d, %Y.'))
    else
        npcHandler:say('Seu parceiro n�o aceitou sua proposta ainda.', cid)
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
		
        npcHandler:say('Voc� tem certeza que quer remover sua proposta de casamento com {' .. getPlayerNameById(playerSpouse) .. '}?', cid)
        node:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 3, text = 'Ok, ent�o vamos manter assim.'})
       
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
        npcHandler:say('Voc� n�o prop�s a ningu�m para cancelar uma proposta.', cid)
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
        npcHandler:say('Voc� tem certeza que quer se divorciar de {' .. getPlayerNameById(playerSpouse) .. '}?', cid)
        node:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 3, text = '�timo! Casamentos devem ser eternos.'})
       
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
        node:addChildKeyword({'yes'}, divorce, {moveup = 3, text = 'Ok, voc� se divorciou de {' .. getPlayerNameById(playerSpouse) .. '}. Pense melhor antes de se casar novamente com algu�m.'})
    else
        npcHandler:say('Voc� n�o est� casado para querer se divorciar.', cid)
        keywordHandler:moveUp(2)
    end
    return true
end

local node1 = keywordHandler:addKeyword({'marry'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voc� gostaria de se casar? Tenha certeza de trazer um anel de casamento wedding ring e uma roupa de casamenton {wedding outfit box} com voc�.'})
node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 1, text = 'Est� bem.'})
local node2 = node1:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'E com quem voc� gostaria de se casar?'})
node2:addChildKeyword({'[%w]'}, tryEngage, {})

local node3 = keywordHandler:addKeyword({'celebration'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Todos os convidados de seu casamento est�o aqui?.'})
node3:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 1, text = 'Ent�o busque-os e traga-os aqui!.'})
local node4 = node3:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Bom, vamos come�ar {begin} ent�o!.'}) --, confirmWedding, {})
node4:addChildKeyword({'begin'}, confirmWedding, {})


keywordHandler:addKeyword({'remove'}, confirmRemoveEngage, {})

keywordHandler:addKeyword({'divorce'}, confirmDivorce, {})

--keywordHandler:addKeyword({'celebration'}, confirmwedding,{})

npcHandler:setMessage(MESSAGE_GREET, "Seja bem-vindo em nome dos Deuses, peregrino |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Tenha cuidado em suas jornadas.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Tenha cuidado em suas jornadas.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
