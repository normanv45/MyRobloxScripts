-- [[ CRITICAL ERROR: V7 OBSIDIAN SHADOW ]]
-- [[ THE FINAL ASCENSION - ELITE UI CORE ]]

local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- [ CLEANUP ]
if CoreGui:FindFirstChild("Obsidian") then CoreGui.Obsidian:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Obsidian"

-- [ THE GLASS MAIN FRAME ]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 680, 0, 430)
Main.Position = UDim2.new(0.5, -340, 0.5, -215)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BackgroundTransparency = 0.1 -- Glass effect
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

-- [ THE INNER GLOW BORDER ]
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 0, 60)
Stroke.Thickness = 2.5
Stroke.Transparency = 0.4

-- [ SIDEBAR DESIGN ]
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 20)

local Logo = Instance.new("TextLabel", Sidebar)
Logo.Size = UDim2.new(1, 0, 0, 90)
Logo.Text = "OBSIDIAN"
Logo.TextColor3 = Color3.fromRGB(255, 0, 60)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 26
Logo.BackgroundTransparency = 1

local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -110)
TabContainer.Position = UDim2.new(0, 0, 0, 100)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0
local TabList = Instance.new("UIListLayout", TabContainer)
TabList.Padding = UDim.new(0, 12)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [ CONTENT PAGE LOADER ]
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -210, 1, -20)
Container.Position = UDim2.new(0, 200, 0, 15)
Container.BackgroundTransparency = 1

local function CreateTab(name)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.ScrollBarThickness = 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 15)

    local TabBtn = Instance.new("TextButton", TabContainer)
    TabBtn.Size = UDim2.new(0.85, 0, 0, 45)
    TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabBtn.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Container:GetChildren()) do 
            if p:IsA("ScrollingFrame") then p.Visible = false end
        end
        Page.Visible = true
        TS:Create(TabBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 60), TextColor3 = Color3.fromRGB(255,255,255)}):Play()
        task.wait(0.3)
        TS:Create(TabBtn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(25, 25, 30), TextColor3 = Color3.fromRGB(180,180,180)}):Play()
    end)
    return Page
end

-- [ TILED BUTTON CREATOR ]
local function AddFeature(page, name, desc, callback)
    local Tile = Instance.new("Frame", page)
    Tile.Size = UDim2.new(1, -10, 0, 70)
    Tile.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", Tile).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", Tile).Color = Color3.fromRGB(40, 40, 45)

    local Title = Instance.new("TextLabel", Tile)
    Title.Text = name
    Title.Size = UDim2.new(0.7, 0, 0.5, 0)
    Title.Position = UDim2.new(0, 15, 0.1, 0)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    local Desc = Instance.new("TextLabel", Tile)
    Desc.Text = desc
    Desc.Size = UDim2.new(0.7, 0, 0.4, 0)
    Desc.Position = UDim2.new(0, 15, 0.5, 0)
    Desc.TextColor3 = Color3.fromRGB(130, 130, 140)
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.BackgroundTransparency = 1

    local Switch = Instance.new("TextButton", Tile)
    Switch.Size = UDim2.new(0, 50, 0, 26)
    Switch.Position = UDim2.new(1, -65, 0.5, -13)
    Switch.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Switch.Text = ""
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)
    
    local Dot = Instance.new("Frame", Switch)
    Dot.Size = UDim2.new(0, 18, 0, 18)
    Dot.Position = UDim2.new(0, 4, 0.5, -9)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    local active = false
    Switch.MouseButton1Click:Connect(function()
        active = not active
        TS:Create(Switch, TweenInfo.new(0.3), {BackgroundColor3 = active and Color3.fromRGB(255, 0, 60) or Color3.fromRGB(40, 40, 50)}):Play()
        TS:Create(Dot, TweenInfo.new(0.3), {Position = active and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 4, 0.5, -9)}):Play()
        callback(active)
    end)
end

-- [ TABS SETUP ]
local Combat = CreateTab("COMBAT")
local Visuals = CreateTab("SENSORY")
local Opus = CreateTab("OPUS WORLD")

Combat.Visible = true

-- [ FEATURES ]
AddFeature(Combat, "Silent Aim Engine", "Precision bullet redirection", function(v) end)
AddFeature(Combat, "Universal Kill Aura", "Auto-hit entities in range", function(v) end)
AddFeature(Visuals, "High-Res ESP", "Box, Skeleton, and Tracers", function(v) end)
AddFeature(Opus, "Scrap Magnet", "Lethal Company Item Gathering", function(v) end)
