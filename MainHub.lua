-- =========================================================
-- SYSTEM: BINHSUBVIP PREMIUM HUB
-- AUTHOR: binhsubvip
-- UI FRAMEWORK: NIGHT UI (Bản Full/Backup)
-- =========================================================

-- 1. Load thư viện NightUI từ nguồn Backup ổn định
local NightUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/NightUI.lua"))()

-- 2. Khởi tạo Cửa sổ chính (Tùy chỉnh tên của bạn)
local Window = NightUI:MakeWindow({
    Name = "Binhsubvip Hub - Version 1.0",
    Theme = "Dark" 
})

-- 3. Khởi tạo các Tab chức năng
local MainTab = Window:MakeTab("Chính (Main)")
local ServerTab = Window:MakeTab("Máy Chủ (Server)")
local PlayerTab = Window:MakeTab("Nhân Vật (Player)")

-- =========================================================
-- CHỨC NĂNG CỦA NIGHT UI (DROPDOWN, TOGGLE, SLIDER)
-- =========================================================
MainTab:MakeToggle({
    Name = "Bật Auto Farm",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        print("Trạng thái Auto Farm: ", Value)
    end
})

MainTab:MakeDropdown({
    Name = "Chọn Vũ Khí Farm",
    Options = {"Melee", "Sword", "Blox Fruit"},
    Default = "Melee",
    Callback = function(Value)
        _G.Weapon = Value
    end
})

-- =========================================================
-- CHỨC NĂNG LÕI: SERVER HOP (Vượt Ping)
-- =========================================================
ServerTab:MakeButton({
    Name = "Tự động nhảy Server trống (Hop)",
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
                    -- Tìm server chưa full người và ping thấp
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

ServerTab:MakeButton({
    Name = "Vào lại máy chủ (Rejoin)",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
    end
})

-- =========================================================
-- CHỨC NĂNG: NGƯỜI CHƠI
-- =========================================================
PlayerTab:MakeSlider({
    Name = "Tốc độ chạy",
    Min = 16,
    Max = 300,
    Default = 16,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
