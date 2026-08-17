local player = game.Players.LocalPlayer

if _G.Configs.Key ~= "Key" then
	player:Kick("Key inválida!")
end

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
	GetCdk          = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependences/GetCdk.luau"),
	GetTtk          = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependences/GetTtk.luau"),
	GetGh           = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependences/GetGh.luau"),
	GetHumanFullV4  = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependences/GetHumanFullV4.luau"),
	GetMiticalFruit = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependences/GetMiticalFruit.luau"),
	GetSoulGuitar   = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependences/GetSoulGuitar.luau"),
	GetLv2800       = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Dependences/GetLv2800.luau"),

	GetSkills       = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/GetSkills.luau"),
	GetMoney        = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/GetMoney.luau"),
	GetFrag         = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/GetFrag.luau"),
	FpsBooter       = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/FpsBooter.luau"),
	ServerHop       = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/ServerHop.luau"),
	AutoSelectTeam  = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/AutoSelectTeam.luau"),
	AutoRandomFruits= import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/AutoRandomFruits.luau"),
	AutoQuestsSeas  = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/AutoQuestsSeas.luau"),
	AutoCods        = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/AutoCods.luau"),
	Security        = import("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Services/Security.luau"),

	Rayfield        = import("https://sirius.menu/rayfield")
}

-- Validação: verifica se algum módulo essencial não retornou nada
local player = game.Players.LocalPlayer
for name, mod in pairs(Modules) do
	if not mod then
		player:Kick("O módulo [" .. name .. "] falhou ao carregar ou está vazio.")
		return
	end
end

-- Abrindo window
local Window = Modules.Rayfield:CreateWindow({
	Name = "Pedrin Kaitun",
	Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
	LoadingTitle = "Pedrin Kaitun",
	LoadingSubtitle = "by Pedro",
	ShowText = "Rayfield", -- for mobile users to unhide Rayfield, change if you'd like
	Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

	ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

	-- ScriptID = "sid_xxxxxxxxxxxx", -- Your Script ID from developer.sirius.menu — enables analytics, managed keys, and script hosting

	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Pedrin Kaitun"
	},

	Discord = {
		Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
		Invite = "noinvitelink", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ABCD would be ABCD
		RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
	},

	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
		FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"Hello"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
	}
})

local Tab = Window:CreateTab("Tab Example", 4483362458) -- Title, Image

local Button = Tab:CreateButton({
	Name = "Button Example",
	Callback = function()
		Modules.Rayfield:Destroy()
	end,
})
