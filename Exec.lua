repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
game.Players.LocalPlayer.CharacterAdded:Wait()

_G.Configs = { -- Exemple
	["Team"] = "Pirates",

	["Webhook"] = "WebhookExemple", -- Optional
	["FpsBoost"] = false,

	["LevelTarget"] = 2800,
	["MoneyTarget"] = 100000,
	["FragTarget"] = 1500,

	["GetCdk"] = true,
	["GetTtk"] = false,
	["GetGh"] = true,
	["GetHumanFullV4"] = true,
	["GetMiticalFruit"] = true,
	["GetSoulGuitar"] = true,
	["GetSkills"] = true
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Main.luau"))()
