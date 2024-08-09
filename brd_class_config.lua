--- @type Mq
local mq                          = require('mq')
local RGMercUtils                 = require("utils.rgmercs_utils")
local RGMercsLogger               = require("utils.rgmercs_logger")

local Tooltips                    = {
    Epic             = 'Item: Casts Epic Weapon Ability',
    BardRunBuff      = "Song Line: Movement Speed Modifier",
    UseMelody        =
    "Enabling Use Melody will cause the bard to stick to a strict rotation similar to MQ2Twist rather than choosing each song dynamically based on current conditions",

    MainAriaSong     = "Song Line: Spell Damage Focus Haste v3 Modifier",
    WarMarchSong     = "Song Line: Melee Haste + DS + STR/ATK Increase",
    SufferingSong    = "Song Line Line: Melee Proc With Agro Reduction",
    SpitefulSong     = "Song Line: Increase AC Agro Increase Proc",
    SprySonataSong   = "Song Line: Magic Asorb AC Increase Mitigate Damage Shield Resist Spells",
    PotencySong      = "Song Line: Fire and Magic DoT Modifier",
    CrescendoSong    = "Song Line: Group v2 Increase Hit Points and Mana",
    ArcaneSong       = "Song Line: Caster Spell Proc",
    InsultSong       = "Song Line: Single Target DD",
    DichoSong        =
    "Song Line: Triggers Psalm of Empowerment and Psalm of Potential H/M/E Increase Melee and Caster Dam Increase",
    BardDPSAura      = "Aura Line: OverHaste, Melee/Caster DPS",
    BardRegenAura    = "Aura Line: HP/Mana Regen",
    AreaRegenSong  	 = "Song Line: AE HP/Mana Regen",
    GroupRegenSong 	 = "Song Line: Group HP/Mana Regen",
    CasterAriaSong   = "Song Line: Fire DD Damage Increase + Effiency",
    SlowSong         = "Song Line: Melee Attack Slow",
    AESlowSong       = "Song Line: PBAE Melee Attack Slow",
    AccelerandoSong  = "Song Line: Reduce Cast Time (Beneficial Only) Agro Reduction Modifier",
    RecklessSong     = "Song Line: Increase Crit Heal and Crit HoT",
    FateSong         = "Song Line: Cold DD Damage Increae + Effiency",
    -- Splitting DoT lines into individual dots because it is often useful to drop 1-2 dots for some other song on raids
    FireDotSong      = "Song Line: Fire Dots",
    DiseaseDotSong   = "Song Line: Disease Dots",
    PoisonDotSong    = "Song Line: Poison Dots",
    IceDotSong       = "Song Line: Ice Dots",

    CureSong         = "Song Line: Single Target Cure Poison Disease and Corruption",
    AllianceSong     = "Song Line: Mob Debuff Increase Insult Damage for other Bards",
    CharmSong        = "Song Line: Charm Mob",
    ReflexStrike     = "Disc Line: Attack 4 times to restore Mana to Group",
    ChordsAE         = "Song Line: PBAE Damage if Target isn't moving",
    LowAriaSong      = "Song Line: Warsong and BattleCry prior to combination of effects into Aria",
    AmpSong          = "Song Line: Increase Singing Skill",
    DispelSong       = "Song Line: Dispell",
    ResistSong       = "Song Line: Group Resist Increase",
    MezSong          = "Song Line: Single Target Mez",
    MezAESong        = "Song Line: PBAE Mez",
    Bellow           = "AA: Stuns Initial DD Damage and Increases Resist Modifier on Mob Concludes with DD",
    Spire            = "AA: Lowers Incoming Melee Damage and Increases Melee and Spell Damage",
    FuneralDirge     = "AA: DD and Increases Melee Damage to Target",
    FierceEye        =
    "AA: Increases Base Melee Damage and Increase Melee Crit Damage and Increase Proc Rate and Increase Crit Chance on Spells",
    QuickTime        = "AA: Hundred Hands Effect and Increase Melee Hit and Increase Atk",
    BladedSong       = "AA: Reverse Damage Shield",
    Jonthans         = "Song Line: Self-only Haste Melee Damage Modifier Melee Min Damage Modifier Proc Modifier",
}

local function generateSongList()
    local songCache = { CollapseGems = true, }
    local songCount = 0

    --------------------------------------------------------------------------------------
	local function addSong(songToAdd)
        songCount = songCount + 1
        table.insert(songCache, {
            gem = songCount,
            spells = {
                { name = songToAdd, cond = function(self) return true end, },
            },
        })
    end

    local function ConditionallyAddSong(settingToCheck, songToAdd)
        if songCount >= mq.TLO.Me.NumGems() then return end
        if RGMercUtils.GetSetting(settingToCheck) then
            addSong(songToAdd)
        end
    end

    local function AddCriticalSongs()
        ConditionallyAddSong("UseAEAAMez", "MezAESong")
        ConditionallyAddSong("MezOn", "MezSong")
        ConditionallyAddSong("DoSlow", "SlowSong")
        ConditionallyAddSong("DoAESlow", "AESlowSong")
        if not RGMercUtils.GetSetting('UseAASelo') then
            ConditionallyAddSong("DoRunSpeed", "BardRunBuff")
        end
        -- TODO maybe someday
        --ConditionallyAddSong("DoCharm", "CharmSong")
        ConditionallyAddSong("DoDispel", "DispelSong")
    end

    local function AddMainGroupDPSSongs()
        addSong('WarMarchSong')
        addSong('MainAriaSong')
        ConditionallyAddSong('UseProgressive', 'DichoSong')
    end

    local function AddSelfDPSSongs()
        ConditionallyAddSong("UseAlliance", "AllianceSong")
        ConditionallyAddSong("UseInsult", 'InsultSong')
        ConditionallyAddSong("UseFireDots", "FireDotSong")
        ConditionallyAddSong("UseIceDots", "IceDotSong")
        ConditionallyAddSong("UseDiseaseDots", "DiseaseDotSong")
        ConditionallyAddSong("UsePoisonDots", "PoisonDotSong")
    end

    local function AddMeleeDPSSongs()
        ConditionallyAddSong("UseSuffering", "SufferingSong")
    end

    local function AddTankSongs()
        ConditionallyAddSong("UseSpiteful", "SpitefulSong")
        ConditionallyAddSong("UseSpry", "SprySonataSong")
        ConditionallyAddSong("UseResist", "ResistSong")
    end

    local function AddHealerSongs()
        ConditionallyAddSong("UseReckless", "RecklessSong")
    end

    local function AddCasterDPSSongs()
        ConditionallyAddSong("UseArcane", "ArcaneSong")
        ConditionallyAddSong("UseFireDDMod", "CasterAriaSong")
        ConditionallyAddSong("UseFate", "FateSong")
        ConditionallyAddSong("UsePotency", "PotencySong")
    end

    local function AddRegenSongs()
        ConditionallyAddSong("UseAmp", "AmpSong")
        ConditionallyAddSong("UseCrescendo", "CrescendoSong")
        if RGMercUtils.GetSetting('RegenSong') == 1 then addSong("GroupRegenSong")
        elseif RGMercUtils.GetSetting('RegenSong') == 2 then addSong("AreaRegenSong")
        end
    end
    -- local function AddEnduringBreathSongs()
        -- ConditionallyAddSong("UseEnduringBreath", "EnduringBreathSong")
    -- end
    -- local function AddBardAura()
		-- if RGMercUtils.GetSetting('UseAura') == 1 then addSong("BardDPSAura")
        -- elseif RGMercUtils.GetSetting('UseAura') == 2 then addSong("BardRegenAura")
        -- end
    -- end
    -----------------------------------------------------------------------------------------

    AddCriticalSongs()
   -- AddEnduringBreathSongs()
    if RGMercUtils.IsModeActive("General") then
        AddMainGroupDPSSongs()
        AddSelfDPSSongs()
        AddRegenSongs()
        AddMeleeDPSSongs()
        AddCasterDPSSongs()
        AddHealerSongs()
        AddTankSongs()
    elseif RGMercUtils.IsModeActive("Tank") then -- Tank
        AddTankSongs()
        AddMainGroupDPSSongs()
        AddHealerSongs()
        AddMeleeDPSSongs()
        AddRegenSongs()
        AddSelfDPSSongs()
        AddCasterDPSSongs()
    elseif RGMercUtils.IsModeActive("Caster") then
        AddMainGroupDPSSongs()
        AddCasterDPSSongs()
        AddRegenSongs()
        AddSelfDPSSongs()
        AddMeleeDPSSongs()
        AddHealerSongs()
        AddTankSongs()
    elseif RGMercUtils.IsModeActive("Healer") then -- Healer
        AddHealerSongs()
        AddMainGroupDPSSongs()
        AddRegenSongs()
        AddSelfDPSSongs()
        AddCasterDPSSongs()
        AddTankSongs()
        AddMeleeDPSSongs()
    else
        RGMercsLogger.log_warn("Bard Mode not found!  Adding DPS songs, but you should select a mode.")
        AddMainGroupDPSSongs()
        AddSelfDPSSongs()
        AddRegenSongs()
        AddMeleeDPSSongs()
        AddCasterDPSSongs()
    end
    return songCache
end

--- Checks target for duration remaining on dot songs
local function getDetSongDuration(songSpell)
    local duration = mq.TLO.Target.FindBuff("name " .. songSpell.Name()).Duration.TotalSeconds() or 0
	RGMercsLogger.log_debug("getDetSongDuration() Current duration for %s : %d", songSpell, duration)
    --BL.info("Det song duration is: ", duration)
    return duration
end

local _ClassConfig = {
    _version          = "0.3",
    _author           = "Derple, Tiddliestix, SonicZentropy, Algar",
	['FullConfig'] = true,
    ['Modes']         = {
        'General',
        'Tank',
        'Caster',
        'Healer',
    },
    ['ModeChecks']    = {
        IsMezzing = function() return true end,
		--todo: add iscuring with cure option checked and curespell memmed as conditions
    },
    ['ItemSets']      = {
        ['Epic'] = {
            "Blade of Vesagran",
            "Prismatic Dragon Blade",
        },
        ['Dreadstone'] = {
            "Possessed Dreadstone Minstrel's Rapier",
        },
        ['SymphonyOfBattle'] = {
            "Rapier of Somber Notes",
            "Songblade of the Eternal",
        },
    },
    ['AbilitySets']   = {
        ['BardRunBuff'] = {
            -- Bard RunSpeed
            "Selo's Accelerato",
            -- Song of travel has been removed due to causing Bugs with Invis and rotation.
            -- [] = ["Selo's Song of Travel"],
            "Selo's Accelerating Chorus",
            "Selo's Accelerando",
        },
        ['MainAriaSong'] = {
            -- MainAriaSong - Level Ranges 45 - 111
            "Aria of Tenisbre", -- 125
            "Aria of Pli Xin Liako",
            "Aria of Margidor",
            "Aria of Begalru",
            "Aria of Maetanrus",
            "Aria of Va'Ker",
            "Aria of the Orator",
            "Aria of the Composer",
            "Aria of the Poet",
            "Performer's Psalm of Pyrotechnics",
            "Ancient: Call of Power",
            "Aria of the Artist",
            "Yelhun's Mystic Call",
            "Ancient: Call of Power",
            "Rizlona's Call of Flame",
            "Rizlona's Fire",
            "Rizlona's Embers",
            "Eriki's Psalm of Power",
        },
        ['SufferingSong'] = {
            -- SufferingSong - Level Range 89 - 114
            "Kanghammer's Song of Suffering", -- 125
            "Shojralen's Song of Suffering",
            "Omorden's Song of Suffering",
            "Travenro's Song of Suffering",
            "Fjilnauk's Song of Suffering",
            "Kaficus' Song of Suffering",
            "Hykast's Song of Suffering",
            "Noira's Song of Suffering",
        },
        ['SprySonataSong'] = {
            -- Adding misc songs below level 77 to fill in first spell gem
            -- [] = 'Psalm of Veeshan",
            -- [] = "Nillipus' March of the Wee",
            -- [] = "Verses of Victory",
            -- [] = "Psalm of Mystic Shielding",
            -- [] = "Psalm of Cooling",
            -- [] = "Psalm of Vitality",
            -- [] = "Psalm of Warmth",
            -- [] = "Guardian Rhythms",
            -- [] = Purifying Rhythms",
            -- [] = "Elemental Rhythms",
            -- [] = "Jonthan's Whistling Warsong",
            -- [] = "Chant of Battle",
            -- SprySonataSong - Level Range 77 - 118
            "Dhakka's Spry Sonata", -- 125, really bad song, nobody should ever use this
            "Xetheg's Spry Sonata",
            "Kellek's Spry Sonata",
            "Kluzen's Spry Sonata",
            "Doben's Spry Sonata",
            "Terasal's Spry Sonata",
            "Sionachie's Spry Sonata",
            "Coldcrow's Spry Sonata",
        },
        ['CrescendoSong'] = {
            -- CrescendoSong - Level Range 75 - 114
            "Regar's Lively Crescendo", -- 125
            "Zelinstein's Lively Crescendo",
            "Zburator's Lively Crescendo",
            "Jembel's Lively Crescendo",
            "Silisia's Lively Crescendo",
            "Motlak's Lively Crescendo",
            "Kolain's Lively Crescendo",
            "Lyssa's Lively Crescendo",
            "Gruber's Lively Crescendo",
            "Kaerra's Spirited Crescendo",
            "Veshma's Lively Crescendo",
        },
        ['ArcaneSong'] = {
            -- ArcaneSong - Level Range 70 - 115
            "Arcane Rhythm", -- 125
            "Arcane Harmony",
            "Arcane Symphony",
            "Arcane Ballad",
            "Arcane Melody",
            "Arcane Hymn",
            "Arcane Address",
            "Arcane Chorus",
            "Arcane Arietta",
            "Arcane Anthem",
            "Arcane Aria",
        },
        ['InsultSong'] = {
            "Eoreg's Insult", -- 125
            "Nord's Disdain",
            "Sogran's Insult",
            "Yelinak's Insult",
            "Omorden's Insult",
            "Sathir's Insult",
            "Travenro's Insult",
            "Tsaph's Insult",
            "Fjilnauk's Insult",
            "Kaficus' Insult",
            "Garath's Insult",
            "Hykast's Insult",
            "Venimor's Insult",
            -- Below Level 85 This line turns into "bellow" instead of "Insult"
            "Bellow of Chaos",
            "Brusco's Bombastic Bellow",
            "Brusco's Boastful Bellow",
        },
        ['DichoSong'] = {
            -- DichoSong Level Range - 101 - 106
            "Ecliptic Psalm",
            "Composite Psalm",
            "Dissident Psalm",
            "Dichotomic Psalm",
        },
        ['BardDPSAura'] = {
            -- BardDPSAura - Level Ranges 55 - 115
            "Aura of Tenisbre", -- 125
            "Aura of Pli Xin Liako",
            "Aura of Margidor",
            "Aura of Begalru",
            "Aura of Maetanrus",
            "Aura of Va'Ker",
            "Aura of the Orator",
            "Aura of the Composer",
            "Aura of the Poet",
            "Aura of the Artist",
            "Aura of the Muse",
            "Aura of Insight",
        },
        ['BardRegenAura'] = {
            "Aura of Shalowain",
            "Aura of Shei Vinitras",
            "Aura of Vhal`Sera",
            "Aura of Xigam",
            "Aura of Sionachie",
            "Aura of Salarra",
            "Aura of Lunanyn",
            "Aura of Renewal",
            "Aura of Rodcet",
        },
        ['GroupRegenSong'] = {
			--Note level 77 pulse only offers a heal% buff
            "Pulse of August", -- 125
            "Pulse of Nikolas",
            "Pulse of Vhal`Sera",
            "Pulse of Xigam",
            "Pulse of Sionachie",
            "Pulse of Salarra",
            "Pulse of Lunanyn",
            "Pulse of Renewal", 		--86 start hp/mana/endurance
			"Cantata of Rodcet",        -- 81
            "Cantata of Restoration",   -- 76
            "Erollisi's Cantata",       -- 71
            "Cantata of Life",          -- 67
            "Wind of Marr",             -- 62
            "Cantata of Replenishment", -- 55
            "Cantata of Soothing",      -- 34 start hp/mana
			"Cassindra's Chant of Clarity", --20, mana only
            "Hymn of Restoration",      -- 7, hp only
            
        },
        ['AreaRegenSong'] = {
            -- ChorusRegenSong - Level Range 58 - 113
            "Chorus of Shalowain",      -- 123
            "Chorus of Shei Vinitras",  -- 118
            "Chorus of Vhal`Sera",      -- 113
            "Chorus of Xigam",          -- 108
            "Chorus of Sionachie",      -- 103
            "Chorus of Salarra",        -- 98
            "Chorus of Lunanyn",        -- 93
            "Chorus of Renewal",        -- 88
            "Chorus of Rodcet",         -- 83
            "Chorus of Restoration",    -- 78
            "Erollisi's Chorus",        -- 73
            "Chorus of Life",           -- 69
            "Chorus of Marr",           -- 64
            "Ancient: Lcea's Lament",   -- 60
            "Chorus of Replenishment",  -- 58
        },
        ['WarMarchSong'] = {
            -- WarMarchSong Level Range 10 - 114
            "War March of Nokk", -- 125
            "War March of Centien Xi Va Xakra",
            "War March of Radiwol",
            "War March of Dekloaz",
            "War March of Jocelyn",
            "War March of Protan",
            "War March of Illdaera",
            "War March of Dagda",
            "War March of Brekt",
            "War March of Meldrath",
            "War March of Muram",
            "War March of the Mastruq",
            "Warsong of Zek",
            "McVaxius' Rousing Rondo",
            "Vilia's Chorus of Celerity",
            "Verses of Victory",
            "McVaxius' Berserker Crescendo",
            "Vilia's Verses of Celerity",
            "Anthem de Arms",


        },
        ['CasterAriaSong'] = {
            -- CasterAriaSong - Level Range 72 - 113
            "Flariton's Aria", -- 125
            "Constance's Aria",
            "Sontalak's Aria",
            "Qunard's Aria",
            "Nilsara's Aria",
            "Gosik's Aria",
            "Daevan's Aria",
            "Sotor's Aria",
            "Talendor's Aria",
            "Performer's Explosive Aria",
            "Weshlu's Chillsong Aria",
        },
        ['SlowSong'] = {
            -- SlowSong - We only get 1 single target slow
            "Requiem of Time",
        },
        ['AESlowSong'] = {
            -- AESlowSong - Level Range 20 - 114 (Single target works better)
            "Zinnia's Melodic Binding", -- 125
            "Radiwol's Melodic Binding",
            "Dekloaz's Melodic Binding",
            "Protan's Melodic Binding",
            "Largo's Melodic Binding",
        },
        ['AccelerandoSong'] = {
            -- AccelerandoSong - Level Range 88 - 113 **
            "Appeasing Accelerando", -- 125
            "Satisfying Accelerando",
            "Placating Accelerando",
            "Atoning Accelerando",
            "Allaying Accelerando",
            "Ameliorating Accelerando",
            "Assuaging Accelerando",
            "Alleviating Accelerando",
        },
        ['SpitefulSong'] = {
            -- SpitefulSong - Level Range 90 -
            "Tatalros' Spiteful Lyric", -- 125
            "Von Deek's Spiteful Lyric",
            "Omorden's Spiteful Lyric",
            "Travenro's Spiteful Lyric",
            "Fjilnauk's Spiteful Lyric",
            "Kaficus' Spiteful Lyric",
            "Hykast's Spiteful Lyric",
            "Lyrin's Spiteful Lyric",
        },
        ['RecklessSong'] = {
            -- RecklessSong - Level Range 93 - 113 **
            "Grayleaf's Reckless Renewal", -- 125
            "Kai's Reckless Renewal",
            "Reivaj's Reckless Renewal",
            "Rigelon's Reckless Renewal",
            "Rytan's Reckless Renewal",
            "Ruaabri's Reckless Renewal",
            "Ryken's Reckless Renewal",
        },
        ['FateSong'] = {
            -- Fatesong - Level Range 77 - 112 **
            "Fatesong of Zoraxmen", -- 125
            "Fatesong of Lucca",
            "Fatesong of Radiwol",
            "Fatesong of Dekloaz",
            "Fatesong of Jocelyn",
            "Fatesong of Protan",
            "Fatesong of Illdaera",
            "Fatesong of Fergar",
            "Fatesong of the Gelidran",
            "Garadell's Fatesong",
        },

        ['PotencySong'] = {
            -- Fire & Magic Dots song
            "Tatalros' Psalm of Potency", -- 125
            "Fyrthek Fior's Psalm of Potency",
            "Velketor's Psalm of Potency",
            "Akett's Psalm of Potency",
            "Horthin's Psalm of Potency",
            "Siavonn's Psalm of Potency",
            "Wasinai's Psalm of Potency",
            "Lyrin's Psalm of Potency",
            "Druzzil's Psalm of Potency",
            "Erradien's Psalm of Potency",
        },
        ['FireDotSong'] = {
            "Kindleheart's Chant of Flame", -- 125
            "Shak Dathor's Chant of Flame",
            "Sontalak's Chant of Flame",
            "Qunard's Chant of Flame",
            "Nilsara's Chant of Flame",
            "Gosik's Chant of Flame",
            "Daevan's Chant of Flame",
            "Sotor's Chant of Flame",
            "Talendor's Chant of Flame",
            "Tjudawos' Chant of Flame",
            "Vulka's Chant of Flame",
            "Tuyen's Chant of Fire",
            "Tuyen's Chant of Flame",

            -- Misc Dot -- Or Minsc Dot (HEY HEY BOO BOO!)
            "Ancient: Chaos Chant",
            "Angstlich's Assonance",
            "Fufil's Diminishing Dirge",
            "Fufil's Curtailing Chant",
        },
        ['IceDotSong'] = {

            -- Ice Dot
            "Swarn's Chant of Frost",
            "Sylra Fris' Chant of Frost",
            "Yelinak's Chant of Frost",
            "Ekron's Chant of Frost",
            "Kirchen's Chant of Frost",
            "Edoth's Chant of Frost",
            "Kalbrok's Chant of Frost",
            "Fergar's Chant of Frost",
            "Gorenaire's Chant of Frost",
            "Zeixshi-Kar's Chant of Frost",
            "Vulka's Chant of Frost",
            "Tuyen's Chant of Ice",
            "Tuyen's Chant of Frost",



            -- Misc Dot -- Or Minsc Dot (HEY HEY BOO BOO!)
            "Ancient: Chaos Chant",
            "Angstlich's Assonance",
            "Fufil's Diminishing Dirge",
            "Fufil's Curtailing Chant",
        },
        ['PoisonDotSong'] = {
            -- DotSongs - Level Range 30 - 115


            "Marsin's Chant of Poison",
            "Cruor's Chant of Poison",
            "Malvus's Chant of Poison",
            "Nexona's Chant of Poison",
            "Serisaria's Chant of Poison",
            "Slaunk's Chant of Poison",
            "Hiqork's Chant of Poison",
            "Spinechiller's Chant of Poison",
            "Severilous' Chant of Poison",
            "Kildrukaun's Chant of Poison",
            "Vulka's Chant of Poison",
            "Tuyen's Chant of Venom",
            "Tuyen's Chant of Poison",



            -- Misc Dot -- Or Minsc Dot (HEY HEY BOO BOO!)
            "Ancient: Chaos Chant",
            "Angstlich's Assonance",
            "Fufil's Diminishing Dirge",
            "Fufil's Curtailing Chant",
        },
        ['DiseaseDotSong'] = {
            -- DotSongs - Level Range 30 - 115

            "Goremand's Chant of Disease", -- 125
            "Coagulus' Chant of Disease",
            "Zlexak's Chant of Disease",
            "Hoshkar's Chant of Disease",
            "Horthin's Chant of Disease",
            "Siavonn's Chant of Disease",
            "Wasinai's Chant of Disease",
            "Shiverback's Chant of Disease",
            "Trakanon's Chant of Disease",
            "Vyskudra's Chant of Disease",
            "Vulka's Chant of Disease",
            "Tuyen's Chant of the Plague",
            "Tuyen's Chant of Disease",

            -- Misc Dot -- Or Minsc Dot (HEY HEY BOO BOO!)
            "Ancient: Chaos Chant",
            "Angstlich's Assonance",
            "Fufil's Diminishing Dirge",
            "Fufil's Curtailing Chant",
        },
        ['CureSong'] = {
            -- Multiple Missing --
            "Aria of Absolution",
        },
        ['AllianceSong'] = {
            "Conjunction of Sticks and Stones",
            "Alliance of Sticks and Stones",
            "Covenant of Sticks and Stones",
            "Coalition of Sticks and Stones",
        },
        ['CharmSong'] = {
            "Voice of Suja", -- 125
            "Omiyad's Demand",
            "Voice of the Diabo",
            "Silisia's Demand",
            "Dawnbreeze's Demand",
            "Desirae's Demand",
            -- Low Level Aria Song - before Combination of Effects Under Level 68
            "Battlecry of the Vah Shir",
            "Warsong of the Vah Shir",
        },
        ['ReflexStrike'] = {
            -- Bard ReflexStrike - Restores mana to group
            "Reflexive Retort",
            "Reflexive Rejoinder",
            "Reflexive Rebuttal",
        },
        ['ChordsAE'] = {
            "Chords of Dissonance",
        },
        ['LowAriaSong'] = {
            -- Low Level Aria Song - before Combination of Effects Under Level 68
            "Battlecry of the Vah Shir",
            "Warsong of the Vah Shir",
        },
        ['AmpSong'] = {
            "Amplification",
        },
        ['DispelSong'] = {
            -- Dispel Song - For pulling to avoid Summons
            "Syvelian's Anti-Magic Aria",
            "Druzzil's Disillusionment",
        },
        ['ResistSong'] = {
            -- Resists Song
            "Psalm of Cooling",
            "Psalm of Purity",
            "Psalm of Warmth",
            "Psalm of Vitality",
            "Psalm of Veeshan",
            "Psalm of the Forsaken",
            "Second Psalm of Veeshan",
            "Psalm of the Restless",
            "Psalm of the Pious",
        },
        ['MezSong'] = {
            -- MezSong - Level Range 15 - 114
            "Slumber of Suja", -- 125
            "Slumber of the Diabo",
            -- [] = "Lullaby of Nightfall",
            -- [] = "Lullaby of Zburator",
            "Slumber of Zburator",
            "Slumber of Jembel",
            -- [] = "Lullaby of Jembel",
            "Slumber of Silisia",
            -- [] = "Lullaby of Silisia",
            "Slumber of Motlak",
            -- [] = "Lullaby of the Forsaken",
            "Slumber of Kolain",
            -- [] = "Lullaby of the Forlorn",
            "Slumber of Sionachie",
            -- [] = "Lullaby of the Lost",
            "Slumber of the Mindshear",
            "Serenity of Oceangreen",
            "Amber's Last Lullaby",
            "Queen Eletyl's Screech",
            "Command of Queen Veneneu",
            "Aelfric's Last Lullaby",
            "Vulka's Lullaby",
            "Creeping Dreams",
            "Luvwen's Lullaby",
            "Lullaby of Morell",
            "Dreams of Terris",
            "Dreams of Thule",
            "Dreams of Ayonae",
            "Song of Twilight",
            "Sionachie's Dreams",
            "Crission's Pixie Strike",
            "Kelin's Lucid Lullaby",
        },
        ['MezAESong'] = {
            -- MezAESong - Level Range 85 - 115 **
            "Wave of Stupor", -- 125
            "Wave of Nocturn",
            "Wave of Sleep",
            "Wave of Somnolence",
            "Wave of Torpor",
            "Wave of Quietude",
            "Wave of the Conductor",
            "Wave of Dreams",
            "Wave of Slumber",
        },
    },
	['HelperFunctions']   = {
		CheckSongStateUse = function(self, config)
		local usestate = RGMercUtils.GetSetting(config)
		if (RGMercUtils.GetXTHaterCount() == 0 and usestate > 1) or (RGMercUtils.GetXTHaterCount() >= 1 and usestate < 3) then return true end
		return false
		end,
	},
    ['RotationOrder'] = {
		{
            name = 'Melody',
			state = 1,
            steps = 1,
            targetId = function(self) return { mq.TLO.Me.ID(), } end,
            cond = function(self, combat_state)
				return not RGMercUtils.Feigning() and not (combat_state == "Downtime" and mq.TLO.Me.Invis())
            end,
        },
        {
            name = 'Downtime',
			state = 1,
            steps = 1,
            targetId = function(self) return { mq.TLO.Me.ID(), } end,
            cond = function(self, combat_state)
                return combat_state == "Downtime" and not (RGMercUtils.Feigning() or mq.TLO.Me.Invis())
            end,
        },
        -- {
            -- name = 'Debuff',
            -- state = 1,
            -- steps = 1,
            -- targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            -- cond = function(self, combat_state)
                -- return combat_state == "Combat" and not RGMercUtils.Feigning()
            -- end,
        -- },
		
		{
            name = 'DPS',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and not RGMercUtils.Feigning()
            end,
        },
        {
            name = 'Burn',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and
                    RGMercUtils.BurnCheck() and not RGMercUtils.Feigning()
            end,
        },
    },
    ['Rotations']     = {
        ['Burn'] = {
            {
                name = "Epic",
                type = "Item",
                cond = function(self)
                    return RGMercUtils.GetSetting('UseEpic') == 2 and mq.TLO.FindItemCount(itemName)() ~= 0 and mq.TLO.FindItem(itemName).TimerReady() == 0
                end,
            },
            {
                name = "Fierce Eye",
                type = "AA",
                cond = function(self, aaName)
                    return
                        RGMercUtils.GetSetting('UseFierceEye') == 2
                        and RGMercUtils.AAReady(aaName)
                end,
            },
            {
                name = "Quick Time",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
            {
                name = "Funeral Dirge",
                type = "AA",
                cond = function(self, aaName)
                    return
                        RGMercUtils.GetSetting('UseFuneralDirge')
                        and RGMercUtils.AAReady(aaName)
                end,
            },
            {
                name = "Spire of the Minstrels",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
            {
                name = "Bladed Song",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
            {
                name = "Thousand Blades",
                type = "Ability",
                cond = function(self, abilityName)
                    return RGMercUtils.AbilityReady(abilityName)
                end,
            },
            {
                name = "Flurry of Notes",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
            {
                name = "Dance of Blades",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName)
                end,
            },
			{
                name = mq.TLO.Me.Inventory("Chest").Name(),
                type = "Item",
                active_cond = function(self)
                    local item = mq.TLO.Me.Inventory("Chest")
                    return item() and mq.TLO.Me.Song(item.Spell.RankName.Name())() ~= nil
                end,
                cond = function(self)
                    local item = mq.TLO.Me.Inventory("Chest")
                    return RGMercUtils.GetSetting('DoChestClick') and item() and item.Spell.Stacks() and item.TimerReady() == 0
                end,
            },
            {
                name = "Cacophony",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.NPCAAReady(aaName, targetId)
                end,
            },
            {
                name = "Frenzied Kicks",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.NPCAAReady(aaName, targetId)
                end,
            },
			{
                name = "Boastful Bellow",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.GetSetting('UseBellow') and RGMercUtils.NPCAAReady(aaName, targetId) and RGMercUtils.SelfBuffAACheck(aaName)
						and mq.TLO.Me.PctEndurance() > RGMercUtils.GetSetting('BellowPct')
                end,
            },
        },
        ['Debuff'] = {
            {
                name = "MezAESong",
                type = "Song",
                cond = function(self, songSpell)
                    local setting = RGMercUtils.GetSetting('UseAEAAMez')
                    local memmed = RGMercUtils.SongMemed(songSpell)
                    local spellReady = mq.TLO.Me.SpellReady(songSpell)()
                    local aeMezCt = RGMercUtils.GetSetting("MezAECount")

                    local res = setting and memmed and spellReady
                        and RGMercUtils.GetXTHaterCount() >= aeMezCt

                    return res
                end,
            },
            {
                name = "AESlowSong",
                type = "Song",
                cond = function(self, songSpell)
                    return RGMercUtils.GetSetting("DoAESlow")
                        and RGMercUtils.DetSpellCheck(songSpell)
                        and RGMercUtils.GetXTHaterCount() > 2
                        and not mq.TLO.Target.Slowed()
                end,
            },
            {
                name = "SlowSong",
                type = "Song",
                cond = function(self, songSpell)
                    return RGMercUtils.GetSetting("DoSlow")
                        and RGMercUtils.DetSpellCheck(songSpell)
                        and not mq.TLO.Target.Slowed()
                end,
            },
            {
                name = "DispelSong",
                type = "Song",
                cond = function(self, songSpell)
                    return RGMercUtils.GetSetting('DoDispel') and mq.TLO.Target.Beneficial()
                end,
            },

        },
        ['Heal'] = {
        },
        ['DPS'] = {
            -- This makes the full rotation execute each round,
            --so it'll never pick up and resume wherever it left off the previous cast
            --doFullRotation = true,
            -- Kludge that addresses bards not attempting to start attacking until after a song completes
            -- Uncomment if you'd like to occasionally start attacking earlier than normal
            --[[{
                name = "Force Attack",
                type = "AA",
                cond = function(self, itemName)
                    local mytar = mq.TLO.Target
                    if not mq.TLO.Me.Combat() and mytar() and mytar.Distance() < 50 then
                        RGMercUtils.DoCmd("/keypress AUTOPRIM")
                    end
                end,
            },]]
            -- {
                -- name = "Dreadstone",
                -- type = "Item",
                -- cond = function(self, itemName)
                    -- -- This item is instant cast for free with almost no CD, just mash it forever when it's available
                    -- return mq.TLO.FindItemCount(itemName)() ~= 0 and mq.TLO.FindItem(itemName).TimerReady() == 0
                -- end,
            -- },
			{
                name = "Epic",
                type = "Item",
                cond = function(self, itemName)
                    return RGMercUtils.GetSetting('UseEpic') == 3 and mq.TLO.FindItemCount(itemName)() ~= 0 and mq.TLO.FindItem(itemName).TimerReady() == 0
                end,
            },
            {
                name = "Fierce Eye",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.GetSetting('UseFierceEye') == 3
                        and RGMercUtils.AAReady(aaName)
                end,
            },
			{
                name = "ReflexStrike",
                type = "Disc",
                tooltip = Tooltips.ReflexStrike,
                cond = function(self, discSpell)
					local pct = RGMercUtils.GetSetting('ManaManagePct')
                    return RGMercUtils.NPCDiscReady(discSpell) and (mq.TLO.Group.LowMana(pct)() or -1) > RGMercUtils.GetSetting('ManaManageCt')
                end,
            },
            {
                name = "Boastful Bellow",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.GetSetting('UseBellow')
                        and not RGMercUtils.SongActiveByName("Boastful Bellow")
                        and RGMercUtils.AAReady(aaName)
                        and mq.TLO.Me.PctEndurance() > 40 -- Bellow DEVOURS endurance
                end,
            },
			{
                name = "DichoSong",
                type = "Song",
                cond = function(self, songSpell)
                    return RGMercUtils.GetSetting('UseProgressive') and RGMercUtils.SongMemed(songSpell) and mq.TLO.Me.PctEndurance() > 25
						and RGMercUtils.BuffActiveByID(mq.TLO.Me.AltAbility("Quick Time").Spell.ID()) --and mq.TLO.Me.Song(mq.TLO.Me.AltAbility("Quick Time").Spell.Name)()
                end,
            },
			{
                name = "InsultSong",
                type = "Song",
                cond = function(self, songSpell)
					local gemTimer = mq.TLO.Me.GemTimer(songSpell.RankName.Name())() or 0
                    return RGMercUtils.SongMemed(songSpell) and RGMercUtils.GetSetting('UseInsult')
                        and gemtimer == 0
               
                        and mq.TLO.Me.PctMana() > 20
                end,
            },
			{
                name = "FireDotSong",
                type = "Song",
                cond = function(self, songSpell)
                    return RGMercUtils.SongMemed(songSpell) and RGMercUtils.GetSetting('UseFireDots') and
						-- If dot is about to wear off, recast
                        getDetSongDuration(songSpell) <= 3
                        --RGMercUtils.DetSpellCheck(songSpell)
                end,
            },
            {
                name = "IceDotSong",
                type = "Song",
                cond = function(self, songSpell)
                    return RGMercUtils.SongMemed(songSpell) and RGMercUtils.GetSetting('UseIceDots') and
					-- If dot is about to wear off, recast
                        getDetSongDuration(songSpell) <= 3
                        --RGMercUtils.DetSpellCheck(songSpell)
                end,
            },
            {
                name = "PoisonDotSong",
                type = "Song",
                cond = function(self, songSpell)
                    return RGMercUtils.SongMemed(songSpell) and RGMercUtils.GetSetting('UsePoisonDots') and
                        -- If dot is about to wear off, recast
                        getDetSongDuration(songSpell) <= 3
                end,
            },
            {
                name = "DiseaseDotSong",
                type = "Song",
                cond = function(self, songSpell)
                    return RGMercUtils.SongMemed(songSpell) and RGMercUtils.GetSetting('UseDiseaseDots') and
                        -- If dot is about to wear off, recast
                        getDetSongDuration(songSpell) <= 3
                end,
            },
			-- {
                -- name = "InsultSong",
                -- type = "Song",
                -- cond = function(self, songSpell)
                    -- return RGMercUtils.SongMemed(songSpell) and RGMercUtils.GetSetting('UseInsult')
                        -- and mq.TLO.Me.SpellReady(self.ResolvedActionMap['InsultSong'] or "")()
                        -- -- If dot is about to wear off, recast
                        -- and getDetSongDuration(songSpell) <= 4
                        -- and mq.TLO.Me.PctMana() > 20
                -- end,
            -- },
        },
		['Melody'] = { doFullRotation = true,
			{
                name = "MainAriaSong",
                type = "Song",
                targetId = function(self) return { mq.TLO.Me.ID(), } end,
                cond = function(self, songSpell, combat_state)
				 return RGMercUtils.BuffSong(songSpell)
                end,
            },
            {
                name = "WarMarchSong",
                type = "Song",
                targetId = function(self) return { mq.TLO.Me.ID(), } end,
                cond = function(self, songSpell, combat_state)
				 return RGMercUtils.BuffSong(songSpell)
                end,
            },
			{
                name = "ArcaneSong",
                type = "Song",
                cond = function(self, songSpell, combat_state)
				 return RGMercUtils.BuffSong(songSpell)
                end,
            },
			{
                name = "CrescendoSong",
                type = "Song",
                targetId = function(self) return { mq.TLO.Me.ID(), } end,
                cond = function(self, songSpell)
                    local gemTimer = mq.TLO.Me.GemTimer(songSpell.RankName.Name())() or 0
					local pct = RGMercUtils.GetSetting('ManaManagePct')
                    return RGMercUtils.GetSetting('UseCrescendo') and RGMercUtils.SongMemed(songSpell) and gemTimer == 0 and
						(mq.TLO.Group.LowMana(pct)() or -1) > RGMercUtils.GetSetting('ManaManageCt')
                end,
            },
			{
                name = "GroupRegenSong",
                type = "Song",
                targetId = function(self) return { mq.TLO.Me.ID(), } end,
                cond = function(self, songSpell, combat_state)
					local pct = RGMercUtils.GetSetting('ManaManagePct')
                    return RGMercUtils.BuffSong(songSpell) and not (mq.TLO.Me.Combat() and (mq.TLO.Group.LowMana(pct)() or -1) < RGMercUtils.GetSetting('ManaManageCt'))
                end,
            },
			{
                name = "SufferingSong",
                type = "Song",
                cond = function(self, songSpell)
					return self.ClassConfig.HelperFunctions.CheckSongStateUse(self, "SufferingState") and RGMercUtils.BuffSong(songSpell)
				end,
            },
		},
        ['Downtime'] = {
            {
               name = "BardDPSAura",
               type = "Song",
               cond = function(self, songSpell)
                   return not RGMercUtils.AuraActiveByName(songSpell.BaseName()) and RGMercUtils.GetSetting('UseAura') == 1
               end,
            },
            {
               name = "BardRegenAura",
               type = "Song",
               cond = function(self, songSpell)
                   return not RGMercUtils.AuraActiveByName(songSpell.BaseName()) and RGMercUtils.GetSetting('UseAura') == 2
               end,
            },
            -- {
                -- name = "SymphonyOfBattle",
                -- type = "Item",
                -- targetId = function(self) return { mq.TLO.Me.ID(), } end,
                -- cond = function(self, _)
                    -- return RGMercUtils.SelfBuffCheck("Symphony of Battle") and mq.TLO.FindItemCount(itemName)() ~= 0 and mq.TLO.FindItem(itemName).TimerReady() == 0
                -- end,
            -- },
			{
                name = "Rallying Solo",
                type = "AA",
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and (mq.TLO.Me.PctEndurance() < 30 or mq.TLO.Me.PctMana() < 30)
                end,
            },
            -- {
                -- name = "AccelerandoSong",
                -- type = "Song",
                -- targetId = function(self) return { mq.TLO.Me.ID(), } end,
                -- cond = function(self, songSpell)
                    -- return RGMercUtils.BuffSong(songSpell)
                -- end,
            -- },
            -- {
                -- name = "BardRunBuff",
                -- type = "Song",
                -- targetId = function(self) return { mq.TLO.Me.ID(), } end,
                -- cond = function(self, songSpell)
                    -- return RGMercUtils.BuffSong(songSpell) and
                        -- not RGMercUtils.GetSetting('UseAASelo') and
                        -- RGMercUtils.GetSetting('DoRunSpeed')
                -- end,
            -- },
            {
                name = "Selo's Sonata",
                type = "AA",
                targetId = function(self) return { mq.TLO.Me.ID(), } end,
                cond = function(self, aaName)
                    return RGMercUtils.AAReady(aaName) and
                        not RGMercUtils.SelfBuffCheck("Selo's Accelerato") and
                        RGMercUtils.GetSetting('UseAASelo') and
                        RGMercUtils.GetSetting('DoRunSpeed')
                end,
            },
           
        },
    },
    ['PullAbilities'] = {
        {
            id = 'Sonic Disturbance',
            Type = "AA",
            DisplayName = 'Sonic Disturbance',
            AbilityName = 'Sonic Disturbance',
            AbilityRange = 250,
            cond = function(self)
                return mq.TLO.Me.AltAbility('Sonic Disturbance')
            end,
        },
        {
            id = 'Boastful Bellow',
            Type = "AA",
            DisplayName = 'Boastful Bellow',
            AbilityName = 'Boastful Bellow',
            AbilityRange = 250,
            cond = function(self)
                return mq.TLO.Me.AltAbility('Boastful Bellow')
            end,
        },
    },
    ['DefaultConfig'] = {
        ['Mode']             = { DisplayName = "Mode", Category = "Combat", Tooltip = "Select the Combat Mode for this Toon", Type = "Custom", RequiresLoadoutChange = true, Default = 1, Min = 1, Max = 4, },
        ['UseAASelo']        = { DisplayName = "Use AA Selo", Category = "Buffs", Tooltip = "Do Selo's AAs", Default = true, },
        ['DoRunSpeed']       = { DisplayName = "Cast Run Speed Buffs", Category = "Buffs", Tooltip = "Use Selos.", RequiresLoadoutChange = true, Default = true, },
        ['UseEpic']          = { DisplayName = "Use Epic Click", Category = "Burns", Tooltip = "Use Epic 1-Never 2-Burns 3-Always", Type = "Combo", ComboOptions = { 'Never', 'Burns', 'Always', }, Default = 1, Min = 1, Max = 3, },
        ['UseFierceEye']     = { DisplayName = "Use Fierce Eye", Category = "Burns", Tooltip = "Use FierceEye 1-Never 2-Burns 3-Always", Type = "Combo", ComboOptions = { 'Never', 'Burns', 'Always', }, Default = 1, Min = 1, Max = 3, },
        ['UseFuneralDirge']  = { DisplayName = "Use Funeral Dirge", Category = "Burns", Tooltip = "Use Funeral Dirge", Default = true, },

        ['UseAlliance']      = { DisplayName = "Use Alliance", Category = "Combat", Tooltip = Tooltips.AllianceSong, RequiresLoadoutChange = true, Default = false, },
        ['UseBellow']        = { DisplayName = "Use Bellow", Category = "Combat", Tooltip = "Use Boastful Bellow", Default = true, },
		['BellowPct']   	= { DisplayName = "Bellow Min End%", Category = "Combat", Tooltip = "Minimum End% to use Bellow.", Default = 40, Min = 1, Max = 100, },
		['UseAura']           = { DisplayName = "Use Bard Aura", Category = "Buffs", Tooltip = "Select the Aura to be used, if any.", Type = "Combo", ComboOptions = { 'DPS', 'Regen', 'None' }, RequiresLoadoutChange = true, Default = 1, Min = 1, Max = 3, },
        -- Debuffs
        ['DoSlow']           = { DisplayName = "Cast Slow", Category = "Combat", Tooltip = Tooltips.SlowSong, RequiresLoadoutChange = true, Default = false, },
        ['DoAESlow']         = { DisplayName = "Cast AE Slow", Category = "Combat", Tooltip = Tooltips.AESlowSong, RequiresLoadoutChange = true, Default = false, },
        ['DoDispel']         = { DisplayName = "Use Dispel", Category = "Combat", Tooltip = Tooltips.DispelSong, RequiresLoadoutChange = true, Default = false, },

        -- TODO
        --['DoCharm']       = { DisplayName = "Use Charm", Category = "Songs", Tooltip = Tooltips.CharmSong, RequiresLoadoutChange = true, Default = false },
        -- in mez config.['DoAEMez']          = { DisplayName = "Do AoE Mez", Category = "Combat", Tooltip = "AEMez", RequiresLoadoutChange = true, Default = false, },
        ['DoMez']            = { DisplayName = "Do Mez", Category = "Combat", Tooltip = "STMez", RequiresLoadoutChange = true, Default = false, },
        -- in mez config.['AEMezCount']       = { DisplayName = "AoE Mez Count", Category = "Combat", Tooltip = "Mob count before AE mez casts", RequiresLoadoutChange = true, Default = 3, Min = 1, Max = 12, },
        --healer
        ['UseResist']        = { DisplayName = "Use Resists", Category = "Heal Songs", Tooltip = Tooltips.ResistSong, RequiresLoadoutChange = true, Default = false, },
        ['UseReckless']      = { DisplayName = "Use Reckless", Category = "Heal Songs", Tooltip = Tooltips.RecklessSong, RequiresLoadoutChange = true, Default = false, },
        ['UseCure']          = { DisplayName = "Use Cure", Category = "Heal Songs", Tooltip = Tooltips.CureSong, RequiresLoadoutChange = true, Default = false, },
        --Regen
        ['UseAmp']           = { DisplayName = "Use Amp", Category = "Regen Songs", Tooltip = Tooltips.AmpSong, RequiresLoadoutChange = true, Default = false, },
        
		
		['RegenSong']     	= { DisplayName = "Regen Song Choice", Category = "Regen Songs", Tooltip = "Select the Regen Song to be used, if any.", RequiresLoadoutChange = true, Type = "Combo", 		ComboOptions = { 'Group', 'Area', 'None', }, Default = 1, Min = 1, Max = 3, },
        ['UseCrescendo']     = { DisplayName = "Use Crescendo", Category = "Regen Songs", Tooltip = Tooltips.CrescendoSong, RequiresLoadoutChange = true, Default = true, },
        ['UseAccelerando']   = { DisplayName = "Use Accelerando", Category = "Regen Songs", Tooltip = Tooltips.AccelerandoSong, RequiresLoadoutChange = true, Default = false, },
		['ManaManagePct']   = { DisplayName = "Mana Manage %", Category = "Regen Songs", Tooltip = "Mana% to begin managing group mana(Use Crescendoes and Reflexive Strikes, use Regen song in combat).", Default = 80, Min = 1, Max = 100, },
		['ManaManageCt']   = { DisplayName = "Mana Manage Count", Category = "Regen Songs", Tooltip = "The number of party members (including yourself) that need to be under the mana percentage", Default = 2, Min = 1, Max = 6, },
		
        --DPS
        ['UseInsult']        = { DisplayName = "Use Insult Nuke", Category = "DPS Songs", Tooltip = Tooltips.InsultSong, RequiresLoadoutChange = true, Default = true, },
        ['UseFireDots']      = { DisplayName = "Use Fire Dots", Category = "DPS Songs", Tooltip = Tooltips.FireDotSong, RequiresLoadoutChange = true, Default = true, },
        ['UseIceDots']       = { DisplayName = "Use Ice Dots", Category = "DPS Songs", Tooltip = Tooltips.IceDotSong, RequiresLoadoutChange = true, Default = true, },
        ['UsePoisonDots']    = { DisplayName = "Use Poison Dots", Category = "DPS Songs", Tooltip = Tooltips.PoisonDotSong, RequiresLoadoutChange = true, Default = true, },
        ['UseDiseaseDots']   = { DisplayName = "Use Disease Dots", Category = "DPS Songs", Tooltip = Tooltips.DiseaseDotSong, RequiresLoadoutChange = true, Default = true, },

        --Tank
        ['UseSpiteful']      = { DisplayName = "Use Spiteful", Category = "Tank Songs", Tooltip = Tooltips.SpitefulSong, RequiresLoadoutChange = true, Default = false, },
        ['UseSpry']          = { DisplayName = "Use Spry", Category = "Tank Songs", Tooltip = Tooltips.SprySonataSong, RequiresLoadoutChange = true, Default = false, },
        --Caster
        ['UseArcane']        = { DisplayName = "Use Arcane", Category = "Caster Songs", Tooltip = Tooltips.ArcaneSong, RequiresLoadoutChange = true, Default = true, },
        ['UseFireDDMod']     = { DisplayName = "Use Fire Aria", Category = "Caster Songs", Tooltip = Tooltips.CasterAriaSong, RequiresLoadoutChange = true, Default = false, },
        ['UsePotency']       = { DisplayName = "Use Potency", Category = "Caster Songs", Tooltip = Tooltips.PotencySong, RequiresLoadoutChange = true, Default = false, },
        ['UseFate']          = { DisplayName = "Use Fate", Category = "Caster Songs", Tooltip = Tooltips.FateSong, RequiresLoadoutChange = true, Default = false, },
        -- Melee DPS Only
        ['UseSuffering']     = { DisplayName = "Use Suffering Line", Category = "Melee Songs", Tooltip = Tooltips.SufferingSong, RequiresLoadoutChange = true, Default = false, },
		['SufferingState']   = { DisplayName = "Use Suffering When", Category = "Melee Songs", Tooltip = Tooltips.SufferingSong, Type = "Combo", ComboOptions = { 'In-Combat Only', 'Always', 'Out-of-Combat Only', }, Default = 2, Min = 1, Max = 3, RequiresLoadoutChange = true,},
        ['UseProgressive']   = { DisplayName = "Use Progressive", Category = "Melee Songs", Tooltip = Tooltips.DichoSong, RequiresLoadoutChange = true, Default = true, },
        ['UseJonthan']       = { DisplayName = "Use Jonthan", Category = "Melee Songs", Tooltip = Tooltips.Jonthans, RequiresLoadoutChange = true, Default = false, },
		['DoChestClick']   	=  { DisplayName = "Do Chest Click", Category = "Utilities", Tooltip = "Click your chest item", Default = true, },

    },
    ['Spells']        = { getSpellCallback = generateSongList, },
}
return _ClassConfig
