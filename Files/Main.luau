-- Função auxiliar segura para carregar os arquivos
local function import(url)
	local success, result = pcall(function()
		return loadstring(game:HttpGet(url))()
	end)
	if success and result then
		return result
	else
		warn("Falha ao carregar o módulo: " .. url)
		return nil
	end
end

-- Tabela central de módulos
local Modules = {
	GetCdk           = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependencies/GetCdk.luau"),
	GetTtk           = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependencies/GetTtk.luau"),
	GetGh            = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependencies/GetGh.luau"),
	GetHumanFullV4   = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependencies/GetHumanFullV4.luau"),
	GetMiticalFruit  = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependencies/GetMiticalFruit.luau"),
	GetSoulGuitar    = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependencies/GetSoulGuitar.luau"),
	GetLv2800        = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependencies/GetLv2800.luau"),

	GetSkills        = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/GetSkills.luau"),
	GetMoney         = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/GetMoney.luau"),
	GetFrag          = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/GetFrag.luau"),
	FpsBooter        = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/FpsBooter.luau"),
	ServerHop        = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/ServerHop.luau"),
	AutoSelectTeam   = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/AutoSelectTeam.luau"),
	AutoRandomFruits = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/AutoRandomFruits.luau"),
	AutoQuestsSeas   = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/AutoQuestsSeas.luau"),
	AutoCods         = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/AutoCods.luau"),
	Security         = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/Security.luau"),

	Rayfield         = import("https://sirius.menu/rayfield")
}

-- Validação: verifica se algum módulo essencial não retornou nada
local player = game.Players.LocalPlayer
for name, mod in pairs(Modules) do
	if not mod then
		player:Kick("O módulo [" .. name .. "] falhou ao carregar ou está vazio.")
		return
	end
end

-- Inicializa a tabela de variáveis globais caso não exista
_G.Vars = _G.Vars or {}
_G.Vars.TweenSpeed       = 200

_G.Vars.haveCdk          = false
_G.Vars.haveTtk          = false
_G.Vars.haveGh           = false
_G.Vars.haveHumanFullV4  = false
_G.Vars.haveMiticalFruit = false
_G.Vars.haveSoulGuitar   = false
_G.Vars.haveSkills       = false

_G.Vars.Money            = 0
_G.Vars.Frag             = 0
_G.Vars.Level            = 1
_G.Vars.Fruit            = ""

_G.Vars.Skills.Haki      = false
_G.Vars.Skills.Obs       = false
_G.Vars.Skills.Soru      = false
_G.Vars.Skills.PuloNoAr  = false

_G.Vars.Status.Melee     = 1
_G.Vars.Status.Defensa   = 1
_G.Vars.Status.Espada    = 1
_G.Vars.Status.Arma      = 1
_G.Vars.Status.BloxFruit = 1

-- Função auxiliar para obter status
local function getAllVars()
	
end

-- Abrindo window
local Window = Modules.Rayfield:CreateWindow({
	Name = "Pedrin Kaitun",
	Icon = 0,
	LoadingTitle = "Pedrin Kaitun",
	LoadingSubtitle = "by Pedro",
	ShowText = "Rayfield",
	Theme = "Default",

	ToggleUIKeybind = "K",

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,

	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil,
		FileName = "Pedrin Kaitun"
	},

	Discord = {
		Enabled = false,
		Invite = "noinvitelink",
		RememberJoins = true
	},

	KeySystem = false,
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided",
		FileName = "Key",
		SaveKey = true,
		GrabKeyFromSite = false,
		Key = {"Hello"}
	}
})

local Tab = Window:CreateTab("Main", nil)

local TweenSpeedSlider = Tab:CreateSlider({
	Name = "Tween Speed",
	Range = {150, 1000},
	Increment = 50,
	Suffix = "Tween speed",
	CurrentValue = 200,
	Flag = "TweenSpeed",
	Callback = function(Value)
		_G.Vars.TweenSpeed = Value
	end,
})

local KickBtn = Tab:CreateButton({
	Name = "Kick Button",
	Callback = function()
		player:Kick("Você foi kickado por você mesmo.")
	end,
})

local ExitBtn = Tab:CreateButton({
	Name = "Exit Button",
	Callback = function()
		Modules.Rayfield:SetVisibility(false)
		Modules.Rayfield:Destroy()
		
		task.cancel()
		error()
	end,
})

-- Init
task.spawn(function()
	while true do
		local hasAdmin = Modules.Security:VerifyAdmin()
		if hasAdmin then player:Kick("Um admin entrou no server.") end
		
		wait()
	end
end)

if _G.Configs.Team == "Marines" then
	Modules.AutoSelectTeam:SelectMarines()
elseif _G.Configs.Team == "Pirates" then
	Modules.AutoSelectTeam:SelectPirates()
else
	player:Kick("Você não tem team especificado no _G.Configs.")
end

wait(1)

if _G.Configs.FpsBoost then
	Modules.FPSBoost:Enable()
end

wait()

if _G.Vars.Level <= 700 then
	if _G.Configs.LevelTarget < 700 then
		Modules.AutoLevel:FarmLevel(_G.Configs.LevelTarget)
	else
		Modules.AutoLevel:FarmLevel(700)
	end

	wait(0.5)

	Modules.AutoQuestsSeas:StartSecondQuest()
end

if _G.Vars.Level <= 1500 then
	if _G.Configs.LevelTarget < 1500 then
		Modules.AutoLevel:FarmLevel(_G.Configs.LevelTarget)
	else
		Modules.AutoLevel:FarmLevel(1500)
	end

	wait(0.5)

	Modules.AutoQuestsSeas:StartThirdQuest()
end

if _G.Vars.Level <= 2800 then
	if _G.Configs.LevelTarget < 2800 then
		Modules.AutoLevel:FarmLevel(_G.Configs.LevelTarget)
	else
		Modules.AutoLevel:FarmLevel(2800)
	end

	wait(0.5)

	Modules.AutoQuestsSeas:StartThirdQuest()
end
