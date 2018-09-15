local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'how', 'are', 'you'}, StdModule.say, {npcHandler = npcHandler, text = "Estou bem, muito obrigado."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = "Meu neg�cio � conhecimento e � gr�tis."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Tenho a honra de ser professor nesta escola."})
keywordHandler:addKeyword({'teacher'}, StdModule.say, {npcHandler = npcHandler, text = "Eu administro esta escola, h� outros professores itinerantes que chamamos de {Loremasters}."})
keywordHandler:addKeyword({'loremaster'}, StdModule.say, {npcHandler = npcHandler, text = "Se voc� tem sorte voc� encontrar� um em suas jornadas."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome � Phillip."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = "Agora s�o |TIME|."})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = "Vou lhe fornecer todo o conhecimento que tenho."})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, text = "Os monstros v�m em forma e poder diferentes. Dizem que h� um zool�gico na cidade dos an�es."})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, text = "Masmorras s�o lugares de perigos e quebra-cabe�as. Em alguma delas, uma mente brilhante ir� defend�-lo mais do que uma l�mina."})
keywordHandler:addKeyword({'sewer'}, StdModule.say, {npcHandler = npcHandler, text = "Um lugar interessante que voc� deve considerar visitar."})
keywordHandler:addKeyword({'thank you'}, StdModule.say, {npcHandler = npcHandler, text = "Voc� n�o precisa me agradecer, � apenas o meu dever."})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, text = "Para aprender sobre deuses, visite os templos e converse com os sacerdotes."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, text = "O rei do sul se chama Tibianus. Ele e nossa rainha Eloise est�o em constante luta."})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, text = "O rei do sul se chama Tibianus. Ele e nossa rainha Eloise est�o em constante luta."})
keywordHandler:addKeyword({'rumour'}, StdModule.say, {npcHandler = npcHandler, text = "Eu n�o gosto de rumores."})
keywordHandler:addKeyword({'gossip'}, StdModule.say, {npcHandler = npcHandler, text = "Eu n�o gosto de rumores."})
keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, text = "Eu n�o gosto de rumores."})
keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, text = "Para aprender sobre armas, leia livros apropriados ou fale com os smiths."})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = "Para saber mais sobre a conversa m�gica com os l�deres da alian�a."})
keywordHandler:addKeyword({'rebellion'}, StdModule.say, {npcHandler = npcHandler, text = "Rebeli�o? Pelo que? Estamos lidando com a nossa situa��o."})
keywordHandler:addKeyword({'in tod we trust'}, StdModule.say, {npcHandler = npcHandler, text = "Tod vir� e nos salvar� a todos. Ele trar� liberdade e cerveja aos homens de Carlin."})
keywordHandler:addKeyword({'lugri'}, StdModule.say, {npcHandler = npcHandler, text = "Este servo do mal � protegido pelos deuses das trevas e n�o pode ser prejudicado."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = "Ele � um seguidor do mal. Seus poderes foram impulsionados por uma for�a sinistra e ele est� al�m das restri��es humanas agora."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = "Esta arma � dita ser muito poderosa e �nica. Estava escondido nos tempos antigos e agora est� pensado para ser perdido."})

npcHandler:setMessage(MESSAGE_GREET, "Ol�, grande aventureiro |PLAYERNAME|. Posso ensinar-lhe algo que voc� n�o conhece?")
npcHandler:setMessage(MESSAGE_FAREWELL, "V� e tenha cuidado. Lembre-se do que aprendeu!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "O toque da campainha?")
npcHandler:addModule(FocusModule:new())
