local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'hail general'}, StdModule.say, {npcHandler = npcHandler, text = "Sauda��es, plebeus |PLAYERNAME|!"})
keywordHandler:addKeyword({'how', 'are', 'you'}, StdModule.say, {npcHandler = npcHandler, text = "Estamos em treinamento constante e em perfeita sa�de."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou o general do ex�rcito da rainha. N�o tenho tempo para explicar este conceito para voc�."})
keywordHandler:addKeyword({'bonecrusher'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa fam�lia tem servido o ex�rcito Carlin desde in�meras gera��es!"})
keywordHandler:addKeyword({'sister'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa fam�lia tem servido o ex�rcito Carlin desde in�meras gera��es!"})
keywordHandler:addKeyword({'family'}, StdModule.say, {npcHandler = npcHandler, text = "Ela � uma das minhas amadas irm�s e serve Carlin como guarda da cidade."})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, text = "SALVE A RAINHA ELOISA, A NOBRE {LEADER}!"})
keywordHandler:addKeyword({'leader'}, StdModule.say, {npcHandler = npcHandler, text = "A rainha Eloise � um bom l�der para nossa cidade justa, de fato!"})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, text = "O ex�rcito protege os homens indefesos da nossa {cidade}. Nossas for�as de elite s�o as {Ferrets verdes}."})
keywordHandler:addKeyword({'city'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa cidade se mistura com a natureza que o rodeia. Nossos {druids} cuidam disso."})
keywordHandler:addKeyword({'druids'}, StdModule.say, {npcHandler = npcHandler, text = "Eles s�o o nosso principal suporte m�gico e desempenham um papel importante em nossa batalha {tactics}."})
keywordHandler:addKeyword({'tactics'}, StdModule.say, {npcHandler = npcHandler, text = "Nossa t�tica � beijar."})
keywordHandler:addKeyword({'kiss'}, StdModule.say, {npcHandler = npcHandler, text = "B.E.I.J.O.! Mantenha isso simples, idiota! T�ticas complicadas s�o muito f�ceis de serem esmagadas por um toque de destino."})
keywordHandler:addKeyword({'green ferrets'}, StdModule.say, {npcHandler = npcHandler, text = "Nossas for�as de elite s�o treinadas por rangers e druidas. Na floresta, eles ficam pr�ximos dos duendes."})
keywordHandler:addKeyword({'join'}, StdModule.say, {npcHandler = npcHandler, text = "Entrar para que?"})
keywordHandler:addKeyword({'join army'}, StdModule.say, {npcHandler = npcHandler, text = "Desculpe, n�o recrutamos estrangeiros. Talvez voc� possa se juntar se voc� se provar em uma miss�o para a rainha."})

npcHandler:addModule(FocusModule:new())
