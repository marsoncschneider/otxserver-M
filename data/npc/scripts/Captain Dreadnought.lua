local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local Topic, Town = {}, {}
function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)    npcHandler:onCreatureSay(cid, type, msg) end
function onThink()				npcHandler:onThink()					end

local voices = {
	{ text = 'Todos a bordo! Preparem-se para navegar!' },
	{ text = 'Esta ilha � muito pequena. Preciso da �gua do mar ao meu redor.' },
	{ text = 'Sem medo! O Sea Cat ir� enviar voc� com seguran�a para o continente!' },
	{ text = 'N�o h� contrabando a bordo deste navio! Apenas 20 pe�as de qualquer produto ou criatura permitido!' },
	{ text = 'Venha o inferno ou a �gua alta, vamos chegar a qualquer porto que eu  possa navegar para voc�!' }
}
npcHandler:addModule(VoiceModule:new(voices))

function creatureSayCallback(cid, type, msg)
    if (msgcontains(msg, "hello") or msgcontains(msg, "hi")) and (not npcHandler:isFocused(cid)) then
        local player = Player(cid)
        local v, v2, k = player:getVocation(), player:getVocation():getId(), getCreatureName(cid)
		if vid == 0 then
            npcHandler:say(getPlayerSex(cid) == 0 and "Bem, ol�, ador�vel senhorita! N�o posso navegar em qualquer lugar sem que voc� tenha uma voca��o {vocation}, no entanto. Devias falar primeiro com os Mestres {master} das quatro voca��es, " .. k .. "." or "Que fofo, um rec�m-chegado. Harr. N�o pode sair desta ilha sem uma voca��o, sabia? Devias falar com os Mestres {master}  das quatro voca��es primeiro, " .. k.. ".", cid)
            Topic[cid] = 0
        else
            npcHandler:say("Bem, bem, um {" .. v:getName() .. "} novato! Quer que eu te leve para um lugar agrad�vel {" .. k .. "}?", cid)
            Topic[cid] = 1
        end
        Town[cid] = nil
        npcHandler:addFocus(cid)
    elseif(not npcHandler:isFocused(cid)) then
        return false
    elseif msgcontains(msg, "bye") or msgcontains(msg, "farewell") then
        npcHandler:say("Tem certeza de que deseja passar mais tempo neste peda�o de rocha? Eu posso lhe mostrar o mundo! Hein.", cid, TRUE)
        Topic[cid] = nil
        Town[cid] = nil
        npcHandler:releaseFocus(cid)
    elseif Topic[cid] == 1 then
        if msgcontains(msg, "yes") then
            npcHandler:say("{Boa}. J� tem tudo o que quer levar para o continente consigo? Armas, armaduras, equipamentos...", cid)
            Topic[cid] = 3
        elseif msgcontains(msg, "no") then
            npcHandler:say("Enquanto voc� toma tempo para refletir, vou passear por l� e fingir n�o ouvi voc� pensando.", cid)
            Topic[cid] = 3
        else
            npcHandler:say("Errr ... era uma l�ngua estrangeira? Voc� poderia responder com um claro {yes} ou {no}?", cid)
            Topic[cid] = 1
        end
    elseif Topic[cid] == 2 then
        if msgcontains(msg, "yes") then
            npcHandler:say("Voc� gostaria de {TER AULAS} sobre as cidades Tibianas {ANTES DE PARTIR?} Caso contrario diga {NO} e v� direto para o continente", cid)
            Topic[cid] = 3
        elseif msgcontains(msg, "no") then
            npcHandler:say("Ent�o prepare-se e volte mais tarde, hm?", cid)
            npcHandler:releaseFocus(cid)
            Topic[cid] = nil
        end
    elseif Topic[cid] == 3 then
        if msgcontains(msg, "aula") then
            npcHandler:say("Bem. Vamos falar sobre {Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Kazordoon}, {Liberty} {Bay}, {Port} {Hope}, {Svargrond}, {Thais}, {Venore} ou {Yalahar}?", cid)
            Topic[cid] = 0
        elseif msgcontains(msg, "yes") then
            npcHandler:say(isPremium(cid) and "Ent�o, {voc� sabe tudo}, hein? Onde voc� quer que eu te leve ent�o, novato? {Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Liberty Bay}, {Port Hope}, {Thais} ou {Venore}?" or "Ent�o, voc� sabe tudo, hein? Onde voc� quer que eu te leve ent�o, novato? {Ab'Dendriel}, {Carlin}, {Thais} ou {Venore}?", cid)
            Topic[cid] = 4
        end
    elseif Topic[cid] == 4 then
        if msgcontains(msg, "ab'Dendriel") then
            npcHandler:say("Ent�o � Ab'Dendriel onde voc� quer morar? Apenas diga {yes} ou {no}?", cid)
            Topic[cid] = 5
            Town[cid] = "Ab'Dendriel"
        elseif msgcontains(msg, "Ankrahmun") then
            if isPremium(cid) then
                npcHandler:say("Ent�o e Ankrahmun onde voc� quer morar? Apenas diga {yes} ou {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Ankrahmun'
            else
                npcHandler:say("N�o, n�o posso levar voc� para este lugar sem uma conta premium. Deveria ficar feliz por voc� viajar de barco, geralmente um servi�o premium, voc� sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "carlin") then
            npcHandler:say("Ent�o � Carlin que voc� quer morar? Apenas diga {yes} ou {no}?", cid)
            Topic[cid] = 5
            Town[cid] = 'Carlin'
        elseif msgcontains(msg, "darashia") then
            if isPremium(cid) then
                npcHandler:say("Ent�o � Darashia que voc� quer morar? Apenas diga {yes} or {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Darashia'
            else
                npcHandler:say("N�o, n�o posso levar voc� para este lugar sem uma conta premium. Deveria ficar feliz por voc� viajar de barco, geralmente um servi�o premium, voc� sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "edron") then
            if isPremium(cid) then
                npcHandler:say("Ent�o e Edron que voc� quer morar? Apenas diga {yes} ou {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Edron'
            else
                npcHandler:say("N�o, n�o posso levar voc� para este lugar sem uma conta premium. Deveria ficar feliz por voc� viajar de barco, geralmente um servi�o premium, voc� sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "liberty bay") and msgcontains(msg, "sdfds") then
            if isPremium(cid) then
                npcHandler:say("Ent�o e Liberty Bay que voc� quer morar? Apenas diga {yes} ou {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Liberty Bay'
            else
                npcHandler:say("N�o, n�o posso levar voc� para este lugar sem uma conta premium. Deveria ficar feliz por voc� viajar de barco, geralmente um servi�o premium, voc� sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "port hope") and msgcontains(msg, "dasads") then
            if isPremium(cid) then
                npcHandler:say("Ent�o e Port Hope que voc� quer morar? Apenas diga {yes} ou {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Port Hope'
            else
                npcHandler:say("N�o, n�o posso levar voc� para este lugar sem uma conta premium. Deveria ficar feliz por voc� viajar de barco, geralmente um servi�o premium, voc� sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "thais") then
            npcHandler:say("Ent�o, � Thais, o mais antigo dos reinos humanos que escolheu como seu novo lar? O que voc� diz, {yes} ou {no}?", cid)
            Topic[cid] = 5
            Town[cid] = 'Thais'
        elseif msgcontains(msg, "venore") then
            npcHandler:say("Hohoh, uma das cidades mais ricas, cheia de comerciantes e LOOT! Errr. Quero dizer, � ALTAMENTE recomend�vel para aventureiros inexperientes e de primeira viagem. N�o sei por que eles constru�ram sobre um p�ntano fedido. Eu posso ir {sail} para l� se voc� quiser, {yes}.?", cid)
            Topic[cid] = 5
            Town[cid] = 'Venore'
        else
            npcHandler:say("O que? Seja o que for, n�o � um porto para o qual eu navegar.".. isPremium(cid) and "{Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Liberty Bay}, {Port Hope}, {Thais} ou {Venore}" or "{Ab\'Dendriel}, {Carlin}, {Thais} ou {Venore}" .."?", cid)
            Topic[cid] = 5
        end
    elseif msgcontains(msg, "passage") or msgcontains(msg, "sail") or msgcontains(msg, "travel") then
        if getPlayerVocation(cid) == 0 then
            npcHandler:say("N�o, voc� n�o vai a lugar algum. N�o posso lhe levar com voc� sem uma voca��o {vocation}, sabia?", cid)
            Topic[cid] = 0
        else
            npcHandler:say("Ent�o, sua nova cidade natal? Qual ser�?", cid)
            Topic[cid] = 4
        end
    elseif Topic[cid] == 5 then
        if msgcontains(msg, 'yes') then
            npcHandler:say("E n�s vamos! Se voc� se perder, n�o se esqueca do guia no navio!", cid)
            local v = getTownId(Town[cid])
            npcHandler:releaseFocus(cid)
            doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
            doTeleportThing(cid, getTownTemplePosition(v))
            doSendMagicEffect(getTownTemplePosition(v), CONST_ME_TELEPORT)
            doPlayerSetTown(cid, v)
            Topic[cid] = nil
        else
            npcHandler:say("Mudou de ideia? Para qual cidade voc� quer que eu navegue? {Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Liberty Bay}, {Port Hope}, {Thais} ou {Venore}?", cid)
        end
 
        Topic[cid] = 0
    elseif msgcontains(msg, "venore") then
        npcHandler:say("Cidade dos tempos antigos. Na verdade, a cidade principal mais antiga de Tibia. Tenha cuidado nessas ruas, h� bandidos por toda parte. Eu posso lev�-lo se voc� quiser.", cid)
   
    end
    return true
end
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_WALKAWAY, "huh, figuras.")
