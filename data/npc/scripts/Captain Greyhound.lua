local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end
 
-- Travel
local function addTravelKeyword(keyword, cost, destination)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Você procura uma passagem para ' .. keyword:titleCase() .. ' por |TRAVELCOST|?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, cost = cost, discount = 'postman', destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'Gostaríamos de lhe servir em algum momento.', reset = true})
end

addTravelKeyword('thais', 110, Position(32310, 32210, 6))
addTravelKeyword('ab\'dendriel', 80, Position(32734, 31668, 6))
addTravelKeyword('edron', 110, Position(33175, 31764, 6))
addTravelKeyword('venore', 130, Position(32954, 32022, 6))
addTravelKeyword('svargrond', 110, Position(32341, 31108, 6))
addTravelKeyword('yalahar', 185, Position(32816, 31272, 6))

-- Kick
keywordHandler:addKeyword({'kick'}, StdModule.kick, {npcHandler = npcHandler, destination = {Position(32384, 31815, 6), Position(32387, 31815, 6), Position(32390, 31815, 6)}})

-- Basic
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "Meu nome é Captain Greyhound da Royal Tibia Line."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou o capitão deste navio de vela."})
keywordHandler:addKeyword({'captain'}, StdModule.say, {npcHandler = npcHandler, text = "Eu sou o capitão deste navio de vela."})
keywordHandler:addKeyword({'ship'}, StdModule.say, {npcHandler = npcHandler, text = "A Royal Tibia Line conecta todas as cidades costeiras do Tibia."})
keywordHandler:addKeyword({'line'}, StdModule.say, {npcHandler = npcHandler, text = "A Royal Tibia Line conecta todas as cidades costeiras do Tibia."})
keywordHandler:addKeyword({'company'}, StdModule.say, {npcHandler = npcHandler, text = "A Royal Tibia Line conecta todas as cidades costeiras do Tibia."})
keywordHandler:addKeyword({'route'}, StdModule.say, {npcHandler = npcHandler, text = "A Royal Tibia Line conecta todas as cidades costeiras do Tibia."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = "A Royal Tibia Line conecta todas as cidades costeiras do Tibia."})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, text = "Podemos transportar tudo o que quiser."})
keywordHandler:addKeyword({'passenger'}, StdModule.say, {npcHandler = npcHandler, text = "Gostaríamos de recebê-lo a bordo."})
keywordHandler:addKeyword({'trip'}, StdModule.say, {npcHandler = npcHandler, text = "Onde você quer ir? Para {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} ou {Edron?}"})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = "Onde você quer ir? Para {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} ou {Edron?}"})
keywordHandler:addKeyword({'town'}, StdModule.say, {npcHandler = npcHandler, text = "Onde você quer ir? Para {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} ou {Edron?}"})
keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, text = "Onde você quer ir? Para {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} ou {Edron?}"})
keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = "Onde você quer ir? Para {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} ou {Edron?}"})
keywordHandler:addKeyword({'go'}, StdModule.say, {npcHandler = npcHandler, text = "Onde você quer ir? Para {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} ou {Edron?}"})
keywordHandler:addKeyword({'ice'}, StdModule.say, {npcHandler = npcHandler, text = "Me desculpe, mas não velejamos pelas rotas para as Ilhas Glacias."})
keywordHandler:addKeyword({'senja'}, StdModule.say, {npcHandler = npcHandler, text = "Me desculpe, mas não velejamos pelas rotas para as Ilhas Glacias."})
keywordHandler:addKeyword({'folda'}, StdModule.say, {npcHandler = npcHandler, text = "Me desculpe, mas não velejamos pelas rotas para as Ilhas Glacias."})
keywordHandler:addKeyword({'vega'}, StdModule.say, {npcHandler = npcHandler, text = "Me desculpe, mas não velejamos pelas rotas para as Ilhas Glacias."})
keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, text = "Eu não estou navegando lá. Esta rota é afetada por um navio fantasma! No entanto, eu ouvi que o Capitão Fearless de Venore navega por lá."})
keywordHandler:addKeyword({'darama'}, StdModule.say, {npcHandler = npcHandler, text = "Eu não estou navegando lá. Esta rota é afetada por um navio fantasma! No entanto, eu ouvi que o Capitão Fearless de Venore navega por lá."})
keywordHandler:addKeyword({'ghost'}, StdModule.say, {npcHandler = npcHandler, text = "Muitas pessoas que navegaram para Darashia nunca voltaram porque foram atacadas por um fantasma! Eu nunca irei para lá!"})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = "Esta é Carlin. Aonde você gostaria de ir?"})

npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo a bordo, |PLAYERNAME|. Por onde iremos velejar hoje?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Adeus. Recomende-nos se você estivesse satisfeito com o nosso serviço.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus então.")
npcHandler:addModule(FocusModule:new())
