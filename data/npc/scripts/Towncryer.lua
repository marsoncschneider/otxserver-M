local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = "Escutem-me! Escutem-me! O mago Wyrdin da academia de Edron est� procurando por bravos aventureiros para dar-lhes algumas miss�es!" },
	{ text = "Escutem-me! Escutem-me! A guild dos correios tem vagas para aspirantes a carteiros! Contate Kevin Postner no centro dos correios ao sul de Kazordoon!" },
	{ text = "Escutem-me! Escutem-me! The inquisition est� procurando por pessoas ousadas para combater o mal! Fa�a sua inscri��o no inquisition headquarter localizado perto da jaula de Thaian!" },
	{ text = "Escutem-me! Escutem-me! 'Fique parado e entregue tudo'! � isso que eles gritam, roubando bancos nas principais cidades costeiras e depois se escondem. Peguem esses ladr�es e fa�amo-nos orgulhosos, traga o ouro devolta para a multid�o!" },
	{ text = "Escutem-me! Escutem-me! Um rio est� inundando ao sul da base dos fora da lei. Explore essa nova ilha, um lugar desconhecido. N�o tenha medo, mas fique pronto para usar sua espada." },
	{ text = "Escutem-me! Escutem-me! O vulc�o de Goroma est� cuspindo fogo! Criaturas est�o surgindo, fortes e terr�veis! A lava est� indo em dire��o a terra. Bravo guerreiro, tenha cuidado ou ser� seu fim!" },
	{ text = "Escutem-me! Escutem-me! � dia do Rei pessoal! Vamos celebrar e cantar! Decore Thais e deixem que os sinos badalem! Venha para arena, veja e ou�a espadas se confrontando. Viva ao Rei!" },
	{ text = "Escutem-me! Escutem-me! Ao norte da cidade da Rainha, as arvores reais s�o cortadas. Voc� vai mesmo denunciar esse tipo de desrespeito? Vai lidar com o suspeito?" },
	{ text = "Escutem-me! Escutem-me! Noodles se foi, o Rei est� em desespero! Encontrem o pequeno patife, olhem em toda a cidade! Tragam-no devolta e sejam recompensados!" },
	{ text = "Escutem-me! Escutem-me! O deserto de Ankrahmun � a terra dos n�mades. Encontrem seus acampamentos na areia dourada e quem sabe um tesouro esteja escondido por l�!" },
	{ text = "Escutem-me! Escutem-me! Que lindo dia! Visite Carlin, Ankrahmun ou Liberty Bay. Yasir, o comerciante oriental pode estar por l�. Pegue seus produtos de monstros, pois esta chance � rara!" },
	{ text = "Escutem-me! Escutem-me! Em Zao Steppe o rio corre voraz. Se voc� pegar algum peixe estranho, mantenha-o para si." },
	{ text = "Escutem-me! Escutem-me! Os elefantes de Tiquanda est�o aterrorizados, os passos do Deus dos Macacos s�o assustadores! Busque sua presa enquanto est�o cheias de medo!" },
	{ text = "Escutem-me! Escutem-me! Mamutes observam silenciosamente enquanto a neve se derrete. Ela revela flores especiais que v�o desaparecer! Plantem suas sementes, alegrem o seu dia!" },
	{ text = "Escutem-me! Escutem-me! A bruxa Wyda aparenta estar entediada. Fa�a uma visita a ela, mas saque sua espada. Ela pode vir pra cima de voc� com uma terr�vel surpresa, voc� � corajoso o suficiente para olhar em seus olhos?" }
}

npcHandler:addModule(VoiceModule:new(voices))
