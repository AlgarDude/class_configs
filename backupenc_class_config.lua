local mq           = require('mq')
local RGMercUtils  = require("utils.rgmercs_utils")
local AlgarInclude = require("utils.algar_include")

local _ClassConfig = {
    _version            = "Jank",
    _author             = "Algar",
    ['FullConfig']      = true,
    ['ModeChecks']      = {
        IsMezzing = function() return true end,
        IsCharming = function() return RGMercUtils.GetSetting('CharmOn') end,
    },
    ['Modes']           = {
        'Mez',
    },
    ['ItemSets']        = {
        ['Epic'] = {
            "Staff of Eternal Eloquence",
            "Oculus of Persuasion",
        },
    },
    ['AbilitySets']     = {
        ['AuraBuff1'] = {
            "Twincast Aura",
        },
        ['AuraBuff2'] = {
            "Mana Ripple Aura",
            "Mana Radix Aura",
            "Mana Replication Aura",
            "Mana Repetition Aura",
            "Mana Reciprocation Aura",
            "Mana Reverberation Aura",
            "Mana Repercussion Aura",
            "Mana Reiteration Aura",
            "Mana Reiterate Aura",
            "Mana Resurgence Aura",
            "Mystifier's Aura",
            "Entrancer's Aura",
            "Illusionist's Aura",
            "Beguiler's Aura",
        },
        ['AuraBuff3'] = {
            "Learner's Aura",
        },
        ['HasteBuff'] = {
            "Hastening of Margator",
            "Hastening of Jharin",
            "Hastening of Cekenar",
            "Hastening of Milyex",
            "Hastening of Prokev",
            "Hastening of Sviir",
            "Hastening of Aransir",
            "Hastening of Novak",
            "Hastening of Erradien",
            "Hastening of Ellowind",
            "Hastening of Salik",
            "Vallon's Quickening",
            -- "Speed of the Brood",
            -- "Speed of Cekenar",
            -- "Speed of Milyex",
            -- "Speed of Prokev",
            -- "Speed of Sviir",
            -- "Speed of Aransir",
            -- "Speed of Novak",
            -- "Speed of Erradien",
            -- "Speed of Ellowind",
            -- "Speed of Salik",
            -- "Speed of Vallon",
            "Visions of Grandeur",
            "Wondrous Rapidity",
            "Aanya's Quickening",
            "Swift Like the Wind",
            "Celerity",
            "Augmentation",
            "Alacrity",
            "Quickness",
        },
        ['ManaRegen'] = {
            "Voice of Preordination",
            "Voice of Perception",
            "Voice of Sagacity",
            "Voice of Perspicacity",
            "Voice of Precognition",
            "Voice of Foresight",
            "Voice of Premeditation",
            "Voice of Forethought",
            "Voice of Prescience",
            "Voice of Cognizance",
            "Voice of Intuition",
            "Voice of Clairvoyance",
            "Voice of Quellious",
            "Tranquility",
            -- [] = ["Gift of Brilliance", -- Removed because the Map Defaults to it Instead of Koadics
            "Koadic's Endless Intellect",
            "Gift of Pure Thought",
            "Sagacity",
            "Perspicacity",
            "Precognition",
            "Foresight",
            "Premeditation",
            "Forethought",
            "Prescience",
            "Seer's Cognizance",
            "Seer's Intuition",
            "Clairvoyance",
            "Gift of Insight",
            "Clarity II",
            "Clarity",
            "Breeze",
        },
        ['MezBuff'] = {
            "Ward of the Stupefier",
            "Ward of the Beguiler",
            "Ward of the Deviser",
            "Ward of the Transfixer",
            "Ward of the Enticer",
            "Ward of the Mastermind",
            "Ward of Arctending",
            "Ward of Bafflement",
            "Ward of Befuddlement",
            "Ward of Mystifying",
            "Ward of Bewilderment",
            "Ward of Bedazzlement",
        },
        ['NdtBuff'] = {
            "Night's Perpetual Terror",
            "Night's Endless Terror",
            "Night's Dark Terror",
            "Boon of the Garou",
        },
        ['SelfHPBuff'] = {
            "Shield of Memories",
            "Shield of Shadow",
            "Shield of Restless Ice",
            "Shield of Scales",
            "Shield of the Pellarus",
            "Shield of the Dauntless",
            "Shield of Bronze",
            "Shield of Dreams",
            "Shield of the Void",
            "Spellbound Shield",
            "Sorcerous Shield",
            "Mystic Shield",
            "Shield of Maelin",
            "Shield of the Arcane",
            "Shield of the Magi",
            "Arch Shielding",
            "Greater Shielding",
            "Major Shielding",
            "Shielding",
            "Lesser Shielding",
            "Minor Shielding",
        },
        ['SelfRune1'] = {
            "Esoteric Rune",
            "Marvel's Rune",
            "Deviser's Rune",
            "Transfixer's Rune",
            "Enticer's Rune",
            "Mastermind's Rune",
            "Arcanaward's Rune",
            "Spectral Rune",
            "Pearlescent Rune",
            "Opalescent Rune",
            "Draconic Rune",
            "Ethereal Rune",
            "Arcane Rune",
        },
        ['SelfRune2'] = {
            "Polyradiant Rune",
            "Polyluminous Rune",
            "Polycascading Rune",
            "Polyfluorescent Rune",
            "Polyrefractive Rune",
            "Polyiridescent Rune",
            "Polyarcanic Rune",
            "Polyspectral Rune",
            "Polychaotic Rune",
            "Multichromatic Rune",
            "Polychromatic Rune",
        },
        ['UnityRune'] = {
            "Esoteric Unity",
            "Deviser's Unity",
            "Marvel's Unity",
        },
        ['SingleRune'] = {
            "Rune of Zoraxmen",
            "Rune of Tearc",
            "Rune of Kildrukaun",
            "Rune of Skrizix",
            "Rune of Lucem",
            "Rune of Xolok",
            "Rune of Tonmek",
            "Rune of Novak",
            "Rune of Yozan",
            "Rune of Erradien",
            "Rune of Ellowind",
            "Rune of Salik",
            "Rune of Zebuxoruk",
            "Rune V",
            "Rune IV",
            "Rune III",
            "Rune II",
            "Rune I",
        },
        ['GroupRune'] = {
            "Gloaming Rune",
            "Eclipsed Rune",
            "Crepuscular Rune",
            "Tenebrous Rune",
            "Darkened Rune",
            "Umbral Rune",
            "Shadowed Rune",
            "Twilight Rune",
            "Rune of the Void",
            "Rune of the Deep",
            "Rune of the Kedge",
            "Rune of Rikkukin",
            "Rune of the Scale",
        },
        ['AggroRune'] = {
            "Disquieting Rune",
            "Ghastly Rune",
            "Horrendous Rune",
            "Dreadful Rune",
            "Frightening Rune",
            "Terrifying Rune",
            "Horrifying Rune",
        },
        ['AggroBuff'] = {
            "Horrifying Visage",
            "Haunting Visage",
        },
        ['SingleSpellShield'] = {
            "Aegis of Elmara",
            "Aegis of Sefra",
            "Aegis of Omica",
            "Aegis of Nureya",
            "Aegis of Gordianus",
            "Aegis of Xorbb",
            "Aegis of Soliadal",
            "Aegis of Zykean",
            "Aegis of Xadrith",
            "Aegis of Qandieal",
            "Aegis of Alendar",
            "Wall of Alendar",
            "Bulwark of Alendar",
            "Protection of Alendar",
            "Guard of Alendar",
            "Ward of Alendar",
        },
        ['GroupSpellShield'] = {
            "Legion of Ogna",
            "Legion of Liako",
            "Legion of Kildrukaun",
            "Legion of Skrizix",
            "Legion of Lucem",
            "Legion of Xolok",
            "Legion of Tonmek",
            "Legion of Zykean",
            "Legion of Xadrith",
            "Legion of Qandieal",
            "Legion of Alendar",
            "Circle of Alendar",
        },
        ['SingleDoTShield'] = {
            "Aegis of Xetheg",
            "Aegis of Cekenar",
            "Aegis of Milyex",
            "Aegis of the Indagator",
            "Aegis of the Keeper",
        },
        ['GroupDoTShield'] = {
            "Legion of Dhakka",
            "Legion of Xetheg",
            "Legion of Cekenar",
            "Legion of Milyex",
            "Legion of the Indagator",
            "Legion of the Keeper",
        },
        ['SingleMeleeShield'] = {
            "Gloaming Auspice",
            "Eclipsed Auspice",
            "Crepuscular Auspice",
            "Tenebrous Auspice",
            "Darkened Auspice",
            "Umbral Auspice",
        },
        ['SelfGuardShield'] = {
            "Shield of Inescapability",
            "Shield of Shadow",
            "Shield of Destiny",
            "Shield of Order",
            "Shield of Consequence",
            "Shield of Fate",
        },
        ['GroupAuspiceBuff'] = {
            "Marvel's Auspice",
            "Deviser's Auspice",
            "Transfixer's Auspice",
            "Enticer's Auspice",
        },
        ['GroupProcBuff'] = {
            "Mana Reproduction",
            "Mana Rebirth",
            "Mana Replication",
            "Mana Repetition",
            "Mana Reciprocation",
            "Mana Reverberation",
            "Mana Repercussion",
            "Mana Reiteration",
            "Mana Reiterate",
            "Mana Resurgence",
        },
        ['AllianceSpell'] = {
            "Chromatic Conjunction",
            "Chromatic Coalition",
            "Chromatic Covenant",
            "Chromatic Alliance",
        },
        ['TwinCastMez'] = {
            "Chaotic Deception",
            "Chaotic Delusion",
            "Chaotic Bewildering",
            "Chaotic Confounding",
            "Chaotic Confusion",
            "Chaotic Baffling",
            "Chaotic Befuddling",
            "Chaotic Puzzlement",
            "Chaotic Conundrum",
        },
        ['PBAEStunSpell'] = {
            "Color Calibration",
            "Color Conflagration",
            "Color Cascade",
            "Color Congruence",
            "Color Concourse",
            "Color Confluence",
            "Color Convergence",
            "Color Clash",
            "Color Conflux",
            "Color Cataclysm",
            "Color Collapse",
            "Color Snap",
            "Color Cloud",
            "Color Slant",
            "Color Skew",
            "Color Shift",
            "Color Flux",
        },
        ['TargetAEStun'] = {
            "Remote Color Calibration",
            "Remote Color Conflagration",
            "Remote Color Cascade",
            "Remote Color Congruence",
            "Remote Color Concourse",
            "Remote Color Confluence",
            "Remote Color Convergence",
        },
        ['SingleStunSpell1'] = {
            "Dizzying Spindle",
            "Dizzying Vortex",
            "Dizzying Coil",
            "Dizzying Wheel",
            "Dizzying Storm",
            "Dizzying Squall",
            "Dizzying Gyre",
            "Dizzying Helix",
            "The Downward Spiral",
            "Whirling into the Hollow",
            "Spinning into the Void",
            "Largarn's Lamentation",
            "Dyn's Dizzying Draught",
            "Whirl till you hurl",
        },
        ['CharmSpell'] = {
            "Esoteric Command",
            "Marvel's Demand",
            "Marvel's Command",
            "Inveigle",
            "Deviser's Demand",
            "Deviser's Command",
            "Transfixer's Command",
            "Spellbinding",
            "Enticer's Command",
            "Enticer's Demand",
            "Captivation",
            "Impose",
            "Temptation",
            "Enforce",
            "Compelling Edict",
            "Subjugate",
            "Deception",
            "Dominate",
            "Seduction",
            "Haunting Whispers",
            "Cajole",
            "Dyn`leth's Whispers",
            "Coax",
            -- [] = "Ancient Voice of Muram",
            "True Name",
            "Compel",
            "Command of Druzzil",
            "Beckon",
            "Dictate",
            "Boltran's Agacerie",
            "Ordinance",
            "Allure",
            "Cajoling Whispers",
            "Beguile",
            "Charm",
        },
        ['CrippleSpell'] = {
            "Splintered Consciousness",
            "Fragmented Consciousness",
            "Shattered Consciousness",
            "Fractured Consciousness",
            "Synapsis Spasm",
            "Cripple",
            "Incapacitate",
            "Listless Power",
            "Disempower",
            "Enfeeblement",
        },
        ['SlowSpell'] = {
            -- Slow - lvl88 and above this is also cripple spell Starting @ Level 88  Combines With Cripple.
            "Desolate Deeds",
            "Dreary Deeds",
            "Forlorn Deeds",
            "Shiftless Deeds",
            "Tepid Deeds",
            "Languid Pace",
        },
        ['StripBuffSpell'] = {
            "Eradicate Magic",
            "Recant Magic",
            "Pillage Enchantment",
            "Nullify Magic",
            "Strip Enchantment",
            "Cancel Magic",
            "Taper Enchantment",
        },
        ['TashSpell'] = {
            "Roar of Tashan",
            "Edict of Tashan",
            "Proclamation of Tashan",
            "Order of Tashan",
            "Decree of Tashan",
            "Enunciation of Tashan",
            "Declaration of Tashan",
            "Clamor of Tashan",
            "Bark of Tashan",
            "Din of Tashan",
            "Echo of Tashan",
            "Howl of Tashan",
            "Tashanian",
            "Tashania",
            "Tashani",
            "Tashina",
        },
        ['ManaDrainSpell'] = {
            "Tears of Kasha",
            "Tears of Xenacious",
            "Tears of Aaryonar",
            "Tears of Skrizix",
            "Tears of Visius",
            "Tears of Syrkl",
            "Tears of Wreliard",
            "Tears of Zykean",
            "Tears of Xadrith",
            "Tears of Qandieal",
            "Torment of Scio",
            "Torment of Argli",
            "Scryer's Trespass",
            "Wandering Mind",
            "Mana Sieve",
        },
        ['DichoSpell'] = {
            "Ecliptic Reinforcement",
            "Composite Reinforcement",
            "Dissident Reinforcement",
            "Dichotomic Reinforcement",
        },
        ['DoTSpell1'] = {
            ---DoT 1 -- >=LVL1
            "Asphyxiating Grasp",
            "Throttling Grip",
            "Pulmonary Grip",
            "Strangulate",
            "Drown",
            "Stifle",
            "Suffocation",
            "Constrict",
            "Smother",
            "Strangling Air",
            "Thin Air",
            "Arcane Noose",
            "Strangle",
            "Asphyxiate",
            "Gasping Embrace",
            "Suffocate",
            "Choke",
            "Suffocating Sphere",
            "Shallow Breath",
        },
        ['ManaDot'] = {
            -- DoT 2 --  >= LVL70
            "Mind Whirl",
            "Mind Vortex",
            "Mind Coil",
            "Mind Tempest",
            "Mind Storm",
            "Mind Squall",
            "Mind Spiral",
            "Mind Helix",
            "Mind Twist",
            "Mind Oscillate",
            "Mind Phobiate",
            "Mind Shatter",
        },
        ['DebuffDot'] = {
            ---DoT 3 -- >= LVL89
            "Dismaying Constriction",
            "Perplexing Constriction",
            "Deceiving Constriction",
            "Deluding Constriction",
            "Bewildering Constriction",
            "Confounding Constriction",
            "Confusing Constriction",
            "Baffling Constriction",
        },
        ['NukeSpell1'] = {
            --- Nuke 1 -- >= LVL7
            "Mindrend",
            "Mindreap",
            "Mindrift",
            "Mindslash",
            "Mindsunder",
            "Mindcleave",
            "Mindscythe",
            "Mindblade",
            "Spectral Assault",
            "Polychaotic Assault",
            "Multichromatic Assault",
            "Polychromatic Assault",
            "Colored Chaos",
            "Psychosis",
            "Madness of Ikkibi",
            "Insanity",
            "Dementing Visions",
            "Dementia",
            "Discordant Mind",
            "Anarchy",
            "Chaos Flux",
            "Sanity Warp",
            "Chaotic Feedback",
            "Chromarcana",
            "Ancient: Neurosis",
            "Ancient: Chaos Madness",
            "Ancient: Chaotic Visions",
        },
        ['NukeSpell2'] = {
            --- Nuke 1 -- >= LVL7
            "Mindrend",
            "Mindreap",
            "Mindrift",
            "Mindslash",
            "Mindsunder",
            "Mindcleave",
            "Mindscythe",
            "Mindblade",
            "Spectral Assault",
            "Polychaotic Assault",
            "Multichromatic Assault",
            "Polychromatic Assault",
            "Colored Chaos",
            "Psychosis",
            "Madness of Ikkibi",
            "Insanity",
            "Dementing Visions",
            "Dementia",
            "Discordant Mind",
            "Anarchy",
            "Chaos Flux",
            "Sanity Warp",
            "Chaotic Feedback",
            "Chromarcana",
            "Ancient: Neurosis",
            "Ancient: Chaos Madness",
            "Ancient: Chaotic Visions",
        },
        ['RuneNuke'] = {
            --- RUNE - Nuke Fast >=LVL86
            "Chromatic Spike",
            "Chromatic Flare",
            "Chromatic Stab",
            "Chromatic Flicker",
            "Chromatic Blink",
            "Chromatic Percussion",
            "Chromatic Flash",
            "Chromatic Jab",
        },
        ['ManaNuke'] = {
            --- Mana Drain Nuke - Fast -- >=LVL96
            "Psychological Appropriation",
            "Ideological Appropriation",
            "Psychic Appropriation",
            "Intellectual Appropriation",
            "Mental Appropriation",
            "Cognitive Appropriation",
        },
        --Unused table, temporarily removed - was causing conflicts while resolving NukeSpell1 action maps (will revisit nukes later)
        -- ['ChromaNuke'] = {
        --- Chromatic Lowest Nuke - Normal -- >=LVL73
        -- "Polycascading Assault",
        -- "Polyfluorescent Assault",
        -- "Polyrefractive Assault",
        -- "Phantasmal Assault",
        -- "Arcane Assault",
        -- "Spectral Assault",
        -- "Polychaotic Assault",
        -- "Multichromatic Assault",
        -- "Polychromatic Assault",
        -- },
        ['CripSlowSpell'] = {
            --- Slow Cripple Combo Spell - Beginning @ Level 88
            "Constraining Coil",
            "Constraining Helix",
            "Undermining Helix",
            "Diminishing Helix",
            "Attenuating Helix",
            "Curtailing Helix",
            "Inhibiting Helix",
        },
        ['PetSpell'] = {
            "Flariton's Animation",
            "Constance's Animation",
            "Omica's Animation",
            "Nureya's Animation",
            "Gordianus' Animation",
            "Xorlex's Animation",
            "Seronvall's Animation",
            "Novak's Animation",
            "Yozan's Animation",
            "Erradien's Animation",
            "Ellowind's Animation",
            "Salik's Animation",
            "Aeldorb's Animation",
            "Zumaik's Animation",
            "Kintaz's Animation",
            "Yegoreff's Animation",
            "Aanya's Animation",
            "Boltran's Animation",
            "Uleen's Animation",
            "Sagar's Animation",
            "Sisna's Animation",
            "Shalee's Animation",
            "Kilan's Animation",
            "Mircyl's Animation",
            "Juli's Animation",
            "Pendril's Animation",
        },
        ['PetBuffSpell'] = {
            ---Pet Buff Spell * Var Name: PetBuffSpell string outer
            "Speed of Margator",
            "Speed of Vallon",
            "Visions of Grandeur",
            "Wondrous Rapidity",
            "Aanya's Quickening",
            "Swift Like the Wind",
            "Celerity",
            "Augmentation",
            "Alacrity",
            "Quickness",
            "Infused Minion",
            "Empowered Minion",
            "Invigorated Minion",
            --- Speed of the Brood won't take effect properly on pets. Unless u Purchase the AA
        },
        ['MezAESpell'] = {
            ---AE Mez * Var Name:,string outer
            "Neutralizing Wave",
            "Perplexing Wave",
            "Deadening Wave",
            "Slackening Wave",
            "Peaceful Wave",
            "Serene Wave",
            "Ensorcelling Wave",
            "Quelling Wave",
            "Wake of Subdual",
            "Wake of Felicity",
            "Bliss of the Nihil",
            "Fascination",
            "Mesmerization",
            "Bewildering Wave",
            "Stupefying Wave",
        },
        ['MezAESpellFast'] = {
            "Vexing Glance",
            "Confounding Glance",
            "Neutralizing Glance",
            "Perplexing Glance",
            "Slackening Glance",
        },
        ['MezPBAESpell'] = {
            "Neutralize",
            "Perplex",
            "Bafflement",
            "Disorientation",
            "Confusion",
            "Serenity",
            "Docility",
            "Visions of Kirathas",
            "Dreams of Veldyn",
            "Circle of Dreams",
            "Word of Morell",
            "Entrancing Lights",
            "Bewilderment",
            "Wonderment",
        },
        ['MezSpell'] = {
            --need to put twincast mez in here so it is the one that is chosen to be used
            "Chaotic Puzzlement",
            "Chaotic Conundrum",
            "Chaotic Deception",
            "Chaotic Delusion",
            "Chaotic Bewildering",
            "Chaotic Confounding",
            "Chaotic Confusion",
            "Chaotic Baffling",
            "Chaotic Befuddling", --Level 83


            -- "Flummox",
            -- "Addle",
            -- "Deceive",
            -- "Delude",
            -- "Bewilder",
            -- "Confound",
            -- "Mislead",
            -- "Baffle",
            -- "Befuddle",
            -- "Mystify",
            -- "Bewilderment",
            -- "Euphoria",
            -- "Felicity",
            -- "Bliss",
            -- "Sleep",
            -- "Apathy",
            -- "Glamour of Kintaz",
            -- "Enthrall",
            -- "Mesmerize",
        },
        ['MezSpellFast'] = {
            "Deceiving Flash",
            "Deluding Flash",
            "Bewildering Flash",
            "Confounding Flash",
            "Misleading Flash",
            "Baffling Flash",
            "Befuddling Flash",
            "Mystifying Flash",
            "Perplexing Flash",
            "Addling Flash",
            "Flummoxing Flash",
        },
        ['BlurSpell'] = {
            "Memory Flux",
            "Reoccurring Amnesia",
            "Memory Blur",
        },
        ['AEBlurSpell'] = {
            "Blanket of Forgetfulness",
            "Mind Wipe",
        },
        ['CalmSpell'] = {
            ---Calm Spell -- >= LVL1
            "Docile Mind",
            "Still Mind",
            "Serene Mind",
            "Mollified Mind",
            "Pacified Mind",
            "Quiescent Mind",
            "Halcyon Mind",
            "Bucolic Mind",
            "Hushed Mind",
            "Silent Mind",
            "Quiet Mind",
            "Placate",
            "Pacification",
            "Pacify",
            "Calm",
            "Soothe",
            "Lull",
        },
        ['FearSpell'] = {
            ---Fear Spell * Var Name:, string outer >= LVL3
            "Anxiety Attack",
            "Jitterskin",
            "Phobia",
            "Trepidation",
            "Invoke Fear",
            "Chase the Moon",
            "Fear",
        },
        ['RootSpell'] = {
            "Greater Fetter",
            "Fetter",
            "Paralyzing Earth",
            "Immobilize",
            "Instill",
            "Root",
        },
    },
    ['HelperFunctions'] = {
    },
    ['RotationOrder']   = {
        {
            name = 'SelfBuff',
            targetId = function(self) return { mq.TLO.Me.ID(), } end,
            cond = function(self, combat_state)
                return combat_state == "Downtime" and
                    RGMercUtils.DoBuffCheck() and RGMercConfig:GetTimeSinceLastMove() > RGMercUtils.GetSetting('BuffWaitMoveTimer')
            end,

        },
        {
            name = 'PetBuff',
            targetId = function(self) return { mq.TLO.Me.Pet.ID(), } end,
            cond = function(self, combat_state)
                return combat_state == "Downtime" and RGMercUtils.DoBuffCheck() and mq.TLO.Me.Pet.ID() > 0 and
                    RGMercConfig:GetTimeSinceLastMove() > RGMercUtils.GetSetting('BuffWaitMoveTimer')
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
        {
            name = 'CripSlow',
            --we want these both checked
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                if not RGMercUtils.GetSetting('DoSlow') or RGMercUtils.GetSetting('DoCripple') then return false end
                return combat_state == "Combat" and AlgarInclude.DebuffConCheck() and not RGMercUtils.Feigning() and
                    mq.TLO.Me.PctMana() >= RGMercUtils.GetSetting('ManaToDebuff')
            end,
        },
        {
            name = 'Tash',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                if not RGMercUtils.GetSetting('DoTash') then return false end
                return combat_state == "Combat" and AlgarInclude.DebuffConCheck() and not RGMercUtils.Feigning() and
                    mq.TLO.Me.PctMana() >= RGMercUtils.GetSetting('ManaToDebuff')
            end,
        },
        {
            name = 'Burn',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and RGMercUtils.BurnCheck() and not RGMercUtils.Feigning()
            end,
        },
        {
            name = 'CombatSupport',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and not RGMercUtils.Feigning()
            end,
        },
        {
            name = 'DPS',
            state = 1,
            steps = 1,
            targetId = function(self) return mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and { RGMercConfig.Globals.AutoTargetID, } or {} end,
            cond = function(self, combat_state)
                return combat_state == "Combat" and not RGMercUtils.Feigning()
            end,
        },

    },
    ['Rotations']       = {
        ['PetBuff'] = {
            {
                name = "PetBuffSpell",
                type = "Spell",
                active_cond = function(self, spell) return mq.TLO.Me.PetBuff(spell.ID()).ID() end,
                cond = function(self, spell) return RGMercUtils.SelfBuffPetCheck(spell) end,
            },
        },
        ['SelfBuff'] = {
            {
                name = "PetSpell",
                type = "Spell",
                active_cond = function(self, _) return mq.TLO.Me.Pet.ID() > 0 end,
                cond = function(self, spell) return mq.TLO.Me.Pet.ID() == 0 and RGMercUtils.ReagentCheck(spell) end,
            },
            {
                name = "GroupProcBuff",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell) return RGMercUtils.SelfBuffCheck(spell) end,
            },
            {
                name = "SelfHPBuff",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell) return RGMercUtils.SelfBuffCheck(spell) end,
            },
            {
                name = "MezBuff",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell) return RGMercUtils.SelfBuffCheck(spell) end,
            },
            {
                name = "SelfRune1",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell) return RGMercUtils.SelfBuffCheck(spell) end,
            },
            {
                name = "SelfRune2",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.BuffActiveByID(spell.ID()) end,
                cond = function(self, spell) return RGMercUtils.SelfBuffCheck(spell) end,
            },
            {
                name = "Veil of Mindshadow",
                type = "AA",
                active_cond = function(self, aaName) return RGMercUtils.BuffActiveByName(aaName) end,
                cond = function(self, aaName) return RGMercUtils.SelfBuffAACheck(aaName) end,
            },

            {
                name = "Azure Mind Crystal",
                type = "AA",
                active_cond = function(self, aaName) return mq.TLO.FindItem(aaName)() ~= nil end,
                cond = function(self, aaName) return mq.TLO.Me.PctMana() > 90 and not mq.TLO.FindItem(aaName)() end,
                post_activate = function(self, aaName, success)
                    if success then
                        mq.delay(100)
                        RGMercUtils.DoCmd("/autoinventory")
                    end
                end,
            },
            {
                name = "Gather Mana",
                type = "AA",
                active_cond = function(self, aaName) return RGMercUtils.AAReady(aaName) end,
                cond = function(self, aaName) return mq.TLO.Me.PctMana() < 60 end,
            },
            {
                name = "AuraBuff1",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.AuraActiveByName(spell.Name()) end,
                cond = function(self, spell)
                    if RGMercUtils.GetSetting('DoLearners') and not RGMercUtils.CanUseAA('Auroria Mastery') then return false end
                    return RGMercUtils.PCSpellReady(spell) and not RGMercUtils.AuraActiveByName(spell.Name())
                end,
            },
            {
                name = "AuraBuff2",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.AuraActiveByName(spell.Name()) end,
                cond = function(self, spell)
                    return RGMercUtils.PCSpellReady(spell) and not RGMercUtils.AuraActiveByName(spell.Name()) and not RGMercUtils.GetSetting('DoLearners')
                end,
            },
            {
                name = "AuraBuff3",
                type = "Spell",
                active_cond = function(self, spell) return RGMercUtils.AuraActiveByName(spell.Name()) end,
                cond = function(self, spell)
                    return RGMercUtils.GetSetting('DoLearners') and RGMercUtils.PCSpellReady(spell) and not RGMercUtils.AuraActiveByName(spell.Name())
                end,
            },
        },
        ['GroupBuff'] = {
            -- TODO : Macro group buff rotation never was hooked up ask Mori about this later.
            {
                name = "SingleRune",
                type = "Spell",
                active_cond = function(self, spell) return mq.TLO.Me.FindBuff("id " .. tostring(spell.ID()))() ~= nil end,
                cond = function(self, spell, target)
                    return RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            {
                name = "ManaRegen",
                type = "Spell",
                active_cond = function(self, spell) return mq.TLO.Me.FindBuff("id " .. tostring(spell.ID()))() ~= nil end,
                cond = function(self, spell, target)
                    if not RGMercConfig.Constants.RGCasters:contains(target.Class.ShortName()) then return false end

                    return RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            {
                name = "HasteBuff",
                type = "Spell",
                active_cond = function(self, spell) return mq.TLO.Me.FindBuff("id " .. tostring(spell.ID()))() ~= nil end,
                cond = function(self, spell, target)
                    return RGMercConfig.Constants.RGMelee:contains(target.Class.ShortName()) and RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            {
                name = "GroupSpellShield",
                type = "Spell",
                active_cond = function(self, spell) return mq.TLO.Me.FindBuff("id " .. tostring(spell.ID()))() ~= nil end,
                cond = function(self, spell, target)
                    return RGMercUtils.GroupBuffCheck(spell, target) and RGMercUtils.ReagentCheck(spell)
                end,
            },
            -- {
            -- name = "GroupDoTShield",
            -- type = "Spell",
            -- active_cond = function(self, spell) return mq.TLO.Me.FindBuff("id " .. tostring(spell.ID()))() ~= nil end,
            -- cond = function(self, spell, target)
            -- if not target or not target() then return false end

            -- return RGMercUtils.GroupBuffCheck(spell, target) and RGMercUtils.ReagentCheck(spell) and RGMercUtils.SpellStacksOnTarget(spell)
            -- end,
            -- },
            {
                name = "GroupAuspiceBuff",
                type = "Spell",
                active_cond = function(self, spell) return mq.TLO.Me.FindBuff("id " .. tostring(spell.ID()))() ~= nil end,
                cond = function(self, spell, target)
                    return RGMercUtils.GroupBuffCheck(spell, target) and RGMercUtils.ReagentCheck(spell)
                end,
            },
            {
                name = "NdtBuff",
                type = "Spell",
                active_cond = function(self, spell) return mq.TLO.Me.FindBuff("id " .. tostring(spell.ID()))() ~= nil end,
                cond = function(self, spell, target)
                    --NDT will not be cast or memorized if it isn't already on the bar due to a very long refresh time causing pauses in automation
                    if not RGMercUtils.CastReady(spell.RankName) and RGMercUtils.GetSetting('DoNDTBuff') then return false end
                    --Single target versions of the spell will only be used on Melee, group versions will be cast if they are missing from any groupmember
                    if (spell and spell() and ((spell.TargetType() or ""):lower() ~= "group v2"))
                        and not RGMercConfig.Constants.RGMelee:contains(target.Class.ShortName()) then
                        return false
                    end

                    return RGMercUtils.GroupBuffCheck(spell, target)
                end,
            },
            {
                name = "GroupRune",
                type = "Spell",
                active_cond = function(self, spell) return mq.TLO.Me.FindBuff("id " .. tostring(spell.ID()))() ~= nil end,
                cond = function(self, spell, target)
                    if not RGMercUtils.GetSetting('DoGroupAbsorb') or RGMercConfig.Constants.RGCasters:contains(target.Class.ShortName()) then return false end

                    return RGMercUtils.GroupBuffCheck(spell, target) and RGMercUtils.ReagentCheck(spell)
                end,
            },
            -- {
            -- name = "AggroRune",
            -- type = "Spell",
            -- active_cond = function(self, spell) return mq.TLO.Me.FindBuff("id " .. tostring(spell.ID()))() ~= nil end,
            -- cond = function(self, spell, target)
            -- if not RGMercUtils.GetSetting('DoAggroRune') and RGMercConfig.Constants.RGTank:contains(target.Class.ShortName()) then return false end

            -- return RGMercUtils.GroupBuffCheck(spell, target)
            -- end,
            -- },
        },
        ['CombatSupport'] = {
            {
                name = "Glyph Spray",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return (RGMercUtils.IsNamed(mq.TLO.Target) and mq.TLO.Target.Level() > mq.TLO.Me.Level()) or
                        RGMercUtils.GetMainAssistPctHPs() < 45 and RGMercUtils.GetMainAssistPctHPs() > 5
                end,

            },
            {
                name = "Reactive Rune",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return (RGMercUtils.IsNamed(mq.TLO.Target) and mq.TLO.Target.Level() > mq.TLO.Me.Level()) or
                        RGMercUtils.GetMainAssistPctHPs() < 45 and RGMercUtils.GetMainAssistPctHPs() > 5
                end,

            },
            {
                name = "Self Stasis",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return mq.TLO.Me.TargetOfTarget.ID() == mq.TLO.Me.ID() and mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and mq.TLO.Me.PctHPs() <= 30
                end,

            },
            {
                name = "Dimensional Instability",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return mq.TLO.Me.TargetOfTarget.ID() == mq.TLO.Me.ID() and mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and mq.TLO.Me.PctHPs() <= 30
                end,

            },
            {
                name = "Beguiler's Directed Banishment",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return mq.TLO.Me.TargetOfTarget.ID() == mq.TLO.Me.ID() and mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and mq.TLO.Me.PctHPs() <= 40
                end,

            },
            {
                name = "Beguiler's Banishment",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return mq.TLO.Me.TargetOfTarget.ID() == mq.TLO.Me.ID() and mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and mq.TLO.Me.PctHPs() <= 50 and
                        mq.TLO.SpawnCount("npc radius 20")() > 2
                end,

            },
            {
                name = "Doppelganger",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return mq.TLO.Me.TargetOfTarget.ID() == mq.TLO.Me.ID() and mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and mq.TLO.Me.PctHPs() <= 60
                end,

            },
            {
                name = "Phantasmal Opponent",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return mq.TLO.Me.TargetOfTarget.ID() == mq.TLO.Me.ID() and mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and mq.TLO.Me.PctHPs() <= 60
                end,

            },
            {
                name = "Dimensional Shield",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return mq.TLO.Me.TargetOfTarget.ID() == mq.TLO.Me.ID() and mq.TLO.Target.ID() == RGMercConfig.Globals.AutoTargetID and mq.TLO.Me.PctHPs() <= 80
                end,

            },
            {
                name = "Arcane Whisper",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return mq.TLO.Me.PctAggro() >= 90
                end,

            },
            {
                name = "Silent Casting",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return mq.TLO.Me.PctAggro() >= 90
                end,

            },
            {
                name = "UseAzureMindCrystal",
                type = "CustomFunc",
                cond = function(self)
                    if not RGMercUtils.CanUseAA("Azure Mind Crystal") then return false end
                    local crystal = mq.TLO.FindItem("Azure Mind Crystal")
                    ---@diagnostic disable-next-line: param-type-mismatch
                    return crystal and crystal() and mq.TLO.FindItem(crystal).TimerReady() == 0 and mq.TLO.Me.PctMana() <= RGMercUtils.GetSetting('ModRodManaPct')
                end,
                custom_func = function(self)
                    local crystal = mq.TLO.FindItem("Azure Mind Crystal")
                    return RGMercUtils.UseItem(crystal.Name(), mq.TLO.Me.ID())
                end,
            },
        },
        ['DPS'] = {
            {
                name = "Focus of Arcanum",
                type = "AA",
                cond = function(self, aaName)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return true
                end,

            },
            {
                name = "DichoSpell",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.GetSetting('DoDicho') and RGMercUtils.DetSpellCheck(spell) and mq.TLO.Me.PctMana() >= RGMercUtils.GetSetting('ManaToNuke')
                end,
            },
            {
                name = "ManaDot",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.IsNamed(mq.TLO.Target) and RGMercUtils.DetSpellCheck(spell) and mq.TLO.Me.PctMana() >= RGMercUtils.GetSetting('ManaToNuke')
                end,
            },
            {
                name = "NukeSpell1",
                type = "Spell",
                cond = function(self, spell)
                    return mq.TLO.Me.PctMana() >= RGMercUtils.GetSetting('ManaToNuke')
                end,
            },
            {
                name = "DoTSpell1",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.GetSetting('DoDot') and RGMercUtils.DetSpellCheck(spell) and mq.TLO.Me.PctMana() >= RGMercUtils.GetSetting('ManaToNuke')
                end,
            },
            --This is not an error
            {
                name = "DoTSpell1",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.GetSetting('DoDot') and RGMercUtils.DetSpellCheck(spell) and mq.TLO.Me.PctMana() >= RGMercUtils.GetSetting('ManaToNuke')
                end,
            },
            {
                name = "ManaNuke",
                type = "Spell",
                cond = function(self, spell)
                    return (mq.TLO.Group.LowMana(50)() or -1) > 1 or mq.TLO.Me.PctMana() <= RGMercUtils.GetSetting('ManaToNuke')
                end,
            },
        },
        ['Burn'] = {
            {
                name = "Illusions of Grandeur",
                type = "AA",
                cond = function(self, aaName) return true end,

            },
            {
                name = "Improved Twincast",
                type = "AA",
                cond = function(self, aaName) return true end,

            },
            {
                name = "Forceful Rejuvenation",
                type = "AA",
                cond = function(self, aaName) return true end,

            },
            {
                name = "Calculated Insanity",
                type = "AA",
                cond = function(self, aaName) return true end,

            },
            {
                name = "Mental Contortion",
                type = "AA",
                cond = function(self, aaName) return RGMercUtils.IsNamed(mq.TLO.Target) end,

            },
            {
                name = "Chromatic Haze",
                type = "AA",
                cond = function(self, aaName) return true end,

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
                name = "Spire of Enchantment",
                type = "AA",
                cond = function(self, aaName) return not RGMercUtils.SongActiveByName("Illusions of Grandeur") end,

            },
        },
        ['Tash'] = {
            {
                name = "TashSpell",
                type = "Spell",
                cond = function(self, spell)
                    return RGMercUtils.GetSetting('DoTash') and RGMercUtils.DetSpellCheck(spell) and not mq.TLO.Target.Tashed()
                        and RGMercUtils.NPCSpellReady(spell)
                end,
            },
            {
                name = "Bite of Tashani",
                type = "AA",
                cond = function(self, aaName, target)
                    if mq.TLO.Target.ID() <= 0 then return false end
                    return RGMercUtils.GetSetting('DoTash') and RGMercUtils.DetAACheck(mq.TLO.Me.AltAbility(aaName).ID()) and not mq.TLO.Target.Tashed() and
                        RGMercUtils.GetXTHaterCount() > 1 and RGMercUtils.NPCAAReady(aaName, target.ID())
                end,

            },

        },
        ['CripSlow'] = {
            {
                name = "Enveloping Helix",
                type = "AA",
                cond = function(self, aaName, target)
                    if RGMercUtils.GetXTHaterCount() < RGMercUtils.GetSetting('SlowCount') then return false end
                    return RGMercUtils.DetAACheck(mq.TLO.Me.AltAbility(aaName).ID()) and RGMercUtils.NPCAAReady(aaName, target.ID())
                end,
            },
            {
                name = "Slowing Helix",
                type = "AA",
                cond = function(self, aaName, target)
                    return not RGMercUtils.TargetHasBuffByName(aaName) and (mq.TLO.Me.AltAbility(aaName).Spell.SlowPct() or 0) > (RGMercUtils.GetTargetSlowedPct()) and
                        RGMercUtils.NPCAAReady(aaName, target.ID())
                end,
            },
            {
                name = "CripSlowSpell",
                type = "Spell",
                cond = function(self, spell, target)
                    if RGMercUtils.CanUseAA("Enveloping Helix") then return false end
                    return RGMercUtils.DetSpellCheck(spell) and RGMercUtils.NPCSpellReady(spell, target.ID())
                end,
            },
            {
                name = "SlowSpell",
                type = "Spell",
                cond = function(self, spell, target)
                    if not RGMercUtils.GetSetting('DoSlow') then return false end
                    return not RGMercUtils.TargetHasBuffByName(spell) and (mq.TLO.Me.AltAbility(spell).Spell.SlowPct() or 0) > (RGMercUtils.GetTargetSlowedPct()) and
                        RGMercUtils.NPCSpellReady(aaName, target.ID())
                end,
            },
            {
                name = "CrippleSpell",
                type = "Spell",
                cond = function(self, spell, target)
                    if not RGMercUtils.GetSetting('DoCripple') or RGMercUtils.CanUseAA("Enveloping Helix") then return false end
                    return RGMercUtils.DetSpellCheck(spell) and RGMercUtils.NPCSpellReady(aaName, target.ID())
                end,
            },
        },
    },
    ['Spells']          = {
        {
            gem = 1,
            spells = {
                { name = "MezSpell", },
            },
        },
        {
            gem = 2,
            spells = {
                { name = "MezAESpell", },
            },
        },
        {
            gem = 3,
            spells = {
                { name = "TashSpell", },
            },
        },
        {
            gem = 4,
            spells = {
                { name = "DichoSpell", },
            },
        },
        {
            gem = 5,
            spells = {
                { name = "NukeSpell1", },
            },
        },
        {
            gem = 6,
            spells = {
                { name = "DoTSpell1", },
            },
        },
        {
            gem = 7,
            spells = {
                { name = "ManaDot", },
            },
        },
        {
            gem = 8,
            spells = {
                { name = "ManaNuke", },
            },
        },
        {
            gem = 9,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "SingleRune", cond = function(self) return true end, },
            },
        },
        {
            gem = 10,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "NdtBuff", cond = function(self) return true end, },
            },
        },
        {
            gem = 11,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "GroupProcBuff", cond = function(self) return true end, },
            },
        },
        {
            gem = 12,
            cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
            spells = {
                { name = "GroupSpellShield", cond = function(self) return true end, },
            },
        },
        -- {
        -- gem = 13,
        -- cond = function(self, gem) return mq.TLO.Me.NumGems() >= gem end,
        -- spells = {
        -- { name = "GroupAuspiceBuff", cond = function(self) return true end, },
        -- },
        -- },
    },
    ['PullAbilities']   = {
        {
            id = 'TashSpell',
            Type = "Spell",
            DisplayName = function() return RGMercUtils.GetResolvedActionMapItem('TashSpell').RankName.Name() or "" end,
            AbilityName = function() return RGMercUtils.GetResolvedActionMapItem('TashSpell').RankName.Name() or "" end,
            AbilityRange = 150,
            cond = function(self)
                local resolvedSpell = RGMercUtils.GetResolvedActionMapItem('TashSpell')
                if not resolvedSpell then return false end
                return mq.TLO.Me.Gem(resolvedSpell.RankName.Name() or "")() ~= nil
            end,
        },
    },
    ['DefaultConfig']   = {
        ['Mode']              = { DisplayName = "Mode", Category = "Combat", Tooltip = "Select the Combat Mode for this Toon", Type = "Custom", RequiresLoadoutChange = true, Default = 1, Min = 1, Max = 1, },
        ['DoLearners']        = { DisplayName = "Do Learners", Category = "Spells & Abilities", Tooltip = "Set to use the Learner's Aura instead of the Mana Regen Aura.", Default = false, },
        ['SlowCount']         = { DisplayName = "Slow Count", Category = "Spells & Abilities", Tooltip = "Number of XT Haters before we start slowing", Min = 1, Default = 3, Max = 10, },
        ['DoTash']            = { DisplayName = "Do Tash", Category = "Spells & Abilities", Tooltip = "Cast Tash Spells", Default = true, },
        ['DoTwincastDPS']     = { DisplayName = "Do Twincast DPS", Category = "Spells & Abilities", Tooltip = "Cast Twincast during DPS rotation", Default = true, },
        ['DoDot']             = { DisplayName = "Cast DOTs", Category = "Spells and Abilities", Tooltip = "Enable casting Damage Over Time spells.", Default = true, },
        ['DoSlow']            = { DisplayName = "Cast Slow", Category = "Spells and Abilities", Tooltip = "Enable casting Slow spells.", Default = true, },
        ['DoCripple']         = { DisplayName = "Cast Cripple", Category = "Spells and Abilities", Tooltip = "Enable casting Cripple spells.", Default = true, },
        ['DoDicho']           = { DisplayName = "Cast Dicho", Category = "Spells and Abilities", Tooltip = "Enable casting Dicho spells.", Default = true, },
        ['DoNDTBuff']         = { DisplayName = "Cast NDT", Category = "Spells and Abilities", Tooltip = "Enable casting use Melee Proc Buff (Night's Dark Terror Line).", Default = true, },
        ['DoGroupAbsorb']     = { DisplayName = "Do Group Absorb", Category = "Spells and Abilities", Tooltip = "Enable casting the Group Absorb line with -Hate Proc.", Default = true, },
        ['DoAggroRune']       = { DisplayName = "Do Aggro Rune", Category = "Spells and Abilities", Tooltip = "Enable casting the Tank Aggro Rune", Default = true, },
        ['DoStripBuff']       = { DisplayName = "Do Strip Buffs", Category = "Spells and Abilities", Tooltip = "Enable casting buff canceler spells.", Default = true, },
        ['DoChestClick']      = { DisplayName = "Do Chest Click", Category = "Utilities", Tooltip = "Click your chest item", Default = true, },
        ['DebuffMinCon']      = { DisplayName = "Debuff Min Con", Category = "Debuffs", Tooltip = "Min Con to use debuffs on", Default = 4, Min = 1, Max = #RGMercConfig.Constants.ConColors, Type = "Combo", ComboOptions = RGMercConfig.Constants.ConColors, },
        ['DebuffNamedAlways'] = { DisplayName = "Always Debuff Named", Category = "Debuffs", Tooltip = "Debuff named regardless of con color", Default = true, },
    },
}

return _ClassConfig
