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
	{ text = 'Esta ilha é muito pequena. Preciso da água do mar ao meu redor.' },
	{ text = 'Sem medo! O Sea Cat irá enviar você com segurança para o continente!' },
	{ text = 'Não há contrabando a bordo deste navio! Apenas 20 peças de qualquer produto ou criatura permitido!' },
	{ text = 'Venha o inferno ou a água alta, vamos chegar a qualquer porto que eu  possa navegar para você!' }
}
npcHandler:addModule(VoiceModule:new(voices))

function creatureSayCallback(cid, type, msg)
    if (msgcontains(msg, "hello") or msgcontains(msg, "hi")) and (not npcHandler:isFocused(cid)) then
        local player = Player(cid)
        local v, v2, k = player:getVocation(), player:getVocation():getId(), getCreatureName(cid)
		if vid == 0 then
            npcHandler:say(getPlayerSex(cid) == 0 and "Bem, olá, adorável senhorita! Não posso navegar em qualquer lugar sem que você tenha uma vocação {vocation}, no entanto. Devias falar primeiro com os Mestres {master} das quatro vocações, " .. k .. "." or "Que fofo, um recém-chegado. Harr. Não pode sair desta ilha sem uma vocação, sabia? Devias falar com os Mestres {master}  das quatro vocações primeiro, " .. k.. ".", cid)
            Topic[cid] = 0
        else
            npcHandler:say("Bem, bem, um {" .. v:getName() .. "} novato! Quer que eu te leve para um lugar agradável {" .. k .. "}?", cid)
            Topic[cid] = 1
        end
        Town[cid] = nil
        npcHandler:addFocus(cid)
    elseif(not npcHandler:isFocused(cid)) then
        return false
    elseif msgcontains(msg, "bye") or msgcontains(msg, "farewell") then
        npcHandler:say("Tem certeza de que deseja passar mais tempo neste pedaço de rocha? Eu posso lhe mostrar o mundo! Hein.", cid, TRUE)
        Topic[cid] = nil
        Town[cid] = nil
        npcHandler:releaseFocus(cid)
    elseif Topic[cid] == 1 then
        if msgcontains(msg, "yes") then
            npcHandler:say("{Boa}. Já tem tudo o que quer levar para o continente consigo? Armas, armaduras, equipamentos...", cid)
            Topic[cid] = 3
        elseif msgcontains(msg, "no") then
            npcHandler:say("Enquanto você toma tempo para refletir, vou passear por lá e fingir não ouvi você pensando.", cid)
            Topic[cid] = 3
        else
            npcHandler:say("Errr ... era uma língua estrangeira? Você poderia responder com um claro {yes} ou {no}?", cid)
            Topic[cid] = 1
        end
    elseif Topic[cid] == 2 then
        if msgcontains(msg, "yes") then
            npcHandler:say("Você gostaria de {TER AULAS} sobre as cidades Tibianas {ANTES DE PARTIR?} Caso contrario diga {NO} e vá direto para o continente", cid)
            Topic[cid] = 3
        elseif msgcontains(msg, "no") then
            npcHandler:say("Então prepare-se e volte mais tarde, hm?", cid)
            npcHandler:releaseFocus(cid)
            Topic[cid] = nil
        end
    elseif Topic[cid] == 3 then
        if msgcontains(msg, "aula") then
            npcHandler:say("Bem. Vamos falar sobre {Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Kazordoon}, {Liberty} {Bay}, {Port} {Hope}, {Svargrond}, {Thais}, {Venore} ou {Yalahar}?", cid)
            Topic[cid] = 0
        elseif msgcontains(msg, "yes") then
            npcHandler:say(isPremium(cid) and "Então, {você sabe tudo}, hein? Onde você quer que eu te leve então, novato? {Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Liberty Bay}, {Port Hope}, {Thais} ou {Venore}?" or "Então, você sabe tudo, hein? Onde você quer que eu te leve então, novato? {Ab'Dendriel}, {Carlin}, {Thais} ou {Venore}?", cid)
            Topic[cid] = 4
        end
    elseif Topic[cid] == 4 then
        if msgcontains(msg, "ab'Dendriel") then
            npcHandler:say("Então é Ab'Dendriel onde você quer morar? Apenas diga {yes} ou {no}?", cid)
            Topic[cid] = 5
            Town[cid] = "Ab'Dendriel"
        elseif msgcontains(msg, "Ankrahmun") then
            if isPremium(cid) then
                npcHandler:say("Então e Ankrahmun onde você quer morar? Apenas diga {yes} ou {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Ankrahmun'
            else
                npcHandler:say("Não, não posso levar você para este lugar sem uma conta premium. Deveria ficar feliz por você viajar de barco, geralmente um serviço premium, você sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "carlin") then
            npcHandler:say("Então é Carlin que você quer morar? Apenas diga {yes} ou {no}?", cid)
            Topic[cid] = 5
            Town[cid] = 'Carlin'
        elseif msgcontains(msg, "darashia") then
            if isPremium(cid) then
                npcHandler:say("Então é Darashia que você quer morar? Apenas diga {yes} or {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Darashia'
            else
                npcHandler:say("Não, não posso levar você para este lugar sem uma conta premium. Deveria ficar feliz por você viajar de barco, geralmente um serviço premium, você sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "edron") then
            if isPremium(cid) then
                npcHandler:say("Então e Edron que você quer morar? Apenas diga {yes} ou {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Edron'
            else
                npcHandler:say("Não, não posso levar você para este lugar sem uma conta premium. Deveria ficar feliz por você viajar de barco, geralmente um serviço premium, você sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "liberty bay") and msgcontains(msg, "sdfds") then
            if isPremium(cid) then
                npcHandler:say("Então e Liberty Bay que você quer morar? Apenas diga {yes} ou {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Liberty Bay'
            else
                npcHandler:say("Não, não posso levar você para este lugar sem uma conta premium. Deveria ficar feliz por você viajar de barco, geralmente um serviço premium, você sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "port hope") and msgcontains(msg, "dasads") then
            if isPremium(cid) then
                npcHandler:say("Então e Port Hope que você quer morar? Apenas diga {yes} ou {no}?", cid)
                Topic[cid] = 5
                Town[cid] = 'Port Hope'
            else
                npcHandler:say("Não, não posso levar você para este lugar sem uma conta premium. Deveria ficar feliz por você viajar de barco, geralmente um serviço premium, você sabia?", cid)
                Topic[cid] = 0
            end
        elseif msgcontains(msg, "thais") then
            npcHandler:say("Então, é Thais, o mais antigo dos reinos humanos que escolheu como seu novo lar? O que você diz, {yes} ou {no}?", cid)
            Topic[cid] = 5
            Town[cid] = 'Thais'
        elseif msgcontains(msg, "venore") then
            npcHandler:say("Hohoh, uma das cidades mais ricas, cheia de comerciantes e LOOT! Errr. Quero dizer, é ALTAMENTE recomendável para aventureiros inexperientes e de primeira viagem. Não sei por que eles construíram sobre um pântano fedido. Eu posso ir {sail} para lá se você quiser, {yes}.?", cid)
            Topic[cid] = 5
            Town[cid] = 'Venore'
        else
            npcHandler:say("O que? Seja o que for, não é um porto para o qual eu navegar.".. isPremium(cid) and "{Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Liberty Bay}, {Port Hope}, {Thais} ou {Venore}" or "{Ab\'Dendriel}, {Carlin}, {Thais} ou {Venore}" .."?", cid)
            Topic[cid] = 5
        end
    elseif msgcontains(msg, "passage") or msgcontains(msg, "sail") or msgcontains(msg, "travel") then
        if getPlayerVocation(cid) == 0 then
            npcHandler:say("Não, você não vai a lugar algum. Não posso lhe levar com você sem uma vocação {vocation}, sabia?", cid)
            Topic[cid] = 0
        else
            npcHandler:say("Então, sua nova cidade natal? Qual será?", cid)
            Topic[cid] = 4
        end
    elseif Topic[cid] == 5 then
        if msgcontains(msg, 'yes') then
            npcHandler:say("E nós vamos! Se você se perder, não se esqueca do guia no navio!", cid)
            local v = getTownId(Town[cid])
            npcHandler:releaseFocus(cid)
            doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
            doTeleportThing(cid, getTownTemplePosition(v))
            doSendMagicEffect(getTownTemplePosition(v), CONST_ME_TELEPORT)
            doPlayerSetTown(cid, v)
            Topic[cid] = nil
        else
            npcHandler:say("Mudou de ideia? Para qual cidade você quer que eu navegue? {Ab'Dendriel}, {Ankrahmun}, {Carlin}, {Darashia}, {Edron}, {Liberty Bay}, {Port Hope}, {Thais} ou {Venore}?", cid)
        end
 
        Topic[cid] = 0
    elseif msgcontains(msg, "venore") then
        npcHandler:say("Cidade dos tempos antigos. Na verdade, a cidade principal mais antiga de Tibia. Tenha cuidado nessas ruas, há bandidos por toda parte. Eu posso levá-lo se você quiser.", cid)
   
    end
    return true
end
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_WALKAWAY, "huh, figuras.")
