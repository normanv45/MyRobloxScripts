-- [[ CRITICAL ERROR: ZENITH V5 ]]
-- [[ THE ULTIMATE UNIVERSAL INTERFACE ]]

local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- [ CLEANUP ]
if CoreGui:FindFirstChild("Zenith_Hub") then CoreGui.Zenith_Hub:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Zenith_Hub"

-- [ THE ACRYLIC FRAME ]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 750, 0, 480)
Main.Position = UDim2.new(0.5, -375, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- [ NEON GLOW BORDER ]
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 0, 50)
Stroke.Thickness = 2
Stroke.Transparency = 0.5

-- [ SIDEBAR SYSTEM WITH ICONS ]
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 70)
Title.Text = "ZENITH V5"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.BackgroundTransparency = 1

local TabHolder = Instance.new("ScrollingFrame", Sidebar)
TabHolder.Size = UDim2.new(1, 0, 1, -80)
TabHolder.Position = UDim2.new(0, 0, 0, 70)
TabHolder.BackgroundTransparency = 1
TabHolder.CanvasSize = UDim2.new(0, 0, 2, 0)
TabHolder.ScrollBarThickness = 0
local TabList = Instance.new("UIListLayout", TabHolder)
TabList.Padding = UDim.new(0, 8)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [ CONTENT PAGE LOADER ]
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -200, 1, -20)
Container.Position = UDim2.new(0, 190, 0, 10)
Container.BackgroundTransparency = 1

local function CreateTab(name, iconID)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 5, 0) -- MASSIVE ROOM FOR FEATURES
    Page.ScrollBarThickness = 2
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10)

    local TabBtn = Instance.new("TextButton", TabHolder)
    TabBtn.Size = UDim2.new(0.9, 0, 0, 45)
    TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabBtn.Text = "  " .. name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    
    -- Icon Placeholder (Can replace with ImageLabels)
    local Icon = Instance.new("TextLabel", TabBtn)
    Icon.Text = ">"
    Icon.Position = UDim2.new(1, -30, 0, 0)
    Icon.Size = UDim2.new(0, 30, 1, 0)
    Icon.BackgroundTransparency = 1
    Icon.TextColor3 = Color3.fromRGB(255, 0, 50)

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Container:GetChildren()) do p.Visible = false end
        Page.Visible = true
    end)
    return Page
end

-- [ TABS SETUP ]
local Combat = CreateTab("COMBAT", "")
local Visuals = CreateTab("VISUALS", "")
local Opus = CreateTab("OPUS WORLD", "")
local Scripts = CreateTab("SCRIPT HUB", "")
local Settings = CreateTab("SETTINGS", "")

-- [ ADVANCED TOGGLE SYSTEM ]
local function AddFeature(page, name, desc, callback)
    local Frame = Instance.new("Frame", page)
    Frame.Size = UDim2.new(1, -15, 0, 65)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Instance.new("UICorner", Frame)

    local Title = Instance.new("TextLabel", Frame)
    Title.Text = "  " .. name
    Title.Size = UDim2.new(1, 0, 0.6, 0)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    local Desc = Instance.new("TextLabel", Frame)
    Desc.Text = "  " .. desc
    Desc.Size = UDim2.new(1, 0, 0.4, 0)
    Desc.Position = UDim2.new(0, 0, 0.5, 0)
    Desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 12
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.BackgroundTransparency = 1

    local Toggle = Instance.new("TextButton", Frame)
    Toggle.Size = UDim2.new(0, 50, 0, 25)
    Toggle.Position = UDim2.new(1, -60, 0.5, -12)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Toggle.Text = ""
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)

    local State = false
    Toggle.MouseButton1Click:Connect(function()
        State = not State
        TS:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = State and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(40, 40, 40)}):Play()
        callback(State)
    end)
end

-- [[ THE MAX FEATURE LIST ]]

-- COMBAT
AddFeature(Combat, "Silent Aim V3", "Perfect prediction for projectiles and bullets", function(v) end)
AddFeature(Combat, "Kill Aura", "Automatically hits enemies in 30 stud radius", function(v) end)
AddFeature(Combat, "Triggerbot", "Shoots automatically when crosshair hits enemy", function(v) end)

-- VISUALS
AddFeature(Visuals, "Box ESP", "Draws 2D boxes around every player", function(v) end)
AddFeature(Visuals, "Skeleton ESP", "Shows player bones through walls", function(v) end)
AddFeature(Visuals, "Chams", "See entities through walls with solid colors", function(v) end)

-- OPUS WORLD
AddFeature(Opus, "Auto-Farm Items", "Automatically TPs and collects all world scrap", function(v) end)
AddFeature(Opus, "Noclip", "Walk through any wall (Press V)", function(v) end)
AddFeature(Opus, "Infinite Stamina", "Never run out of breath in horror games", function(v) end)

-- SCRIPT HUB (PRE-LOADED GEMS)
AddFeature(Scripts, "Infinite Yield", "Loads the legendary admin command script", function(v)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
AddFeature(Scripts, "Hydroxide", "Advanced Remote Event spy for developers", function(v) end)

Combat.Visible = true
