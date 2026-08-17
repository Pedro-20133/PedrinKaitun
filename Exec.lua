_G.Configs = { -- Exemple
	["Team"] = "Pirates",
	
	["Key"] = "KeyExemple", -- Optional
	["Webhook"] = "WebhookExemple", -- Optional
	
	["LevelTarget"] = 2800,
	["MoneyTarget"] = 100000,
	["FragTarget"] = 1500,
	
	["GetCdk"] = true,
	["GetTtk"] = false,
	["GetGh"] = true,
	["GetHumanFullV4"] = true,
	["GetMiticalFruit"] = true,
	["GetSoulGuitar"] = true
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/Pedro-20133/PedrinKaitun/refs/heads/main/Files/Main.luau"))()
