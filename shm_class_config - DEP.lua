local mq           = require('mq')
local RGMercUtils  = require("utils.rgmercs_utils")

local _ClassConfig = {
    _version              = "Healer",
    _author               = "Algar",
    ['FullConfig']        = true,
    ['ModeChecks']        = {
        IsHealing = function() return true end,
        IsCuring = function() return true end,
        IsRezing = function() return RGMercUtils.GetSetting('DoBattleRez') or RGMercUtils.GetXTHaterCount() == 0 end,
    },
    ['Modes']             = {
        'Heal',
        --'Hybrid',
    },
    ['Cures']             = {
        --Revisit TLP Fallback when this is reintegrated
        CureNow = function(self, type, targetId)
            if RGMercUtils.AAReady("Radiant Cure") then
                return RGMercUtils.UseAA("Radiant Cure", targetId)
            end

            local cureSpell = RGMercUtils.GetResolvedActionMapItem('CureSpell')
            if not cureSpell or not cureSpell() then return false end
            return RGMercUtils.UseSpell(cureSpell.RankName.Name(), targetId, true)
        end,
    },
    ['ItemSets']          = {
        ['Epic'] = {
            "Crafted Talisman of Fates",
            "Blessed Spiritstaff of the Heyokah",
        },
        ['VP2Hammer'] = {
            "Apothic Dragon Spine Hammer",
        },
    },
    ['AbilitySets']       = {
        ["GroupFocusSpell"] = {
            -- Focus Spell - Group Spells will be used on everyone
            "Khura's Focusing",           -- Level 60 - Group
            "Focus of the Seventh",       -- Level 65 - Group
            "Talisman of Wunshi",         -- Level 70 - Group
            "Talisman of the Dire",       -- Level 75 - Group
            "Talisman of the Bloodworg",  -- Level 80 - Group
            "Talisman of Unity",          -- Level 85 - Group
            "Talisman of Soul's Unity",   -- Level 90 - Group
            "Talisman of Kolos' Unity",   -- Level 95 - Group
            "Talisman of the Courageous", -- Level 100 - Group
            "Talisman of the Doomscale",  -- Level 105 - Group
            "Talisman of the Wulthan",    -- Level 110 - Group
            "Talisman of the Ry'Gorr",    -- Level 115 - Group
            "Talisman of the Usurper",    -- Level 120 - Group
            "Talisman of the Heroic",     -- Level 125 - Group
        },
        ["SingleFocusSpell"] = {
            -- Focus Spell - Single Spells will only be used on the Tank
            "Inner Fire",             -- Level 1 - Single
            "Talisman of Tnarg",      -- Level 32 - Single
            "Talisman of Altuna",     -- Level 40 - Single
            "Talisman of Kragg",      -- Level 55 - Single
            "Unity of the Doomscale", -- Level 101 - Single
            "Unity of the Wulthan",   -- Level 106 - Single
            "Unity of the Kromrif",   -- Level 111 - Single
            "Unity of the Vampyre",   -- Level 116 - Single
            "Celeritous Unity",       -- Level 121 - Single
        },
        ["RunSpeedBuff"] = {
            -- Run Speed Buff - 9 - 74
            "Spirit of Tala'Tak",
            "Spirit of Bih`Li",
            "Pack Shrew",
            "Spirit of Wolf",
        },
        ["HasteBuff"] = {
            -- Haste Buff - 26 - 64
            "Talisman of Celerity",
            "Swift Like the Wind",
            "Celerity",
            "Quickness",
        },
        ["GrowthBuff"] = {
            -- Growth Buff 111 -> 81
            "Overwhelming Growth",
            "Fervent Growth",
            "Frenzied Growth",
            "Savage Growth",
            "Ferocious Growth",
            "Rampant Growth",
            "Unfettered Growth",
            "Untamed Growth",
            "Wild Growth",
        },
        ["LowLvlAtkBuff"] = {
            -- Low Level Attack Buff --- user under level 86
            "Primal Avatar",
            "Ferine Avatar",
            "Champion",
        },
        ["AEMaloSpell"] = {
            "Wind of Malisene",
            "Wind of Malis",
        },
        ["MaloSpell"] = {
            -- AA Starts at LVL 75
            "Malosinera",
            "Malosinetra",
            "Malosinise",
            "Malos",
            "Malosinia",
            "Malo",
            "Malosini",
            "Malosi",
            "Malaisement",
            "Malaise",
        },
        ["AESlowSpell"] = {
            "Tigir's Insects",
        },
        ["SlowSpell"] = {
            "Balance of Discord",
            "Balance of the Nihil",
            "Turgur's Insects",
            "Togor's Insects",
            "Tagar's Insects",
            "Walking Sleep",
            "Drowsy",
        },
        ["DieaseSlow"] = {
            "Cloud of Grummus",
            "Plague of Insects",
        },
        ["GroupHealProcBuff"] = {
            "Watchful Spirit",
            "Responsive Spirit",
            "Attentive Spirit",
        },
        ["SelfWard"] = {
            -- Self Heal Ward Spells -- LVL 115 -> LVL 80
            "Ward of Heroic Deeds",
            "Ward of Recuperation",
            "Ward of Remediation",
            "Ward of Regeneration",
            "Ward of Rejuvenation",
            "Ward of Reconstruction",
            "Ward of Recovery",
            "Ward of Restoration",
            "Ward of Resurgence",
            "Ward of Rebirth",
        },
        ["DichoSpell"] = {
            "Ecliptic Roar",
            "Composite Roar",
            "Dissident Roar",
            "Roar of the Lion",
        },
        ["MeleeProcBuff"] = {
            -- Melee Proc Buff - Level 50 - 111
            -- To be used when the Shaman does not have Dicho
            "Talisman of the Manul",
            "Talisman of the Kerran",
            "Talisman of the Lioness",
            "Talisman of the Sabretooth",
            "Talisman of the Leopard",
            "Talisman of the Snow Leopard",
            "Talisman of the Lion",
            "Talisman of the Tiger",
            "Talisman of the Lynx",
            "Talisman of the Cougar",
            "Talisman of the Panther",
            -- Below Level 71 This is a single target buff and should not be enabled without entry editing (as entries are keyed off of the SHM's buffs)
            -- "Spirit of the Panther",
            -- "Spirit of the Leopard",
            -- "Spirit of the Jaguar",
            -- "Spirit of the Puma",
        },
        ["SlowProcBuff"] = {
            -- Slow Proc Buff for MA - Level 68 - 122
            "Moroseness",
            "Melancholy",
            "Ennui",
            "Incapacity",
            "Sluggishness",
            "Fatigue",
            "Apathy",
            "Lethargy",
            "Listlessness",
            "Languor",
            "Lassitude",
            "Lingering Sloth",
        },
        ["PackSelfBuff"] = {
            -- Pack Self Buff - Level 90 - 115
            --- Ignoring the LVL 85 Call the Pack buff due to the decrease in mana per tick.
            "Pack of Ancestral Beasts",
            "Pack of Lunar Wolves",
            "Pack of The Black Fang",
            "Pack of Mirtuk",
            "Pack of Olesira",
            "Pack of Kriegas",
            "Pack of Hilnaah",
            "Pack of Wurt",
        },
        ["AllianceBuff"] = {
            "Ancient Alliance",
            "Ancient Coalition",
        },
        ["IcefixSpell"] = {
            -- Eradicate Curse
            "Remove Greater Curse",
            "Eradicate Curse",
        },
        ["RecklessHeal1"] = {
            "Reckless Reinvigoration",
            "Reckless Resurgence",
            "Reckless Renewal",
            "Reckless Rejuvenation",
            "Reckless Regeneration",
            "Reckless Restoration",
            "Reckless Remedy",
            "Reckless Mending",
            "Qirik's Mending",
            "Dannal's Mending",
            "Gemmi's Mending",
            "Ahnkaul's Mending",
            "Ancient: Wilslik's Mending",
            "Yoppa's Mending",
            "Daluda's Mending",
            "Tnarg's Mending",
            "Chloroblast",
            "Kragg's Salve",
            "Superior Healing",
            "Spirit Salve",
            "Greater Healing",
            "Healing",
            "Light Healing",
            "Minor Healing",
        },
        ["RecklessHeal2"] = {
            --worthless to mem two mendings because they don't have a recast time, keep Qirik's for when we only have one Reckless.
            "Reckless Reinvigoration",
            "Reckless Resurgence",
            "Reckless Renewal",
            "Reckless Rejuvenation",
            "Reckless Regeneration",
            "Reckless Restoration",
            "Reckless Remedy",
            "Reckless Mending",
            "Qirik's Mending",
        },
        ["AESpiritualHeal"] = {
            -- LVL 115-LVL100
            "Spiritual Shower",
            "Spiritual Squall",
            "Spiritual Swell",
            "Spiritual Surge",
        },
        ["RecourseHeal"] = {
            --- RecourseHeal LVL115-87
            "Grayleaf's Recourse",
            "Rowain's Recourse",
            "Zrelik's Recourse",
            "Eyrzekla's Recourse",
            "Krasir's Recourse",
            "Blezon's Recourse",
            "Gotikan's Recourse",
            "Qirik's Recourse",
        },
        ["InterventionHeal"] = {
            -- Intervention Heal LVL 113 -> 78
            "Immortal Intervention",
            "Primordial Intervention",
            "Prehistoric Intervention",
            "Historian's Intervention",
            "Antecessor's Intervention",
            "Progenitor's Intervention",
            "Ascendant's Intervention",
            "Antecedent's Intervention",
            "Ancestral Intervention",
            "Antediluvian Intervention",
        },
        ["GroupRenewalHoT"] = {
            -- LVL 115->70
            "Reverie of Renewal",
            "Spirit of Renewal",
            "Spectre of Renewal",
            "Cloud of Renewal",
            "Shear of Renewal",
            "Wisp of Renewal",
            "Phantom of Renewal",
            "Penumbra of Renewal",
            "Shadow of Renewal",
            "Shade of Renewal",
            "Specter of Renewal",
            "Ghost of Renewal",
        },
        ["CanniSpell"] = {
            -- Convert Health to Mana - Level  23 - 113
            "Hoary Agreement",
            "Ancient Bargain",
            "Tribal Bargain",
            "Tribal Pact",
            "Ancestral Pact",
            "Ancestral Arrangement",
            "Ancestral Covenant",
            "Ancestral Obligation",
            "Ancestral Hearkening",
            "Ancestral Bargain",
            "Ancient: Ancestral Calling",
            "Pained Memory",
            "Ancient: Chaotic Pain",
            "Cannibalize IV",
            "Cannibalize III",
            "Cannibalize II",
            "Cannibalize",
        },
        ["CureSpell"] = {
            "Blood of Mayong",
            "Blood of Tevik",
            "Blood of Rivans",
            "Blood of Sanera",
            "Blood of Klar",
            "Blood of Corbeth",
            "Blood of Avoling",
            "Blood of Nadox",
        },
        ["TwinHealNuke"] = {
            -- Nuke the MA Not the assist target - Levels 85 - 115
            "Gelid Gift",
            "Polar Gift",
            "Wintry Gift",
            "Frostbitten Gift",
            "Glacial Gift",
            "Frigid Gift",
            "Freezing Gift",
            "Frozen Gift",
            "Frost Gift",
        },
        ["PoisonNuke"] = {
            -- Poison Nuke LVL115->LVL34
            "Red Eye's Spear of Venom",
            "Fleshrot's Spear of Venom",
            "Narandi's Spear of Venom",
            "Nexona's Spear of Venom",
            "Serisaria's Spear of Venom",
            "Slaunk's Spear of Venom",
            "Hiqork's Spear of Venom",
            "Spinechiller's Spear of Venom",
            "Severilous' Spear of Venom",
            "Vestax's Spear of Venom",
            "Ahnkaul's Spear of Venom",
            "Yoppa's Spear of Venom",
            "Spear of Torment",
            "Blast of Venom",
            "Shock of Venom",
            "Blast of Poison",
            "Shock of the Tainted",
        },
        ["FastPoisonNuke"] = {
            -- Fast Poison Nuke LVL115->LVL73
            "Oka's Bite",
            "Ander's Bite",
            "Direfang's Bite",
            "Mawmun's Bite",
            "Reefmaw's Bite",
            "Seedspitter's Bite",
            "Bite of the Grendlaen",
            "Bite of the Blightwolf",
            "Bite of the Ukun",
            "Bite of the Brownie",
            "Sting of the Queen",
        },
        ["FrostNuke"] = {
            --- FrostNuke - Levels 4 - 114
            "Ice Barrage",
            "Heavy Sleet",
            "Ice Salvo",
            "Ice Shards",
            "Ice Squall",
            "Ice Burst",
            "Ice Mass",
            "Ice Floe",
            "Ice Sheet",
            "Tundra Crumble",
            "Glacial Avalanche",
            "Ice Age",
            "Velium Strike",
            "Ice Strike",
            "Blizzard Blast",
            "Winter's Roar",
            "Frost Strike",
            "Spirit Strike",
            "Frost Rift",
        },
        ["ChaoticDoT"] = {
            -- Long Dot(42s) LVL 109 -> LVL104
            -- Two resist types because it throws 2 dots
            -- Stacking: Nectar of Pain - Stacking: Blood of Saryrn
            "Chaotic Poison",
            "Chaotic Venom",
            "Chaotic Venin",
            "Chaotic Toxin",
        },
        ["PandemicDot"] = {
            -- Pandemic Dot Long Dot(84s) Level 103 - 108
            -- Two resist types because it throws 2 dots
            -- Stacking: Kralbor's Pandemic  -    Stacking: Breath of Ultor
            "Tegi Pandemic",
            "Bledrek's Pandemic",
            "Elkikatar's Pandemic",
            "Hemocoraxius' Pandemic",
        },
        ["MaloDot"] = {
            -- Malo Dot Stacking: Yubai's Affliction - LongDot(96s) Level 99 - 114
            "Svartmane's Malosinara",
            "Rirwech's Malosinata",
            "Livio's Malosenia",
            "Falhotep's Malosenia",
            "Txiki's Malosinara",
            "Krizad's Malosinera",
        },
        ["CurseDoT1"] = {
            -- Curse Dot 1 Stacking: Curse - Long Dot(30s) - Level 34 - 115
            "Malediction",
            "Obeah",
            "Evil Eye",
            "Jinx",
            "Garugaru",
            "Naganaga",
            "Hoodoo",
            "Hex",
            "Mojo",
            "Pocus",
            "Juju",
            "Curse of Sisslak",
            "Bane",
            "Anathema",
            "Odium",
            "Curse",
        },
        ["CurseDoT2"] = {
            ---, Stacking: Enalam's Curse - Long Dot(54s) - 100 - 115
            "Lenrel's Curse",
            "Marlek's Curse",
            "Erogo's Curse",
            "Sraskus' Curse",
            "Enalam's Curse",
            "Fandrel's Curse",
        },
        ["FastPoisonDoT"] = {
            ---, Stacking: Blood of Saryrn - Fast Dot(12s) - Level 89 - 115
            "Korsh's Venom",
            "Namdrows' Venom",
            "Xalgoti's Venom",
            "Mawmun's Venom",
            "Serpentil's Venom",
            "Banescale's Venom",
            "Stranglefang's Venom",
            "Undaleen's Venom",
        },
        ["SaryrnDot"] = {
            -- Stacking: Blood of Saryrn - Long Dot(42s) - Level 8 - 115
            "Desperate Vampyre Blood",
            "Restless Blood",
            "Reef Crawler Blood",
            "Phase Spider Blood",
            "Naeya Blood",
            "Spinechiller Blood",
            "Blood of Jaled'Dar",
            "Blood of Kerafyrm",
            "Vengeance of Ahnkaul",
            "Blood of Yoppa",
            "Blood of Saryrn",
            "Ancient: Scourge of Nife",
            "Bane of Nife",
            "Envenomed Bolt",
            "Venom of the Snake",
            "Envenomed Breath",
            "Tainted Breath",
        },
        ["FastDiseaseDoT"] = {
            -- Fast Disease Dot Stacking: Breath of Ultor - Fast Dot(12s) - Level 87 - 115
            "Krizad's Malady",
            "Cruor's Malady",
            "Malvus's Malady",
            "Hoshkar's Malady",
            "Sephry's Malady",
            "Elsrop's Malady",
            "Giaborn's Malady",
            "Nargul's Malady",
        },
        ["UltorDot"] = {
            ---, Stacking: Breath of Ultor - Long Dot(84s) - Level 4 - 111
            "Breath of the Hotariton",
            "Breath of the Tegi",
            "Breath of Bledrek",
            "Breath of Hemocoraxius",
            "Breath of Natigo",
            "Breath of Silbar",
            "Breath of the Shiverback",
            "Breath of Queen Malarian",
            "Breath of Big Bynn",
            "Breath of Ternsmochin",
            "Breath of Wunshi",
            "Breath of Ultor",
            "Pox of Bertoxxulous",
            "Plague",
            "Scourge",
            "Affliction",
            "Sicken",
        },
        ["NectarDot"] = {
            --- Nectar Dot Line
            "Nectar of Obscurity",
            "Nectar of Pain",
            "Nectar of Agony",
            "Nectar of Rancor",
            "Nectar of the Slitheren",
            "Nectar of Torment",
            "Nectar of Sholoth",
            "Nectar of Anguish",
            "Nectar of Woe",
            "Nectar of Suffering",
            "Nectar of Misery",
            "Nectar of Destitution",
        },
        ["PetSpell"] = {
            -- Pet Spell - 32 - 112
            "Suja's Faithful",
            "Diabo Sivuela's Faithful",
            "Grondo's Faithful",
            "Mirtuk's Faithful",
            "Olesira's Faithful",
            "Kriegas' Faithful",
            "Hilnaah's Faithful",
            "Wurt's Faithful",
            "Aina's Faithful",
            "Vegu's Faithful",
            "Kyrah's Faithful",
            "Farrel's Companion",
            "True Spirit",
            "Spirit of the Howler",
            "Frenzied Spirit",
            "Guardian spirit",
            "Vigilant Spirit",
            "Companion Spirit",
        },
        ["PetBuffSpell"] = {
            ---Pet Buff Spell - 50 - 112
            "Spirit Augmentation",
            "Spirit Reinforcement",
            "Spirit Bracing",
            "Spirit Bolstering",
            "Spirit Quickening",
        },
        ["TLPCureDisease"] = {
            "Cure Disease",
            "Counteract Disease",
            "Eradicate Disease",
        },
        ["TLPCurePoison"] = {
            "Counteract Poison",
            "Abolish Poison",
            "Eradicate Poison",
        },
        ["GroupRegenBuff"] = {
            "Talisman of the Unforgettable",
            "Talisman of the Tenacious",
            "Talisman of the Enduring",
            "Talisman of the Unwavering",
            "Talisman of the Faithful",
            "Talisman of the Steadfast",
            "Talisman of the Indomitable",
            "Talisman of the Reletntless",
            "Talisman of the Resolute",
            "Talisman of the Stalwart",
            "Talisman of the Stoic One",
            "Talisman of Perseverance",
            "Regrowth of Dar Khura",
        },
    },
    ['HelperFunctions']   = {
        DoRez = function(self, corpseId)
            if not RGMercUtils.PCSpellReady(mq.TLO.Spell("Incarnate Anew")) and
                not mq.TLO.FindItem("Staff of Forbidden Rites")() and
                not RGMercUtils.CanUseAA("Rejuvenation of Spirit") and
                not RGMercUtils.CanUseAA("Call of the Wild") then
                return false
            end

            RGMercUtils.SetTarget(corpseId)

            local target = mq.TLO.Target

            if not target or not target() then return false end

            if mq.TLO.Target.Distance() > 25 then
                RGMercUtils.DoCmd("/corpse")
            end

            local targetClass = target.Class.ShortName()

            if RGMercUtils.GetXTHaterCount() > 0 and (targetClass == "dru" or targetClass == "clr" or RGMercUtils.GetSetting('DoBattleRez')) then
                if mq.TLO.FindItem("Staff of Forbidden Rites")() and mq.TLO.Me.ItemReady("=Staff of Forbidden Rites")() then
                    return RGMercUtils.UseItem("Staff of Forbidden Rites", corpseId)
                end

                if RGMercUtils.AAReady("Call of the Wild") then
                    return RGMercUtils.UseAA("Call of the Wild", corpseId)
                end
            elseif RGMercUtils.GetXTHaterCount() == 0 then
                if RGMercUtils.CanUseAA("Rejuvenation of Spirit") then
                    return RGMercUtils.UseAA("Rejuvenation of Spirit", corpseId)
                end

                if RGMercUtils.PCSpellReady(mq.TLO.Spell("Incarnate Anew")) then
                    return RGMercUtils.UseSpell("Incarnate Anew", corpseId, true, true)
                end
            end

            return false
        end,
    },
    -- These are handled differently from normal rotations in that we try to make some intelligent desicions about which spells to use instead
    -- of just slamming through the base ordered list.
    -- These will run in order and exit after the first valid spell to cast
    ['HealRotationOrder'] = {
        {
            name  = 'BigHealPoint',
            state = 1,
            steps = 1,
            cond  = function(self, target) return (target.PctHPs() or 999) < RGMercUtils.GetSetting('BigHealPoint') end,
        },
        {
            name = 'GroupHealPoint',
            state = 1,
            steps = 1,
            cond = function(self, target)
                return (mq.TLO.Group.Injured(RGMercUtils.GetSetting('GroupHealPoint'))() or 0) >
                    RGMercUtils.GetSetting('GroupInjureCnt')
            end,
        },
        {
            name = 'MainHealPoint',
            state = 1,
            steps = 1,
            cond = function(self, target) return (target.PctHPs() or 999) < RGMercUtils.GetSetting('MainHealPoint') end,
        },
    },
    ['HealRotations']     = {
        ["GroupHealPoint"] = {
            {
                name = "RecourseHeal",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.CastReady(spell.RankName) and RGMercUtils.PCSpellReady(spell)
                end,
            },
            {
                name = "AESpiritualHeal",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.CastReady(spell.RankName) and RGMercUtils.PCSpellReady(spell)
                end,
            },
            {
                name = "Call of the Ancients",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.PCAAReady(aaName)
                end,
            },
            {
                name = "Fleeting Spirit",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.GetSetting('DoHOT') and RGMercUtils.PCAAReady(aaName)
                end,
            },
            {
                name = "GroupRenewalHoT",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercUtils.GetSetting('DoHOT') and RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
        },
        ["BigHealPoint"] = { --TODO: check/add personal emergency AA for if target is me
            {
                name = "Spiritual Blessing",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.PCAAReady(aaName)
                end,
            },
            {
                name = "InterventionHeal",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercUtils.CastReady(spell.RankName) and RGMercUtils.NPCSpellReady(spell, target.ID(), true)
                end,
            },
            {
                name = "Soothsayer's Intervention",
                type = "AA",
                cond = function(self, aaName, target)
                    return RGMercUtils.NPCAAReady(aaName, target.ID(), true)
                end,
            },
            {
                name = "Union of Spirits",
                type = "AA",
                cond = function(self, aaName, target)
                    return RGMercUtils.NPCAAReady(aaName, target.ID(), true)
                end,
            },
            {
                name = "VP2Hammer",
                type = "Item",
                cond = function(self, itemName)
                    return mq.TLO.FindItem(itemName).TimerReady() == 0
                end,
            },
            {
                name = "Forceful Rejuvenation",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.PCAAReady(aaName)
                end,
            },
        },
        ["MainHealPoint"] = {
            {
                name = "RecourseHeal",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercUtils.CastReady(spell.RankName) and RGMercUtils.NPCSpellReady(spell, target.ID(), true)
                end,
            },
            {
                name = "AESpiritualHeal",
                type = "Spell",
                cond = function(self, spell, target)
                    return (target.ID() or 0) == RGMercUtils.GetMainAssistId() and RGMercUtils.CastReady(spell.RankName) and RGMercUtils.NPCSpellReady(spell, target.ID(), true)
                end,
            },
            {
                name = "RecklessHeal1",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercUtils.NPCSpellReady(spell, target.ID(), true)
                end,
            },
            {
                name = "RecklessHeal2",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercUtils.NPCSpellReady(spell, target.ID(), true)
                end,
            },
            {
                name = "VP2Hammer",
                type = "Item",
                cond = function(self, itemName)
                    return mq.TLO.FindItem(itemName).TimerReady() == 0
                end,
            },
        },
    },
    ['RotationOrder']     = {
        -- Downtime doesn't have state because we run the whole rotation at once.
        {
            name = 'Downtime',
            targetId = function(self) return { mq.TLO.Me.ID(), } end,
            cond = function(self, combat_state)
                return combat_state == "Downtime" and
                    (not RGMercUtils.IsModeActive('Heal') or RGMercUtils.GetMainAssistPctHPs() >= RGMercUtils.GetSetting('MainHealPoint')) and
                    RGMercUtils.DoBuffCheck() and RGMercConfig:GetTimeSinceLastMove() > RGMercUtils.GetSetting('BuffWaitMoveTimer')
            end,
        },
        {
            name = 'Slow Downtime',
            timer = 30,
            targetId = function(self) return { mq.TLO.Me.ID(), } end,
            cond = function(self, combat_state)
                return combat_state == "Downtime" and
                    (not RGMercUtils.IsModeActive('Heal') or RGMercUtils.GetMainAssistPctHPs() >= RGMercUtils.GetSetting('MainHealPoint')) and
                    RGMercUtils.DoBuffCheck() and RGMercConfig:GetTimeSinceLastMove() > RGMercUtils.GetSetting('BuffWaitMoveTimer')
            end,
        },
        { --Summon pet even when buffs are off on emu
            name = 'PetSummon',
            targetId = function(self) return { mq.TLO.Me.ID(), } end,
            cond = function(self, combat_state)
                return combat_state == "Downtime" and mq.TLO.Me.Pet.ID() == 0 and RGMercUtils.DoPetCheck()
            end,
        },
        { --Pet Buffs if we have one, timer because we don't need to constantly check this
            name = 'PetBuff',
            timer = 60,
            targetId = function(self) return mq.TLO.Me.Pet.ID() > 0 and { mq.TLO.Me.Pet.ID(), } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Downtime" and mq.TLO.Me.Pet.ID() > 0 and RGMercUtils.DoPetCheck()
            end,
        },
        {
            name = 'GroupBuff',
            timer = 60, -- only run every 60 seconds top.
            targetId = function(self)
                local groupIds = { mq.TLO.Me.ID(), }
                local count = mq.TLO.Group.Members()
                for i = 1, count do
                    local rezSearch = string.format("pccorpse %s radius 100 zradius 50", mq.TLO.Group.Member(i).DisplayName())
                    if RGMercUtils.GetSetting('BuffRezables') or mq.TLO.SpawnCount(rezSearch)() == 0 then
                        table.insert(groupIds, mq.TLO.Group.Member(i).ID())
                    end
                end
                return groupIds
            end,
            cond = function(self, combat_state)
                return combat_state == "Downtime" and RGMercUtils.DoBuffCheck() and
                    (not RGMercUtils.IsModeActive('Heal') or RGMercUtils.GetMainAssistPctHPs() >= RGMercUtils.GetSetting('MainHealPoint')) and
                    RGMercUtils.DoBuffCheck()
            end,
        },
        {
            name = 'Malo',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and not RGMercUtils.Feigning() and RGMercUtils.DoCombatActions() and RGMercUtils.DebuffConCheck() and
                    (not RGMercUtils.IsModeActive('Heal') or RGMercUtils.GetMainAssistPctHPs() >= RGMercUtils.GetSetting('MainHealPoint'))
            end,
        },
        {
            name = 'Slow',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and not RGMercUtils.Feigning() and RGMercUtils.DoCombatActions() and RGMercUtils.DebuffConCheck() and
                    (not RGMercUtils.IsModeActive('Heal') or RGMercUtils.GetMainAssistPctHPs() >= RGMercUtils.GetSetting('MainHealPoint'))
            end,
        },
        {
            name = 'HealBurn',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and RGMercUtils.BurnCheck() and RGMercUtils.IsModeActive("Heal") and not RGMercUtils.Feigning()
                    and RGMercUtils.GetMainAssistPctHPs() >= RGMercUtils.GetSetting('MainHealPoint')
            end,
        },
        {
            name = 'Twin Heal',
            state = 1,
            steps = 1,
            targetId = function(self) return { RGMercUtils.GetMainAssistId(), } end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and RGMercUtils.GetSetting('DoTwinHeal') and not RGMercUtils.SongActiveByName("Healing Twincast") and
                    RGMercUtils.IsHealing() and not RGMercUtils.Feigning() and RGMercUtils.GetMainAssistPctHPs() >= RGMercUtils.GetSetting('MainHealPoint')
            end,
        },
        {
            name = 'HealDPS',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and RGMercUtils.IsModeActive("Heal") and not RGMercUtils.Feigning()
                    and RGMercUtils.GetMainAssistPctHPs() >= RGMercUtils.GetSetting('MainHealPoint')
            end,
        },
    },
    ['Rotations']         = {
        ['Twin Heal'] = {
            {
                name = "TwinHealNuke",
                type = "Spell",
                retries = 0,
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell)
                end,
            },
        },
        ['Malo'] = {
            {
                name = "Wind of Malaise",
                type = "AA",
                cond = function(self, aaName, target)
                    if not RGMercUtils.GetSetting('DoAEMalo') or RGMercUtils.GetXTHaterCount() < RGMercUtils.GetSetting('AEMaloCount') then return false end
                    return RGMercUtils.NPCAAReady(aaName, target.ID()) and RGMercUtils.DetAACheck(mq.TLO.Me.AltAbility(aaName).ID())
                end,
            },
            {
                name = "AEMaloSpell",
                type = "Spell",
                cond = function(self, spell, target)
                    if not RGMercUtils.GetSetting('DoAEMalo') or RGMercUtils.CanUseAA("Wind of Malaise") or RGMercUtils.GetXTHaterCount() < RGMercUtils.GetSetting('AEMaloCount') then return false end
                    return RGMercUtils.NPCSpellReady(spell, target.ID()) and RGMercUtils.DetSpellCheck(spell)
                end,
            },
            {
                name = "Malaise",
                type = "AA",
                cond = function(self, aaName, target)
                    if not RGMercUtils.GetSetting('DoMalo') or RGMercUtils.CanUseAA("Malaise") then return false end
                    return RGMercUtils.NPCAAReady(aaName, target.ID()) and RGMercUtils.DetAACheck(mq.TLO.Me.AltAbility(aaName).ID())
                end,
            },
            {
                name = "MaloSpell",
                type = "Spell",
                cond = function(self, spell, target)
                    if not RGMercUtils.GetSetting('DoMalo') then return false end
                    return RGMercUtils.NPCSpellReady(spell, target.ID()) and RGMercUtils.DetSpellCheck(spell)
                end,
            },
        },
        ['Slow'] = {
            {
                name = "Turgur's Virulent Swarm",
                type = "AA",
                cond = function(self, aaName, target)
                    if not RGMercUtils.GetSetting('DoAESlow') or RGMercUtils.GetXTHaterCount() < RGMercUtils.GetSetting('AESlowCount') then return false end
                    return RGMercUtils.NPCAAReady(aaName, target.ID()) and RGMercUtils.DetAACheck(mq.TLO.Me.AltAbility(aaName).ID())
                end,
            },
            {
                name = "AESlowSpell",
                type = "Spell",
                cond = function(self, spell, target)
                    if not RGMercUtils.GetSetting('DoAESlow') or RGMercUtils.CanUseAA("Turgur's Virulent Swarm") or RGMercUtils.GetXTHaterCount() < RGMercUtils.GetSetting('AESlowCount') then return false end
                    return RGMercUtils.NPCSpellReady(spell, target.ID()) and RGMercUtils.DetSpellCheck(spell)
                end,
            },
            {
                name = "Turgur's Swarm",
                type = "AA",
                cond = function(self, aaName, target)
                    if not RGMercUtils.GetSetting('DoSTSlow') then return false end
                    return RGMercUtils.NPCAAReady(aaName, target.ID()) and RGMercUtils.DetAACheck(mq.TLO.Me.AltAbility(aaName).ID())
                end,
            },
            {
                name = "SlowSpell",
                type = "Spell",
                cond = function(self, spell, target)
                    if not RGMercUtils.GetSetting('DoSTSlow') or RGMercUtils.CanUseAA("Turgur's Swarm") then return false end
                    return RGMercUtils.NPCSpellReady(spell, target.ID()) and RGMercUtils.DetSpellCheck(spell)
                end,
            },
            {
                name = "DieaseSlow",
                type = "Spell",
                cond = function(self, spell, target)
                    if not RGMercUtils.GetSetting('DoDiseaseSlow') or RGMercUtils.CanUseAA("Turgur's Swarm") then return false end
                    return RGMercUtils.NPCSpellReady(spell, target.ID()) and RGMercUtils.DetSpellCheck(spell)
                end,
            },
            { --I need to make this an optional setting (can break mez) and move it to combat (no business in debuffs anyway)
                name = "Languid Bite",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.GetSetting('DoSlow') and not RGMercUtils.BuffActiveByID(mq.TLO.Spell("Languid Bite").RankName.ID())
                end,
            },
        },
        ['HealBurn'] = {
            --TODO, Scrub AA to see if anything needs to be added, add vet AA
            {
                name = "Ancestral Aid",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
            {
                name = "Spire of Ancestors",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
            {
                name = "Spirit Call",
                type = "AA",
                cond = function(self, aaName, target)
                    return RGMercUtils.Small and RGMercUtils.NPCAAReady(aaName, target.ID())
                end,
            },
            {
                name = "Rabid Bear",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and RGMercUtils.GetSetting('DoMelee') and mq.TLO.Me.Combat()
                end,
            },
            {
                name = "Focus of Arcanum",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
        },
        ['HealDPS'] = {
            {
                name = "DichoSpell",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell)
                end,
            },
            {
                name = "MeleeProcBuff",
                type = "Spell",
                cond = function(self, spell)
                    if RGMercUtils.GetResolvedActionMapItem('DichoSpell') then return false end
                    return RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell)
                end,
            },
            {
                name = "Epic",
                type = "Item",
                cond = function(self, itemName)
                    return mq.TLO.FindItem(itemName).TimerReady() == 0
                end,
            },
            {
                name = "ChaoticDoT",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercUtils.DotSpellCheck(spell) and (RGMercUtils.DotManaCheck() or RGMercUtils.BurnCheck()) and RGMercUtils.NPCSpellReady(spell)
                end,
            },
            {
                name = "CurseDoT2",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercUtils.DotSpellCheck(spell) and (RGMercUtils.DotManaCheck() or RGMercUtils.BurnCheck()) and RGMercUtils.NPCSpellReady(spell)
                end,
            },
            {
                name = "PandemicDot",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercUtils.DotSpellCheck(spell) and (RGMercUtils.DotManaCheck() or RGMercUtils.BurnCheck()) and RGMercUtils.NPCSpellReady(spell)
                end,
            },
            {
                name = "CurseDoT1",
                type = "Spell",
                cond = function(self, spell, target)
                    if RGMercUtils.GetResolvedActionMapItem('CurseDoT2') then return false end
                    return RGMercUtils.DotSpellCheck(spell) and (RGMercUtils.DotManaCheck() or RGMercUtils.BurnCheck()) and RGMercUtils.NPCSpellReady(spell)
                end,
            },
            {
                name = "SaryrnDoT",
                type = "Spell",
                cond = function(self, spell, target)
                    if RGMercUtils.GetResolvedActionMapItem('ChaoticDoT') then return false end
                    return RGMercUtils.DotSpellCheck(spell) and (RGMercUtils.DotManaCheck() or RGMercUtils.BurnCheck()) and RGMercUtils.NPCSpellReady(spell)
                end,
            },
            {
                name = "Cannibalization",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.GetSetting('DoAACanni') and RGMercUtils.AAReady(aaName) and
                        mq.TLO.Me.PctMana() < RGMercUtils.GetSetting('AACanniCombatPct') and
                        mq.TLO.Me.PctHPs() >= RGMercUtils.GetSetting('AACanniMinHP')
                end,
            },
            {
                name = "GroupRenewalHoT",
                type = "Spell",
                cond = function(self, spell)
                    if not RGMercUtils.CanUseAA("Luminary's Synergy") then return false end
                    return not RGMercUtils.DotSpellCheck(spell) and RGMercUtils.SpellStacksOnMe(spell)
                        and (mq.TLO.Me.Song(spell).Duration.TotalSeconds() or 0) < 30
                end,
            },
            {
                name = "FastPoisonNuke",
                type = "Spell",
                cond = function(self, spell, target)
                    return (RGMercUtils.ManaCheck() or RGMercUtils.BurnCheck()) and RGMercUtils.NPCSpellReady(spell)
                end,
            },
            {
                name = "PoisonNuke",
                type = "Spell",
                cond = function(self, spell, target)
                    if RGMercUtils.GetResolvedActionMapItem('FastPoisonNuke') then return false end
                    return (RGMercUtils.ManaCheck() or RGMercUtils.BurnCheck()) and RGMercUtils.NPCSpellReady(spell)
                end,
            },
            {
                name = "IceNuke",
                type = "Spell",
                cond = function(self, spell, target)
                    if RGMercUtils.GetResolvedActionMapItem('PoisonNuke') then return false end
                    return (RGMercUtils.ManaCheck() or RGMercUtils.BurnCheck()) and RGMercUtils.NPCSpellReady(spell)
                end,
            },
        },
        ['Downtime'] = {
            {
                name = "Cannibalization",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.GetSetting('DoAACanni') and RGMercUtils.AAReady(aaName) and
                        mq.TLO.Me.PctMana() < RGMercUtils.GetSetting('AACanniManaPct') and
                        mq.TLO.Me.PctHPs() >= RGMercUtils.GetSetting('AACanniMinHP')
                end,
            },
            {
                name = "CanniSpell",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.GetSetting('DoSpellCanni') and RGMercUtils.CastReady(spell.RankName()) and
                        mq.TLO.Me.PctMana() < RGMercUtils.GetSetting('SpellCanniManaPct') and
                        mq.TLO.Me.PctHPs() >= RGMercUtils.GetSetting('SpellCanniMinHP')
                end,
            },
            {
                name = "GroupHealProcBuff",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell)
                    return RGMercUtils.SelfBuffCheck(spell)
                end,
            },
            {
                name = "GroupRenewalHoT",
                type = "Spell",
                cond = function(self, spell)
                    if not RGMercUtils.CanUseAA("Luminary's Synergy") then return false end
                    return RGMercUtils.SpellStacksOnMe(spell) and (mq.TLO.Me.Song(spell).Duration.TotalSeconds() or 0) < 30
                end,
            },
            {
                name = "Preincarnation",
                type = "AA",
                active_cond = function(self, aaName)
                    return RGMercUtils.BuffActiveByID(mq.TLO.Me.AltAbility(aaName)
                        .Spell.Trigger(1).ID())
                end,
                cond = function(self, aaName)
                    return RGMercUtils.SelfBuffAACheck(aaName)
                end,
            },
        },
        ['PetSummon'] = {
            {
                name = "PetSpell",
                type = "Spell",
                active_cond = function(self, _) return mq.TLO.Me.Pet.ID() ~= 0 end,
                cond = function(self, _) return RGMercUtils.GetSetting('DoPet') and mq.TLO.Me.Pet.ID() == 0 end,
                post_activate = function(self, spell)
                    local pet = mq.TLO.Me.Pet
                    if pet.ID() > 0 then
                        RGMercUtils.PrintGroupMessage("Summoned a new %d %s pet named %s using '%s'!", pet.Level(),
                            pet.Class.Name(), pet.CleanName(), spell.RankName())
                    end
                end,
            },
        },
        ['PetBuff'] = {
            {
                name = "PetBuffSpell",
                type = "Spell",
                active_cond = function(self, spell) return mq.TLO.Me.PetBuff(spell.RankName())() ~= nil end,
                cond = function(self, spell) return RGMercUtils.SelfBuffPetCheck(spell) end,
            },
        },
        ['Slow Downtime'] = {
            {
                name = "Group Shrink",
                type = "AA",
                active_cond = function(self, _) return mq.TLO.Me.Height() < 2 end,
                cond = function(self, _) return RGMercUtils.GetSetting('DoGroupShrink') and mq.TLO.Me.Height() > 2.2 end,
            },
            {
                name = "Pact of the Wolf",
                type = "AA",
                active_cond = function(self, aaName) return mq.TLO.Me.Aura(aaName)() ~= nil end,
                cond = function(self, aaName)
                    return RGMercUtils.GetSetting('DoAura') and not RGMercUtils.SongActiveByName(aaName) and
                        mq.TLO.Me.Aura(aaName)() == nil
                end,
            },
            {
                name = "Visionary's Unity",
                type = "AA",
                active_cond = function(self, aaName)
                    return RGMercUtils.BuffActiveByID(mq.TLO.Me.AltAbility(aaName)
                        .Spell.Trigger(1).ID())
                end,
                cond = function(self, aaName) --Check ranks because we don't want the first pack buff (drains mana)
                    if (mq.TLO.Me.AltAbility(aaName).Rank() or 999) < 2 then return false end
                    return RGMercUtils.SelfBuffAACheck(aaName)
                end,
            },
            {
                name = "PackSelfBuff",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell)
                    if (mq.TLO.Me.AltAbility("Visionary's Unity").Rank() or 999) > 1 then return false end
                    return RGMercUtils.SelfBuffCheck(spell)
                end,
            },
            {
                name = "SelfWard",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell)
                    if not RGMercUtils.GetSetting('DoSelfWard') then return false end
                    return RGMercUtils.SelfBuffCheck(spell)
                end,
            },
        },
        ['GroupBuff'] = {
            {
                name = "Spirit Guardian",
                type = "AA",
                cond = function(self, aaName, target)
                    if target.ID() ~= mq.TLO.Group.MainTank.ID() then return false end
                    return RGMercUtils.AAReady(aaName)
                end,
            },
            -- {
            -- name = "GrowthBuff",
            -- type = "Spell",
            -- cond = function(self, spell, target)
            -- return RGMercUtils.GetSetting('DoGrowth') and RGMercUtils.TargetClassIs("WAR", target) and RGMercUtils.GroupBuffCheck(spell, target)
            -- end,
            -- },
            {
                name = "SlowProcBuff",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercConfig.Constants.RGTank:contains(target.Class.ShortName()) and RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            { --Used on the entire group
                name = "GroupFocusSpell",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            { --If our single target is better than the group spell above, we will use it on the Tank
                name = "SingleFocusSpell",
                type = "Spell",
                cond = function(self, spell, target)
                    return RGMercConfig.Constants.RGTank:contains(target.Class.ShortName()) and RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            { --Only cast below 86 because past that our focus spells take over
                name = "LowLvlAtkBuff",
                type = "Spell",
                cond = function(self, spell, target)
                    return mq.TLO.Me.Level() < 86 and RGMercConfig.Constants.RGMelee:contains(target.Class.ShortName()) and
                        RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            {
                name = "Talisman of Celerity",
                type = "AA",
                active_cond = function(self, aaName) return mq.TLO.Me.Haste() end,
                cond = function(self, aaName, target)
                    if not RGMercUtils.GetSetting('DoHaste') then return false end
                    return mq.TLO.Me.Level() < 111 and RGMercUtils.GroupBuffCheck(mq.TLO.AltAbility(aaName).Spell, target)
                end,
            },
            {
                name = "HasteBuff",
                type = "Spell",
                active_cond = function(self, aaName) return mq.TLO.Me.Haste() end,
                cond = function(self, spell, target)
                    if not RGMercUtils.GetSetting('DoHaste') or RGMercUtils.CanUseAA("Talisman of Celerity") then return false end
                    return RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            {
                name = "GroupRegenBuff",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell, target)
                    if RGMercUtils.GetResolvedActionMapItem('DichoSpell') then return false end --Dicho regen overwrites this
                    return RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            {
                name = "Lupine Spirit",
                type = "AA",
                active_cond = function(self, aaName)
                    return RGMercUtils.BuffActiveByID(mq.TLO.Me.AltAbility(aaName)
                        .Spell.Trigger(1).ID())
                end,
                cond = function(self, aaName, target, uiCheck) --check ranks because this won't use Tala'Tak between 74 and 90
                    if not RGMercUtils.GetSetting('DoRunSpeed') or (mq.TLO.Me.AltAbility(aaName).Rank() or 999) < 4 then return false end
                    --TODO: Refactor
                    local speedSpell = mq.TLO.Me.AltAbility(aaName).Spell.Trigger(1)
                    if not speedSpell or not speedSpell() then return false end

                    return RGMercUtils.GroupBuffCheck(speedSpell, target)
                end,
            },
            {
                name = "RunSpeedBuff",
                type = "Spell",
                cond = function(self, spell, target) --We get Tala'tak at 74, but don't get the AA version until 90
                    if not RGMercUtils.GetSetting('DoRunSpeed') or (mq.TLO.Me.AltAbility("Lupine Spirit").Rank() or -1) > 3 then return false end
                    return RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
        },
    },
    ['Spells']            = {
        {
            gem = 1,
            spells = {
                { name = "RecklessHeal1", cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
            },
        },
        {
            gem = 2,
            spells = {
                { name = "RecklessHeal2", cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
                {
                    name = "MaloSpell",
                    cond = function(self)
                        return RGMercUtils.IsModeActive("Heal") and not RGMercUtils.CanUseAA("Malaise")
                    end,
                },
            },
        },
        {
            gem = 3,
            spells = {
                { name = "RecourseHeal",  cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
                { name = "LowLvlAtkBuff", cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },

            },
        },
        {
            gem = 4,
            spells = {
                { name = "InterventionHeal", cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
                {
                    name = "SlowSpell",
                    cond = function(self)
                        return RGMercUtils.IsModeActive("Heal") and not RGMercUtils.CanUseAA("Turgur's Swarm")
                    end,
                },
            },
        },
        {
            gem = 5,
            spells = {
                { name = "AESpiritualHeal", cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
                {
                    name = "AEMaloSpell",
                    cond = function(self)
                        return RGMercUtils.IsModeActive("Heal") and not RGMercUtils.CanUseAA("Wind of Malaise")
                    end,
                },
                {
                    name = "AESlowSpell",
                    cond = function(self)
                        return RGMercUtils.IsModeActive("Heal") and not RGMercUtils.CanUseAA("Turgur's Virulent Swarm")
                    end,
                },
            },
        },
        {
            gem = 6,
            spells = {
                { name = "GroupRenewalHoT", cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
            },
        },
        {
            gem = 7,
            spells = {
                { name = "DichoSpell",    cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
                { name = "MeleeProcBuff", cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
            },
        },
        {
            gem = 8,
            spells = {
                { name = "FastPoisonNuke", cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },

            },
        },
        { --55
            gem = 9,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "CurseDoT2", cond = function(self) return RGMercUtils.GetSetting('DoMagicDot') end, },
                { name = "CureSpell", },
            },
        },
        { --75
            gem = 10,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "ChaoticDoT",   cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
                { name = "TwinHealNuke", cond = function(self) return RGMercUtils.IsModeActive("Heal") and RGMercUtils.GetSetting('DoTwinHeal') end, },
                { name = "CureSpell", },
            },
        },
        { --80
            gem = 11,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "PandemicDot",    cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
                { name = "FastPoisonNuke", },
                { name = "TwinHealNuke",   cond = function(self) return RGMercUtils.IsModeActive("Heal") and RGMercUtils.GetSetting('DoTwinHeal') end, },
                { name = "CureSpell", },
            },
        },
        { --80
            gem = 12,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "TwinHealNuke", cond = function(self) return RGMercUtils.IsModeActive("Heal") and RGMercUtils.GetSetting('DoTwinHeal') end, },
                { name = "CureSpell", },
            },
        },
        { --105
            gem = 13,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "CureSpell",         cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
                { name = "GroupHealProcBuff", cond = function(self) return RGMercUtils.IsModeActive("Heal") end, },
            },
        },
    },
    ['PullAbilities']     = {
        {
            id = 'SlowSpell',
            Type = "Spell",
            DisplayName = function() return RGMercUtils.GetResolvedActionMapItem('SlowSpell')() or "" end,
            AbilityName = function() return RGMercUtils.GetResolvedActionMapItem('SlowSpell')() or "" end,
            AbilityRange = 150,
            cond = function(self)
                local resolvedSpell = RGMercUtils.GetResolvedActionMapItem('SlowSpell')
                if not resolvedSpell then return false end
                return mq.TLO.Me.Gem(resolvedSpell.RankName.Name() or "")() ~= nil
            end,
        },
        {
            id = 'SlowAA',
            Type = "AA",
            DisplayName = "Turgur's Swarm",
            AbilityName = "Turgur's Swarm",
            AbilityRange = 150,
            cond = function(self)
                return mq.TLO.Me.AltAbility("Turgur's Swarm")
            end,
        },
        {
            id = 'DDSpell',
            Type = "Spell",
            DisplayName = "Burst of Flame",
            AbilityName = "Burst of Flame",
            AbilityRange = 150,
            cond = function(self)
                local resolvedSpell = mq.TLO.Spell("Burst of Flame")
                if not resolvedSpell then return false end
                return mq.TLO.Me.Gem(resolvedSpell.RankName.Name() or "")() ~= nil
            end,
        },
    },
    ['DefaultConfig']     = {
        ['Mode']              = { DisplayName = "Mode", Category = "Combat", Tooltip = "Select the Combat Mode for this Toon", Type = "Custom", RequiresLoadoutChange = true, Default = 2, Min = 1, Max = 2, },
        ['DoTwinHeal']        = { DisplayName = "Cast Twin Heal Nuke", Category = "Spells and Abilities", Tooltip = "Use Twin Heal Nuke Spells", RequiresLoadoutChange = true, Default = true, },
        ['DoNuke']            = { DisplayName = "Cast Nukes", Category = "Spells and Abilities", Tooltip = "Use Nuke Spells", Default = true, },
        ['DoHOT']             = { DisplayName = "Cast HOTs", Category = "Spells and Abilities", Tooltip = "Use Heal Over Time Spells", Default = true, },
        -- Removing this as it is too confusing to explain when it would  be used.
        -- ['RecklessHealPct']   = { DisplayName = "Reckless Heal %", Category = "Spells and Abilities", Tooltip = "Use Reckless Heal When Assist hits [X]% HPs", Default = 80, Min = 1, Max = 100, },
        ['DoDiseaseSlow']     = { DisplayName = "Cast Disease Slows", Category = "Spells and Abilities", Tooltip = "Use Disease Slow Spells", Default = false, },
        ['DoMagicDot']        = { DisplayName = "Cast Magic DOT", Category = "Spells and Abilities", Tooltip = "Use Magic DOTs", Default = true, },
        ['DoAACanni']         = { DisplayName = "Use AA Canni", Category = "Spells and Abilities", Tooltip = "Use Canni AA during downtime", Default = true, },
        ['AACanniCombatPct']  = { DisplayName = "AA Canni Combat %", Category = "Spells and Abilities", Tooltip = "Use Canni AA Under [X]% mana", Default = 40, Min = 1, Max = 100, },
        ['AACanniManaPct']    = { DisplayName = "AA Canni Downtime %", Category = "Spells and Abilities", Tooltip = "Use Canni AA Under [X]% mana", Default = 70, Min = 1, Max = 100, },
        ['AACanniMinHP']      = { DisplayName = "AA Canni HP %", Category = "Spells and Abilities", Tooltip = "Dont Use Canni AA Under [X]% HP", Default = 70, Min = 1, Max = 100, },
        ['DoSpellCanni']      = { DisplayName = "Use Spell Canni", Category = "Spells and Abilities", Tooltip = "Use Canni Spell during downtime", Default = true, },
        ['SpellCanniManaPct'] = { DisplayName = "Spell Canni Mana %", Category = "Spells and Abilities", Tooltip = "Use Canni Spell Under [X]% mana", Default = 70, Min = 1, Max = 100, },
        ['SpellCanniMinHP']   = { DisplayName = "Spell Canni HP %", Category = "Spells and Abilities", Tooltip = "Dont Use Canni Spell Under [X]% HP", Default = 70, Min = 1, Max = 100, },
        ['DoGroupShrink']     = { DisplayName = "Group Shrink", Category = "Buffs", Tooltip = "Use Group Shrink Buff", Default = true, },
        ['DoGrowth']          = { DisplayName = "Use Growth", Category = "Buffs", Tooltip = "Use Growth Buff", Default = true, },
        ['DoAura']            = { DisplayName = "Use Aura", Category = "Buffs", Tooltip = "Use Aura (Pact of Wolf)", Default = true, },
        ['DoHaste']           = { DisplayName = "Use Haste", Category = "Buffs", Tooltip = "Do Haste Spells/AAs", Default = true, },
        ['DoSelfWard']        = { DisplayName = "Use Ward", Category = "Buffs", Tooltip = "Use your Self heal proc ward.", Default = false, },
        ['DoRunSpeed']        = { DisplayName = "Do Run Speed", Category = "Buffs", Tooltip = "Do Run Speed Spells/AAs", Default = true, },
        ['DoMalo']            = { DisplayName = "Cast Malo", Category = "Debuffs", Tooltip = "Do Malo Spells/AAs", Default = true, },
        ['DoAEMalo']          = { DisplayName = "Cast AE Malo", Category = "Debuffs", Tooltip = "Do AE Malo Spells/AAs", Default = false, },
        ['DoSlow']            = { DisplayName = "Cast Slow", Category = "Debuffs", Tooltip = "Do Slow Spells/AAs", Default = true, },
        ['DoAESlow']          = { DisplayName = "Cast AE Slow", Category = "Debuffs", Tooltip = "Do AE Slow Spells/AAs", Default = false, },
        ['AESlowCount']       = { DisplayName = "AE Slow Count", Category = "Debuffs", Tooltip = "Number of XT Haters before we start AE slowing", Min = 1, Default = 3, Max = 10, },
        ['AEMaloCount']       = { DisplayName = "AE Malo Count", Category = "Debuffs", Tooltip = "Number of XT Haters before we start AE Maloing", Min = 1, Default = 3, Max = 10, },
        ['DoStatBuff']        = { DisplayName = "Do Stat Buff", Category = "Buffs", Tooltip = "Do Stat Buffs for Group", Default = true, },
        --Buffs
        --Debuffs
        --Healing
        --DPS - Personal
        --Items/Utility
    },
}

return _ClassConfig