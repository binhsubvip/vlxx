
local ui_url = "https://raw.githubusercontent.com/binhsubvip/vlxx/main/VLXX.lua"
local NightUI = loadstring(game:HttpGet(ui_url))()


local Window = NightUI:MakeWindow({
    Name = "Binhsubvip Hub - V1.0",
    Theme = "Dark" 
})


local TabServer = Window:MakeTab("Máy Chủ (Server)")
local TabFarm = Window:MakeTab("Tính Năng (Farm)")

TabServer:MakeButton({
    Name = "Tự động nhảy Server trống",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local LocalPlayer = game:GetService("Players").LocalPlayer
        
        local ApiUrl = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
        
        local success, response = pcall(function() return game:HttpGet(ApiUrl) end)
        
        if success then
            local data = HttpService:JSONDecode(response)
            if data and data.data then
                for _, server in ipairs(data.data) do
                    -- Tìm server chưa full và ping < 150
                    if server.id ~= game.JobId and server.playing < server.maxPlayers and server.ping < 150 then
                        print("[*] Đang chuyển sang Server: " .. server.id)
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                        task.wait(2) 
                    end
                end
            end
        end
    end
})

TabServer:MakeButton({
    Name = "Rejoin (Vào lại máy chủ này)",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
    end
})

TabFarm:MakeToggle({
    Name = "Bật Auto Farm (Demo)",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        while _G.AutoFarm do
            task.wait(1)

        end
    end
})

TabFarm:MakeSlider({
    Name = "Chỉnh Tốc Độ Chạy",
    Min = 16,
    Max = 300,
    Default = 16,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
