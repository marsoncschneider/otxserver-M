-- Parser
dofile('data/modules/scripts/gamestore/init.lua')
-- Config
GameStore.Categories = {
	{	
	    name = "Premium Time",
		state = GameStore.States.STATE_SALVE,
		rookgaard = false,
		icons = {"Category_PremiumTime.png"},
		offers = {
 			{name = "30 Days of Premium Time", price = 250, state = GameStore.States.STATE_SALE, validUntil = 30, thingId = 30, type = GameStore.OfferTypes.OFFER_TYPE_PREMIUM, icons = {"Product_PremiumTime30.png"}, description = "Premium Account for 30 days."},
 			{name = "90 Days of Premium Time", price = 400, state = GameStore.States.STATE_SALE, validUntil = 30, thingId = 90, type = GameStore.OfferTypes.OFFER_TYPE_PREMIUM, icons = {"Product_PremiumTime90.png"}, description = "Premium Account for 90 days."},
 			{name = "180 Days of Premium Time", price = 700, state = GameStore.States.STATE_SALE, validUntil = 30, thingId = 180, type = GameStore.OfferTypes.OFFER_TYPE_PREMIUM, icons = {"Product_PremiumTime180.png"}, description = "Premium Account for 180 days."},
			{name = "360 Days of Premium Time", price = 1000, state = GameStore.States.STATE_SALE, validUntil = 30, thingId = 360, type = GameStore.OfferTypes.OFFER_TYPE_PREMIUM, icons = {"Product_PremiumTime360.png"}, description = "Premium Account for 180 days."}
 		}
	},
	{
		name = "Blessings",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Blessings.png"},
		rookgaard = false,
		offers = {

			{name = "All Regular Blessings", thingId = 1, 2, 3, 4, 5, 7, 8, type = GameStore.OfferTypes.OFFER_TYPE_BLESSINGS, price = 999, icons = {"Product_Blessing_AllPvE.png"}},
			{name = "Twist of Fate", thingId = 1, type = GameStore.OfferTypes.OFFER_TYPE_BLESSINGS, price = 2, icons = {"Product_Blessing_Fate.png"}},
			{name = "The Wisdom of Solitude", thingId = 2, type = GameStore.OfferTypes.OFFER_TYPE_BLESSINGS, price = 5, icons = {"Product_Blessing_Solitude.png"}},
			{name = "The Spark of the Phoenix", thingId = 3, type = GameStore.OfferTypes.OFFER_TYPE_BLESSINGS, price = 8, icons = {"Product_Blessing_Phoenix.png"}},
			{name = "The Fire of the Suns", thingId = 4, type = GameStore.OfferTypes.OFFER_TYPE_BLESSINGS, price = 5, icons = {"Product_Blessing_Suns.png"}},
			{name = "The Spiritual Shielding", thingId = 5, type = GameStore.OfferTypes.OFFER_TYPE_BLESSINGS, price = 5, icons = {"Product_Blessing_Shielding.png"}},
			{name = "The Embrace of Tibia", thingId = 6, type = GameStore.OfferTypes.OFFER_TYPE_BLESSINGS, price = 5, icons = {"Product_Blessing_Tibia.png"}},
			{name = "Heart of the Mountain", thingId = 7, type = GameStore.OfferTypes.OFFER_TYPE_BLESSINGS, price = 10, icons = {"Product_Blessing_HeartOfTheMountain.png"}},
			{name = "Blood of the Mountain", thingId = 8, type = GameStore.OfferTypes.OFFER_TYPE_BLESSINGS, price = 10, icons = {"Product_Blessing_BloodOfTheMountain.png"}},
		}
	},
	{
		name = "Extra Services",
		state = GameStore.States.STATE_NONE,
		rookgaard = false,
		icons = {"Category_ExtraServices.png"},
		offers = {
			-- NameChange example
			{name = "Character Name Change", type = GameStore.OfferTypes.OFFER_TYPE_NAMECHANGE, price = 20, icons = {"Product_CharacterNameChange.png"}},
			-- Sexchange example
			{name = "Character Sex Change", type = GameStore.OfferTypes.OFFER_TYPE_SEXCHANGE, price = 20, icons = {"Product_CharacterSexChange.png"}},
			 {name = "Temple Teleport", type = GameStore.OfferTypes.OFFER_TYPE_TEMPLE, price = 25, icons = {"Product_Transportation_TempleTeleport.png"}},
		--	 Promotion example
		--	{name = "First Promotion", thingId = 1--[[ed/ms/rp/ek]], type = GameStore.OfferTypes.OFFER_TYPE_PROMOTION, price = 100, icons = {"Product_FirstPromotion.png"}}
		}
	},
	{	
	    name = "Useful Things",
		state = GameStore.States.STATE_NONE,
		rookgaard = false,
		icons = {"Category_Convenience.png"},
		offers = {
		{name = "Prey Bonus Reroll", state = GameStore.States.STATE_NEW, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_PREYBONUS, price = 1, icons = {"Product_UsefulThings_PreyBonusReroll.png"}},
		{name = "5x Prey Bonus Reroll", state = GameStore.States.STATE_NEW, count = 5, type = GameStore.OfferTypes.OFFER_TYPE_PREYBONUS, price = 5, icons = {"Product_UsefulThings_PreyBonusReroll.png"}},
		{name = "Permanent Prey Slot", state = GameStore.States.STATE_NEW, type = GameStore.OfferTypes.OFFER_TYPE_PREYSLOT, price = 50, icons = {"Product_UsefulThings_PermanentPreySlot.png"}},
        {name = "Gold Pounch", thingId = 26377, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Product_MagicCoinPurse.png"}, description = ""},
		}
	},
	
	{
		name = "Runes",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Runes.png"},
		offers = {	
		{name = "Animate Dead Rune", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2316, count = 250, icons = {"Product_Rune_AnimateDeadRune.png"}},
		{name = "Avalanche Rune", price = 9, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2274, count = 250, icons = {"Product_Rune_AvalancheRune.png"}},
		{name = "Chameleon Rune", price = 2, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2291, count = 250, icons = {"Product_Rune_ChameleonRune.png"}},
		{name = "Convince Creature Rune", price = 6, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2290, count = 250, icons = {"Product_Rune_ConvinceRune.png"}},
		{name = "Cure Poison Rune", price = 3, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2266, count = 250, icons = {"Product_Rune_CurePoisonRune.png"}},
		{name = "Disintegrate Rune", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2310, count = 250, icons = {"Product_Rune_DisintegrateRune.png"}},
		{name = "Energy Bomb Rune", price = 2, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2262, count = 250, icons = {"Product_Rune_EnergyBombRune.png"}},
		{name = "Energy Field Rune", price = 8, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2277, count = 250, icons = {"Product_Rune_EnergyFieldRune.png"}},
		{name = "Energy Wall Rune", price = 7, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2279, count = 250, icons = {"Product_Rune_EnergyWallRune.png"}},
		{name = "Explosion Rune", price = 6, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2313, count = 250, icons = {"Product_Rune_ExplosionRune.png"}},
		{name = "Fireball Rune", price = 6, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2302, count = 250, icons = {"Product_Rune_FireballRune.png"}},
		{name = "Fire Bomb Rune", price = 3, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2305, count = 250, icons = {"Product_Rune_FireBombRune.png"}},
		{name = "Fire Field Rune", price = 6, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2301, count = 250, icons = {"Product_Rune_FireFieldRune.png"}},
		{name = "Fire Wall Rune", price = 2, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2303, count = 250, icons = {"Product_Rune_FireWallRune.png"}},
		{name = "Great Fireball Rune", price = 9, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2304, count = 250, icons = {"Product_Rune_GreatFireBallRune.png"}},
		{name = "Icicle Rune", price = 6, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2271, count = 250, icons = {"Product_Rune_IcicleRune.png"}},
		{name = "Intense Healing Rune", price = 1, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2265, count = 250, icons = {"Product_Rune_IntenseHealingRune.png"}},
		{name = "Magic Wall Rune", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2293, count = 250, icons = {"Product_Rune_MagicWallRune.png"}},
		{name = "Paralyse Rune", price = 4, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2278, count = 250, icons = {"Product_Rune_ParalyseRune.png"}},
		{name = "Poison Bomb Rune", price = 7, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2286, count = 250, icons = {"Product_Rune_PoisonBombRune.png"}},
		{name = "Poison Wall Rune", price = 1, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2289, count = 250, icons = {"Product_Rune_PoisonWallRune.png"}},
		{name = "Soulfire Rune", price = 9, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2308, count = 250, icons = {"Product_Rune_SoulfireRune.png"}},
		{name = "Stone Shower Rune", price = 7, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2288, count = 250, icons = {"Product_Rune_StoneShowerRune.png"}},
		{name = "Sudden Death Rune", price = 9, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2268, count = 250, icons = {"Product_Rune_SuddenDeathRune.png"}},
		{name = "Thunderstorm Rune", price = 7, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2315, count = 250, icons = {"Product_Rune_ThunderstormRune.png"}},
		{name = "Ultimate Healing Rune", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2273, count = 250, icons = {"Product_Rune_UltimateHealingRune.png"}},
		{name = "Wild Growth Rune", price = 3, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 2269, count = 250, icons = {"Product_Rune_WildGrowthRune.png"}},
				}
				},
	{
		name = "Items",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Items.png"},
		offers = {
			{name = "VIP Boots", thingId = 2358, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"2358.png"}, description = "Become rich!"},
			{name = "crystalline token", thingId = 18423, count = 5, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"18423.png"}, description = "Become rich!"},
			-- Item Example : thingId = itemId
			{name = "Yalahari Mask", thingId = 9778, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Yalahari_Mask.png"}, description = "Become rich!"},
			{name = "Golden Helmet", thingId = 2471, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"Golden_Helmet.png"}, description = "Become rich!"},
			{name = "Prismatic Helmet", thingId = 18403, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Prismatic_Helmet.png"}, description = "Become rich!"},
			{name = "Gill Gugel", thingId = 18398, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Gill_Gugel.png"}, description = "Become rich!"},
			{name = "Elite Draken Helmet", thingId = 12645, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Elite_Draken_Helmet.png"}, description = "Become rich!"},
			{name = "Werewolf Helmet", thingId = 24718, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Werewolf_Helmet.png"}, description = "Become rich!"},
			{name = "Depth Galea", thingId = 15408, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Depth_Galea.png"}, description = "Become rich!"},
			--Armorid--
			{name = "Demon Armor", thingId = 2494, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Demon_Armor.png"}, description = "Become rich!"},
			{name = "Fire Born Giant Armor", thingId = 8881, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Fireborn_Giant_Armor.png"}, description = "Become rich!"},
			{name = "Royal Draken Mail", thingId = 12642, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Royal_Draken_Mail.png"}, description = "Become rich!"},
			{name = "Gill Coat", thingId = 18399, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Gill_Coat.png"}, description = "Become rich!"},
			{name = "Depth Lorica", thingId = 15407, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"Depth_Lorica.png"}, description = "Become rich!"},
			{name = "Furios Frock", thingId = 21725, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"Furious_Frock.png"}, description = "Become rich!"},
			{name = "Ornate Chestplate", thingId = 15406, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"Ornate_Chestplate.png"}, description = "Become rich!"},
			{name = "Earthborn Titan Armor", thingId = 8882, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"Earthborn_Titan_Armor.png"}, description = "Become rich!"},
			{name = "Wind Born Colossus Armor", thingId = 8883, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"Windborn_Colossus_Armor.png"}, description = "Become rich!"},
			{name = "Master Acher's Armor", thingId = 8888, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Master_Archer's_Armor.png"}, description = "Become rich!"},
			--Legsid--
			{name = "Demon Legs", thingId = 2495, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"Demon_Legs.png"}, description = "Become rich!"},
			{name = "Grasshopper Legs", thingId = 15490, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Grasshopper_Legs.png"}, description = "Become rich!"},
			{name = "Depth Ocrea", thingId = 15409, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Depth_Ocrea.png"}, description = "Become rich!"},
			{name = "Primatic Legs", thingId = 18405, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Prismatic_Legs.png"}, description = "Become rich!"},
			{name = "Gill Legs", thingId = 18400, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Gill_Legs.png"}, description = "Become rich!"},
			{name = "Ornate Legs", thingId = 15412, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"Ornate_Legs.png"}, description = "Become rich!"},
			{name = "Dwarven Legs", thingId = 2504, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Dwarven_Legs.png"}, description = "Become rich!"},
			{name = "Icy Culotte", thingId = 21700, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"Icy_Culottes.png"}, description = "Become rich!"},
			--Bootsid--
			{name = "Boots of Haste", thingId = 2195, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 3, icons = {"Boots_of_Haste.png"}, description = "Become rich!"},
			{name = "Golden Boots", thingId = 2646, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 50, icons = {"Golden_Boots.png"}, description = "Become rich!"},
			{name = "Pair Soft Boots", thingId = 2640, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Pair_of_Soft_Boots.png"}, description = "Become rich!"},
			--Shieldid--
			{name = "Depth Scutum", thingId = 15411, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 3, icons = {"Depth_Scutum.png"}, description = "Become rich!"},
			{name = "Shield of Corruption", thingId = 12644, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Shield_of_Corruption.png"}, description = "Become rich!"},
			{name = "Prismatic Shield", thingId = 18410, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Prismatic_Shield.png"}, description = "Become rich!"},
			{name = "Ornate Shield", thingId = 15413, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Ornate_Shield.png"}, description = "Become rich!"},
			{name = "Spelbook of Vigilance", thingId = 18401, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Spellbook_of_Vigilance.png"}, description = "Become rich!"},
			{name = "Spellbook of Ancient Arcana", thingId = 16112, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"Spellbook_of_Ancient_Arcana.png"}, description = "Become rich!"},
			{name = "Umbral spellbook", thingId = 22423, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Umbral_Spellbook.png"}, description = "Become rich!"},
			{name = "Umbral Master Spellbook", thingId = 22424, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 60, icons = {"Umbral_Master_Spellbook.png"}, description = "Become rich!"},
			{name = "Great Shield", thingId = 2522, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"Great_Shield.png"}, description = "Become rich!"},
			{name = "Blessed Shield", thingId = 2523, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 50, icons = {"Blessed_Shield.png"}, description = "Become rich!"},
		}
	},

	{
		name = "Items for Sorcerers",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Sorc.png"},
		offers = {
			-- Item Example : thingId = itemId
			{name = "Thundermind Raiment", thingId = 25192, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25192.png"}, description = "Become rich!"},
			{name = "Frostmind Raiment", thingId = 25193, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25193.png"}, description = "Become rich!"},
			{name = "Earthmind Raiment", thingId = 25191, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25191.png"}, description = "Become rich!"},
			{name = "Firemind Raiment", thingId = 25190, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25190.png"}, description = "Become rich!"},
			{name = "Wand of Defiance", thingId = 18390, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"18390.png"}, description = "Become rich!"},
			{name = "Spelbook of Dark Mysteries", thingId = 8918, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"8918.png"}, description = "Become rich!"},
			{name = "Wand of Everblazing", thingId = 18409, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"18409.png"}, description = "Become rich!"},
		}
	},

	{
		name = "Items for Knights",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Knight.png"},
		offers = {
			-- Item Example : thingId = itemId
			{name = "Earthmind Raiment", thingId = 25191, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25191.png"}, description = "Become rich!"},
			{name = "Earthheart Platemail", thingId = 25179, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25179.png"}, description = "Become rich!"},
			{name = "Earthheart Hauberk", thingId = 25178, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25178.png"}, description = "Become rich!"},
			{name = "Frostheart Platemail", thingId = 25185, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25185.png"}, description = "Become rich!"},
			{name = "Frostheart Hauberk", thingId = 25184, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25184.png"}, description = "Become rich!"},
			{name = "Frostheart Cuirass", thingId = 25183, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25183.png"}, description = "Become rich!"},
			{name = "Thunderheart Platemail", thingId = 25182, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25182.png"}, description = "Become rich!"},
			{name = "Thunderheart Hauberk", thingId = 25181, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25181.png"}, description = "Become rich!"},
			{name = "Thunderheart Cuirass", thingId = 25180, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25180.png"}, description = "Become rich!"},
			{name = "Fireheart Platemail", thingId = 25176, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25176.png"}, description = "Become rich!"},
			{name = "Fireheart Hauberk", thingId = 25175, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25175.png"}, description = "Become rich!"},
			{name = "Fireheart Cuirass", thingId = 25174, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25174.png"}, description = "Become rich!"},
			{name = "Shiny Blade", thingId = 18465, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"18465.png"}, description = "Become rich!"},
			{name = "Crystaline Axe ", thingId = 18451, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"18451.png"}, description = "Become rich!"},
			{name = "Mycological Mace", thingId = 18452, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"18452.png"}, description = "Become rich!"},
			{name = "Umbral Blade", thingId = 22399, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"22399.png"}, description = "Become rich!"},
			{name = "Umbral Masterblade", thingId = 22400, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"22400.png"}, description = "Become rich!"},
			{name = "umbral Slayer", thingId = 22402, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"22402.png"}, description = "Become rich!"},
			{name = "Umbral Hammer", thingId = 22414, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"22414.png"}, description = "Become rich!"},
			{name = "Umbral Master Hammer", thingId = 22415, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"22415.png"}, description = "Become rich!"},
			{name = "Umbral Mace", thingId = 22411, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"22411.png"}, description = "Become rich!"},
			{name = "Umbral master Chopper", thingId = 22409, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"22409.png"}, description = "Become rich!"},
			{name = "Umbral Mater Axe", thingId = 22406, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"22406.png"}, description = "Become rich!"},
			{name = "Umbral Axe", thingId = 22405, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"22405.png"}, description = "Become rich!"},
			{name = "Umbral Master Slayer", thingId = 22403, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"22403.png"}, description = "Become rich!"},
			{name = "Umbral Chopper", thingId = 22408, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"22408.png"}, description = "Become rich!"},
		
		}
	},

	{
		name = "Items for Paladins",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Pally.png"},
		offers = {
			-- Item Example : thingId = itemId
			{name = "Firesoul Tabard", thingId = 25186, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25186.png"}, description = "Become rich!"},
			{name = "Frostsoul Tabard", thingId = 25189, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25189.png"}, description = "Become rich!"},
			{name = "Thundersoul Tabard", thingId = 25188, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25188.png"}, description = "Become rich!"},
			{name = "Earthsoul Tabard", thingId = 25187, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25187.png"}, description = "Become rich!"},
			{name = "Crystal Crossbow", thingId = 18453, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"18453.png"}, description = "Become rich!"},
			{name = "Mycological Bow", thingId = 18454, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"18454.png"}, description = "Become rich!"},
			{name = "Umbral bow", thingId = 22417, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"22417.png"}, description = "Become rich!"},
			{name = "Umbral Master bow", thingId = 22418, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"22418.png"}, description = "Become rich!"},
			{name = "Umbral Crossbow", thingId = 22420, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"22420.png"}, description = "Become rich!"},
			{name = "Umbral Master Crossbow", thingId = 22421, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"22421.png"}, description = "Become rich!"},
		}
	},

	{
		name = "Items for Druids",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Druid.png"},
		offers = {
			-- Item Example : thingId = itemId
			{name = "Thundermind Raiment", thingId = 25192, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25192.png"}, description = "Become rich!"},
			{name = "Frostmind Raiment", thingId = 25193, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25193.png"}, description = "Become rich!"},
			{name = "Earthmind Raiment", thingId = 25191, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25191.png"}, description = "Become rich!"},
			{name = "Firemind Raiment", thingId = 25190, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"25190.png"}, description = "Become rich!"},
			{name = "Glacial Rod", thingId = 18412, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"18412.png"}, description = "Become rich!"},
			{name = "Muck Rod", thingId = 18411, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"18411.png"}, description = "Become rich!"},
			{name = "Spelbook of Dark Mysteries", thingId = 8918, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"8918.png"}, description = "Become rich!"},
		}
	},
	{
		name = "Potions",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Potions.png"},
		offers = {			
    {name = "Health Potion", description = "100x Health Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7618, count = 100, icons = {"7618.png"}},
	{name = "Health Potion", description = "250x Health Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7618, count = 250, count = 1, icons = {"7618.png"}},
	{name = "Strong Health Potion", description = "100x Strong Health Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7588, count = 100, count = 1, icons = {"7588.png"}},
    {name = "Strong Health Potion", description = "250x Strong Health Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7588, count = 250, count = 1, icons = {"7588.png"}},
	{name = "Great Health Potion", description = "100x Great Health Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7591, count = 100, count = 1, icons = {"7591.png"}},
	{name = "Great Health Potion", description = "250x Great Health Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7591, count = 250, count = 1, icons = {"7591.png"}},
	{name = "Ultimate Health Potion", description = "100x Ultimate Health Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 8473, count = 100, count = 1, icons = {"8473.png"}},
	{name = "Ultimate Health Potion", description = "250x Ultimate Health Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 8473, count = 250, count = 1, icons = {"8473.png"}},
	{name = "Supreme Health Potion", description = "100x Supreme Health Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 26031, count = 100, count = 1, icons = {"26031.png"}},
	{name = "Supreme Health Potion", description = "250x Supreme Health Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 26031, count = 250, count = 1, icons = {"26031.png"}},
	{name = "Mana Potion", description = "100x Mana Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7620, count = 100, count = 1, icons = {"7620.png"}},
	{name = "Mana Potion", description = "250x Mana Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7620, count = 250, count = 1, icons = {"7620.png"}},
	{name = "Strong Mana Potion", description = "100x Strong Mana Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7589, count = 100, count = 1, icons = {"7589.png"}},
	{name = "Strong Mana Potion", description = "250x Strong Mana Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7589, count = 250, count = 1, icons = {"7589.png"}},
	{name = "Great Mana Potion", description = "100x Great Mana Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7590, count = 100, count = 1, icons = {"7590.png"}},
	{name = "Great Mana Potion", description = "250x Great Mana Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 7590, count = 250, count = 1, icons = {"7590.png"}},
	{name = "Ultimate Mana Potion", description = "100x Ultimate Mana Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 26029, count = 100, count = 1, icons = {"26029.png"}},
	{name = "Ultimate Mana Potion", description = "250x Ultimate Mana Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 26029, count = 250, count = 1, icons = {"26029.png"}},
	{name = "Great Spirit Potion", description = "100x Great Spirit Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 8472, count = 100, count = 1, icons = {"8472.png"}},
	{name = "Great Spirit Potion", description = "250x Great Spirit Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 8472, count = 250, count = 1, icons = {"8472.png"}},
	{name = "Ultimate Spirit Potion", description = "100x Ultimate Spirit Potion", price = 5, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 26030, count = 100, count = 1, icons = {"26030.png"}},
	{name = "Ultimate Spirit Potion", description = "250x Ultimate Spirit Potion", price = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, thingId = 26030, count = 250, count = 1, icons = {"26030.png"}},			
	{name = "health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28577, count = 500, icons = {"28577.png"}},
	{name = "health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28577, count = 500, icons = {"28577.png"}},
	{name = "strong health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28578, count = 500, icons = {"28578.png"}},
	{name = "great health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28579, count = 500, icons = {"28579.png"}},
	{name = "ultimate health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28580, count = 500, icons = {"28580.png"}},
	{name = "supreme health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28581, count = 500,  icons = {"28581.png"}},						   
	{name = "mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28582, count = 500, icons = {"28582.png"}},
	{name = "strong mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28583, count = 500, icons = {"28583.png"}},
	{name = "great mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28584, count = 500, icons = {"28584.png"}},
	{name = "ultimate mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28585, count = 500, icons = {"28585.png"}},
    {name = "supreme mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28586, count = 500, icons = {"28586.png"}},
	{name = "great spirit potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28587, count = 500, icons = {"28587.png"}},
	{name = "ultimate spirit potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28588, count = 500, icons = {"28588.png"}},
					
				}
				},
{
		name = "Kegs",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Potions.png"},
		offers = {			
	{name = "health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28577, count = 500, icons = {"28577.png"}},
	{name = "strong health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28578, count = 500, icons = {"28578.png"}},
	{name = "great health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28579, count = 500, icons = {"28579.png"}},
	{name = "ultimate health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28580, count = 500, icons = {"28580.png"}},
	{name = "supreme health potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28581, count = 500,  icons = {"28581.png"}},						   
	{name = "mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28582, count = 500, icons = {"28582.png"}},
	{name = "strong mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28583, count = 500, icons = {"28583.png"}},
	{name = "great mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28584, count = 500, icons = {"28584.png"}},
	{name = "ultimate mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28585, count = 500, icons = {"28585.png"}},
    {name = "supreme mana potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28586, count = 500, icons = {"28586.png"}},
	{name = "great spirit potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28587, count = 500, icons = {"28587.png"}},
	{name = "ultimate spirit potion keg", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, thingId = 28588, count = 500, icons = {"28588.png"}},
					
				}
				},				
	
	{
		name = "Outfits",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Outfits.png"},
		rookgaard = false,
		offers = {
		{name = "Full Trophy Hunter Outfits", thingId = {male=957,female=958}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons= {"Product_Outfit_TrophyHunter_Male_Full.png","Product_Outfit_TrophyHunter_Female_Full.png"}},
		{name = "Trophy Hunter Outfits", thingId = {male=957,female=958}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_TrophyHunter_Male_Base.png","Product_Outfit_TrophyHunter_Female_Base.png"}},
		{name = "Trophy Hunter Outfits Addon 1", thingId = {male=957,female=958}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_TrophyHunter_Male_Addon1.png", "Product_Outfit_TrophyHunter_Female_Addon1.png"}},
		{name = "Trophy Hunter Outfits Addon 2", thingId = {male=957,female=958}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_TrophyHunter_Male_Addon2.png","Product_Outfit_TrophyHunter_Female_Addon2.png"}},

		{name = "Full Pharaoh OutFits", thingId = {male=955,female=956}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_Pharaoh_male_Full.png","Product_Outfit_Pharaoh_female_Full.png"}},
		{name = "Pharaoh Outfits", thingId = {male=955,female=956}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_Pharaoh_male_Base.png","Product_Outfit_Pharaoh_female_Base.png"}},
		{name = "Pharaoh Outfits Addon 1", thingId = {male=955,female=956}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Pharaoh_male_Addon1.png","Product_Outfit_Pharaoh_female_Addon1.png"}},
		{name = "Pharaoh Outfits Addon 2", thingId = {male=955,female=956}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Pharaoh_male_Addon2.png","Product_Outfit_Pharaoh_female_Addon2.png"}},
	
		{name = "Full Grove Keeper OutFits", thingId = {male=908,female=909}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_AntlerDruid_male_Full.png","Product_Outfit_AntlerDruid_female_Full.png"}},
		{name = "Grove Keeper Outfits", thingId = {male=908,female=909}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_AntlerDruid_male_Base.png","Product_Outfit_AntlerDruid_female_Base.png"}},
		{name = "Grove Keeper Outfits Addon 1", thingId = {male=908,female=909}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_AntlerDruid_male_Addon1.png","Product_Outfit_AntlerDruid_female_Addon1.png"}},
		{name = "Grove Keeper Outfits Addon 2", thingId = {male=908,female=909}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_AntlerDruid_male_Addon2.png","Product_Outfit_AntlerDruid_female_Addon2.png"}},
	
		{name = "Full Champion Outfits", thingId = {male=633,female=632}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_Champion_Male_Full.png","Product_Outfit_Champion_Female_Full.png"}},
		{name = "Champion Outfits", thingId = {male=633,female=632}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_Champion_Male_Base.png","Product_Outfit_Champion_Female_Base.png"}},
		{name = "Champion Outfits Addon 1", thingId = {male=633,female=632}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Champion_Male_Addon1.png","Product_Outfit_Champion_Female_Addon1.png"}},
		{name = "Champion Outfits Addon 2", thingId = {male=633,female=632}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Champion_Male_Addon2.png","Product_Outfit_Champion_Female_Addon2.png"}},

		{name = "Full Conjurer Outfits", thingId = {male=634,female=635}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_Conjurer_Male_Full.png","Product_Outfit_Conjurer_Female_Full.png"}},
		{name = "Conjurer Outfits", thingId = {male=634,female=635}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_Conjurer_Male_Base.png","Product_Outfit_Conjurer_Female_Base.png"}},
		{name = "Conjurer Outfits Addon 1", thingId = {male=634,female=635}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Conjurer_Male_Addon1.png","Product_Outfit_Conjurer_Female_Addon2.png"}},
		{name = "Conjurer Outfits Addon 2", thingId = {male=634,female=635}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Conjurer_Male_Addon2.png","Product_Outfit_Conjurer_Female_Addon1.png"}},

		{name = "Full Lupine Warden Outfits", thingId = {male=899,female=900}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_LupinWarden_male_Full.png","Product_Outfit_LupinWarden_female_Full.png"}},
		{name = "Lupine Warden Outfits", thingId = {male=899,female=900}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_LupinWarden_male_Base.png","Product_Outfit_LupinWarden_female_Base.png"}},
		{name = "Lupine Warden Outfits Addon 1", thingId = {male=899,female=900}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_LupinWarden_male_Addon1.png","Product_Outfit_LupinWarden_female_Addon1.png"}},
		{name = "Lupine Warden Outfits Addon 2", thingId = {male=899,female=900}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_LupinWarden_male_Addon2.png","Product_Outfit_LupinWarden_female_Addon2.png"}},
	
		{name = "Full Arena Champion Outfits", thingId = {male=884,female=885}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_ArenaChampion_Male_Full.png","Product_Outfit_ArenaChampion_Female_Full.png"}},
		{name = "Arena Champion Outfits", thingId = {male=884,female=885}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_ArenaChampion_Male_Base.png","Product_Outfit_ArenaChampion_Female_Base.png"}},
		{name = "Arena Champion Outfits Addon 1", thingId = {male=884,female=885}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_ArenaChampion_Male_Addon1.png","Product_Outfit_ArenaChampion_Female_Addon1.png"}},
		{name = "Arena Champion Outfits Addon 2", thingId = {male=884,female=885}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_ArenaChampion_Male_Addon2.png","Product_Outfit_ArenaChampion_Female_Addon1.png"}},

		{name = "Full Beastmaster Outfits", thingId = {male=637,female=636}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_Beastmaster_Male_Full.png","Product_Outfit_Beastmaster_Female_Full.png"}},
		{name = "Beastmaster Outfits", thingId = {male=637,female=636}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_Beastmaster_Male_Base.png","Product_Outfit_Beastmaster_Female_Base.png"}},
		{name = "Beastmaster Outfits Addon 1", thingId = {male=637,female=636}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Beastmaster_Male_Addon1.png","Product_Outfit_Beastmaster_Female_Addon1.png"}},
		{name = "Beastmaster Outfits Addon 2", thingId = {male=637,female=636}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Beastmaster_Male_Addon2.png","Product_Outfit_Beastmaster_Female_Addon2.png"}},

		{name = "Full Winter Warden Outfits", thingId = {male=853,female=852}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_WinterWarden_Male_Full.png","Product_Outfit_WinterWarden_Female_Full.png"}},
		{name = "Winter Warden Outfits", thingId = {male=853,female=852}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_WinterWarden_Male_Base.png","Product_Outfit_WinterWarden_Female_Base.png"}},
		{name = "Winter Warden Outfits Addon 1", thingId = {male=853,female=852}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_WinterWarden_Male_Addon1.png","Product_Outfit_WinterWarden_Female_Addon1.png"}},
		{name = "Winter Warden Outfits Addon 2", thingId = {male=853,female=852}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_WinterWarden_Male_Addon2.png","Product_Outfit_WinterWarden_Female_Addon2.png"}},
	
		{name = "Full Chaos Acolyte Outfits", thingId = {male=665,female=664}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_ChaosAcolyte_Male_Full.png","Product_Outfit_ChaosAcolyte_Female_Full.png"}},
		{name = "Chaos Acolyte Outfits", thingId = {male=665,female=664}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_ChaosAcolyte_Male_Base.png","Product_Outfit_ChaosAcolyte_Female_Base.png"}},
		{name = "Chaos Acolyte Outfits Addon 1", thingId = {male=665,female=664}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_ChaosAcolyte_Male_Addon1.png","Product_Outfit_ChaosAcolyte_Female_Addon1.png"}},
		{name = "Chaos Acolyte Outfits Addon 2", thingId = {male=665,female=664}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_ChaosAcolyte_Male_Addon2.png","Product_Outfit_ChaosAcolyte_Female_Addon2.png"}},

		{name = "Full Death Herald Outfits", thingId = {male=667,female=666}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_DeathHerald_Male_Full.png","Product_Outfit_DeathHerald_Female_Full.png"}},
		{name = "Death Herald Outfits", thingId = {male=667,female=666}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_DeathHerald_Male_Base.png","Product_Outfit_DeathHerald_Female_Base.png"}},
		{name = "Death Herald Outfits Addon 1", thingId = {male=667,female=666}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_DeathHerald_Male_Addon1.png","Product_Outfit_DeathHerald_Female_Addon1.png"}},
		{name = "Death Herald Outfits Addon 2", thingId = {male=667,female=666}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_DeathHerald_Male_Addon2.png","Product_Outfit_DeathHerald_Female_Addon2.png"}},

		{name = "Full Philosopher Outfits", thingId = {male=873,female=874}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_Professor_Male_Full.png","Product_Outfit_Professor_Female_Full.png"}},
		{name = "Philosopher Outfits", thingId = {male=873,female=874}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_Professor_Male_Base.png","Product_Outfit_Professor_Female_Base.png"}},
		{name = "Philosopher Outfits Addon 1", thingId = {male=873,female=874}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Professor_Male_Addon1.png","Product_Outfit_Professor_Female_Addon1.png"}},
		{name = "Philosopher Outfits Addon 2", thingId = {male=873,female=874}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Professor_Male_Addon2.png","Product_Outfit_Professor_Female_Addon2.png"}},
	
		{name = "Full Ranger Outfits", thingId = {male=684,female=683}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_Ranger_Male_Full.png","Product_Outfit_Ranger_Female_Full.png"}},
		{name = "Ranger Outfits", thingId = {male=684,female=683}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_Ranger_Male_Base.png","Product_Outfit_Ranger_Female_Base.png"}},
		{name = "Ranger Outfits Addon 1", thingId = {male=684,female=683}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Ranger_Male_Addon1.png","Product_Outfit_Ranger_Female_Addon1.png"}},
		{name = "Ranger Outfits Addon 2", thingId = {male=684,female=683}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Ranger_Male_Addon2.png","Product_Outfit_Ranger_Female_Addon2.png"}},

		{name = "Full Ceremonial Garb Outfits", thingId = {male=695,female=694}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_CeremonialGarb_Male_Full.png","Product_Outfit_CeremonialGarb_Female_Full.png"}},
		{name = "Ceremonial Garb Outfits", thingId = {male=695,female=694}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_CeremonialGarb_Male_Base.png","Product_Outfit_CeremonialGarb_Female_Base.png"}},
		{name = "Ceremonial Garb Outfits Addon 1", thingId = {male=695,female=694}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_CeremonialGarb_Male_Addon1.png","Product_Outfit_CeremonialGarb_Female_Addon1.png"}},
		{name = "Ceremonial Garb Outfits Addon 2", thingId = {male=695,female=694}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_CeremonialGarb_Male_Addon2.png","Product_Outfit_CeremonialGarb_Female_Addon2.png"}},
	
		{name = "Full Royal Pumpkin Outfits", thingId = {male=760,female=759}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_RoyalPumpkin_Male_Full.png","Product_Outfit_RoyalPumpkin_Female_Full.png"}},
		{name = "Royal Pumpkin Outfits", thingId = {male=760,female=759}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_RoyalPumpkin_Male_Base.png","Product_Outfit_RoyalPumpkin_Female_Base.png"}},
		{name = "Royal Pumpkin Outfits Addon 1", thingId = {male=760,female=759}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_RoyalPumpkin_Male_Addon1.png","Product_Outfit_RoyalPumpkin_Female_Addon1.png"}},
		{name = "Royal Pumpkin Outfits Addon 2", thingId = {male=760,female=759}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_RoyalPumpkin_Male_Addon2.png","Product_Outfit_RoyalPumpkin_Female_Addon2.png"}},
	
		{name = "Full Puppeteer Outfits", thingId = {male=697,female=696}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_Puppeteer_Male_Full.png","Product_Outfit_Puppeteer_Female_Full.png"}},
		{name = "Puppeteer Outfits", thingId = {male=697,female=696}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_Puppeteer_Male_Base.png","Product_Outfit_Puppeteer_Female_Base.png"}},
		{name = "Puppeteer Outfits Addon 1", thingId = {male=697,female=696}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Puppeteer_Male_Addon1.png","Product_Outfit_Puppeteer_Female_Addon1.png"}},
		{name = "Puppeteer Outfits Addon 2", thingId = {male=697,female=696}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Puppeteer_Male_Addon2.png","Product_Outfit_Puppeteer_Female_Addon2.png"}},
	
		{name = "Full Spirit Caller Outfits", thingId = {male=699,female=698}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_SpiritCaller_Male_Full.png","Product_Outfit_SpiritCaller_Female_Full.png"}},
		{name = "Spirit Caller Outfits", thingId = {male=699,female=698}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_SpiritCaller_Male_Base.png","Product_Outfit_SpiritCaller_Female_Base.png"}},
		{name = "Spirit Caller Outfits Addon 1", thingId = {male=699,female=698}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_SpiritCaller_Male_Addon1.png","Product_Outfit_SpiritCaller_Female_Addon1.png"}},
		{name = "Spirit Caller Outfits Addon 2", thingId = {male=699,female=698}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_SpiritCaller_Male_Addon2.png","Product_Outfit_SpiritCaller_Female_Addon2.png"}},
		
		{name = "Full Evoker Outfits", thingId = {male=725,female=724}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_Evoker_Male_Full.png","Product_Outfit_Evoker_Female_Full.png"}},
		{name = "Evoker Outfits", thingId = {male=725,female=724}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_Evoker_Male_Base.png","Product_Outfit_Evoker_Female_Base.png"}},
		{name = "Evoker Outfits Addon 1", thingId = {male=725,female=724}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Evoker_Male_Addon1.png","Product_Outfit_Evoker_Female_Addon1.png"}},
		{name = "Evoker Outfits Addon 2", thingId = {male=725,female=724}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Evoker_Male_Addon2.png","Product_Outfit_Evoker_Female_Addon2.png"}},
		
		{name = "Full Seaweaver Outfits", thingId = {male=733,female=732}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_SeaWeaver_Male_Full.png","Product_Outfit_SeaWeaver_Female_Full.png"}},
		{name = "Seaweaver Outfits", thingId = {male=733,female=732}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_SeaWeaver_Male_Base.png","Product_Outfit_SeaWeaver_Female_Base.png"}},
		{name = "Seaweaver Outfits Addon 1", thingId = {male=733,female=732}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_SeaWeaver_Male_Addon1.png","Product_Outfit_SeaWeaver_Female_Addon1.png"}},
		{name = "Seaweaver Outfits Addon 2", thingId = {male=733,female=732}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_SeaWeaver_Male_Addon2.png","Product_Outfit_SeaWeaver_Female_Addon2.png"}},
	
		{name = "Full Entrepreneur Outfits", thingId = {male=472,female=471}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 65, icons = {"Product_Outfit_Entrepreneur_Male_Full.png","Product_Outfit_Entrepreneur_Female_Full.png"}},
		{name = "Entrepreneur Outfits", thingId = {male=472,female=471}, addon = 0, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 15, icons = {"Product_Outfit_Entrepreneur_Male_Base.png","Product_Outfit_Entrepreneur_Female_Base.png"}},
		{name = "Entrepreneur Outfits Addon 1", thingId = {male=472,female=471}, addon = 1, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Entrepreneur_Male_Addon1.png","Product_Outfit_Entrepreneur_Female_Addon1.png"}},
		{name = "Entrepreneur Outfits Addon 2", thingId = {male=472,female=471}, addon = 2, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Entrepreneur_Male_Addon2.png","Product_Outfit_Entrepreneur_Female_Addon2.png"}}
		
		}
	},
	{
		name = "Retro Outfits",
		state = GameStore.States.STATE_NONE,
		icons = {"category_retro.png"},
		rookgaard = false,
		offers = {
	 {name = "Retro Citizen Outfit", thingId = {male=974,female=975}, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 60, icons = {"Product_Outfit_RetroCitizen_Male_Base.png","Outfit_Retro_Citizen_Female.png"}},
	 
	 {name = "Retro Hunter Outfit", thingId = {male=972,female=973}, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 60, icons = {"Product_Outfit_RetroHunter_Male_Base.png","Outfit_Retro_Hunter_Female.png"}},
	 
	{name = "Retro Knight Outfit", thingId = {male=970,female=971}, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 60, icons = {"Product_Outfit_RetroKnight_Male_Base.png","Outfit_Retro_Knight_Female.png"}},
	
	{name = "Retro Mage Outfit", thingId = {male=968,female=969}, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 60, icons = {"Product_Outfit_RetroMage_Male_Base.png","Outfit_Retro_Mage_Female.png"}},	 
	
	{name = "Retro Warrior Outfit", thingId = {male=962,female=963}, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 60, icons = {"Product_Outfit_RetroWarrior_Male_Base.png","Outfit_Retro_Warrior_Female.png"}},
	
	{name = "Retro Summoner Outfit", thingId = {male=964,female=965}, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 60, icons = {"Product_Outfit_RetroSummoner_Male_Base.png","Outfit_Retro_Summoner_Female.png"}},
	
	 {name = "Retro Nobleman Outfit", thingId = {male=966,female=967}, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT, price = 60, icons = {"Product_Outfit_RetroNobleman_Male_Base.png","Product_Outfit_RetroNobleman_Female_Base.png"}}
		}
	},
	{
		name = "Mounts",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_Mounts.png"},
		offers = {
			-- Mount Example : thingId = mountId
			{name = "Widow Queen", thingId = 1, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o368.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Racing Bird", thingId = 2, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o369.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "War Bear", thingId = 3, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o370.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Black Sheep", thingId = 4, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o371.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Midnight Panther", thingId = 5, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o372.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Draptor", thingId = 6, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o373.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Titanica", thingId = 7, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o374.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Tin Lizzard", thingId = 8, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o375.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			--{name = "Blazebringer", thingId = 9, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o376.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Rapid Boar", thingId = 10, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o377.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			--{name = "Stampor", thingId = 11, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o378.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Undead Cavebear", thingId = 12, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o379.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Donkey", thingId = 13, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o387.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Tiger Slug", thingId = 14, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o388.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Uniwheel", thingId = 15, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o389.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Crystal Wolf", thingId = 16, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o390.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "War Horse", thingId = 17, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o392.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Kingly Deer", thingId = 18, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o401.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Tamed Panda", thingId = 19, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o402.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Dromedary", thingId = 20, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o405.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Scorpion King", thingId = 21, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o406.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Rented Horse", thingId = 22, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o421.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Armoured War Horse", thingId = 23, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o426.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Shadow Draptor", thingId = 24, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o427.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Rented Horse", thingId = 25, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o437.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Rented Horse", thingId = 26, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o438.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Ladybug", thingId = 27, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o447.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Manta Ray", thingId = 28, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o450.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Ironblight", thingId = 29, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o502.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Magma Crawler", thingId = 30, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o503.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Dragonling", thingId = 31, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o506.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			--{name = "Gnarlhound", thingId = 32, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 530, icons = {"o515.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Crimson Ray", thingId = 33, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o521.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Steelbeak", thingId = 34, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o522.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Water Buffalo", thingId = 35, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 30, icons = {"o526.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Tombstinger", thingId = 36, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o546.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Platesaurian", thingId = 37, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o547.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Ursagrondon", thingId = 38, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 560, icons = {"o548.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			--{name = "The Hellgrip", thingId = 39, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o559.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Noble Lion", thingId = 40, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o571.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Desert King", thingId = 41, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o572.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Shock Head", thingId = 42, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o580.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Walker", thingId = 43, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o606.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Azudocus", thingId = 44, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o621.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Carpacosaurus", thingId = 45, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o622.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Death Crawler", thingId = 46, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o624.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Flamesteed", thingId = 47, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o626.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Jade Lion", thingId = 48, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o627.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Jade Pincer", thingId = 49, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o628.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Nethersteed", thingId = 50, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o629.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Tempest", thingId = 51, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o630.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Winter King", thingId = 52, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o631.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Doombringer", thingId = 53, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o644.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Woodland Prince", thingId = 54, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o647.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Hailtorm Fury", thingId = 55, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o648.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Siegebreaker", thingId = 56, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o649.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Poisonbane", thingId = 57, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o650.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Blackpelt", thingId = 58, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o651.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Golden Dragonfly", thingId = 59, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o669.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Steel Bee", thingId = 60, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o670.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Copper Fly", thingId = 61, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o671.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Tundra Rambler", thingId = 62, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o672.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Highland Yak", thingId = 63, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o673.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Glacier Vagabond", thingId = 64, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o674.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Flying Divan", thingId = 65, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o688.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Magic Carpet", thingId = 66, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o689.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Floating Kashmir", thingId = 67, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o690.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Ringtail Waccoon", thingId = 68, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o691.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Night Waccoon", thingId = 69, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o692.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Emerald Waccoon", thingId = 70, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o693.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			--{name = "Glooth Glider", thingId = 71, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o682.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Shadow Hart", thingId = 72, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o685.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Black Stag", thingId = 73, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o686.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Emperor Deer", thingId = 74, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o687.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Flitterkatzen", thingId = 75, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o726.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Venompaw", thingId = 76, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o727.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Batcat", thingId = 77, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o728.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Sea Devil", thingId = 78, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o734.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Coralripper", thingId = 79, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o735.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Plumfish", thingId = 80, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o736.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Gorongra", thingId = 81, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o738.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Noctungra", thingId = 82, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o739.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Silverneck", thingId = 83, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o740.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Slagsnare", thingId = 84, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o761.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Nightstinger", thingId = 85, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o762.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Razorcreep", thingId = 86, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o763.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			--{name = "Rift Runner", thingId = 87, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o848.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Nightdweller", thingId = 88, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o849.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Frostflare", thingId = 89, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o850.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Cinderhoof", thingId = 90, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o851.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Mouldpincer", thingId = 91, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o868.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Bloodcurl", thingId = 92, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o869.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Leafscuttler", thingId = 93, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o870.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Sparkion", thingId = 94, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o883.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Swamp Snapper", thingId = 95, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o886.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Mould Shell", thingId = 96, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o887.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Reed Lurker", thingId = 97, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o888.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Neon Sparkid", thingId = 98, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o889.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Vortexion", thingId = 99, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o890.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Ivory Fang", thingId = 100, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o901.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Shadow Claw", thingId = 101, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o902.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
			-- Mount Example : thingId = mountId
			{name = "Snow Pelt", thingId = 102, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 60, icons = {"o903.png"}, description = "Here you can purchase the Mount  for your character. Riding on a mount is not only cool, but also gives your character a speed boost."},
		}
	},

	{
		name = "House Equipment",
		state = GameStore.States.STATE_NONE,
		icons = {"Category_HouseEquipment.png"},
		rookgaard = false,
		offers = {
		{name = "health potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28553, count = 1000, icons = {"28553.png"}},
	    {name = "strong health potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28554, count = 1000, icons = {"28554.png"}},
	    {name = "great health potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28555, count = 1000, icons = {"28555.png"}},
        {name = "ultimate health potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28556, count = 1000, icons = {"28556.png"}},
	    {name = "supreme health potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28557, count = 1000, icons = {"28557.png"}},					   
        {name = "mana potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28563, count = 1000, icons = {"28563.png"}},
	    {name = "strong mana potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28564, count = 1000, icons = {"28564.png"}},
	    {name = "great mana potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28565, count = 1000, icons = {"28565.png"}},
	    {name = "ultimate mana potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28566, count = 1000, icons = {"28566.png"}},
	    {name = "great spirit potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28573, count = 1000, icons = {"28573.png"}},
	    {name = "ultimate spirit potion cask", type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 45, thingId = 28574, count = 1000, icons = {"28574.png"}}, 
		{name = "Gilded Imbuing Shrine", description = "Buy an incredible Gilded Imbuing Shrine to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27838, count = 1, price = 200, icons = {"Product_HouseEquipment_GildedImbuingShrine.png"}},
		{name = "Imbuing Shrine", description = "Buy an incredible Imbuing Shrine to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27830, count = 1, price = 150, icons = {"Product_HouseEquipment_ImbuingShrine.png"}},
		{name = "Magnificent Cabinet", description = "Buy an incredible Magnificent Cabinet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26075, count = 1, price = 100, icons = {"Product_HouseEquipment_BaroqueFurniture_Cabinet.png"}},
		{name = "Magnificent chair", description = "Buy an incredible Magnificent chair to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26059, count = 1, price = 60, icons = {"Product_HouseEquipment_BaroqueFurniture_Chair.png"}},
		{name = "Magnificent Trunk", description = "Buy an incredible Magnificent Trunk to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26083, count = 1, price = 70, icons = {"Product_HouseEquipment_BaroqueFurniture_Chest.png"}},
		{name = "Magnificent Table", description = "Buy an incredible Magnificent Table to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26073, count = 1, price = 60, icons = {"Product_HouseEquipment_BaroqueFurniture_Table.png"}},
		{name = "Ferocious Cabinet", description = "Buy an incredible Ferocious Cabinet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26077, count = 1, price = 110, icons = {"Product_HouseEquipment_TortureChamberFurniture_Cabinet.png"}},
		{name = "Ferocious Chair", description = "Buy an incredible Ferocious Chair to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26063, count = 1, price = 50, icons = {"Product_HouseEquipment_TortureChamberFurniture_Chair.png"}},
		{name = "Ferocious Trunk", description = "Buy an incredible Ferocious Trunk to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26079, count = 1, price = 80, icons = {"Product_HouseEquipment_TortureChamberFurniture_Chest.png"}},
		{name = "Ferocious Table", description = "Buy an incredible Ferocious Table to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26067, count = 1, price = 50, icons = {"Product_HouseEquipment_TortureChamberFurniture_Table.png"}},
		{name = "Rustic Cabinet", description = "Buy an incredible Rustic Cabinet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26356, count = 1, price = 100, icons = {"Product_HouseEquipment_RusticFurniture_Cabinet.png"}},
		{name = "Rustic Chair", description = "Buy an incredible Rustic Chair to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26349, count = 1, price = 50, icons = {"Product_HouseEquipment_RusticFurniture_Chair.png"}},
		{name = "Rustic Trunk", description = "Buy an incredible Rustic Trunk to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26358, count = 1, price = 80, icons = {"Product_HouseEquipment_RusticFurniture_Chest.png"}},
		{name = "Rustic Table", description = "Buy an incredible Rustic Table to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26354, count = 1, price = 50, icons = {"Product_HouseEquipment_RusticFurniture_Table.png"}},
		{name = "vengothic cabinet", description = "Buy an incredible Vengothic Cabinet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27901, count = 1, price = 100, icons = {"Product_HouseEquipment_VengothicFurniture_Cupboard.png"}},
		{name = "Vengothic Chair", description = "Buy an incredible Vengothic Chair to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27895, count = 1, price = 50, icons = {"Product_HouseEquipment_VengothicFurniture_Chair.png"}},
		{name = "Vengothic Chest", description = "Buy an incredible Vengothic Chest to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27903, count = 1, price = 80, icons = {"Product_HouseEquipment_VengothicFurniture_Chest.png"}},
		{name = "Vengothic Table", description = "Buy an incredible Vengothic Table to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27899, count = 1, price = 50, icons = {"Product_HouseEquipment_VengothicFurniture_Table.png"}},
		{name = "Bitter-Smack Leaf", description = "Buy an incredible Bitter-Smack Leaf to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27891, count = 1, price = 50, icons = {"Product_HouseEquipment_BitterSmackLeaf.png"}},
		{name = "Blooming Cactus", description = "Buy an incredible Blooming Cactus to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27890, count = 1, price = 50, icons = {"Product_HouseEquipment_BloomingCactus.png"}},
		{name = "Pink Roses", description = "Buy an incredible Pink Roses to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27892, count = 1, price = 50, icons = {"Product_HouseEquipment_PinkRoses.png"}},
		{name = "Red Roses", description = "Buy an incredible Red Roses to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27893, count = 1, price = 50, icons = {"Product_HouseEquipment_RedRoses.png"}},
		{name = "Yellow Roses", description = "Buy an incredible Yellow Roses to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27894, count = 1, price = 50, icons = {"Product_HouseEquipment_YellowRoses.png"}},
		{name = "Yalaharian Carpet", description = "Buy an incredible Yalaharian Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26087, count = 1, price = 35, icons = {"Product_HouseEquipment_Carpet1.png"}},
		{name = "White Fur Carpet", description = "Buy an incredible White Fur Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26088, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet2.png"}},
		{name = "Bamboo Mat", description = "Buy an incredible Bamboo Mat to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26089, count = 1, price = 25, icons = {"Product_HouseEquipment_Carpet3.png"}},
		{name = "Crimson Carpet", description = "Buy an incredible Crimson Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26363, count = 1, price = 35, icons = {"Product_HouseEquipment_Carpet_04.png"}},
		{name = "Azure Carpet", description = "Buy an incredible Azure Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26366, count = 1, price = 35, icons = {"Product_HouseEquipment_Carpet_05.png"}},
		{name = "Emerald Carpet", description = "Buy an incredible Emerald Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26367, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet_06.png"}},
		{name = "Light Parquet", description = "Buy an incredible Light Parquet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26368, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet_07.png"}},
		{name = "Dark Parquet", description = "Buy an incredible Dark Parquet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26369, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet_08.png"}},
		{name = "Flowery Carpet", description = "Buy an incredible Flowery Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27072, count = 1, price = 35, icons = {"Product_HouseEquipment_Carpet_10.png"}},
		{name = "Colourful Carpet", description = "Buy an incredible Colourful Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27081, count = 1, price = 35, icons = {"Product_HouseEquipment_Carpet_11.png"}},
		{name = "Striped Carpet", description = "Buy an incredible Striped Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27074, count = 1, price = 35, icons = {"Product_HouseEquipment_Carpet_12.png"}},
		{name = "Fur Carpet", description = "Buy an incredible Fur Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27075, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet_13.png"}},
		{name = "Diamond Carpet", description = "Buy an incredible Diamond Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27076, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet_14.png"}},
		{name = "Patterned Carpet", description = "Buy an incredible Patterned Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27077, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet_15.png"}},
		{name = "Night Sky Carpet", description = "Buy an Night Sky Carpet Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27078, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet_16.png"}},
		{name = "Star Carpet", description = "Buy an incredible Star Carpet to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27079, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet_17.png"}},
		{name = "Marble Floor", description = "Buy an incredible Marble Floor to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26370, count = 1, price = 30, icons = {"Product_HouseEquipment_Carpet_09.png"}},
		{name = "Fish Tank", description = "Buy an incredible Fish Tank to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26347, count = 1, price = 180, icons = {"Product_HouseEquipment_Housepet_FishTank.png"}},
		{name = "Dog House", description = "Buy an incredible Dog House to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26353, count = 1, price = 150, icons = {"Product_HouseEquipment_Housepet_DogHouse.png"}},
		{name = "Baby Dragon", description = "Buy an incredible Baby Dragon to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26098, count = 1, price = 250, icons = {"Product_HouseEquipment_Housepet_BabyDragon.png"}},
		{name = "Cat in a Basket", description = "Buy an incredible Cat in a Basket to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26107, count = 1, price = 150, icons = {"Product_HouseEquipment_Housepet_Cat.png"}},
		{name = "Hamster in a Wheel", description = "Buy an incredible Hamster in a Wheel to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26100, count = 1, price = 180, icons = {"Product_HouseEquipment_Housepet_Hamster.png"}},
		{name = "Parrot", description = "Buy an incredible Parrot to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27088, count = 1, price = 180, icons = {"Product_HouseEquipment_Housepet_Parrot.png"}},
		{name = "Chamaleon", description = "Buy an incredible Chamaleon to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27887, count = 1, price = 250, icons = {"Product_HouseEquipment_Chameleon.png"}},
		{name = "Protectress Lamp", description = "Buy an incredible Protectress Lamp to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26094, count = 1, price = 90, icons = {"Product_HouseEquipment_Lamp_Goddess.png"}},
		{name = "Predator Lamp", description = "Buy an incredible Predator Lamp to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26090, count = 1, price = 60, icons = {"Product_HouseEquipment_Lamp_Leopard.png"}},
		{name = "Skull Lamp", description = "Buy an incredible Skull Lamp to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27090, count = 1, price = 90, icons = {"Product_HouseEquipment_Lamp_Skull.png"}},
		{name = "Vengothic Lamp", description = "Buy an incredible Vengothic Lamp to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 27884, count = 1, price = 180, icons = {"Product_HouseEquipment_VengothicLamp.png"}},
		{name = "Ornate Mailbox", description = "Buy an incredible Ornate Mailbox to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26057, count = 1, price = 200, icons = {"Product_HouseEquipment_Mailbox_Standard.png"}},
		{name = "Royal Mailbox", description = "Buy an incredible Royal Mailbox to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26055, count = 1, price = 150, icons = {"Product_HouseEquipment_Mailbox_Golden.png"}},
		{name = "Lordly Tapestry", description = "Buy an incredible Lordly Tapestry to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26104, count = 1, price = 50, icons = {"Product_HouseEquipment_Tapestry_01.png"}},
		{name = "Menacing Tapestry", description = "Buy an incredible Menacing Tapestry to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26105, count = 1, price = 70, icons = {"Product_HouseEquipment_Tapestry_02.png"}},
		{name = "All-Seeing Tapestry", description = "Buy an incredible All-Seeing Tapestry to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26106, count = 1, price = 60, icons = {"Product_HouseEquipment_Tapestry_03.png"}},
		{name = "Golden Dragon Tapestry", description = "Buy an incredible Golden Dragon Tapestry to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26379, count = 1, price = 70, icons = {"Product_HouseEquipment_Tapestry_04.png"}},
		{name = "Sword Tapestry", description = "Buy an incredible Sword Tapestry to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26380, count = 1, price = 60, icons = {"Product_HouseEquipment_Tapestry_05.png"}},
		{name = "Brocade Tapestry", description = "Buy an incredible Brocade Tapestry to decorate your home.", type = GameStore.OfferTypes.OFFER_TYPE_HOUSE, thingId = 26381, count = 1, price = 50, icons = {"Product_HouseEquipment_Tapestry_06.png"}},
			}
	},							
}

-- For Explanation and information
-- view the readme.md file in github or via markdown viewer.

-- Non-Editable
local runningId = 1
for k, category in ipairs(GameStore.Categories) do
	if category.offers then
		for m, offer in ipairs(category.offers) do
			offer.id = runningId
			runningId = runningId + 1
			
			if not offer.type then
				offer.type = GameStore.OfferTypes.OFFER_TYPE_NONE
			end
		end
	end
end
