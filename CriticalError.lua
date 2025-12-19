-- [[ CRITICAL ERROR: V11.5 MULTIVERSE ENGINE ]]
local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Mouse = LPlayer:GetMouse()

-- [ 1. BOOT & CLEANUP ]
if CoreGui:FindFirstChild("OmniV12") then CoreGui.OmniV11:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "OmniV12"

-- [ 2. THE OBSIDIAN FRAME ]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 850, 0, 550)
Main.Position = UDim2.new(0.5, -425, 0.5, -275)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Main.BackgroundTransparency = 0.1
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true 
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Glow = Instance.new("UIStroke", Main)
Glow.Color = Color3.fromRGB(255, 0, 0); Glow.Thickness = 3; Glow.Transparency = 0.5

-- [ 3. TOP BAR ]
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 50); TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15); Instance.new("UICorner", TopBar)
local Title = Instance.new("TextLabel", TopBar)
Title.Text = "  OMNIPOTENCE V12 // MULTIVERSE"; Title.Size = UDim2.new(0.5, 0, 1, 0); Title.TextColor3 = Color3.fromRGB(255, 0, 0); Title.Font = Enum.Font.GothamBold; Title.TextSize = 20; Title.BackgroundTransparency = 1; Title.TextXAlignment = Enum.TextXAlignment.Left

-- CLOSE / MINIMIZE
local function Control(txt, pos, cb)
    local B = Instance.new("TextButton", TopBar)
    B.Size = UDim2.new(0, 30, 0, 30); B.Position = pos; B.Text = txt; B.BackgroundColor3 = Color3.fromRGB(25,25,30); B.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", B).CornerRadius = UDim.new(1,0)
    B.MouseButton1Click:Connect(cb)
end
Control("X", UDim2.new(1, -40, 0.5, -15), function() ScreenGui:Destroy() end)
Control("-", UDim2.new(1, -80, 0.5, -15), function() 
    local Target = (Main.Size.Y.Offset > 60) and 50 or 550
    TS:Create(Main, TweenInfo.new(0.4), {Size = UDim2.new(0, 850, 0, Target)}):Play()
end)

-- [ 4. DYNAMIC TAB SYSTEM ]
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 180, 1, -60); Sidebar.Position = UDim2.new(0, 10, 0, 60); Sidebar.BackgroundTransparency = 1
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 5)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -210, 1, -70); Container.Position = UDim2.new(0, 200, 0, 60); Container.BackgroundTransparency = 1

local function CreateTab(name)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.CanvasSize = UDim2.new(0,0,5,0); Page.ScrollBarThickness = 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10)
    local B = Instance.new("TextButton", Sidebar)
    B.Size = UDim2.new(1, 0, 0, 40); B.BackgroundColor3 = Color3.fromRGB(20, 20, 25); B.Text = name; B.TextColor3 = Color3.fromRGB(200,200,200); B.Font = Enum.Font.GothamSemibold; Instance.new("UICorner", B)
    B.MouseButton1Click:Connect(function()
        for _, p in pairs(Container:GetChildren()) do p.Visible = false end
        Page.Visible = true
    end)
    return Page
end

-- TABS
local Combat = CreateTab("COMBAT / TITAN")
local Farm = CreateTab("AUTO-FARM / SIM")
local Movement = CreateTab("MOVEMENT")
local Troll = CreateTab("TROLL / WORLD")

-- FEATURE ADDER
local function AddFeature(page, name, desc, code)
    local F = Instance.new("Frame", page); F.Size = UDim2.new(1, -10, 0, 75); F.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Instance.new("UICorner", F)
    local T = Instance.new("TextLabel", F); T.Text = " " .. name; T.Size = UDim2.new(0.7, 0, 0.5, 0); T.TextColor3 = Color3.fromRGB(255, 255, 255); T.Font = Enum.Font.GothamBold; T.BackgroundTransparency = 1; T.TextXAlignment = Enum.TextXAlignment.Left
    local D = Instance.new("TextLabel", F); D.Text = " " .. desc; D.Size = UDim2.new(0.7, 0, 0.4, 0); D.Position = UDim2.new(0, 0, 0.5, 0); D.TextColor3 = Color3.fromRGB(120, 120, 120); D.TextSize = 12; D.Font = Enum.Font.Gotham; D.BackgroundTransparency = 1; D.TextXAlignment = Enum.TextXAlignment.Left
    local S = Instance.new("TextButton", F); S.Size = UDim2.new(0, 50, 0, 25); S.Position = UDim2.new(1, -60, 0.5, -12); S.BackgroundColor3 = Color3.fromRGB(40, 40, 45); S.Text = ""; Instance.new("UICorner", S).CornerRadius = UDim.new(1, 0)
    local active = false
    S.MouseButton1Click:Connect(function()
        active = not active
        S.BackgroundColor3 = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(40, 40, 45)
        task.spawn(function() code(active) end)
    end)
end

-- [ 5. THE ULTIMATE BACK-END SCRIPTS ]

-- TITAN KILLER (Auto-Nape Lock)
AddFeature(Combat, "TITAN SLAYER", "Auto-locks to the nape of Titans and swings", function(v)
    _G.TitanKill = v
    while _G.TitanKill do
        for _, t in pairs(workspace:GetDescendants()) do
            if t.Name == "Nape" and t:IsA("BasePart") then
                LPlayer.Character.HumanoidRootPart.CFrame = t.CFrame * CFrame.new(0, 0, 3)
            end
        end
        task.wait(0.1)
    end
end)

-- SIMULATOR AUTO-FARM
AddFeature(Farm, "SIMULATOR GOD", "Auto-clicks and Auto-collects everything", function(v)
    _G.AutoFarm = v
    while _G.AutoFarm do
        -- Trigger common Simulator "Click" remotes
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("ClickRemote") or game:GetService("ReplicatedStorage"):FindFirstChild("Click")
        if remote then remote:FireServer() end
        -- Collect nearby coins/drops
        for _, drop in pairs(workspace:GetChildren()) do
            if drop:IsA("BasePart") and (drop.Position - LPlayer.Character.HumanoidRootPart.Position).Magnitude < 50 then
                drop.CFrame = LPlayer.Character.HumanoidRootPart.CFrame
            end
        end
        task.wait(0.1)
    end
end)

-- TYCOON MONEY MAGNET
AddFeature(Farm, "TYCOON STEALER", "Automatically collects all money from droppers", function(v)
    while v do
        for _, part in pairs(workspace:GetDescendants()) do
            if part.Name == "Essence" or part.Name == "Part" and part.Parent.Name == "Debris" then
                part.CFrame = LPlayer.Character.HumanoidRootPart.CFrame
            end
        end
        task.wait(0.5)
    end
end)

-- UNIVERSAL ESP (Enhanced)
AddFeature(Troll, "ULTRA ESP", "See Players, NPCs, and Rare Items", function(v)
    for _, p in pairs(game.Players:GetPlayers()) do
        if v and p ~= LPlayer and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255,0,0)
        elseif not v and p.Character:FindFirstChild("Highlight") then
            p.Character.Highlight:Destroy()
        end
    end
end)

Combat.Visible = true
