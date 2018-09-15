local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'how', 'are', 'you'}, StdModule.say, {npcHandler = npcHandler, text = "Estou bem, muito obrigado."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = "Meu negócio é conhecimento e é grátis."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Tenho a honra de ser professor nesta escola."})
keywordHandler:addKeyword({'teacher'}, StdModule.say, {npcHandler = npcHandler, text = "Eu administro esta escola, há outros professores itinerantes que chamamos de {Loremasters}."})
keywordHandler:addKeyword({'loremaster'}, StdModule.say, {npcHandler = npcHandler, text = "Se você tem sorte você encontrará um em suas jornadas."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome é Phillip."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "Agora são |TIME|."})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = "Vou lhe fornecer todo o conhecimento que tenho."})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, text = "Os monstros vêm em forma e poder diferentes. Dizem que há um zoológico na cidade dos anões."})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, text = "Masmorras são lugares de perigos e quebra-cabeças. Em alguma delas, uma mente brilhante irá defendê-lo mais do que uma lâmina."})
keywordHandler:addKeyword({'sewer'}, StdModule.say, {npcHandler = npcHandler, text = "Um lugar interessante que você deve considerar visitar."})
keywordHandler:addKeyword({'thank you'}, StdModule.say, {npcHandler = npcHandler, text = "Você não precisa me agradecer, é apenas o meu dever."})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, text = "Para aprender sobre deuses, visite os templos e converse com os sacerdotes."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, text = "O rei do sul se chama Tibianus. Ele e nossa rainha Eloise estão em constante luta."})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, text = "O rei do sul se chama Tibianus. Ele e nossa rainha Eloise estão em constante luta."})
keywordHandler:addKeyword({'rumour'}, StdModule.say, {npcHandler = npcHandler, text = "Eu não gosto de rumores."})
keywordHandler:addKeyword({'gossip'}, StdModule.say, {npcHandler = npcHandler, text = "Eu não gosto de rumores."})
keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, text = "Eu não gosto de rumores."})
keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, text = "Para aprender sobre armas, leia livros apropriados ou fale com os smiths."})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = "Para saber mais sobre a conversa mágica com os líderes da aliança."})
keywordHandler:addKeyword({'rebellion'}, StdModule.say, {npcHandler = npcHandler, text = "Rebelião? Pelo que? Estamos lidando com a nossa situação."})
keywordHandler:addKeyword({'in tod we trust'}, StdModule.say, {npcHandler = npcHandler, text = "Tod virá e nos salvará a todos. Ele trará liberdade e cerveja aos homens de Carlin."})
keywordHandler:addKeyword({'lugri'}, StdModule.say, {npcHandler = npcHandler, text = "Este servo do mal é protegido pelos deuses das trevas e não pode ser prejudicado."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = "Ele é um seguidor do mal. Seus poderes foram impulsionados por uma força sinistra e ele está além das restrições humanas agora."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = "Esta arma é dita ser muito poderosa e única. Estava escondido nos tempos antigos e agora está pensado para ser perdido."})

npcHandler:setMessage(MESSAGE_GREET, "Olá, grande aventureiro |PLAYERNAME|. Posso ensinar-lhe algo que você não conhece?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Vá e tenha cuidado. Lembre-se do que aprendeu!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "O toque da campainha?")
npcHandler:addModule(FocusModule:new())
