local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = "Escutem-me! Escutem-me! O mago Wyrdin da academia de Edron está procurando por bravos aventureiros para dar-lhes algumas missões!" },
	{ text = "Escutem-me! Escutem-me! A guild dos correios tem vagas para aspirantes a carteiros! Contate Kevin Postner no centro dos correios ao sul de Kazordoon!" },
	{ text = "Escutem-me! Escutem-me! The inquisition está procurando por pessoas ousadas para combater o mal! Faça sua inscrição no inquisition headquarter localizado perto da jaula de Thaian!" },
	{ text = "Escutem-me! Escutem-me! 'Fique parado e entregue tudo'! É isso que eles gritam, roubando bancos nas principais cidades costeiras e depois se escondem. Peguem esses ladrões e façamo-nos orgulhosos, traga o ouro devolta para a multidão!" },
	{ text = "Escutem-me! Escutem-me! Um rio está inundando ao sul da base dos fora da lei. Explore essa nova ilha, um lugar desconhecido. Não tenha medo, mas fique pronto para usar sua espada." },
	{ text = "Escutem-me! Escutem-me! O vulcão de Goroma está cuspindo fogo! Criaturas estão surgindo, fortes e terríveis! A lava está indo em direção a terra. Bravo guerreiro, tenha cuidado ou será seu fim!" },
	{ text = "Escutem-me! Escutem-me! É dia do Rei pessoal! Vamos celebrar e cantar! Decore Thais e deixem que os sinos badalem! Venha para arena, veja e ouça espadas se confrontando. Viva ao Rei!" },
	{ text = "Escutem-me! Escutem-me! Ao norte da cidade da Rainha, as arvores reais são cortadas. Você vai mesmo denunciar esse tipo de desrespeito? Vai lidar com o suspeito?" },
	{ text = "Escutem-me! Escutem-me! Noodles se foi, o Rei está em desespero! Encontrem o pequeno patife, olhem em toda a cidade! Tragam-no devolta e sejam recompensados!" },
	{ text = "Escutem-me! Escutem-me! O deserto de Ankrahmun é a terra dos nômades. Encontrem seus acampamentos na areia dourada e quem sabe um tesouro esteja escondido por lá!" },
	{ text = "Escutem-me! Escutem-me! Que lindo dia! Visite Carlin, Ankrahmun ou Liberty Bay. Yasir, o comerciante oriental pode estar por lá. Pegue seus produtos de monstros, pois esta chance é rara!" },
	{ text = "Escutem-me! Escutem-me! Em Zao Steppe o rio corre voraz. Se você pegar algum peixe estranho, mantenha-o para si." },
	{ text = "Escutem-me! Escutem-me! Os elefantes de Tiquanda estão aterrorizados, os passos do Deus dos Macacos são assustadores! Busque sua presa enquanto estão cheias de medo!" },
	{ text = "Escutem-me! Escutem-me! Mamutes observam silenciosamente enquanto a neve se derrete. Ela revela flores especiais que vão desaparecer! Plantem suas sementes, alegrem o seu dia!" },
	{ text = "Escutem-me! Escutem-me! A bruxa Wyda aparenta estar entediada. Faça uma visita a ela, mas saque sua espada. Ela pode vir pra cima de você com uma terrível surpresa, você é corajoso o suficiente para olhar em seus olhos?" }
}

npcHandler:addModule(VoiceModule:new(voices))
