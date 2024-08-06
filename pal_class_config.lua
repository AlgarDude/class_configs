-- [ README: Customization ] --
-- If you want to make customizations to this file, please put it
-- into your: MacroQuest/configs/rgmercs/class_econfigs/ directory
-- so it is not patched over.

-- [ NOTE ON ORDERING ] --
-- Order matters! Lua will implicitly iterate everything in an array
-- in order by default so always put the first thing you want checked
-- towards the top of the list.

local mq           = require('mq')
local RGMercUtils  = require("utils.rgmercs_utils")

local Tooltips     = {
    Mantle              = "Spell Line: Melee Absorb Proc",
    Carapace            = "Spell Line: Melee Absorb Proc",
	CombatEndRegen      = "Discipline Line: Endurance Regen (In-Combat Useable)",
    EndRegen            = "Discipline Line: Endurance Regen (Out of Combat)",
    Blade               = "Ability Line: Double 2HS Attack w/ Accuracy Mod",
    Crimson             = "Disicpline Line: Triple Attack w/ Accuracy Mod",
    MeleeMit            = "Discipline Line: Absorb Incoming Dmg",
    Deflection          = "Discipline: Shield Block Chance 100%",
    LeechCurse          = "Discipline: Melee LifeTap w/ Increase Hit Chance",
    UnholyAura          = "Discipline: Increase LifeTap Spell Damage",
    CurseGuard          = "Discipline: Melee Mtigation w/ Defensive LifeTap & Lowered Melee DMG Output",
    PetSpell            = "Spell Line: Summons SK Pet",
    PetHaste            = "Spell Line: Haste Buff for SK Pet",
    Shroud              = "Spell Line: Add Melee LifeTap Proc",
    Horror              = "Spell Line: Proc Mana Return",
    Skin                = "Spell Line: Melee Absorb Proc",
    SelfDS              = "Spell Line: Self Damage Shield",
    Demeanor            = "Spell Line: Add LifeTap Proc Buff on Killshot",
    HealBurn            = "Spell Line: Add Hate Proc on Incoming Spell Damage",
    CloakHP             = "Spell Line: Increase HP and Stacking DS",
    Covenant            = "Spell Line: Increase Mana Regen + Ultravision / Decrease HP Per Tick",
    CallAtk             = "Spell Line: Increase Attack / Decrease HP Per Tick",
    AeTaunt             = "Spell Line: PBAE Hate Increase + Taunt",
    PoisonDot           = "Spell Line: Poison Dot",
    Spearnuke           = "Spell Line: Instacast Disease Nuke",
    BondTap             = "Spell Line: LifeTap DOT",
    DireTap             = "Spell Line: LifeTap",
    LifeTap             = "Spell Line: LifeTap",
    BuffTap             = "Spell Line: LifeTap + Hate Increase + HP Regen",
    BiteTap             = "Spell Line: LifeTap + ManaTap",
    ForPower            = "Spell Line: Hate Increase + Hate Increase DOT + AC Buff 'BY THE POWER OF GRAYSKULL, I HAVE THE POWER -- HE-MAN'",
    Terror              = "Spell Line: Hate Increase + Taunt",
    TempHP              = "Spell Line: Temporary Hitpoints (Decrease per Tick)",
    Dicho               = "Spell Line: Hate Increase + LifeTap",
    Torrent             = "Spell Line: Attack Tap",
    SnareDOT            = "Spell Line: Snare + HP DOT",
    Acrimony            = "Spell Increase: Aggrolock + LifeTap DOT + Hate Generation",
    SpiteStrike         = "Spell Line: LifeTap + Caster 1H Blunt Increase + Target Armor Decrease",
    ReflexStrike        = "Ability: Triple 2HS Attack + HP Increase",
    DireDot             = "Spell Line: DOT + AC Decrease + Strength Decrease",
    AllianceNuke        = "Spell Line: Alliance (Requires Multiple of Same Class) - Increase Spell Damage Taken by Target + Large LifeTap",
    InfluenceDisc       = "Ability Line: Increase AC + Absorb Damage + Melee Proc (LifeTap + Max HP Increase)",
    DLUA                = "AA: Cast Highest Level of Scribed Buffs (Shroud, Horror, Drape, Demeanor, Skin, Covenant, CallATK)",
    HarmTouch           = "AA: Harms Target HP",
    ThoughtLeech        = "AA: Harms Target HP + Harms Target Mana",
    VisageOfDeath       = "Spell: Increases Melee Hit Dmg + Illusion",
    LeechTouch          = "AA: LifeTap Touch",
    Tvyls               = "Spell: Triple 2HS Attack + % Melee Damage Increase on Target",
    ActivateShield      = "Activate 'Shield' if set in Bandolier",
    Activate2HS         = "Activate '2HS' if set in Bandolier",
    ExplosionOfHatred   = "Spell: Targeted AE Hatred Increase",
    ExplosionOfSpite    = "Spell: Targeted PBAE Hatred Increase",
    Taunt               = "Ability: Increases Hatred to 100% + 1",
    EncroachingDarkness = "Ability: Snare + HP DOT",
    Epic                = 'Item: Casts Epic Weapon Ability',
    ViciousBiteOfChaos  = "Spell: Duration LifeTap + Mana Return",
    Bash                = "Use Bash Ability",
    Slam                = "Use Slam Ability",
}

local _ClassConfig = {
    _version            = "1.1",
    _author             = "Algar (based on AlgarSK based on 1.0 Derple)",
	['FullConfig'] = true,
    ['ModeChecks']        = {
        IsTanking = function() return RGMercUtils.IsModeActive("Tank") end,
        IsHealing = function() return true end,
        IsCuring = function() return RGMercUtils.GetSetting('DoCures') end,
        IsRezing = function() return (RGMercUtils.GetSetting('DoBattleRez') and not RGMercUtils.IsTanking()) or RGMercUtils.GetXTHaterCount() == 0 end,
            --Disabling tank battle rez is not optional to prevent settings in different areas and to avoid causing more potential deaths
    },
    ['Modes']           = {
        'Tank',
        'DPS',
    },
	['Cures']             = {
        CureNow = function(self, type, targetId)
            if RGMercUtils.AAReady("Radiant Cure") then
                return RGMercUtils.UseAA("Radiant Cure", targetId)
            end
            --local cureSpell = RGMercUtils.GetResolvedActionMapItem('Puritycure')

            -- if type:lower() == "poison" then
                -- cureSpell = RGMercUtils.GetResolvedActionMapItem('Puritycure')
            -- elseif type:lower() == "curse" then
                -- cureSpell = RGMercUtils.GetResolvedActionMapItem('Puritycure')
			--TODO: Add corruption AbilitySet
            -- elseif type:lower() == "corruption" then
                -- cureSpell = RGMercUtils.GetResolvedActionMapItem('Puritycure')
            -- end

            -- if not cureSpell or not cureSpell() then return false end
            -- return RGMercUtils.UseSpell(cureSpell.RankName.Name(), targetId, true)
        end,
    },
    ['ItemSets']          = {
        ['Epic'] = {
            "Nightbane, Sword of the Valiant",
            "Redemption",
        },
    },
    ['AbilitySets']       = {
        ["CrushTimer6"] = {
            -- Timer 6 - Crush (with damage)
            "Crush of Compunction",  -- Level 85
            "Crush of Repentance",   -- Level 90
            "Crush of Tides",        -- Level 95
            "Crush of Tarew",        -- Level 100
            "Crush of Povar",        -- Level 105
            "Crush of E'Ci",         -- Level 110
            "Crush of Restless Ice", -- Level 115
            "Crush of the Umbra",    -- Level 120
        },
        ["CrushTimer5"] = {
            -- Timer 5 - Crush
            "Crush of the Crying Seas",   -- Level 82
            "Crush of Marr",              -- Level 87
            "Crush of Oseka",             -- Level 92
            "Crush of the Iceclad",       -- Level 97
            "Crush of the Darkened Sea",  -- Level 102
            "Crush of the Timorous Deep", -- Level 107
            "Crush of the Grotto",        -- Level 112
            "Crush of the Twilight Sea",  -- Level 117
        },
        ["HealNuke"] = {
            -- Timer 7 - HealNuke
            "Glorious Vindication",  -- Level 85
            "Glorious Exoneration",  -- Level 90
            "Glorious Exculpation",  -- Level 95
            "Glorious Expurgation",  -- Level 100
            "Brilliant Vindication", -- Level 105
            "Brilliant Exoneration", -- Level 110
            "Brilliant Exculpation", -- Level 115
            "Brilliant Acquittal",   -- Level 120
        },
        ["TempHP"] = {
            "Steely Stance",
            "Stubborn Stance",
            "Stoic Stance",
            "Staunch Stance",
            "Steadfast Stance",
            "Defiant Stance",
            "Stormwall Stance",
            "Adamant Stance",
        },
        ["Preservation"] = {
            -- Timer 12 - Preservation
            "Ward of Tunare",               -- Level 70
            "Sustenance of Tunare",         -- Level 80
            "Preservation of Tunare",       -- Level 85
            "Preservation of Marr",         -- Level 90
            "Preservation of Oseka",        -- Level 95
            "Preservation of the Iceclad",  -- Level 100
            "Preservation of Rodcet",       -- Level 110
            "Preservation of the Grotto",   -- Level 115
            "Preservation of the Basilica", -- Level 120
        },
        ["Lowaggronuke"] = {
            --- Nuke Heal Target - Censure
            "Denouncement",
            "Reprimand",
            "Ostracize",
            "Admonish",
            "Censure",
            "Remonstrate",
            "Upbraid",
        },
        ["Incoming"] = {
            -- Harmonius Blessing - Empires of Kunark spell
            "Harmonious Blessing",
            "Concordant Blessing",
            "Confluent Blessing",
            "Penumbral Blessing",
        },
        ["DebuffNuke"] = {
            -- Undead DebuffNuke
            "Last Rites",   -- Level 68 - Timer 7
            "Burial Rites", -- Level 71 - Timer 7
            "Benediction",  -- Level 76
            "Eulogy",       -- Level 81
            "Elegy",        -- Level 86
            "Paean",        -- Level 91
            "Laudation",    -- Level 96
            "Consecration", -- Level 101
            "Remembrance",  -- Level 106
            "Requiem",      -- Level 111
            "Hymnal",       -- Level 116
        },
        ["Healproc"] = {
            --- Proc Buff Heal target of Target => LVL 97
            "Regenerating Steel",
            "Rejuvenating Steel",
            "Reinvigorating Steel",
            "Revitalizating Steel",
            "Renewing Steel",
        },
        ["FuryProc"] = {
            -- - Fury Proc Strike  67 - 115
            "Wrathful Fury",
            "Silvered Fury",
            "Pious Fury",
            "Righteous Fury",
            "Devout Fury",
            "Earnest Fury",
            "Zealous Fury",
            "Reverent Fury",
            "Ardent Fury",
            "Merciful Fury",
            "Sincere Fury",
        },
        ["Aurora"] = {
            "Aurora of Dawning",
            "Aurora of Dawnlight",
            "Aurora of Daybreak",
            "Aurora of Splendor",
            "Aurora of Sunrise",
            "Aurora of Dayspring",
            "Aurora of Morninglight",
            "Aurora of Wakening",
        },
        ["StunTimer5"] = {
            -- Timer 5 - Hate Stun
            "Desist",                     -- Level 13 - Not Timer 5, use for TLP Low Level Stun
            "Stun",                       -- Level 28
            "Force of Akera",             -- Level 53
            "Ancient: Force of Chaos",    -- Level 65
            "Ancient: Force of Jeron",    -- Level 70
            "Force of Prexus",            -- Level 75
            "Force of Timorous",          -- Level 80
            "Force of the Crying Seas",   -- Level 85
            "Force of Marr",              -- Level 90
            "Force of Oseka",             -- Level 95
            "Force of the Iceclad",       -- Level 100
            "Force of the Darkened Sea",  -- Level 105
            "Force of the Timorous Deep", -- Level 110
            "Force of the Grotto",        -- Level 115
            "Force of the Umbra",         -- Level 120
        },
        ["StunTimer4"] = {
            -- Timer 4 - Hate Stun
            "Cease",           -- Level 7 - Not Timer 4, use for TLP Low Level Stun
            "Force of Akilae", -- Level 62
            "Force of Piety",  -- Level 66
            "Sacred Force",    -- Level 71
            "Devout Force",    -- Level 81
            "Solemn Force",    -- Level 83
            "Earnest Force",   -- Level 86
            "Zealous Force",   -- Level 91
            "Reverent Force",  -- Level 96
            "Ardent Force",    -- Level 101
            "Merciful Force",  -- Level 106
            "Sincere Force",   -- Level 111
            "Pious Force",     -- Level 116
        },
        ["HealStun"] = {
            --- Heal Stuns T3 12s recast
            "Force of Generosity",
            "Force of Reverence",
            "Force of Ardency",
            "Force of Mercy",
            "Force of Sincerity",
        },
        ["HealWard"] = {
            --- Healing ward Heals Target of target and wards self. Divination based heal/ward
            "Protective Revelation",
            "Protective Confession",
            "Protective Devotion",
            "Protective Dedication",
            "Protective Allegiance",
            "Protective Proclamation",
            "Protective Devotion",
            "Protective Consecration",
        },
        ["Aego"] = {
            --- Pally Aegolism
            "Austerity",                     -- Level 55
            "Blessing of Austerity",         -- Level 58 - Group
            "Guidance",                      -- Level 65
            "Affirmation",                   -- Level 70
            "Sworn Protector",               -- Level 75
            "Oathbound Protector",           -- Level 80
            "Sworn Keeper",                  -- Level 85
            "Oathbound Keeper",              -- Level 90
            "Avowed Keeper",                 -- Level 92
            "Hand of the Avowed Keeper",     -- Level 95 - Group
            "Pledged Keeper",                -- Level 97
            "Hand of the Pledged Keeper",    -- Level 100 - Group
            "Stormbound Keeper",             -- Level 102
            "Hand of the Stormbound Keeper", -- Level 105 - Group
            "Ashbound Keeper",               -- Level 107
            "Hand of the Ashbound Keeper",   -- Level 110 - Group
            "Stormwall Keeper",              -- Level 112
            "Hand of the Stormwall Keeper",  -- Level 115 - Group
            "Shadewell Keeper",              -- Level 117
            "Hand of the Dreaming Keeper",   -- Level 120 - Group
        },
        ["Brells"] = {
            "Brell's Tenacious Barrier",
            "Brell's Loamy Ward",
            "Brell's Tellurian Rampart",
            "Brell's Adamantine Armor",
            "Brell's Steadfast Bulwark",
            "Brell's Stalwart Bulwark",
            "Brell's Blessed Bastion",
            "Brell's Blessed Barrier",
            "Brell's Earthen Aegis",
            "Brell's Stony Guard",
            "Brell's Brawny Bulwark",
            "Brell's Stalwart Shield",
            "Brell's Mountainous Barrier",
            "Brell's Steadfast Aegis",
        },
        ["Splashcure"] = {
            ---, Spells
            "Splash of Repentance",
            "Splash of Sanctification",
            "Splash of Purification",
            "Splash of Cleansing",
            "Splash of Atonement",
            "Splash of Depuration",
            "Splash of Exaltation",
        },
        ["Healtaunt"] = {
            --- Valiant Taunt With Built in heal.
            "Valiant Disruption",
            "Valiant Deflection",
            "Valiant Defense",
            "Valiant Diversion",
            "Valiant Deterrence",
        },
        ["Affirmation"] = {
            --- Improved Super Taunt - Gets you Aggro for X seconds and reduces other Haters generation.
            "Unrelenting Affirmation",
            "Undivided Affirmation",
            "Unbroken Affirmation",
            "Unflinching Affirmation",
            "Unyielding Affirmation",
            "Unending Affirmation",
        },
        ["Doctrine"] = {
            --- Undead DD
            "Doctrine of Abrogation",
            "Doctrine of Rescission",
            "Doctrine of Exculpation",
            "Doctrine of Abolishment",
        },
        ["WaveHeal"] = {
            --- Group Wave heal 39-115
            "Wave of Bereavement",
            "Wave of Propitiation",
            "Wave of Expiation",
            "Wave of Grief",
            "Wave of Sorrow",
            "Wave of Contrition",
            "Wave of Penitence",
            "Wave of Remitment",
            "Wave of Absolution",
            "Wave of Forgiveness",
            "Wave of Piety",
            "Wave of Marr",
            "Wave of Trushar",
            "Healing Wave of Prexus",
            "Wave of Healing",
            "Wave of Life",
        },
        ["WaveHeal2"] = {
            --- Group Wave heal 39-115
            "Wave of Bereavement",
            "Wave of Propitiation",
            "Wave of Expiation",
            "Wave of Grief",
            "Wave of Sorrow",
            "Wave of Contrition",
            "Wave of Penitence",
            "Wave of Remitment",
            "Wave of Absolution",
            "Wave of Forgiveness",
            "Wave of Piety",
            "Wave of Marr",
            "Wave of Trushar",
            "Healing Wave of Prexus",
            "Wave of Healing",
            "Wave of Life",
        },
        ["SelfHeal"] = {
            "Penitence",
            "Contrition",
            "Sorrow",
            "Grief",
            "Expiation",
            "Propitiation",
            "Culpability",
        },
        ["Reverseds"] = {
            --- Reverse DS
            "Mark of the Saint",
            "Mark of the Crusader",
            "Mark of the Pious",
            "Mark of the Pure",
            "Mark of the Defender",
            "Mark of the Reverent",
            "Mark of the Exemplar",
            "Mark of the Commander",
            "Mark of the Jade Cohort",
            "Mark of the Eclipsed Cohort",
        },
        ["Cleansehot"] = {
            --- Pally Hot
            "Ethereal Cleansing",   -- Level 44
            "Celestial Cleansing",  -- Level 59
            "Supernal Cleansing",   -- Level 64
            "Pious Cleansing",      -- Level 69
            "Sacred Cleansing",     -- Level 73
            "Solemn Cleansing",     -- Level 78
            "Devout Cleansing",     -- Level 93
            "Earnest Cleansing",    -- Level 88
            "Zealous Cleansing",    -- Level 93
            "Reverent Cleansing",   -- Level 98
            "Ardent Cleansing",     -- Level 103
            "Merciful Cleansing",   -- Level 108
            "Sincere Cleansing",    -- Level 113
            "Forthright Cleansing", -- Level 118
        },
        ["BurstHeal"] = {
            --- Burst Heal - heals target or Target of target 73-115
            "Burst of Sunlight",
            "Burst of Morrow",
            "Burst of Dawnlight",
            "Burst of Daybreak",
            "Burst of Splendor",
            "Burst of Sunrise",
            "Burst of Dayspring",
            "Burst of Morninglight",
            "Burst of Wakening",
            "Burst of Dawnbreak",
        },
        ["ArmorSelfBuff"] = {
            --- Self Buff Armor Line Ac/Hp/Mana regen
            "Aura of the Crusader",       -- Level 64
            "Armor of the Champion",      -- Level 69
            "Armor of Unrelenting Faith", -- Level 73
            "Armor of Inexorable Faith",  -- Level 78
            "Armor of Unwavering Faith",  -- Level 83
            "Armor of Implacable Faith",  -- Level 88
            "Armor of Formidable Faith",  -- Level 93
            "Armor of Formidable Grace",  -- Level 98
            "Armor of Formidable Spirit", -- Level 103
            "Armor of Steadfast Faith",   -- Level 108
            "Armor of Steadfast Grace",   -- Level 113
            "Armor of Unyielding Grace",  -- Level 118
        },
        ["Righteousstrike"] = {
            --- Righteous Strikes Line
            "Righteous Antipathy",
            "Righteous Fury",
            "Righteous Indignation",
            "Righteous Vexation",
            "Righteous Umbrage",
            "Righteous Condemnation",
            "Righteous Antipathy",
        },
        ["Symbol"] = {
            "Symbol of Liako",
            "Symbol of Jeneca",
            "Symbol of Jyleel",
            "Symbol of Erillion",
            "Symbol of Burim",
            "Symbol of Niparson",
            "Symbol of Teralov",
            "Symbol of Sevalak",
            "Symbol of Bthur",
            "Symbol of Jeron",
            "Symbol of Marzin",
            "Symbol of Naltron",
            "Symbol of Pinzarn",
            "Symbol of Ryltan",
            "Symbol of Transal",
        },
        ["LessonStun"] = {
            --- Lesson Stun - Timer 6
            "Quellious' Word of Tranquility", -- Level 54
            "Quellious' Word of Serenity",    -- Level 64
            "Serene Command",                 -- Level 68
            "Lesson of Penitence",            -- Level 72
            "Lesson of Contrition",           -- Level 77
            "Lesson of Compunction",          -- Level 82
            "Lesson of Repentance",           -- Level 87
            "Lesson of Remorse",              -- Level 92
            "Lesson of Sorrow",               -- Level 97
            "Lesson of Grief",                -- Level 102
            "Lesson of Expiation",            -- Level 107
            "Lesson of Propitiation",         -- Level 112
            "Lesson of Guilt",                -- Level 117
        },
        ["Audacity"] = {
            -- Hate magic Debuff Over time
            "Ardent,",
            "Fervent,",
            "Sanctimonious,",
            "Devout,",
            "Righteous,",
        },
        ["LightHeal"] = {
            -- Target Light Heal
            "Salve",            -- Level 1
            "Minor Healing",    -- Level 6
            "Light Healing",    -- Level 12
            "Healing",          -- Level 27
            "Greater Healing",  -- Level 36
            "Superior Healing", -- Level 48
        },
        ["TotLightHeal"] = {
            -- ToT Light Heal
            "Light of Life",   -- Level 52
            "Light of Nife",   -- Level 63
            "Light of Order",  -- Level 65
            "Light of Piety",  -- Level 68
            "Gleaming Light",  -- Level 72
            "Radiant Light",   -- Level 77
            "Shining Light",   -- Level 82
            "Joyous Light",    -- Level 87
            "Brilliant Light", -- Level 92
            "Dazzling Light",  -- Level 97
            "Blessed Light",   -- Level 102
            "Merciful Light",  -- Level 107
            "Sincere Light",   -- Level 112
            "Raptured Light",  -- Level 117
        },
        ["Pacify"] = {
            "Placating Words",
            "Tranquil Words",
            "Propitiate",
            "Mollify",
            "Reconcile",
            "Dulcify",
            "Soothe",
            "Pacify",
            "Calm",
            "Lull",
        },
        ["Toucheal"] = {
            --- Touch Heal Line LVL61 - LVL115
            "Touch of Nife",
            "Touch of Piety",
            "Sacred Touch",
            "Solemn Touch",
            "Devout Touch",
            "Earnest Touch",
            "Zealous Touch",
            "Reverent Touch",
            "Ardent Touch",
            "Merciful Touch",
            "Sincere Touch",
            "Soothing Touch",
        },
        ["Dicho"] = {
            --- Dissident Stun
            "Dichotomic Force",
            "Dissident Force",
            "Composite Force",
            "Ecliptic Force",
        },
        ["Puritycure"] = {
            --- Purity Cure Poison/Diease Cure Half Power to curse
            "Balanced Purity",
            "Devoted Purity",
            "Earnest Purity",
            "Zealous Purity",
            "Reverent Purity",
            "Ardent Purity",
            "Merciful Purity",
        },
        ["ForHonor"] = {
            --- Challenge Taunt Over time Debuff
            "Challenge for Honor",
            "Trial For Honor",
            "Charge for Honor",
            "Confrontation for Honor",
            "Provocation for Honor",
            "Demand for Honor",
            "Impose for Honor",
            "Refute for Honor",
            "Protest for Honor",
            "Parlay for Honor",
        },
        ["Piety"] = {
            -- One Off Buffs
            "Silent Piety",
        },
        ["Remorse"] = {
            -- Remorse
            "Remorse for the fallen",
            "Penitence for the Fallen",
        },
        ["Aurabuff"] = {
            -- Aura Buffs
            "Blessed Aura",
            "Holy Aura",
        },
        ["AntiUndeadNuke"] = {
            -- Undead Nuke
            "Ward Undead",             -- Level 14
            "Expulse Undead",          -- Level 30
            "Dismiss Undead",          -- Level 46
            "Expel Undead",            -- Level 54
            "Deny Undead",             -- Level 62 - Timer 7
            "Spurn Undead",            -- Level 67 - Timer 7
            --[] = "Wraithguard's Vengeance",  -- Level 75 - Unobtainable?
            "Annihilate the Undead",   -- Level 86 - Res Debuff / Extra Damage
            "Abolish the Undead",      -- Level 91 - Res Debuff / Extra Damage
            "Doctrine of Abrogation",  -- Level 96
            "Abrogate the Undead",     -- Level 96 - Res Debuff / Extra Damage
            "Doctrine of Rescission",  -- Level 101
            "Doctrine of Exculpation", -- Level 106
            "Doctrine of Abolishment", -- Level 111
            "Doctrine of Annulment",   -- Level 116
        },
        ["AllianceNuke"] = {
            -- Pally Alliance Spell
            "Holy Alliance",
            "Stormwall Coalition",
        },
        ["CurseCure"] = {
            -- Curse Cure Line
            "Remove Minor Curse",
            "Remove Lesser Curse",
            "Remove Curse",
            "Remove Greater Curse",
        },
        ['EndRegen'] = {
			--Timer 13, can't be used in combat
            "Second Wind",
            "Third Wind",
            "Fourth Wind",
            "Respite",
            "Reprieve",
            "Rest",
            "Breather", --Level 101
        },
		['CombatEndRegen'] = {
			--Timer 13, can be used in combat.
			"Hiatus", --Level 106
            "Relax",
            "Night's Calming",
            "Convalesce",
        },
        ["MeleeMit"] = {
            -- Withstand Combat Line of Defense - Update to format once tested
            "Withstand",
            "Defy",
            "Renounce",
            "Reprove",
            "Repel",
            "Spurn",
            "Thwart",
            "Repudiate",
        },
        ["Armor"] = {
            --- Armor Timer 11
            "Armor of the Forthright",
            "Armor of Sincerity",
            "Armor of Mercy",
            "Armor of Ardency",
            "Armor of Reverence",
            "Armor of Zeal",
			"Armor of Courage",
        },
        ["Undeadburn"] = {
            "Holyforge Discipline",
        },
        ["Penitent"] = {
            -- Pentient Armor Discipline Timer 11
            "Fervent Penitence",
            "Reverent Penitence",
            "Devout Penitence",
            "Merciful Penitence",
            "Sincere Penitence",
        },
        ["Mantle"] = {
            ---Mantle Line of Discipline Timer 5 defensive burn
            "Supernal Mantle",
            "Mantle of the Sapphire Cohort",
            "Kar`Zok Mantle",
            "Skalber Mantle",
            "Brightwing Mantle",
            "Prominent Mantle",
            "Exalted Mantle",
            "Honorific Mantle",
            "Armor of Decorum",
            "Armor of Righteousness",
        },
        ["Holyguard"] = {
            -- Holy Guardian Discipline
            "Revered Guardian Discipline",
            "Blessed Guardian Discipline",
            "Holy Guardian Discipline",
        },
        ["Spellblock"] = {
            "Sanctification Discipline",
        },
        ["ReflexStrike"] = {
            --- Reflexive Strike Heal
            "Reflexive Redemption",
            "Reflexive Righteousness",
            "Reflexive Reverence",
        },
    },
    ['HelperFunctions']   = {
        -- helper function for advanced logic to see if we want to use DPU
        castDPU = function(self)
            if not mq.TLO.Me.AltAbility("Divine Protector's Unity")() then return false end
            local furyProcLevel = self:GetResolvedActionMapItem('FuryProc') and self:GetResolvedActionMapItem('FuryProc').Level() or 0
            local DPULevel = mq.TLO.Spell(mq.TLO.Me.AltAbility("Divine Protector's Unity").Spell.Trigger(1).BaseName()).Level() or 0

            return furyProcLevel <= DPULevel
        end,
		--Did not include Staff of Forbidden Rites, GoR refresh is very fast and rez is 96%
		DoRez = function(self, corpseId)

            if RGMercUtils.GetSetting('DoBattleRez') or RGMercUtils.DoBuffCheck() then
                RGMercUtils.SetTarget(corpseId)

                local target = mq.TLO.Target

                if not target or not target() then return false end

                if mq.TLO.Target.Distance() > 25 then
                    RGMercUtils.DoCmd("/corpse")
                end

                if RGMercUtils.AAReady("Gift of Resurrection") then
                    return RGMercUtils.UseAA("Gift of Resurrection", corpseId)
                end
            end
        end,
		AeTauntCheck = function(self)
			--check to see if we are the tank in the first place
			if not RGMercUtils.IsTanking() then return false end
	
			-- check that there are sufficient targets to AE taunt and that it is (optionally) safe to do so
			local mobs = mq.TLO.SpawnCount("NPC radius 50 zradius 50")()
			if (RGMercUtils.GetSetting('SafeAeTaunt') and mobs > RGMercUtils.GetXTHaterCount()) or RGMercUtils.GetXTHaterCount() < RGMercUtils.GetSetting('AeTauntCnt') then return false end

			--check to make sure the above targets need to be tanked
			local xtCount = mq.TLO.Me.XTarget()
			for i = 1, xtCount do
				local xtSpawn = mq.TLO.Me.XTarget(i)
				--ensure we only check hostiles, the hostile is in range, that we aren't already tanking it, and that the other xtargets aren't out of range of an AE taunt
				if xtSpawn() and (xtSpawn.ID() or 0) > 0 and (xtSpawn.TargetType() or ""):lower() == "auto hater" 
					and (xtSpawn.Distance() or 999) <= 50 and xtSpawn.PctAggro() < 100 and mobs > 1 then return true end
			end
			
			return false
		end,
    },
    ['HealRotationOrder'] = {
        {
            name = 'MainHealPoint',
            state = 1,
            steps = 1,
            cond = function(self, target) return (target.PctHPs() or 999) < RGMercUtils.GetSetting('MainHealPoint') end,
        },
        -- {
            -- name = 'LightHealPoint',
            -- state = 1,
            -- steps = 1,
            -- cond = function(self, target) return (target.PctHPs() or 999) < RGMercUtils.GetSetting('LightHealPoint') end,
        -- },
    },
    ['HealRotations']     = {
        -- ["LightHealPoint"] = {
            -- {
                -- name = "LightHeal",
                -- type = "Spell",
                -- cond = function(self, _) return true end,
            -- },
        -- },
        ["MainHealPoint"] = {
			{
                name = "Gift of Life",
                type = "AA",
                cond = function(self, aaName)
                    if not mq.TLO.Group() then return false end
                    return combat_state == "Combat" and RGMercUtils.AAReady(aaName) and mq.TLO.Group.Injured(RGMercUtils.GetSetting('BigHealPoint'))() > RGMercUtils.GetSetting('GroupInjureCnt')
                end,
            },
            {
                name = "Hand of Piety",
                type = "AA",
                cond = function(self, aaName)
                    if not mq.TLO.Group() then return false end
                    return combat_state == "Combat" and RGMercUtils.AAReady(aaName) and mq.TLO.Group.Injured(RGMercUtils.GetSetting('BigHealPoint'))() > RGMercUtils.GetSetting('GroupInjureCnt')
                end,
            },
            {
                name = "Lay on Hands",
                type = "AA",
                cond = function(self, aaName)
                    return combat_state == "Combat" and RGMercUtils.PCAAReady(aaName) and RGMercUtils.GetTargetPctHPs() < RGMercUtils.GetSetting('LayHandsPct')
                end,
			},
            {
                name = "WaveHeal",
                type = "Spell",
                cond = function(self, _)
                    if not mq.TLO.Group() then return false end
                    return mq.TLO.Group.Injured(RGMercUtils.GetSetting('GroupHealPoint'))() > RGMercUtils.GetSetting('GroupInjureCnt')
                end,
            },
            {
                name = "WaveHeal2",
                type = "Spell",
                cond = function(self, _)
                    if not mq.TLO.Group() then return false end
                    return mq.TLO.Group.Injured(RGMercUtils.GetSetting('GroupHealPoint'))() > RGMercUtils.GetSetting('GroupInjureCnt')
                end,
            },
            {
                name = "Aurora",
                type = "Spell",
                cond = function(self, _)
                    if not mq.TLO.Group() then return false end
                    return mq.TLO.Group.Injured(RGMercUtils.GetSetting('GroupHealPoint'))() > RGMercUtils.GetSetting('GroupInjureCnt')
                end,
            },
            
		},
	},
    ['RotationOrder']   = {
        -- Downtime doesn't have state because we run the whole rotation at once.
        -- Rebuffs and non-combat actions
        {
            name = 'Downtime',
            targetId = function(self) return { mq.TLO.Me.ID(), } end,
            cond = function(self, combat_state)
                return combat_state == "Downtime" and
                    RGMercUtils.DoBuffCheck() and RGMercConfig:GetTimeSinceLastMove() > RGMercUtils.GetSetting('BuffWaitMoveTimer')
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
                    RGMercConfig:GetTimeSinceLastMove() > RGMercUtils.GetSetting('BuffWaitMoveTimer')
            end,
        },
        --Defensive actions or heals triggered by low HP
        --Note that in Tank Mode, defensive discs are preemptively cycled on named in Combat Maintenance
        {
            name = 'EmergencyHealing',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and mq.TLO.Me.PctHPs() <= RGMercUtils.GetSetting('EmergencyStart')
            end,
        },
        {
            name = 'EmergencyDefenses',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and mq.TLO.Me.PctHPs() <= RGMercUtils.GetSetting('EmergencyStart')
            end,
        },
      --Actions that establish or maintain hatred
        {
            name = 'HateTools',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and RGMercUtils.IsTanking()
            end,
        },
        --Defensive actions used proactively to prevent emergencies
        {
            name = 'Defenses',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                --need to look at rotation and decide if it should fire during emergencies. leaning towards no
                return combat_state == "Combat" and mq.TLO.Me.PctHPs() > RGMercUtils.GetSetting('EmergencyLockout')
            end,
        },
        --Offensive actions to temporarily boost damage dealt
        {
            name = 'Burn',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and
                    RGMercUtils.BurnCheck() and not RGMercUtils.Feigning() and mq.TLO.Me.PctHPs() > RGMercUtils.GetSetting('EmergencyLockout')
            end,
        },
      --Prioritized in their own rotation to help keep HP topped to the desired level
        {
            name = 'ToTHeals',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                --using SpellInCooldown() sounds good in theory but want to test if necessary
                return combat_state == "Combat" and mq.TLO.Me.PctHPs() > RGMercUtils.GetSetting('EmergencyLockout')-- and not mq.TLO.Me.SpellInCooldown()
            end,
        },
      --Non-spell actions that can be used during/between casts
		{
            name = 'CombatWeave',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and mq.TLO.Me.PctHPs() > RGMercUtils.GetSetting('EmergencyLockout')
            end,
        },
      --DPS Spells, includes recourse/gift maintenance
		{
            name = 'Combat',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and mq.TLO.Me.PctHPs() > RGMercUtils.GetSetting('EmergencyLockout') --and not mq.TLO.Me.SpellInCooldown() 
            end,
        },
    },
    ['Rotations']       = {
        ['Downtime'] = {
			{
                name = "EndRegen",
                type = "Disc",
				tooltip = Tooltips.EndRegen,
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and mq.TLO.Me.Level() < 106 and mq.TLO.Me.PctEndurance() < 15
                end,
            },
			--If these tables were combined, errors could occur... there is no other good way I can think of to ensure a timer 13 ability that can be used in combat is scribed.
			{
                name = "CombatEndRegen",
                type = "Disc",
				tooltip = Tooltips.CombatEndRegen,
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and mq.TLO.Me.Level() > 105 and mq.TLO.Me.PctEndurance() < 15
                end,
            },
			{
                name = "Preservation",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell) and RGMercUtils.IsModeActive("Tank") and (mq.TLO.Me.Buff(spell).Duration.TotalSeconds() or 0) < 30
                end,
            },
            {
                name = "TempHP",
                type = "Spell",
                tooltip = Tooltips.TempHP,
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.RankName.ID()) end,
                cond = function(self, spell) return RGMercUtils.PCSpellReady(spell) and RGMercUtils.SpellStacksOnMe(spell) and (mq.TLO.Me.Buff(spell).Duration.TotalSeconds() or 0) < 45
				end,
            },
            {
                name = "Incoming",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell) and RGMercUtils.SpellStacksOnMe(spell) and RGMercUtils.IsModeActive("Tank") and (mq.TLO.Me.Buff(spell).Duration.TotalSeconds() or 0) < 15
                end,
            },
			{
                name = "HealWard",
                type = "Spell",
                cond = function(self, spell) return RGMercUtils.PCSpellReady(spell) and RGMercUtils.SpellStacksOnMe(spell) and RGMercUtils.IsModeActive("Tank") and (mq.TLO.Me.Song(spell).Duration.TotalSeconds() or 0) < 15
				end,
            },
            {
                name = "Divine Protector's Unity",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.SelfBuffAACheck(aaName) and self.ClassConfig.HelperFunctions.castDPU(self)
                end,
            },
            {
                name = "ArmorSelfBuff",
                type = "Spell",
                cond = function(self, spell)
                    return not self.ClassConfig.HelperFunctions.castDPU(self) and RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell)
                end,
            },
            {
                name = "FuryProc",
                type = "Spell",
                cond = function(self, spell)
                    return not self.ClassConfig.HelperFunctions.castDPU(self) and RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell)
                end,
            },
            {
                name = "Remorse",
                type = "Spell",
                cond = function(self, spell)
                    return not self.ClassConfig.HelperFunctions.castDPU(self) and RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell)
                end,
            },
            {
                name = "Piety",
                type = "Spell",
                cond = function(self, spell)
                    return not self.ClassConfig.HelperFunctions.castDPU(self) and RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell)
                end,
            },
			{
                name = "Huntsman's Ethereal Quiver",
                type = "Item",
                active_cond = function(self) return mq.TLO.FindItemCount("Ethereal Arrow")() > 1 end,
                cond = function(self)
                    return RGMercUtils.GetSetting('SummonArrows') and mq.TLO.FindItemCount("Ethereal Arrow")() < 1 and mq.TLO.Me.ItemReady("Huntsman's Ethereal Quiver")()
                end,
            },
			{
                name = "Aurabuff",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell) and not RGMercUtils.AuraActiveByName(spell.RankName.Name()) and mq.TLO.Me.PctEndurance() > 10
                end,
            },
        },
		['GroupBuff'] = {
			--These intentionally only check the tank so he isn't constantly switching targets to check stacking/pausing to rebuff others with single target spells. Considering removing or splitting single target versions of buffs.
            {
                name = "Brells",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell) return RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell) and RGMercUtils.GetSetting('DoBrells') end,
            },
            {
                name = "Aego",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell) return RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell) and not RGMercUtils.GetSetting('DoDruid') end,
            },
            {
                name = "Symbol",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell) return RGMercUtils.PCSpellReady(spell) and RGMercUtils.SelfBuffCheck(spell) and RGMercUtils.GetSetting('DoDruid') end,
            },
        },
		--revisit this as most are likely covered in heal modes
		['EmergencyHealing'] = {
			doFullRotation = true,
		    {
                name = "Lay on Hands",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.PCAAReady(aaName) and mq.TLO.Me.PctHPs() < 25
                end,
			},
			{
                name = "SelfHeal",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell)
                end,
            },
			{
                name = "Dicho",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.NPCSpellReady(spell)
                end,
            },
			{
                name = "Marr's Gift",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
            {
                name = "Hand of Piety",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
			{
                name = "Gift of Life",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
			{
                name = "BurstHeal",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell)
                end,
            },
			{
                name = "TotLightHeal",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell)
                end,
            },
            --Staunch Recovery placed as low priority as it has a long(ish) cast time. Also often used manually after a combat rez.
			--Considering dropping this and removing the dofullrotation flag
            {
                name = "Staunch Recovery",
                type = "AA",
                tooltip = Tooltips.StaunchRecovery,
				cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and mq.TLO.Me.PctHPs() < 20
                    and RGMercUtils.GetSetting('DoVetAA')
                end,
            },
        },
		['EmergencyDefenses'] = {
		  --Note that in Tank Mode, defensive discs are preemptively cycled on named in the (non-emergency) Defenses rotation
		  --Abilities should be placed in order of lowest to highest triggered HP thresholds
		  --Side Note: I reserve Bargain for manual use while driving, the omission is intentional.
          --Some conditionals are commented out while I tweak percentages (or determine if they are necessary)
			doFullRotation = true,
            {
                name = "Armor of Experience",
                type = "AA",
                tooltip = Tooltips.ArmorofExperience,
				cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and mq.TLO.Me.PctHPs() < 25
                    and RGMercUtils.GetSetting('DoVetAA')
                end,
            },
          --Note that on named we may already have a mantle/carapace running already
            {
                name = "Deflection",
                type = "Disc",
                tooltip = Tooltips.Deflection,
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and mq.TLO.Me.ActiveDisc.Name() ~= "Leechcurse Discipline" and mq.TLO.Me.PctHPs() < 35
                end,
            },
            -- {
                -- name = "LeechCurse",
                -- type = "Disc",
                -- tooltip = Tooltips.LeechCurse,
                -- cond = function(self, discSpell)
                    -- return RGMercUtils.PCDiscReady(discSpell) and mq.TLO.Me.ActiveDisc.Name() ~= "Deflection Discipline" and mq.TLO.Me.PctHPs() < 35
                -- end,
            -- },
            {
                name = "Shield Flash",
                type = "AA",
                tooltip = Tooltips.ShieldFlash,
                cond = function(self, aaName)
					return RGMercUtils.AAReady(aaName)
                    --return mq.TLO.Me.PctHPs() < 50
                    --and mq.TLO.Me.ActiveDisc.ID()
                end,
            },
		--putting this in in place of influence, figure out later, timer 11 (same as armor)
			{
                name = "Penitent",
                type = "Disc",
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and RGMercUtils.IsTanking() and
                    --mq.TLO.Me.PctHPs() < 50 and
                    not mq.TLO.Me.ActiveDisc.ID()
                end,
            },
			{
                name = "Armor of the Inquisitor",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and not RGMercUtils.SongActiveByName('Group Armor of the Inquisitor')
                end,
            },
			{
                name = "Group Armor of The Inquisitor",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and
                        not RGMercUtils.SongActiveByName('Armor of the Inquisitor')
                end,
            },
            {
                name = mq.TLO.Me.Inventory("Chest").Name(),
                type = "Item",
                active_cond = function(self)
                    local item = mq.TLO.Me.Inventory("Chest")
                    return item() and RGMercUtils.TargetHasBuff(item.Spell, mq.TLO.Me)
                end,
                cond = function(self)
                    local item = mq.TLO.Me.Inventory("Chest")
                    return RGMercUtils.GetSetting('DoChestClick') and item() and RGMercUtils.SpellStacksOnMe(item.Spell) and item.TimerReady() == 0
                end,
            },
			{
                name = "Armor",
                type = "Disc",
                -- tooltip = Tooltips.Carapace
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and not mq.TLO.Me.ActiveDisc.ID()
                end,
            },
			--if we made it this far let's reset our dicho/burst and hope for the best!
			{
                name = "Forceful Rejuvenation",
                type = "AA",
                tooltip = Tooltips.ForcefulRejuv,
                cond = function(self, aaName)
					return RGMercUtils.AAReady(aaName)
                end,
            },
          },
		['HateTools'] = {
            --used when we've lost hatred after it is initially established
			{
                name = "Ageless Enmity",
                type = "AA",
                tooltip = Tooltips.AgelessEnmity,
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and RGMercUtils.GetTargetPctHPs() < 90 and mq.TLO.Me.PctAggro() < 100
					end,
            },
          --used to jumpstart hatred on named from the outset and prevent early rips from burns
			{
                name = "Affirmation",
                type = "Disc",
                tooltip = Tooltips.Acrimony,
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and RGMercUtils.IsNamed(mq.TLO.Target)
                end,
            },
          -- --used to reinforce hatred on named
			-- {
                -- name = "Veil of Darkness",
                -- type = "AA",
                -- tooltip = Tooltips.VeilofDarkness,
                -- cond = function(self)
                    -- return (mq.TLO.Target.SecondaryPctAggro() or 0) > 70
					          -- and RGMercUtils.IsNamed(mq.TLO.Target)
                -- end,
            -- },
			-- {
                -- name = "AeTaunt",
                -- type = "Spell",
                -- tooltip = Tooltips.AeTaunt,
                -- cond = function(self, spell)
                    -- return self.ClassConfig.HelperFunctions.AeTauntCheck(self)
                -- end,
            -- },
            {
                name = "Heroic Leap",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and self.ClassConfig.HelperFunctions.AeTauntCheck(self)
                end,
            },
			{
                name = "Beacon of the Righteous",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and self.ClassConfig.HelperFunctions.AeTauntCheck(self)
                end,
            },
            {
                name = "Hallowed Lodestar",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and self.ClassConfig.HelperFunctions.AeTauntCheck(self)
                end,
            },
      --likely leaving this one as a manual choice, can be used for splitpulling as well
			      -- {
                -- name = "Projection of Doom",
                -- type = "AA",
                -- tooltip = Tooltips.ProjectionofDoom,
                -- cond = function(self)
                    -- return (mq.TLO.Target.SecondaryPctAggro() or 0) > 80
					          -- and RGMercUtils.IsNamed(mq.TLO.Target)
                -- end,
            -- },
            {
                name = "Taunt",
                type = "Ability",
                tooltip = Tooltips.Taunt,
                cond = function(self, abilityName)
                    return mq.TLO.Me.AbilityReady(abilityName)() and
                        mq.TLO.Me.TargetOfTarget.ID() ~= mq.TLO.Me.ID() and RGMercUtils.GetTargetID() > 0 and
                        RGMercUtils.GetTargetDistance() < 30
                end,
			},
			-- figure out timer 2 stuff            
            -- {
                -- name = "Terror2",
                -- type = "Spell",
                -- tooltip = Tooltips.Terror,
                -- cond = function(self)
                    -- return RGMercUtils.GetSetting('DoTerror')
					          -- and (mq.TLO.Target.SecondaryPctAggro() or 0) > 60
					          -- and RGMercUtils.SpellLoaded(spell)
                -- end,
            -- },
            {
                name = "ForHonor",
                type = "Spell",
                cond = function(self, spell)
                     return RGMercUtils.NPCSpellReady(spell) and RGMercUtils.DetSpellCheck(spell)
                    --hopefully this condition only uses the spell to maintain the hatred-over-time debuff
                end,
            },
        },
        ['Burn'] = {
          --I'm seeing burnauto settings checks in conditions for existing entries, wondering if they are actually required... shouldn't burn checking in the rotation phase cover this? Whatever, will apply brainpower later, likely a reason.
            -- return (RGMercUtils.GetSetting('BurnAuto') and RGMercUtils.IsNamed(mq.TLO.Target)) or RGMercUtils.MedBurn()

            {
                name = "Valorous Rage",
                type = "AA",
                cond = function(self, aaName) return RGMercUtils.AAReady(aaName) and RGMercUtils.MedBurn() end,
            },
            {
                name = "Righteousstrike",
                type = "Disc",
                cond = function(self, discSpell)
                    return not mq.TLO.Me.ActiveDisc.ID() and RGMercUtils.NPCDiscReady(discSpell) and RGMercUtils.MedBurn()
                end,
            },
           {
                name = "Intensity of the Resolute",
                type = "AA",
                tooltip = Tooltips.ThoughtLeech,
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and RGMercUtils.GetSetting('DoVetAA')
                    and RGMercUtils.BigBurn()
				end,
            },
          -- --the  next two entries are lower because we want a chance for the above to be up before we HT
            -- {
                -- name = "Harm Touch",
                -- type = "AA",
                -- tooltip = Tooltips.HarmTouch,
                -- cond = function(self, _)
                    -- return RGMercUtils.MedBurn()
                -- end,
            -- },
            -- {
                -- name = "Thought Leech",
                -- type = "AA",
                -- tooltip = Tooltips.ThoughtLeech,
                -- cond = function(self, _)
                    -- return RGMercUtils.MedBurn()
				-- end,
            -- },
            --back to lower priority burn stuff
            {
                name = "Spire of Chivalry",
                type = "AA",
                tooltip = Tooltips.SpireoftheReavers,
                cond = function(self, aaName)
                return
                        RGMercUtils.AAReady(aaName) and RGMercUtils.SmallBurn()
				end,
			},
			{
                name = "Thunder of Karana",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and RGMercUtils.GetSetting('DoNuke') and RGMercUtils.SmallBurn()
                end,
            },
			      -- not sure about this one yet, more homework
            -- {
                -- name = "SpiteStrike",
                -- type = "Disc",
                -- tooltip = Tooltips.SpikeStrike,
                -- cond = function(self)
                    -- return RGMercUtils.IsNamed(mq.TLO.Target)
                -- end,
            -- },
			--add this back in with tanking Check
			-- {
                -- name = "Inquisitor's Judgment",
                -- type = "AA",
                -- cond = function(self, aaName)
                    -- return RGMercUtils.AAReady(aaName)
                -- end,
            -- },
        },
        ['Debuff'] = {},
        ['Defenses'] = {
            -- {
                -- name = "ActivateShield",
                -- type = "CustomFunc",
                -- -- tooltip = Tooltips.ActivateShield,
                -- cond = function(self)
                    -- return RGMercUtils.GetSetting('DoBandolier') and not mq.TLO.Me.Bandolier("Shield").Active() and
                        -- mq.TLO.Me.Bandolier("Shield").Index() and RGMercUtils.IsTanking()
                -- end,
                -- custom_func = function(_)
                    -- RGMercUtils.DoCmd("/bandolier activate Shield")
                    -- return true
                -- end,

            -- },
            -- {
                -- name = "Activate2HS",
                -- type = "CustomFunc",
                -- -- tooltip = Tooltips.Activate2HS,
                -- cond = function(self)
                    -- return RGMercUtils.GetSetting('DoBandolier') and not mq.TLO.Me.Bandolier("2HS").Active() and
                        -- mq.TLO.Me.Bandolier("2HS").Index() and not RGMercUtils.IsTanking()
                -- end,
                -- custom_func = function(_)
                    -- RGMercUtils.DoCmd("/bandolier activate 2HS")
                    -- return true
                -- end,
            -- },
            {
                name = "MeleeMit",
                type = "Disc",
                tooltip = Tooltips.MeleeMit,
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and RGMercUtils.IsTanking()
                end,
            },
          --todo: fully test leechbuff function
            -- {
				-- name = "Epic",
                -- type = "Item",
                -- tooltip = Tooltips.Epic,
                -- cond = function(self, itemName)
                    -- return mq.TLO.FindItemCount(itemName)() ~= 0 and mq.TLO.FindItem(itemName).TimerReady() == 0 and (self.ClassConfig.HelperFunctions.LeechCheck(self) or RGMercUtils.IsNamed(mq.TLO.Target))
                -- end,
            -- },
            -- {
                -- name = "OoW_Chest",
                -- type = "Item",
                -- tooltip = Tooltips.OoW_BP,
                -- cond = function(self, itemName)
                    -- return mq.TLO.FindItemCount(itemName)() ~= 0 and mq.TLO.FindItem(itemName).TimerReady() == 0 and self.ClassConfig.HelperFunctions.LeechCheck(self)
                -- end,
            -- },
            {
                name = "Mantle",
                type = "Disc",
                tooltip = Tooltips.Mantle,
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and RGMercUtils.IsTanking() and
                        (RGMercUtils.IsNamed(mq.TLO.Target) or mq.TLO.SpawnCount("NPC radius 30 zradius 50")() >= RGMercUtils.GetSetting('MantleCount')) and
                        not mq.TLO.Me.ActiveDisc.ID()
                end,
            },
            {
                name = "Armor",
                type = "Disc",
                tooltip = Tooltips.Carapace,
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and RGMercUtils.IsTanking() and
                        (RGMercUtils.IsNamed(mq.TLO.Target) or mq.TLO.SpawnCount("NPC radius 30 zradius 50")() >= RGMercUtils.GetSetting('ArmorCount')) and
                        not mq.TLO.Me.ActiveDisc.ID()
                end,
            },
            {
                name = "HolyGuard",
                type = "Disc",
                tooltip = Tooltips.CurseGuard,
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and RGMercUtils.IsTanking() and
                        (RGMercUtils.IsNamed(mq.TLO.Target) or mq.TLO.SpawnCount("NPC radius 30 zradius 50")() > RGMercUtils.GetSetting('CurseGuardCount')) and
                        not mq.TLO.Me.ActiveDisc.ID()
                end,
            },
            -- {
                -- name = "UnholyAura",
                -- type = "Disc",
                -- tooltip = Tooltips.UnholyAura,
                -- cond = function(self)
                    -- return (RGMercUtils.IsNamed(mq.TLO.Target) or mq.TLO.SpawnCount("NPC radius 30 zradius 50")() >= RGMercUtils.GetSetting('UnholyCount')) and
                        -- not mq.TLO.Me.ActiveDisc.ID()
                -- end,
            -- },

        },
        ['ToTHeals'] = {
			-- This makes the full rotation execute each round, so it'll never pick up and resume wherever it left off the previous cast.
			-- We don't want a light ToT being used if Dicho is needed, for example.
            doFullRotation = true,
			{
                name = "Dicho",
                type = "Spell",
                -- tooltip = Tooltips.Dicho,
                cond = function(self, spell)
                    return RGMercUtils.NPCSpellReady(spell) and (mq.TLO.Me.TargetOfTarget.PctHPs() or 0) <= RGMercUtils.GetSetting('StartDicho')
                end,
            },
			{
                name = "BurstHeal",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell) and
                        (mq.TLO.Me.TargetOfTarget.PctHPs() or 0) < RGMercUtils.GetSetting('StartBurstToT')
                end,
            },
		    {
                name = "TotLightHeal",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell) and
                        (mq.TLO.Me.TargetOfTarget.PctHPs() or 0) < RGMercUtils.GetSetting('TotHealPoint')
                end,
            },
			{
                name = "Lowaggronuke",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.NPCSpellReady(spell) and
						(mq.TLO.Me.TargetOfTarget.PctHPs() or 0) < RGMercUtils.GetSetting('TotHealPoint')
                end,
            },
        },
        ['CombatWeave'] = {
          --Used if the group could benefit from the heal, adjust to taste
			{
                name = "ReflexStrike",
                type = "Disc",
                tooltip = Tooltips.ReflexStrike,
                cond = function(self, discSpell)
                    return RGMercUtils.NPCDiscReady(discSpell) and (mq.TLO.Group.Injured(80)() or 0) > 2
                end,
            },
			{
                name = "CombatEndRegen",
                type = "Disc",
				tooltip = Tooltips.CombatEndRegen,
                cond = function(self, discSpell)
                    return RGMercUtils.PCDiscReady(discSpell) and mq.TLO.Me.PctEndurance() < 15
                end,
            },
			---- figure out timer 2 stuff            
			-- {
                -- name = "Disruptive Persecution",
                -- type = "AA",
                -- cond = function(self, aaName)
                    -- return RGMercUtils.AAReady(aaName) and mq.TLO.Me.AltAbility(aaName).Rank() >= 3 and not RGMercUtils.BuffActiveByName("Knight's Yaulp")
                -- end,
            -- },
            -- {
                -- name = "Vicious Bite of Chaos",
                -- type = "AA",
                -- tooltip = Tooltips.ViciousBiteOfChaos,
                -- cond = function(self)
                    -- return RGMercUtils.GetTargetPctHPs() > 5 and RGMercUtils.GetTargetDistance() < 35
                -- end,
            -- },
            -- {
                -- name = "Blade",
                -- type = "Disc",
                -- tooltip = Tooltips.Blade,
                -- cond = function(self)
                    -- return RGMercUtils.GetTargetID() > 0 and RGMercUtils.GetTargetPctHPs() > 5 and
                        -- RGMercUtils.GetTargetDistance() < 35 --and ((mq.TLO.Me.Inventory("mainhand").Type() or ""):find("2H"))
                -- end,
            -- },
            -- {
                -- name = "Gift of the Quick Spear",
                -- type = "AA",
                    -- cond = function(self, aaName)
                    -- return RGMercUtils.AAReady(aaName)
                -- end,
            -- },
            {
                name = mq.TLO.Me.Inventory("Charm").Name(),
                type = "Item",
                active_cond = function(self)
                    local item = mq.TLO.Me.Inventory("Charm")
                    return item() and RGMercUtils.TargetHasBuff(item.Spell, mq.TLO.Me)
                end,
                cond = function(self)
                    local item = mq.TLO.Me.Inventory("Charm")
                    return RGMercUtils.GetSetting('DoCharmClick') and item() and RGMercUtils.SpellStacksOnMe(item.Spell) and item.TimerReady() == 0
                end,
            },
            {
                name = "Bash",
                type = "Ability",
                -- tooltip = Tooltips.Bash,
                cond = function(self)
                    return mq.TLO.Me.AbilityReady("Bash")() and RGMercUtils.GetTargetDistance() < 30
                end,
            },
            {
                name = "Slam",
                type = "Ability",
                -- tooltip = Tooltips.Slam,
                cond = function(self)
                    return mq.TLO.Me.AbilityReady("Slam")() and RGMercUtils.GetTargetDistance() < 30
                end,
            },
          },
        ['Combat'] = {
			{
                name = "StunTimer4",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.NPCSpellReady(spell) and RGMercUtils.DetSpellCheck(spell)
                end,
            },
			{
                name = "HealStun",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.NPCSpellReady(spell) and RGMercUtils.DetSpellCheck(spell) and RGMercUtils.SpellStacksOnMe(spell) and (mq.TLO.Me.Song(spell.Trigger(1).Name).Duration.TotalSeconds() or 0) < 12
                end,
            },
			{
                name = "HealWard",
                type = "Spell",
                cond = function(self, spell) return RGMercUtils.SelfBuffCheck(spell) end,
            },
			{
                name = "HealNuke",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.NPCSpellReady(spell)
                end,
            },
			--below stuff thrown in, not vetted
			-- {
                -- name = "Healtaunt",
                -- type = "Spell",
                -- cond = function(self, spell)
                    -- return RGMercUtils.NPCSpellReady(spell)
                -- end,
            -- },
			{
                name = "Force of Disruption",
                type = "AA",
                cond = function(self, aaName)
                    return (mq.TLO.Me.AltAbility(aaName).Rank() or 0) > 7 and not RGMercUtils.BuffActiveByName("Knight's Yaulp") and
                        RGMercUtils.GetTargetDistance() < 30 and RGMercUtils.AAReady(aaName)
                end,
            },
			
            -- {
                -- name = "StunTimer5",
                -- type = "Spell",
                -- cond = function(self, spell)
                    -- return RGMercUtils.NPCSpellReady(spell) and RGMercUtils.DetSpellCheck(spell)
                -- end,
            -- },
            {
                name = "LessonStun",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell) and RGMercUtils.DetSpellCheck(spell)
                end,
            },
			-- {
                -- name = "DebuffNuke",
                -- type = "Spell",
                -- cond = function(self, spell)
                    -- return RGMercUtils.NPCSpellReady(spell) and
                        -- ((RGMercUtils.TargetBodyIs(mq.TLO.Target, "Undead") or mq.TLO.Me.Level() >= 96) and not RGMercUtils.TargetHasBuff(spell) and RGMercUtils.GetSetting('DoNuke'))
                -- end,
            -- },
            -- {
                -- name = "AntiUndeadNuke",
                -- type = "Spell",
                -- cond = function(self, spell)
                    -- return RGMercUtils.NPCSpellReady(spell) and RGMercUtils.TargetBodyIs(mq.TLO.Target, "Undead")
                -- end,
            -- },
            -- {
                -- name = "Reverseds",
                -- type = "Spell",
                -- cond = function(self, spell)
                    -- return RGMercUtils.NPCSpellReady(spell) and RGMercUtils.TargetHasBuff(spell) and RGMercUtils.GetSetting('DoReverseDS')
                -- end,
            -- },
            {
                name = "Lowaggronuke",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.NPCSpellReady(spell) and RGMercUtils.GetSetting('DoNuke')
                end,
            },
			-- {
                -- name = "CrushTimer6",
                -- type = "Spell",
                -- cond = function(self, spell)
                    -- return RGMercUtils.NPCSpellReady(spell)
                -- end,
            -- },
            
		},
    },
    ['Spells']            = {
        {
            gem = 1,
            spells = {
                { name = "StunTimer4", },
            },
        },
        {
            gem = 2,
            spells = {
				{ name = "HealStun", },
                { name = "TotLightHeal", },
            },
        },
        {
            gem = 3,
            spells = {
				{ name = "LessonStun", },
            },
        },
        {
            gem = 4,
            spells = {
                { name = "Lowaggronuke", },
            },
        },
        {
            gem = 5,
            spells = {
                { name = "HealNuke", },
            },
        },
        {
            gem = 6,
            spells = {
				{ name = "SelfHeal", },
            },
        },
        {
            gem = 7,
            spells = {
                { name = "BurstHeal", },
            },
        },
        {
            gem = 8,
            spells = {
                { name = "ForHonor", },
            },
        },
        {
            gem = 9,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
				{ name = "Dicho", },
                { name = "Preservation", },
            },
        },
        {
            gem = 10,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "Preservation", },
				{ name = "TempHP", },
            },
        },
        {
            gem = 11,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "TempHP", },
                { name = "HealWard", },
            },
        },
        {
            gem = 12,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "HealWard", },
            },
        },
        {
            gem = 13,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
				{ name = "Incoming", },
            },
        },
		-- {
            -- gem = 1,
            -- spells = {
                -- { name = "CrushTimer6", },
                -- { name = "StunTimer5", },
                -- { name = "ForHonor", },
                -- { name = "LightHeal", },
            -- },
        -- },
        -- {
            -- gem = 2,
            -- spells = {
                -- { name = "Lowaggronuke", cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "CrushTimer5", },
                -- { name = "StunTimer4", },
            -- },
        -- },
        -- {
            -- gem = 3,
            -- spells = {
                -- { name = "HealNuke",    cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "LessonStun",  cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "Healtaunt", },
                -- { name = "LessonStun", },
                -- { name = "CrushTimer5", },
                -- { name = "StunTimer5", },
            -- },
        -- },
        -- {
            -- gem = 4,
            -- spells = {
                -- { name = "AntiUndeadNuke", cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "Lowaggronuke", },
                -- { name = "CrushTimer6", },
                -- { name = "LessonStun", },
                -- { name = "WaveHeal", },
            -- },
        -- },
        -- {
            -- gem = 5,
            -- spells = {
                -- { name = "WaveHeal",       cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "HealNuke", },
                -- { name = "AntiUndeadNuke", },
                -- { name = "TotLightHeal", },
            -- },
        -- },
        -- {
            -- gem = 6,
            -- spells = {
                -- { name = "TotLightHeal", cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
				-- { name = "Aurora", },
                -- { name = "WaveHeal2", },
                -- { name = "BurstHeal", },
            -- },
        -- },
        -- {
            -- gem = 7,
            -- spells = {
                -- { name = "BurstHeal",    cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "TotLightHeal", },
                -- { name = "Preservation", },
            -- },
        -- },
        -- {
            -- gem = 8,
            -- spells = {
                -- { name = "Reverseds", cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "BurstHeal", },
                -- { name = "TempHP", },
            -- },
        -- },
        -- {
            -- gem = 9,
            -- cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            -- spells = {
                -- { name = "DebuffNuke",     cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "ForHonor", },
                -- { name = "Healward", },
            -- },
        -- },
        -- {
            -- gem = 10,
            -- cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            -- spells = {
                -- { name = "Healproc", cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "TempHP", },
                -- { name = "HealNuke", },
            -- },
        -- },
        -- {
            -- gem = 11,
            -- cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            -- spells = {
                -- { name = "Aurora",         cond = function(self) return RGMercUtils.IsModeActive('DPS') end, },
                -- { name = "Preservation", },
                -- { name = "DebuffNuke", },
                -- { name = "AntiUndeadNuke", },
            -- },
        -- },
        -- {
            -- gem = 12,
            -- cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            -- spells = {
                -- { name = "Dicho", },
                -- { name = "ForHonor", },
            -- },
        -- },
        -- {
            -- gem = 13,
            -- cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            -- spells = {
            -- },
        -- },
    },
    ['PullAbilities']     = {
        {
            id = 'StunTimer4',
            Type = "Spell",
            DisplayName = function() return RGMercUtils.GetResolvedActionMapItem('StunTimer4')() or "" end,
            AbilityName = function() return RGMercUtils.GetResolvedActionMapItem('StunTimer4')() or "" end,
            AbilityRange = 150,
            cond = function(self)
                local resolvedSpell = RGMercUtils.GetResolvedActionMapItem('StunTimer4')
                if not resolvedSpell then return false end
                return mq.TLO.Me.Gem(resolvedSpell.RankName.Name() or "")() ~= nil
            end,
        },
        {
            id = 'ForHonor',
            Type = "Spell",
            DisplayName = function() return RGMercUtils.GetResolvedActionMapItem('ForHonor').RankName.Name() or "" end,
            AbilityName = function() return RGMercUtils.GetResolvedActionMapItem('ForHonor').RankName.Name() or "" end,
            AbilityRange = 200,
            cond = function(self)
                local resolvedSpell = RGMercUtils.GetResolvedActionMapItem('ForHonor')
                if not resolvedSpell then return false end
                return mq.TLO.Me.Gem(resolvedSpell.RankName.Name() or "")() ~= nil
            end,
        },
    },
    ['DefaultConfig']   = {
        --Mode
        ['Mode']         = { DisplayName = "Mode", Category = "Combat", Tooltip = "Select the Combat Mode for this Toon", Type = "Custom", RequiresLoadoutChange = true, Default = 1, Min = 1, Max = 2, },
        
        --Spells and Abilities
        ['DoNuke']       = { DisplayName = "Cast Spells", Category = "Spells and Abilities", Tooltip = "Use Spells", Default = true, },
        ['DoCures']       = { DisplayName = "Do Cures", Category = "Spells and Abilities", Tooltip = "Use Cure spells and abilities", Default = true, },
        ['DoReverseDS']  = { DisplayName = "Do Reverse DS", Category = "Spells and Abilities", Tooltip = "Cast Reverse DS", Default = true, },
        ['DoVetAA']          = { DisplayName = "Use Vet AA", Category = "Spells and Abilities", Tooltip = "Use Veteran AA's in emergencies or during BigBurn", Default = true, },
		
		--Group Buffs
		['DoBrells']     = { DisplayName = "Do Brells", Category = "Group Buffs", Tooltip = "Enable Casting Brells", Default = true, },
        ['DoDruid']      = { DisplayName = "Do Druid", Category = "Group Buffs", Tooltip = "Enable SCasting Symbol instead of Aego", Default = true, },
	
        --Healing
        ['TotHealPoint'] = { DisplayName = "ToT HealPoint", Category = "Healing", Tooltip = "HP% before we use Target of Target heals.", Default = 90, Min = 1, Max = 100, },
        ['StartBurstToT']     = { DisplayName = "Burst ToT %", Category = "Healing", Tooltip = "ToT HP % before we use Burst ToT in non-emergencies.", Default = 80, Min = 1, Max = 100, },
        ['DoDicho']       = { DisplayName = "Cast Dicho Stun", Category = "Healing", Tooltip = "Enable casting Dicho-line ToT spells.", RequiresLoadoutChange = true, Default = true, },
        ['StartDicho']     = { DisplayName = "Use Dicho Stun", Category = "Healing", Tooltip = "Your HP % before we use Dicho in non-emergencies.", Default = 65, Min = 1, Max = 100, },
		['LayHandsPct']  = { DisplayName = "Use Lay on Hands", Category = "Healing", Tooltip = "HP% before we use Lay on Hands on others (Present in Emergency Rotations for self).", Default = 35, Min = 1, Max = 100, },
        
        --Hate Tools
        ['DoAE']            = { DisplayName = "Use AE Taunts", Category = "Hate Tools", Tooltip = "Enable casting AE Taunt spells.", Default = true, },
        ['AeTauntCnt']      = { DisplayName = "AE Taunt Count", Category = "Hate Tools", Tooltip = "Minimum number of haters before using AE Taunt.", Default = 2, Min = 1, Max = 10, },
        ['SafeAeTaunt']      = { DisplayName = "AE Taunt Safety Check", Category = "Hate Tools", Tooltip = "Limit unintended pulls with AE Taunts. May result in non-use due to false positives.", Default = false, },

        --Defensees
        ['EmergencyStart']  = { DisplayName = "Emergency Start", Category = "Defenses", Tooltip = "Your HP % before we begin to use Emergency Rotations.", Default = 50, Min = 1, Max = 100, },
        ['EmergencyLockout'] = { DisplayName = "Emergency Only", Category = "Defenses", Tooltip = "Your HP % before DPS is cut in favor of Emergency Rotations.", Default = 35, Min = 1, Max = 100, },
        ['MantleCount']     = { DisplayName = "Mantle Count", Category = "Defenses", Tooltip = "Number of mobs around you before you use Mantle Disc.", Default = 4, Min = 1, Max = 10, },
        ['ArmorCount']   = { DisplayName = "Armor Count", Category = "Defenses", Tooltip = "Number of mobs around you before you use Armor Disc.", Default = 5, Min = 1, Max = 10, },
        ['HolyGuardCount'] = { DisplayName = "Holy Guard Count", Category = "Defenses", Tooltip = "Number of mobs around you before you use Holy Guard Disc.", Default = 5, Min = 1, Max = 10, },
        -- ['UnholyCount']     = { DisplayName = "Unholy Count", Category = "Defenses", Tooltip = "Number of mobs around you before you use Unholy Disc.", Default = 4, Min = 1, Max = 10, },
		 -- ['FlashHP']      = { DisplayName = "Use Shield Flash", Category = "Combat", Tooltip = "Your HP % before we use Shield Flash.", Default = 35, Min = 1, Max = 100, },

        --Equipment
        ['DoBandolier']     = { DisplayName = "Use Bandolier", Category = "Equipment", Tooltip = "Enable Swapping of items using the bandolier.", Default = false, },
        ['DoChestClick']    = { DisplayName = "Do Chest Click", Category = "Equipment", Tooltip = "Click your equipped chest.", Default = true, },
        ['DoCharmClick']    = { DisplayName = "Do Charm Click", Category = "Equipment", Tooltip = "Click your charm for Geomantra.", Default = true, },	
        ['SummonArrows'] = { DisplayName = "Summon Arrows", Category = "Equipment", Tooltip = "Enable Summon Arrows", Default = true, },

        --What is this for? Guessing for Shield Flash and never implemented. Currently covered by emergency rotations.
        --['FlashHP']         = { DisplayName = "Flash HP", Category = "Combat", Tooltip = "TODO: No Idea", Default = 35, Min = 1, Max = 100, },
    },
}

return _ClassConfig
