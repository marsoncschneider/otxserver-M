local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
local count = {}
local transfer = {}
 
function onCreatureAppear(cid)          npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()      npcHandler:onThink()        end
 
local voices = { {text = 'N�o se esque�a de depositar seu dinheiro aqui no Banco antes de sair para uma aventura.'} }
if VoiceModule then
    npcHandler:addModule(VoiceModule:new(voices))
end
--------------------------------guild bank-----------------------------------------------
local receiptFormat = 'Date: %s\nType: %s\nGold Amount: %d\nReceipt Owner: %s\nRecipient: %s\n\n%s'
local function getReceipt(info)
    local receipt = Game.createItem(info.success and 24301 or 24302)
    receipt:setAttribute(ITEM_ATTRIBUTE_TEXT, receiptFormat:format(os.date('%d. %b %Y - %H:%M:%S'), info.type, info.amount, info.owner, info.recipient, info.message))
 
    return receipt
end
 
local function getGuildIdByName(name, func)
    db.asyncStoreQuery('SELECT `id` FROM `guilds` WHERE `name` = ' .. db.escapeString(name),
        function(resultId)
            if resultId then
                func(result.getNumber(resultId, 'id'))
                result.free(resultId)
            else
                func(nil)
            end
        end
    )
end
 
local function getGuildBalance(id)
    local guild = Guild(id)
    if guild then
        return guild:getBankBalance()
    else
        local balance
        local resultId = db.storeQuery('SELECT `balance` FROM `guilds` WHERE `id` = ' .. id)
        if resultId then
            balance = result.getNumber(resultId, 'balance')
            result.free(resultId)
        end
 
        return balance
    end
end
 
local function setGuildBalance(id, balance)
    local guild = Guild(id)
    if guild then
        guild:setBankBalance(balance)
    else
        db.query('UPDATE `guilds` SET `balance` = ' .. balance .. ' WHERE `id` = ' .. id)
    end
end
 
local function transferFactory(playerName, amount, fromGuildId, info)
    return function(toGuildId)
        if not toGuildId then
            local player = Player(playerName)
            if player then
                info.success = false
                info.message = 'Lamentamos informar que n�o conseguimos cumprir seu pedido, porque n�o conseguimos encontrar a guilda do destinat�rio.'
                local inbox = player:getInbox()
                local receipt = getReceipt(info)
                inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
            end
        else
            local fromBalance = getGuildBalance(fromGuildId)
            if fromBalance < amount then
                info.success = false
                info.message = 'Lamentamos inform�-lo de que n�o poderíamos cumprir o seu pedido, devido a� falta da soma necess�ria na sua conta da guild.'
            else
                info.success = true
                info.message = 'Estamos felizes em informar que sua solicita��o de transfer�ncia foi realizada com sucesso.'
                setGuildBalance(fromGuildId, fromBalance - amount)
                setGuildBalance(toGuildId, getGuildBalance(toGuildId) + amount)
            end
 
            local player = Player(playerName)
            if player then
                local inbox = player:getInbox()
                local receipt = getReceipt(info)
                inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
            end
        end
    end
end
--------------------------------guild bank-----------------------------------------------
 
local function greetCallback(cid)
    count[cid], transfer[cid] = nil, nil
    return true
end
 
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    local player = Player(cid)
---------------------------- help ------------------------
    if msgcontains(msg, 'bank account') then
        npcHandler:say({
            'Todo Tibiano tem uma. A grande vantagem � que voc� pode acessar seu dinheiro em todos os ramos do Banco! ... ',
            'Gostaria de saber mais sobre as fun��es {basic} da sua conta banc�ria, as fun��es {advanced}, ou voc� j� est� entediado, talvez?'
        }, cid)
        npcHandler.topic[cid] = 0
        return true
---------------------------- balance ---------------------
--------------------------------guild bank-----------------------------------------------
    elseif msgcontains(msg, 'guild balance') then
        npcHandler.topic[cid] = 0
        if not player:getGuild() then
            npcHandler:say('Voc� n�o � um membro de uma guilda.', cid)
            return false
        end            
        npcHandler:say('O saldo da conta de sua Guild � ' .. player:getGuild():getBankBalance() .. ' Ouro.', cid)
        return true
--------------------------------guild bank-----------------------------------------------
    elseif msgcontains(msg, 'balance') then
        npcHandler.topic[cid] = 0
        if player:getBankBalance() >= 100000000 then
            npcHandler:say('Eu acho que voc� deve ser um dos habitantes mais ricos do mundo! O saldo da sua conta � ' .. player:getBankBalance() .. ' ouro.', cid)
            return true
        elseif player:getBankBalance() >= 10000000 then
            npcHandler:say('Voc� fez dez milh�es e ainda est� aumentando! O saldo da sua conta � ' .. player:getBankBalance() .. ' ouro.', cid)
            return true
        elseif player:getBankBalance() >= 1000000 then
            npcHandler:say('Uau, voc� alcan�ou o n�mero m�gico de um milh�o de GP !!! O saldo da sua conta � ' .. player:getBankBalance() .. ' ouro!', cid)
            return true
        elseif player:getBankBalance() >= 100000 then
            npcHandler:say('Voc� certamente fez um lindo centavo. O saldo da sua conta � ' .. player:getBankBalance() .. ' ouro.', cid)
            return true
        else
            npcHandler:say('O saldo da sua conta � ' .. player:getBankBalance() .. ' ouro.', cid)
            return true
        end
---------------------------- deposit ---------------------
--------------------------------guild bank-----------------------------------------------
    elseif msgcontains(msg, 'guild deposit') then
        if not player:getGuild() then
            npcHandler:say('Voc� n�o � membro de uma Guild', cid)
            npcHandler.topic[cid] = 0
            return false
        end
       -- count[cid] = player:getMoney()
       -- if count[cid] < 1 then
           -- npcHandler:say('Voc� n�o tem ouro suficiente.', cid)
           -- npcHandler.topic[cid] = 0
           -- return false
        --end
        if string.match(msg, '%d+') then
            count[cid] = getMoneyCount(msg)
            if count[cid] < 1 then
                npcHandler:say('Voc� n�o tem ouro suficiente.', cid)
                npcHandler.topic[cid] = 0
                return false
            end
            npcHandler:say('Gostaria de depositar ' .. count[cid] .. ' ouro para o seu {guild account}?', cid)
            npcHandler.topic[cid] = 23
            return true
        else
            npcHandler:say('Por favor, me diga quanto dinheiro voc� deseja depositar.', cid)
            npcHandler.topic[cid] = 22
            return true
        end
    elseif npcHandler.topic[cid] == 22 then
        count[cid] = getMoneyCount(msg)
        if isValidMoney(count[cid]) then
            npcHandler:say('Gostaria de depositar ' .. count[cid] .. ' ouro para sua {guild account}?', cid)
            npcHandler.topic[cid] = 23
            return true
        else
            npcHandler:say('Voc� n�o tem ouro suficiente.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
    elseif npcHandler.topic[cid] == 23 then
        if msgcontains(msg, 'yes') then        
            npcHandler:say('Tudo bem, n�s colocamos uma ordem para depositar a quantidade de ' .. count[cid] .. ' ouro para sua guild account. Verifique sua caixa de entrada para confirma��o.', cid)
            local guild = player:getGuild()
            local info = {
                type = 'Guild Deposit',
                amount = count[cid],
                owner = player:getName() .. ' of ' .. guild:getName(),
                recipient = guild:getName()
            }
            local playerBalance = player:getBankBalance()
            if playerBalance < tonumber(count[cid]) then
                info.message = 'Lamentamos inform�-lo de que n�o podemos cumprir seu pedido, devido a falta da soma necess�ria em sua conta banc�ria.'
                info.success = false
            else
                info.message = 'Estamos felizes em informar que sua solicita��o de transfer�ncia foi realizada com sucesso.'
                info.success = true
                guild:setBankBalance(guild:getBankBalance() + tonumber(count[cid]))
                player:setBankBalance(playerBalance - tonumber(count[cid]))                        
            end
 
            local inbox = player:getInbox()
            local receipt = getReceipt(info)
            inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
        elseif msgcontains(msg, 'no') then
            npcHandler:say('Como quiser. Existe algo mais que posso fazer por voc�?', cid)
        end
        npcHandler.topic[cid] = 0
        return true
--------------------------------guild bank-----------------------------------------------
    elseif msgcontains(msg, 'deposit') then
        count[cid] = player:getMoney()
        if count[cid] < 1 then
            npcHandler:say('Voc� n�o tem ouro suficiente.', cid)
            npcHandler.topic[cid] = 0
            return false
        end
        if msgcontains(msg, 'all') then
            count[cid] = player:getMoney()
            npcHandler:say('Gostaria de depositar ' .. count[cid] .. ' ouro?', cid)
            npcHandler.topic[cid] = 2
            return true
        else
            if string.match(msg,'%d+') then
                count[cid] = getMoneyCount(msg)
                if count[cid] < 1 then
                    npcHandler:say('Voc� n�o tem ouro suficiente.', cid)
                    npcHandler.topic[cid] = 0
                    return false
                end
                npcHandler:say('Gostaria de depositar ' .. count[cid] .. ' ouro?', cid)
                npcHandler.topic[cid] = 2
                return true
            else
                npcHandler:say('Por favor, me diga quanto dinheiro voc� deseja depositar.', cid)
                npcHandler.topic[cid] = 1
                return true
            end
        end
        if not isValidMoney(count[cid]) then
            npcHandler:say('Desculpe, mas voc� n�o pode depositar tanto.', cid)
            npcHandler.topic[cid] = 0
            return false
        end
    elseif npcHandler.topic[cid] == 1 then
        count[cid] = getMoneyCount(msg)
        if isValidMoney(count[cid]) then
            npcHandler:say('Gostaria de depositar ' .. count[cid] .. ' ouro?', cid)
            npcHandler.topic[cid] = 2
            return true
        else
            npcHandler:say('Voc� n�o tem ouro suficiente.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
    elseif npcHandler.topic[cid] == 2 then
        if msgcontains(msg, 'yes') then
            if player:getMoney() >= tonumber(count[cid]) then
                player:depositMoney(count[cid])
                npcHandler:say('Tudo bem, adicionamos a quantia de ' .. count[cid] .. ' ouro para sua {balance}. Agora voc� pode {withdraw} seu ouro a qualquer momento.', cid)
            else
                npcHandler:say('Voc� n�o tem ouro suficiente.', cid)
            end
        elseif msgcontains(msg, 'no') then
            npcHandler:say('Como quiser. Existe algo mais que posso fazer por voc�?', cid)
        end
        npcHandler.topic[cid] = 0
        return true
---------------------------- withdraw --------------------
--------------------------------guild bank-----------------------------------------------
    elseif msgcontains(msg, 'guild withdraw') then
        if not player:getGuild() then
            npcHandler:say('Desculpe, mas parece que voc� n�o est� atualmente em nenhuma Guild.', cid)
            npcHandler.topic[cid] = 0
            return false
        elseif player:getGuildLevel() < 2 then
            npcHandler:say('Apenas l�deres de guildas ou vice-l�deres podem retirar dinheiro da conta da Guild.', cid)
            npcHandler.topic[cid] = 0
            return false
        end
 
        if string.match(msg,'%d+') then
            count[cid] = getMoneyCount(msg)
            if isValidMoney(count[cid]) then
                npcHandler:say('Tem certeza de que deseja retirar ' .. count[cid] .. ' ouro da sua conta da Guild?', cid)
                npcHandler.topic[cid] = 25
            else
                npcHandler:say('N�o h� ouro suficiente na sua conta da Guild.', cid)
                npcHandler.topic[cid] = 0
            end
            return true
        else
            npcHandler:say('Por favor, me diga quanto ouro voc� gostaria de retirar da sua conta da guilda.', cid)
            npcHandler.topic[cid] = 24
            return true
        end
    elseif npcHandler.topic[cid] == 24 then
        count[cid] = getMoneyCount(msg)
        if isValidMoney(count[cid]) then
            npcHandler:say('Tem certeza de que deseja retirar ' .. count[cid] .. ' ouro da sua conta da Guild?', cid)
            npcHandler.topic[cid] = 25
        else
            npcHandler:say('N�o h� ouro suficiente na sua conta da Guild.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
    elseif npcHandler.topic[cid] == 25 then
        if msgcontains(msg, 'yes') then
            local guild = player:getGuild()
            local balance = guild:getBankBalance()
            npcHandler:say('Colocamos uma ordem para retirar ' .. count[cid] .. ' ouro da sua conta da Guild. Verifique sua caixa de entrada para confirma��o.', cid)
            local info = {
                type = 'Guild Withdraw',
                amount = count[cid],
                owner = player:getName() .. ' of ' .. guild:getName(),
                recipient = player:getName()
            }
            if balance < tonumber(count[cid]) then
                info.message = 'Lamentamos inform�-lo de que n�o podere�mos cumprir o seu pedido, devido a� falta da soma necess�ria na sua conta da guild.'
                info.success = false
            else
                info.message = 'Estamos felizes em informar que sua solicita��o de transfer�ncia foi realizada com sucesso.'
                info.success = true
                guild:setBankBalance(balance - tonumber(count[cid]))
                local playerBalance = player:getBankBalance()
                player:setBankBalance(playerBalance + tonumber(count[cid]))                        
            end
 
            local inbox = player:getInbox()
            local receipt = getReceipt(info)
            inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
            npcHandler.topic[cid] = 0
        elseif msgcontains(msg, 'no') then
            npcHandler:say('Como quiser. Existe algo mais que posso fazer por voc�?', cid)
            npcHandler.topic[cid] = 0
        end
        return true
--------------------------------guild bank-----------------------------------------------
    elseif msgcontains(msg, 'withdraw') then
        if string.match(msg,'%d+') then
            count[cid] = getMoneyCount(msg)
            if isValidMoney(count[cid]) then
                npcHandler:say('Tem certeza de que deseja retirar ' .. count[cid] .. ' ouro da sua conta banc�ria?', cid)
                npcHandler.topic[cid] = 7
            else
                npcHandler:say('N�o h� ouro suficiente na sua conta.', cid)
                npcHandler.topic[cid] = 0
            end
            return true
        else
            npcHandler:say('Por favor, me diga quanto ouro voc� gostaria de retirar.', cid)
            npcHandler.topic[cid] = 6
            return true
        end
    elseif npcHandler.topic[cid] == 6 then
        count[cid] = getMoneyCount(msg)
        if isValidMoney(count[cid]) then
            npcHandler:say('Tem certeza de que deseja retirar ' .. count[cid] .. ' ouro da sua conta banc�ria?', cid)
            npcHandler.topic[cid] = 7
        else
            npcHandler:say('N�o h� ouro suficiente na sua conta.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
    elseif npcHandler.topic[cid] == 7 then
        if msgcontains(msg, 'yes') then
            if player:getFreeCapacity() >= getMoneyWeight(count[cid]) then
                if not player:withdrawMoney(count[cid]) then
                    npcHandler:say('N�o h� ouro suficiente na sua conta.', cid)
                else
                    npcHandler:say('Aqui est�, ' .. count[cid] .. ' ouro. Por favor, deixe-me saber se h� algo mais que posso fazer por voc�.', cid)
                end
            else
                npcHandler:say('Whoah, aguarde, voc� n�o tem espa�o em seu invent�rio para transportar todas essas moedas. Eu n�o quero que voc� deixe cair no ch�o, talvez volte com um carrinho!', cid)
            end
            npcHandler.topic[cid] = 0
        elseif msgcontains(msg, 'no') then
            npcHandler:say('O cliente � rei! Volte sempre que quiser, se desejar retirar o seu dinheiro.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
---------------------------- transfer --------------------
--------------------------------guild bank-----------------------------------------------
    elseif msgcontains(msg, 'guild transfer') then
        if not player:getGuild() then
            npcHandler:say('Desculpe, mas parece que voc� n�o est� atualmente em nenhuma Guild.', cid)
            npcHandler.topic[cid] = 0
            return false
        elseif player:getGuildLevel() < 2 then
            npcHandler:say('Somente l�deres de guildas ou vice-l�deres podem transferir dinheiro da conta da guilda.', cid)
            npcHandler.topic[cid] = 0
            return false
        end
 
        if string.match(msg, '%d+') then
            count[cid] = getMoneyCount(msg)
            if isValidMoney(count[cid]) then
                transfer[cid] = string.match(msg, 'to%s*(.+)$')
                if transfer[cid] then
                    npcHandler:say('Ent�o, voc� gostaria de transferir ' .. count[cid] .. ' ouro da sua conta da Guild to guild ' .. transfer[cid] .. '?', cid)
                    npcHandler.topic[cid] = 28
                else
                    npcHandler:say('Qual guild voc� gostaria de transferir ' .. count[cid] .. ' ouro para?', cid)
                    npcHandler.topic[cid] = 27
                end
            else
                npcHandler:say('N�o h� ouro suficiente na sua conta da Guild.', cid)
                npcHandler.topic[cid] = 0
            end
        else
            npcHandler:say('Por favor, conte-me a quantidade de ouro que voc� gostaria de transferir.', cid)
            npcHandler.topic[cid] = 26
        end
        return true
    elseif npcHandler.topic[cid] == 26 then
        count[cid] = getMoneyCount(msg)
        if player:getGuild():getBankBalance() < count[cid] then
            npcHandler:say('N�o h� ouro suficiente na sua conta da Guild.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        if isValidMoney(count[cid]) then
            npcHandler:say('Qual guild voc� gostaria de transferir ' .. count[cid] .. ' ouro para?', cid)
            npcHandler.topic[cid] = 27
        else
            npcHandler:say('N�o h� ouro suficiente na sua conta.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
    elseif npcHandler.topic[cid] == 27 then
        transfer[cid] = msg
        if player:getGuild():getName() == transfer[cid] then
            npcHandler:say('Preencha este campo com a pessoa que ir� receber o seu ouro!', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        npcHandler:say('Ent�o, voc� gostaria de transferir ' .. count[cid] .. ' ouro da sua conta da Guild to guild ' .. transfer[cid] .. '?', cid)
        npcHandler.topic[cid] = 28
        return true
    elseif npcHandler.topic[cid] == 28 then
        if msgcontains(msg, 'yes') then
            npcHandler:say('Passamos um pedido para transferir ' .. count[cid] .. ' ouro da sua conta da Guild to guild ' .. transfer[cid] .. '. Verifique sua caixa de entrada para confirma��o.', cid)
            local guild = player:getGuild()
            local balance = guild:getBankBalance()
            local info = {
                type = 'Guild to Guild Transfer',
                amount = count[cid],
                owner = player:getName() .. ' of ' .. guild:getName(),
                recipient = transfer[cid]
            }
            if balance < tonumber(count[cid]) then
                info.message = 'Lamentamos inform�-lo de que n�o poder�amos cumprir o seu pedido, devido a falta da soma necess�ria na sua conta da guild.'
                info.success = false
                local inbox = player:getInbox()
                local receipt = getReceipt(info)
                inbox:addItemEx(receipt, INDEX_WHEREEVER, FLAG_NOLIMIT)
            else
                getGuildIdByName(transfer[cid], transferFactory(player:getName(), tonumber(count[cid]), guild:getId(), info))                  
            end
            npcHandler.topic[cid] = 0
        elseif msgcontains(msg, 'no') then
            npcHandler:say('Tudo bem, existe algo mais que posso fazer por voc�?', cid)
        end
        npcHandler.topic[cid] = 0
--------------------------------guild bank-----------------------------------------------
    elseif msgcontains(msg, 'transfer') then
        npcHandler:say('Por favor, conte-me a quantidade de ouro que voc� gostaria de transferir.', cid)
        npcHandler.topic[cid] = 11
    elseif npcHandler.topic[cid] == 11 then
        count[cid] = getMoneyCount(msg)
        if player:getBankBalance() < count[cid] then
            npcHandler:say('N�o h� ouro suficiente na sua conta.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        if isValidMoney(count[cid]) then
            npcHandler:say('Quem voc� gostaria de transferir ' .. count[cid] .. ' ouro para?', cid)
            npcHandler.topic[cid] = 12
        else
            npcHandler:say('N�o h� ouro suficiente na sua conta.', cid)
            npcHandler.topic[cid] = 0
        end
    elseif npcHandler.topic[cid] == 12 then
        transfer[cid] = msg
        if player:getName() == transfer[cid] then
            npcHandler:say('Preencha este campo com a pessoa que ir� receber o seu ouro!', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        if playerExists(transfer[cid]) then
           local arrayDenied = {"accountmanager", "rooksample", "druidsample", "sorcerersample", "knightsample", "paladinsample"}
		    if isInArray(arrayDenied, string.gsub(transfer[cid]:lower(), " ", "")) then
                npcHandler:say('Este jogador n�o existe.', cid)
                npcHandler.topic[cid] = 0
                return true
            end
            npcHandler:say('Ent�o, voc� gostaria de transferir ' .. count[cid] .. ' ouro para ' .. transfer[cid] .. '?', cid)
            npcHandler.topic[cid] = 13
        else
            npcHandler:say('Este jogador n�o existe.', cid)
            npcHandler.topic[cid] = 0
        end
    elseif npcHandler.topic[cid] == 13 then
        if msgcontains(msg, 'yes') then
            if not player:transferMoneyTo(transfer[cid], count[cid]) then
                npcHandler:say('Voc� n�o pode transferir dinheiro para esta conta', cid)
            else
                npcHandler:say('Muito bem. Voc� transferiu ' .. count[cid] .. ' ouro para ' .. transfer[cid] ..'.', cid)
                transfer[cid] = nil
            end
        elseif msgcontains(msg, 'no') then
            npcHandler:say('Tudo bem, existe algo mais que posso fazer por voc�?', cid)
        end
        npcHandler.topic[cid] = 0
---------------------------- money exchange --------------
    elseif msgcontains(msg, 'change gold') then
        npcHandler:say('Quantas moedas de platina voc� gostaria de obter?', cid)
        npcHandler.topic[cid] = 14
    elseif npcHandler.topic[cid] == 14 then
        if getMoneyCount(msg) < 1 then
            npcHandler:say('Desculpe, voc� n�o tem moedas de ouro suficientes.', cid)
            npcHandler.topic[cid] = 0
        else
            count[cid] = getMoneyCount(msg)
            npcHandler:say('Ent�o, voc� gostaria que eu mudasse ' .. count[cid] * 100 .. ' de suas moedas de ouro ' .. count[cid] .. ' moedas de platina?', cid)
            npcHandler.topic[cid] = 15
        end
    elseif npcHandler.topic[cid] == 15 then
        if msgcontains(msg, 'yes') then
            if player:removeItem(2148, count[cid] * 100) then
                player:addItem(2152, count[cid])
                npcHandler:say('Aqui est�.', cid)
            else
                npcHandler:say('Desculpe, voc� n�o tem moedas de ouro suficientes.', cid)
            end
        else
            npcHandler:say('Bem, posso ajud�-lo com outra coisa?', cid)
        end
        npcHandler.topic[cid] = 0
    elseif msgcontains(msg, 'change platinum') then
        npcHandler:say('Gostaria de mudar seus moedas de platina em ouro ou cristal?', cid)
        npcHandler.topic[cid] = 16
    elseif npcHandler.topic[cid] == 16 then
        if msgcontains(msg, 'gold') then
            npcHandler:say('Quantos moedas de platina voc� gostaria de mudar em ouro?', cid)
            npcHandler.topic[cid] = 17
        elseif msgcontains(msg, 'crystal') then
            npcHandler:say('Quantas moedas de cristal voc� gostaria de obter?', cid)
            npcHandler.topic[cid] = 19
        else
            npcHandler:say('Bem, posso ajud�-lo com outra coisa?', cid)
            npcHandler.topic[cid] = 0
        end
    elseif npcHandler.topic[cid] == 17 then
        if getMoneyCount(msg) < 1 then
            npcHandler:say('Desculpe, voc� n�o tem suficientes moedas de platina.', cid)
            npcHandler.topic[cid] = 0
        else
            count[cid] = getMoneyCount(msg)
            npcHandler:say('Ent�o, voc� gostaria que eu mudasse ' .. count[cid] .. ' de seus moedas de platina em ' .. count[cid] * 100 .. ' moedas de ouro para voc�?', cid)
            npcHandler.topic[cid] = 18
        end
    elseif npcHandler.topic[cid] == 18 then
        if msgcontains(msg, 'yes') then
            if player:removeItem(2152, count[cid]) then
                player:addItem(2148, count[cid] * 100)
                npcHandler:say('Aqui est�.', cid)
            else
                npcHandler:say('Desculpe, voc� n�o tem suficientes moedas de platina.', cid)
            end
        else
            npcHandler:say('Bem, posso ajud�-lo com outra coisa?', cid)
        end
        npcHandler.topic[cid] = 0
    elseif npcHandler.topic[cid] == 19 then
        if getMoneyCount(msg) < 1 then
            npcHandler:say('Desculpe, voc� n�o tem o suficiente moedas de platina.', cid)
            npcHandler.topic[cid] = 0
        else
            count[cid] = getMoneyCount(msg)
            npcHandler:say('Ent�o, voc� gostaria que eu mudasse ' .. count[cid] * 100 .. ' de seus moedas de platina em ' .. count[cid] .. ' moedas de cristal para voc�?', cid)
            npcHandler.topic[cid] = 20
        end
    elseif npcHandler.topic[cid] == 20 then
        if msgcontains(msg, 'yes') then
            if player:removeItem(2152, count[cid] * 100) then
                player:addItem(2160, count[cid])
                npcHandler:say('Aqui est�.', cid)
            else
                npcHandler:say('Desculpe, voc� n�o tem o suficiente moedas de platina.', cid)
            end
        else
            npcHandler:say('Bem, posso ajud�-lo com outra coisa?', cid) 
        end
        npcHandler.topic[cid] = 0
		
    elseif msgcontains(msg, 'change crystal') then
        npcHandler:say('Quantas moedas de cristal voc� gostaria de transformar em platina?', cid)
        npcHandler.topic[cid] = 21
    elseif npcHandler.topic[cid] == 21 then
        if getMoneyCount(msg) < 1 then
            npcHandler:say('Desculpe, voc� n�o tem o suficiente moedas de cristal.', cid)
            npcHandler.topic[cid] = 0
        else
            count[cid] = getMoneyCount(msg)
            npcHandler:say('Ent�o, voc� gostaria que eu mudasse ' .. count[cid] .. ' de suas moedas de cristal ' .. count[cid] * 100 .. ' moedas de platina para voc�?', cid)
            npcHandler.topic[cid] = 22
        end
    elseif npcHandler.topic[cid] == 22 then
        if msgcontains(msg, 'yes') then
            if player:removeItem(2160, count[cid])  then
                player:addItem(2152, count[cid] * 100)
                npcHandler:say('Aqui est�.', cid)
            else
                npcHandler:say('Desculpe, voc� n�o tem o suficiente crystal coins.', cid)
            end
        else
            npcHandler:say('Bem, posso ajud�-lo com outra coisa?', cid)
        end
        npcHandler.topic[cid] = 0
    end
    return true
end
 
keywordHandler:addKeyword({'money'}, StdModule.say, {npcHandler = npcHandler, text = 'N�s podemos {change} dinheiro para voc�. Voc� tamb�m pode acessar seu {bank account}.'})
keywordHandler:addKeyword({'change'}, StdModule.say, {npcHandler = npcHandler, text = 'Existem tr�s tipos de moedas diferentes no Tibia: 100 moedas de ouro igual a 1 moeda de platina, 100 moedas de platina igual a 1 moeda de cristal. Ent�o, se voc� quiser mudar 100 de ouro em 1 platina, simplesmente diga {change gold} e ent�o 1 platinum.'})
keywordHandler:addKeyword({'bank'}, StdModule.say, {npcHandler = npcHandler, text = 'N�s podemos {change} dinheiro para voc�. Voc� tamb�m pode acessar sua {bank account}.'})
keywordHandler:addKeyword({'advanced'}, StdModule.say, {npcHandler = npcHandler, text = 'Sua conta banc�ria ser� usada automaticamente quando voc� quiser alugar uma casa ou colocar uma oferta em um item no {market}. Deixe-me saber se voc� quer saber sobre como funciona.'})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� pode verificar o {balance} da sua conta banc�ria, {deposit} dinheiro ou {withdraw}. Voc� tamb�m pode transferir dinheiro para outros personagens, desde que tenham uma voca��o.'})
keywordHandler:addKeyword({'functions'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� pode verificar o {balance} da sua conta banc�ria, {deposit} dinheiro ou {withdraw}. Voc� tamb�m pode transferir dinheiro para outros personagens, desde que tenham uma voca��o.'})
keywordHandler:addKeyword({'basic'}, StdModule.say, {npcHandler = npcHandler, text = 'Voc� pode verificar o {balance} da sua conta banc�ria, {deposit} dinheiro ou {withdraw}. Voc� tamb�m pode transferir dinheiro para outros personagens, desde que tenham uma voca��o.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'Eu trabalho neste banco. Posso mudar o dinheiro para voc� e ajud�-lo com sua conta banc�ria.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome � Naji. Minha m�e me deu esse nome porque conhecia um paladino com esse nome. Eu sou um ca�ador de reposi��o sozinho, voc� sabe! Eu quero juntar-me � {Elite de Ca�a - Paw and Fur)!"})
keywordHandler:addKeyword({'paw and fur'}, StdModule.say, {npcHandler = npcHandler, text = "O Paw and Fur - Hunting Elite � uma sociedade de ca�a rec�m-fundada em Port Hope. Dizem que eles te enviam na miss�o de ca�a. Parece �timo se voc� me perguntar."})
 
npcHandler:setMessage(MESSAGE_GREET, "Sim? O que posso fazer por voc�, |PLAYERNAME|? Neg�cios banc�rios, talvez?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Tenha um �timo dia.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Tenha um �timo dia.")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())