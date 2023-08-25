Config = Config or {}

Config.Webhooks = {
	Ban = "https://discord.com/api/webhooks/1144461022007144508/ZHWmT5Wa6wkKoLNk5IvidUUs0988LNZIhOjv-Qy3la3AIYZMnOlfr2Pm_tZzClFMEW9a",
	Suspicious = "https://discord.com/api/webhooks/1144461345480245258/DNLxlO1kplft_Vi7mLOTNG8xXL00TPBEKTOZ1rTjRNsELMI_l3myeQzJdVT06fxj0BeQ",
	Wall = "https://discord.com/api/webhooks/1144460401048830022/jgHy3n7wWAA55eCahLZIP0LWjeyk4dwypeah3OhRqNlfhpwOoAvGXe1ADqHr9zOWsHPv",
	ScreenShot = "https://discord.com/api/webhooks/1144460681605828788/pVc2ykz_y9pPeabMb-Gp2iEoLdDwG-Ibpi0zTBalIhlbC2evOvA0IPHqFqvePA7JZFfC",
	BanHistory = "https://discord.com/api/webhooks/1144460839814963352/pwGl1mSJDLMBvVnJ6pLK9y0cWKzjSo-RKEPJx7U_RslVwRGDuY7yr_9Saubfcs_LZqpM",
}



Config.Detections = {
	["KB_01"] = true, --[[ true/false (true = ban, false = suspeito) ]]
	["POST_FX"] = true,
	["Explosive Bullets"] = false,
	["Weapon Damage Multiplier"] = true,
	["Weapon Spawn"] = true,
	["Generic Menu Detection"] = false,
	["Player Damage Multiplier"] = true,
	["Player Crash"] = true,
	["Spawn de Objetos"] = false,
	["Spawn de Veiculos"] = false,
	["Spawn de NPC"] = false,
	["Mod Menu 01"] = true,
	["Mod Menu 02"] = true,
	["Anti HS"] = true,
	["Injeção de Menu"] = true,
	["Spectate"] = false,
	["Semi God"] = false,
	["Particles"] = false,
	["Fake Shoot"] = true,
	["Mod Menu 09"] = true,

	["Stop AntiCheat 01"] = true,
	["Stop AntiCheat 02"] = true,
	["Stop AntiCheat 05"] = true,
	["Generic Menu Detection"] = true,
	["Mod Menu [K-R]"] = true,
	["Monster Menu 03"] = true,

	["Weapon Spawn 03"] = true,
	["Citizen - Varar Parede"] = true,
	["No Clip 05"] = true,
	["No Clip 07"] = true,
	["Citizen - Sem Rolamento"] = true,
	["Citizen - Municao Infinita"] = true,
	["Ammo Spawn"] = false,
	["Silent Aim (Citizen)"] = true,
	["Stop vRP"] = true,
	["Manipulacao de Eventos 03"] = true,
	["Manipulando vRP:tunnel_req"] = true,
}

Config.BanThreeshold = 15

Config.DefaultDamages = {
	[GetHashKey("WEAPON_CARBINERIFLE")] = 2.0,
}

Config.NotifyAdmins = true

Config.FooterBanText = "\nPara recorrer entre em nosso Discord!"

Config.ImageCDN = "https://discord.com/api/webhooks/1144460681605828788/pVc2ykz_y9pPeabMb-Gp2iEoLdDwG-Ibpi0zTBalIhlbC2evOvA0IPHqFqvePA7JZFfC"


-- Config.Creative = true

-- Config.LockdownMode = true
-- Config.NPC = true

Config.WeaponsList = {
	"WEAPON_KNIFE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_CROWBAR",
	"WEAPON_GOLFCLUB",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_KNUCKLEDUSTER",
	"WEAPON_MACHETE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_SWITCHBLADE",
	"WEAPON_POOLCUE",
	"WEAPON_WRENCH",
	"WEAPON_BATTLEAXE",
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_FLAREGUN",
	"WEAPON_STUNGUN",
	"WEAPON_REVOLVER",
	"WEAPON_MICROSMG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_SMG",
	"WEAPON_SMGMK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMGMK2",
	"WEAPON_GUSENBERG",
	"WEAPON_MINISMG",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPERMK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DOUBLEBARRELSHOTGUN",
	"WEAPON_AUTOSHOTGUN",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_RPG",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_GRENADELAUNCHERSMOKE",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXIMITYMINE",
	"WEAPON_BZGAS",
	"WEAPON_MOLOTOV",
	"GADGET_PARACHUTE",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_FLARE",
	"WEAPON_BALL",
	"WEAPON_SNOWBALL",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_PIPEBOMB",
	"WEAPON_NAVYREVOLVER",
	"WEAPON_MILITARYRIFLE",
	"WEAPON_HAZARDCAN",
	"WEAPON_GADGETPISTOL",
	"WEAPON_COMBATSHOTGUN",
	"WEAPON_CERAMICPISTOL",
}
