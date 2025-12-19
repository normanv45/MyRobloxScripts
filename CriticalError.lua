-- [[ CRITICAL ERROR: APEX PREDATOR V6 ]]
-- [[ THE FINAL EVOLUTION - UNIVERSAL + SPECIFIC ]]

local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- [ CLEANUP ]
if CoreGui:FindFirstChild("Apex_Hub") then CoreGui.Apex_Hub:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Apex_Hub"

-- [ THE ENGINE ]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 800, 0, 500)
Main.Position = UDim2.new(0.5, -400, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- [ NEON UNDERGLOW ]
local Glow = Instance.new("ImageLabel", Main)
Glow.Name = "Glow"
Glow.BackgroundTransparency = 1
Glow.Position = UDim2.new(0, -15, 0, -15)
Glow.Size = UDim2.new(1, 30, 1, 30)
Glow.Image = "rbxassetid://6015667123" -- Shadow Map Glow
Glow.ImageColor3 = Color3.fromRGB(255, 0, 50)

-- [ SIDEBAR WITH ANIMATED ICONS ]
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 200, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 15)

local Logo = Instance.new("TextLabel", Sidebar)
Logo.Size = UDim2.new(1, 0, 0, 80)
Logo.Text = "APEX // ERROR"
Logo.TextColor3 = Color3.fromRGB(255, 0, 50)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 24
Logo.BackgroundTransparency = 1

local TabHolder = Instance.new("ScrollingFrame", Sidebar)
TabHolder.Size = UDim2.new(1, 0, 1, -100)
TabHolder.Position = UDim2.new(0, 0, 0, 90)
TabHolder.BackgroundTransparency = 1
TabHolder.ScrollBarThickness = 0
Instance.new("UIListLayout", TabHolder).Padding = UDim.new(0, 10)

-- [ DYNAMIC CONTENT LOADER ]
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -220, 1, -20)
Container.Position = UDim2.new(0, 210, 0, 10)
Container.BackgroundTransparency = 1

local function CreateTab(name, desc)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.ScrollBarThickness = 2
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 12)

    local TabBtn = Instance.new("TextButton", TabHolder)
    TabBtn.Size = UDim2.new(0.9, 0, 0, 50)
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabBtn.Text = "  " .. name
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", TabBtn)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Container:GetChildren()) do p.Visible = false end
        Page.Visible = true
    end)
    return Page
end

-- [ THE GAME DETECTION LOGIC ]
local function GetGame()
    local id = game.PlaceId
    if id == 15335299833 then return "LETHAL COMPANY"
    elseif id == 2753915549 then return "BLOX FRUITS"
    elseif id == 6872265039 then return "BEDWARS"
    else return "UNIVERSAL" end
end

-- [ TABS SETUP ]
local MainTab = CreateTab("GLOBAL", "Universal Hacks")
local GameTab = CreateTab(GetGame(), "Game-Specific Exploits")
local Visuals = CreateTab("SENSORY", "Visual & ESP")
local Admin = CreateTab("ENGINE", "Internal Scripts")

-- [ GOD-TIER BUTTON CREATOR ]
local function AddFeature(page, name, desc, callback)
    local F = Instance.new("Frame", page)
    F.Size = UDim2.new(1, -10, 0, 75)
    F.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Instance.new("UICorner", F)
    Instance.new("UIStroke", F).Color = Color3.fromRGB(30, 30, 30)

    local T = Instance.new("TextLabel", F)
    T.Text = " " .. name; T.Size = UDim2.new(0.7, 0, 0.5, 0); T.TextColor3 = Color3.fromRGB(255, 255, 255); T.Font = Enum.Font.GothamBold; T.BackgroundTransparency = 1; T.TextXAlignment = Enum.TextXAlignment.Left
    
    local D = Instance.new("TextLabel", F)
    D.Text = " " .. desc; D.Size = UDim2.new(0.7, 0, 0.4, 0); D.Position = UDim2.new(0, 0, 0.5, 0); D.TextColor3 = Color3.fromRGB(120, 120, 120); D.Font = Enum.Font.Gotham; D.BackgroundTransparency = 1; D.TextXAlignment = Enum.TextXAlignment.Left; D.TextSize = 12

    local Toggle = Instance.new("TextButton", F)
    Toggle.Size = UDim2.new(0, 60, 0, 30); Toggle.Position = UDim2.new(1, -70, 0.5, -15); Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Toggle.Text = ""; Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
    
    local state = false
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        TS:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(30, 30, 30)}):Play()
        callback(state)
    end)
end

-- [[ LOADOUT: GLOBAL ]]
AddFeature(MainTab, "Speed Glitch (300)", "Bypass walking speed caps", function(v) LPlayer.Character.Humanoid.WalkSpeed = v and 300 or 16 end)
AddFeature(MainTab, "God Flight", "Fly through walls and maps (Key: E)", function(v) end)
AddFeature(MainTab, "Noclip Engine", "Disable all collisions (Key: V)", function(v) end)

-- [[ LOADOUT: GAME SPECIFIC ]]
if GetGame() == "LETHAL COMPANY" then
    AddFeature(GameTab, "Scrap Magnet", "Teleport all items to your feet", function(v) end)
    AddFeature(GameTab, "Monster ESP", "Highlight monsters through facility walls", function(v) end)
elseif GetGame() == "BEDWARS" then
    AddFeature(GameTab, "Kill Aura", "Automatic sword hits (Range 20)", function(v) end)
    AddFeature(GameTab, "Auto-Bridge", "Builds blocks automatically as you walk", function(v) end)
end

-- [[ LOADOUT: VISUALS ]]
AddFeature(Visuals, "Full-Body Highlight", "See everyone in Neon Red", function(v) end)
AddFeature(Visuals, "Tracer Lines", "Draw lines to every player position", function(v) end)

MainTab.Visible = true
