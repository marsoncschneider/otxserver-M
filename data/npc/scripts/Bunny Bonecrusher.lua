local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'hail general'}, StdModule.say, {npcHandler = npcHandler, text = "Saudações, plebeus |PLAYERNAME|!"})
keywordHandler:addKeyword({'how', 'are', 'you'}, StdModule.say, {npcHandler = npcHandler, text = "Estamos em treinamento constante e em perfeita saúde."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou o general do exército da rainha. Não tenho tempo para explicar este conceito para você."})
keywordHandler:addKeyword({'bonecrusher'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa família tem servido o exército Carlin desde inúmeras gerações!"})
keywordHandler:addKeyword({'sister'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa família tem servido o exército Carlin desde inúmeras gerações!"})
keywordHandler:addKeyword({'family'}, StdModule.say, {npcHandler = npcHandler, text = "Ela é uma das minhas amadas irmãs e serve Carlin como guarda da cidade."})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, text = "SALVE A RAINHA ELOISA, A NOBRE {LEADER}!"})
keywordHandler:addKeyword({'leader'}, StdModule.say, {npcHandler = npcHandler, text = "A rainha Eloise é um bom líder para nossa cidade justa, de fato!"})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, text = "O exército protege os homens indefesos da nossa {cidade}. Nossas forças de elite são as {Ferrets verdes}."})
keywordHandler:addKeyword({'city'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa cidade se mistura com a natureza que o rodeia. Nossos {druids} cuidam disso."})
keywordHandler:addKeyword({'druids'}, StdModule.say, {npcHandler = npcHandler, text = "Eles são o nosso principal suporte mágico e desempenham um papel importante em nossa batalha {tactics}."})
keywordHandler:addKeyword({'tactics'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa tática é beijar."})
keywordHandler:addKeyword({'kiss'}, StdModule.say, {npcHandler = npcHandler, text = "B.E.I.J.O.! Mantenha isso simples, idiota! Táticas complicadas são muito fáceis de serem esmagadas por um toque de destino."})
keywordHandler:addKeyword({'green ferrets'}, StdModule.say, {npcHandler = npcHandler, text = "Nossas forças de elite são treinadas por rangers e druidas. Na floresta, eles ficam próximos dos duendes."})
keywordHandler:addKeyword({'join'}, StdModule.say, {npcHandler = npcHandler, text = "Entrar para que?"})
keywordHandler:addKeyword({'join army'}, StdModule.say, {npcHandler = npcHandler, text = "Desculpe, não recrutamos estrangeiros. Talvez você possa se juntar se você se provar em uma missão para a rainha."})

npcHandler:addModule(FocusModule:new())
