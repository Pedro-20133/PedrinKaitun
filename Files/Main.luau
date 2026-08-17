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
_G.Vars.TweenSpeed = 200

-- Abrindo window
local Rayfield = Modules.Rayfield
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

local ExitBtn = Tab:CreateButton({
	Name = "Exit Button",
	Callback = function()
		Rayfield:SetVisibility(false)
		Rayfield:Destroy()
	end,
})
