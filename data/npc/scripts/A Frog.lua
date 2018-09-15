local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'prince'}, StdModule.say, {npcHandler = npcHandler, text = "Se outro pr�ncipe viar aqui me beijar, eu vou chutar sua bunda t�o forte que ele vai precisar ficar sentado em uma cadeira de seda."})
keywordHandler:addKeyword({'princess'}, StdModule.say, {npcHandler = npcHandler, text = "Se outro pr�ncipe viar aqui me beijar, eu vou chutar sua bunda t�o forte que ele vai precisar ficar sentado em uma cadeira de seda."})
keywordHandler:addKeyword({'kiss'}, StdModule.say, {npcHandler = npcHandler, text = "Nem tente me beijar ou eu vou chutar sua cara!"})
keywordHandler:addKeyword({'talk'}, StdModule.say, {npcHandler = npcHandler, text = "Sapos falantes n�o existem idiota. � a sua merda de imagina��o zuando com a sua cara. E agora sua mente comanda voc� para que saia daqui."})
keywordHandler:addKeyword({'frog'}, StdModule.say, {npcHandler = npcHandler, text = "Finalmente algu�m percebeu que sou um SAPO! Parab�ns, voc� � muito observador... *suspiro*"})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = "Uma miss�o? Sim! Eu tenho uma miss�o! V� falar ao Rei Tibianus que o filho dele tentou me beijar denovo!"})
keywordHandler:addKeyword({'pyrale'}, StdModule.say, {npcHandler = npcHandler, text = "Pyrale? Esse idiota me transformou em humano uma vez. Ent�o minha esposa veio e me beijou, fazendo com que eu voltasse a ser um sapo novamente."})
keywordHandler:addKeyword({'ribbit'}, StdModule.say, {npcHandler = npcHandler, text = "Pyrale? Esse idiota me transformou em humano uma vez. Ent�o minha esposa veio e me beijou, fazendo com que eu voltasse a ser um sapo novamente."})

npcHandler:setMessage(MESSAGE_GREET, "*suspiro* Outro idiota.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Sim, adeus e n�o volte novamente!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Hah! Esse idiota finalmente foi embora.")
npcHandler:addModule(FocusModule:new())
