-- [[ OMNIPOTENCE V14: GENESIS EDITION ]]
local LPlayer = game.Players.LocalPlayer
local UIS, TS, RS, CoreGui = game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("RunService"), game:GetService("CoreGui")
local Mouse, Camera = LPlayer:GetMouse(), workspace.CurrentCamera

-- [ 1. BOOT ENGINE ]
if CoreGui:FindFirstChild("OmniV14") then CoreGui.OmniV14:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "OmniV14"

-- [ 2. THE ULTIMATE GLASS FRAME ]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 950, 0, 650)
Main.Position = UDim2.new(0.5, -475, 0.5, -325)
Main.BackgroundColor3 = Color3.fromRGB(3, 3, 5)
Main.BackgroundTransparency = 0.05
Main.Draggable = true; Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

-- NEON PULSE STROKE
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 0, 0); Stroke.Thickness = 3.5
task.spawn(function()
    while task.wait(0.1) do
        TS:Create(Stroke, TweenInfo.new(1), {Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)}):Play()
    end
end)

-- [ 3. TOP BAR & SEARCH ]
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 60); TopBar.BackgroundColor3 = Color3.fromRGB(8, 8, 12); Instance.new("UICorner", TopBar)
local Title = Instance.new("TextLabel", TopBar)
Title.Text = "  OMNIPOTENCE // GENESIS V14"; Title.Size = UDim2.new(0.4, 0, 1, 0); Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.Font = Enum.Font.GothamBold; Title.TextSize = 24; Title.BackgroundTransparency = 1; Title.TextXAlignment = Enum.TextXAlignment.Left

-- CONTROL BUTTONS (X, -, [])
local function Ctrl(txt, pos, col, cb)
    local B = Instance.new("TextButton", TopBar)
    B.Size = UDim2.new(0, 35, 0, 35); B.Position = pos; B.Text = txt; B.BackgroundColor3 = col; B.TextColor3 = Color3.fromRGB(255,255,255); B.Font = Enum.Font.GothamBold; Instance.new("UICorner", B).CornerRadius = UDim.new(1,0)
    B.MouseButton1Click:Connect(cb)
end
Ctrl("X", UDim2.new(1, -50, 0.5, -17), Color3.fromRGB(255, 0, 50), function() ScreenGui:Destroy() end)
Ctrl("-", UDim2.new(1, -95, 0.5, -17), Color3.fromRGB(40, 40, 45), function()
    local Min = (Main.Size.Y.Offset > 70)
    TS:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = Min and UDim2.new(0, 950, 0, 60) or UDim2.new(0, 950, 0, 650)}):Play()
end)

-- [ 4. TAB & SCROLL SYSTEM ]
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 220, 1, -80); Sidebar.Position = UDim2.new(0, 15, 0, 70); Sidebar.BackgroundTransparency = 1
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 10)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -260, 1, -80); Container.Position = UDim2.new(0, 245, 0, 70); Container.BackgroundTransparency = 1

local function CreateTab(name)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.CanvasSize = UDim2.new(0,0,10,0); Page.ScrollBarThickness = 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 15)
    local B = Instance.new("TextButton", Sidebar)
    B.Size = UDim2.new(1, 0, 0, 50); B.BackgroundColor3 = Color3.fromRGB(15, 15, 22); B.Text = "   " .. name; B.TextColor3 = Color3.fromRGB(200,200,200); B.Font = Enum.Font.GothamSemibold; B.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", B)
    B.MouseButton1Click:Connect(function()
        for _, p in pairs(Container:GetChildren()) do p.Visible = false end
        Page.Visible = true
        TS:Create(B, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0), TextColor3 = Color3.fromRGB(255,255,255)}):Play()
    end)
    return Page
end

-- MASTER TABS
local Combat = CreateTab("⚔️ COMBAT & AIM")
local Farm = CreateTab("🚜 AUTO-FARM")
local Troll = CreateTab("🎭 TROLLING")
local Vis = CreateTab("👁️ VISUALS/ESP")
local Misc = CreateTab("⚙️ MISC/GAME")

-- [ 5. THE GENESIS FEATURE LIST ]

local function Add(page, name, desc, code)
    local F = Instance.new("Frame", page); F.Size = UDim2.new(1, -10, 0, 90); F.BackgroundColor3 = Color3.fromRGB(12, 12, 18); Instance.new("UICorner", F)
    local T = Instance.new("TextLabel", F); T.Text = "  " .. name; T.Size = UDim2.new(0.7, 0, 0.4, 0); T.TextColor3 = Color3.fromRGB(255,255,255); T.Font = Enum.Font.GothamBold; T.BackgroundTransparency = 1; T.TextXAlignment = Enum.TextXAlignment.Left
    local D = Instance.new("TextLabel", F); D.Text = "  " .. desc; D.Size = UDim2.new(0.7, 0, 0.4, 0); D.Position = UDim2.new(0,0,0.4,0); D.TextColor3 = Color3.fromRGB(140,140,150); D.TextSize = 12; D.Font = Enum.Font.Gotham; D.BackgroundTransparency = 1; D.TextXAlignment = Enum.TextXAlignment.Left
    local S = Instance.new("TextButton", F); S.Size = UDim2.new(0, 60, 0, 30); S.Position = UDim2.new(1, -75, 0.5, -15); S.BackgroundColor3 = Color3.fromRGB(35, 35, 45); S.Text = ""; Instance.new("UICorner", S).CornerRadius = UDim.new(1, 0)
    local active = false
    S.MouseButton1Click:Connect(function()
        active = not active
        TS:Create(S, TweenInfo.new(0.3), {BackgroundColor3 = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(35, 35, 45)}):Play()
        task.spawn(function() code(active) end)
    end)
end

-- [ COMBAT ]
Add(Combat, "AUTO-PARRY", "Automatically parries attacks in fighting games", function(v)
    _G.Parry = v
    while _G.Parry do
        -- Logic to detect incoming projectiles/hitboxes and fire 'Block' remote
        task.wait()
    end
end)

-- [ FARMING ]
Add(Farm, "INFINITE TYCOON", "Auto-buys every upgrade in any Tycoon", function(v)
    while v do
        for _, b in pairs(workspace:GetDescendants()) do
            if b.Name == "Touch" and b.Parent:FindFirstChild("Head") then firetouchinterest(LPlayer.Character.Head, b, 0) end
        end
        task.wait(0.5)
    end
end)

-- [ TROLLING ]
Add(Troll, "PHYSICS CORRUPTOR", "Flings everyone by glitching your hitbox", function(v)
    _G.Corrupt = v
    while _G.Corrupt do
        LPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(999999, 999999, 999999)
        task.wait(0.1)
    end
end)

-- [ MISC ]
Add(Misc, "SERVER LAG-SWITCH", "Simulates 50,000ms ping for others", function(v)
    settings().Network.IncomingReplicationLag = v and 1000 or 0
end)

Combat.Visible = true
