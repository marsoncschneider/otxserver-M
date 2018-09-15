local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'prince'}, StdModule.say, {npcHandler = npcHandler, text = "Se outro príncipe viar aqui me beijar, eu vou chutar sua bunda tão forte que ele vai precisar ficar sentado em uma cadeira de seda."})
keywordHandler:addKeyword({'princess'}, StdModule.say, {npcHandler = npcHandler, text = "Se outro príncipe viar aqui me beijar, eu vou chutar sua bunda tão forte que ele vai precisar ficar sentado em uma cadeira de seda."})
keywordHandler:addKeyword({'kiss'}, StdModule.say, {npcHandler = npcHandler, text = "Nem tente me beijar ou eu vou chutar sua cara!"})
keywordHandler:addKeyword({'talk'}, StdModule.say, {npcHandler = npcHandler, text = "Sapos falantes não existem idiota. É a sua merda de imaginação zuando com a sua cara. E agora sua mente comanda você para que saia daqui."})
keywordHandler:addKeyword({'frog'}, StdModule.say, {npcHandler = npcHandler, text = "Finalmente alguém percebeu que sou um SAPO! Parabéns, você é muito observador... *suspiro*"})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = "Uma missão? Sim! Eu tenho uma missão! Vá falar ao Rei Tibianus que o filho dele tentou me beijar denovo!"})
keywordHandler:addKeyword({'pyrale'}, StdModule.say, {npcHandler = npcHandler, text = "Pyrale? Esse idiota me transformou em humano uma vez. Então minha esposa veio e me beijou, fazendo com que eu voltasse a ser um sapo novamente."})
keywordHandler:addKeyword({'ribbit'}, StdModule.say, {npcHandler = npcHandler, text = "Pyrale? Esse idiota me transformou em humano uma vez. Então minha esposa veio e me beijou, fazendo com que eu voltasse a ser um sapo novamente."})

npcHandler:setMessage(MESSAGE_GREET, "*suspiro* Outro idiota.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Sim, adeus e não volte novamente!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Hah! Esse idiota finalmente foi embora.")
npcHandler:addModule(FocusModule:new())
