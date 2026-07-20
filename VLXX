

local NightUI = {}
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Khởi tạo Base Frame
function NightUI:MakeWindow(options)
    local WindowOptions = {
        Name = options.Name or "NightUI Hub",
        Theme = options.Theme or "Dark"
    }

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NightUI_Instance"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TopBar.Size = UDim2.new(1, 0, 0, 35)

    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(1, -15, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = WindowOptions.Name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 10, 0, 45)
    TabContainer.Size = UDim2.new(0, 130, 1, -55)

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 150, 0, 45)
    ContentWindow = Instance.new("Folder")
    ContentWindow.Parent = ContentContainer

    -- Chức năng kéo thả UI (Draggable)
    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local WindowData = {}
    
    function WindowData:MakeTab(TabName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = TabName .. "_Tab"
        TabBtn.Parent = TabContainer
        TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabBtn.Size = UDim2.new(1, 0, 0, 30)
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.Text = TabName
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.TextSize = 13

        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 4)
        TabBtnCorner.Parent = TabBtn

        local Page = Instance.new("ScrollingFrame")
        Page.Name = TabName .. "_Page"
        Page.Parent = ContentContainer
        Page.BackgroundTransparency = 1
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.ScrollBarThickness = 2
        Page.Visible = false

        local PageList = Instance.new("UIListLayout")
        PageList.Parent = Page
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 5)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentContainer:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            Page.Visible = true
        end)

        local TabElements = {}

        function TabElements:MakeButton(BtnOptions)
            local btnName = BtnOptions.Name or "Button"
            local callback = BtnOptions.Callback or function() end

            local Btn = Instance.new("TextButton")
            Btn.Parent = Page
            Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Btn.Size = UDim2.new(1, -10, 0, 35)
            Btn.Font = Enum.Font.Gotham
            Btn.Text = btnName
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 14

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = Btn

            Btn.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end

        function TabElements:MakeToggle(TogOptions)
            local togName = TogOptions.Name or "Toggle"
            local callback = TogOptions.Callback or function() end
            local default = TogOptions.Default or false
            local toggled = default

            local TogFrame = Instance.new("Frame")
            TogFrame.Parent = Page
            TogFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TogFrame.Size = UDim2.new(1, -10, 0, 35)
            
            local TogCorner = Instance.new("UICorner")
            TogCorner.CornerRadius = UDim.new(0, 4)
            TogCorner.Parent = TogFrame

            local TogLabel = Instance.new("TextLabel")
            TogLabel.Parent = TogFrame
            TogLabel.BackgroundTransparency = 1
            TogLabel.Position = UDim2.new(0, 10, 0, 0)
            TogLabel.Size = UDim2.new(1, -50, 1, 0)
            TogLabel.Font = Enum.Font.Gotham
            TogLabel.Text = togName
            TogLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TogLabel.TextSize = 14
            TogLabel.TextXAlignment = Enum.TextXAlignment.Left

            local TogBtn = Instance.new("TextButton")
            TogBtn.Parent = TogFrame
            TogBtn.BackgroundColor3 = toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(100, 100, 100)
            TogBtn.Position = UDim2.new(1, -40, 0.5, -10)
            TogBtn.Size = UDim2.new(0, 30, 0, 20)
            TogBtn.Text = ""

            local BtnCorner2 = Instance.new("UICorner")
            BtnCorner2.CornerRadius = UDim.new(0, 4)
            BtnCorner2.Parent = TogBtn

            TogBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                TogBtn.BackgroundColor3 = toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(100, 100, 100)
                pcall(callback, toggled)
            end)
            pcall(callback, toggled)
        end

        return TabElements
    end
    return WindowData
end
return NightUI
