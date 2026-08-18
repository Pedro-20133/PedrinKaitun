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
	GetMastery       = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/GetMastery.luau"),
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
_G.Vars.Skills.AirJump   = false

_G.Vars.Status.Melee     = 1
_G.Vars.Status.Defensa   = 1
_G.Vars.Status.Espada    = 1
_G.Vars.Status.Arma      = 1
_G.Vars.Status.BloxFruit = 1

_G.Server.IsSea1         = false
_G.Server.IsSea2         = false
_G.Server.IsSea3         = false

_G.Server.IsFullMoon     = false

-- Função auxiliar para obter status
local function getVerificarVars()

end

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

local function UpdateFpsBoost(value)
	
end
task.spawn(function()
	while true do
		UpdateFpsBoost(_G.Configs.FpsBoost)
		wait(5)
	end
end)

task.spawn(function()
	while true do
		if _G.Server.IsSea2 then Modules.GetTtk:TryBuyLegendarySword() end
		wait(60)
	end
end)

task.spawn(function()
	while true do
		getAllVars()
		wait(5)
	end
end)

local LogiaList = {
	"", "", "", "",
	"", "", ""
}

task.spawn(function()
	while true do
		if _G.Level >= 50 then
			local success, fruit_name = Modules.AutoRandomFruits:TryGetRandomFruit()
			if success then
				if LogiaList[fruit_name] then
					Modules.AutoRandomFruits:ComerFruta(fruit_name)
				else
					local sucess = Modules.AutoRandomFruits:GuardarFruta(fruit_name)
					if not sucess then Modules.AutoRandomFruits:SoltarFruta(fruit_name) end
				end
			end
		end
		
		wait(5)
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

Modules.AutoCods:RedeemCods()
wait(3)

if _G.Vars.Level <= 700 then
	if _G.Configs.LevelTarget < 700 then
		Modules.AutoLevel:FarmLevel(_G.Configs.LevelTarget)
	else
		Modules.AutoLevel:FarmLevel(700)
	end
	
	if not _G.Vars.Skills["Haki"] then Modules.GetSkills:GetHaki() end
	if not _G.Vars.Skills["Obs"] then Modules.GetSkills:GetObs() end
	if not _G.Vars.Skills["Soru"] then Modules.GetSkills:GetSoru() end
	if not _G.Vars.Skills["AirJump"] then Modules.GetSkills:GetAirJump() end

	wait(0.5)

	Modules.AutoQuestsSeas:StartSecondQuest()
end

wait(1)

if _G.Vars.Level <= 1500 then
	if _G.Configs.LevelTarget < 1500 then
		Modules.AutoLevel:FarmLevel(_G.Configs.LevelTarget)
	else
		Modules.AutoLevel:FarmLevel(1500)
	end

	wait(0.5)

	Modules.AutoQuestsSeas:StartThirdQuest()
end

wait(1)

if _G.Vars.Level <= 2800 then
	if _G.Configs.LevelTarget < 2800 then
		Modules.AutoLevel:FarmLevel(_G.Configs.LevelTarget)
	else
		Modules.AutoLevel:FarmLevel(2800)
	end
end

wait(1)

if not _G.Vars.haveGh then
	Modules.ServerHop:HopToSea3()
	
	-- Comprar estilos v1
	if _G.Vars.Money >= 1450000 then
		Modules.GetGh:BuyBlackLeg()
		Modules.GetGh:BuyEletric()
		Modules.GetGh:BuyWaterKungfu()
	else
		Modules.GetMoney:Farm(1450000)
		
		Modules.GetGh:BuyBlackLeg()
		Modules.GetGh:BuyEletric()
		Modules.GetGh:BuyWaterKungfu()
	end
	
	if _G.Vars.Frag >= 1500 then
		Modules.GetGh:BuyDragonBreath()
	else
		Modules.GetFrag:Farm(1500)
		Modules.GetGh:BuyDragonBreath()
	end
	
	-- Uppar estilos v1
	
	Modules.GetGh:BuyBlackLeg()
	Modules.GetMastery.EstiloLuta:Farm(400)
	wait(1)
	Modules.GetGh:BuyEletric()
	Modules.GetMastery.EstiloLuta:Farm(400)
	wait(1)
	Modules.GetGh:BuyWaterKungfu()
	Modules.GetMastery.EstiloLuta:Farm(400)
	wait(1)
	Modules.GetGh:BuyDragonBreath()
	Modules.GetMastery.EstiloLuta:Farm(400)
	wait(1)
	
	-- Comprar estilos v2
	Modules.ServerHop:HopToSea2()
	
	Modules.GetGh:AutoQuestBl()
	wait(1)
	Modules.GetGh:AutoQuestWf()
	wait(1)
	
	Modules.ServerHop:HopToSea3()
	
	Modules.GetGh:AutoQuestEl()
	wait(1)
	Modules.GetGh:AutoQuestDb()
	wait(1)
	
	if _G.Vars.Money >= 14000000 and _G.Vars.Frag >= 20000 then
		Modules.GetGh:BuySuperHuman()
		Modules.GetGh:BuyDeathStep()
		Modules.GetGh:BuyEletricClaw()
		Modules.GetGh:BuyWaterKarate()
		Modules.GetGh:BuyDragonTalon()
	else
		Modules.GetMoney:Farm(14000000)
		Modules.GetFrag:Farm(20000)
	end
	
	-- Uppar estilos v2
	Modules.GetGh:BuySuperHuman()
	Modules.GetMastery.EstiloLuta:Farm(400)
	wait(1)
	Modules.GetGh:BuyDeathStep()
	Modules.GetMastery.EstiloLuta:Farm(400)
	wait(1)
	Modules.GetGh:BuyEletricClaw()
	Modules.GetMastery.EstiloLuta:Farm(400)
	wait(1)
	Modules.GetGh:BuyWaterKarate()
	Modules.GetMastery.EstiloLuta:Farm(400)
	wait(1)
	Modules.GetGh:BuyDragonTalon()
	Modules.GetMastery.EstiloLuta:Farm(400)
	wait(1)
	
	if not Modules.GetGh:HaveItens()then
		Modules.GetGh:GetItensGh()
		wait(1)
	end
	
	if _G.Vars.Money >= 5000000 and _G.Vars.Frag >= 5000 then
		Modules.GetGh:BuyGodHuman()
		Modules.GetMastery.EstiloLuta:Farm(600)
		wait(1)
	else
		Modules.GetMoney:Farm(5000000)
		Modules.GetFrag:Farm(5000)
		
		Modules.GetGh:BuyGodHuman()
		Modules.GetMastery.EstiloLuta:Farm(600)
		wait(1)
	end
end

wait(1)

if _G.Vars.Level >= 2300 and not _G.Vars.haveSoulGuitar then
	if not _G.Server.IsSea3 then Modules.ServerHop:HopToSea3() end
	if not _G.Server.IsFullMoon then Modules.ServerHop:HopToFullMoon() end
	Modules.GetSoulGuitar:Start()
end

wait(1)

if not _G.Vars.haveTtk then
	if _G.Vars.Money < 8000000 then Modules.GetMoney:Farm(8000000) end
	if not _G.Server.IsSea2 then Modules.ServerHop:HopToSea2() end
	
	Modules.GetTtk:Start()
end

wait(1)

if not _G.Vars.haveCdk then
	if not _G.Server.IsSea3 then Modules.ServerHop:HopToSea3() end
	
	local haveTushita = Modules.GetCdk:CheckTushita()
	if not haveTushita then Modules.GetCdk:StartTushita() end
	local haveYama = Modules.GetCdk:CheckYama()
	if not haveYama then Modules.GetCdk:StartYama() end
	
	if haveTushita and haveYama then
		Modules.GetCdk:Start()
	end
end

wait(1)

Modules.GetMoney:Farm(_G.Configs.MoneyTarget)
Modules.GetFrag:Farm(_G.Configs.FragTarget)

-- Verificar tudo
if not getVerificarVars() then
	player:Kick("Algo deu errado, reset o script para verificar novamente")
else
	player:Kick("Sua conta está pronta!!")
end
