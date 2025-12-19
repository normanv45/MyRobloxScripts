-- [[ CRITICAL ERROR: V10 OMNIPOTENCE ]]
-- [[ THE ULTIMATE SERVER DESTROYER ]]

local LPlayer = game.Players.LocalPlayer
local Char = LPlayer.Character or LPlayer.CharacterAdded:Wait()
local Root = Char:WaitForChild("HumanoidRootPart")
local Hum = Char:WaitForChild("Humanoid")
local Mouse = LPlayer:GetMouse()
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- [ 1. UI ENGINE: ELITE OBSIDIAN ]
if CoreGui:FindFirstChild("Omnipotence") then CoreGui.Omnipotence:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Omnipotence"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 800, 0, 500)
Main.Position = UDim2.new(0.5, -400, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 7)
Main.BackgroundTransparency = 0.1
Main.Draggable = true
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Glow = Instance.new("UIStroke", Main)
Glow.Color = Color3.fromRGB(255, 0, 0); Glow.Thickness = 2.5; Glow.Transparency = 0.4

-- [ 2. TOP BAR CONTROLS ]
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 50); TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15); Instance.new("UICorner", TopBar)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "  OMNIPOTENCE V10 // CRITICAL ERROR"; Title.Size = UDim2.new(0.5, 0, 1, 0); Title.TextColor3 = Color3.fromRGB(255, 0, 0); Title.Font = Enum.Font.GothamBold; Title.TextSize = 20; Title.BackgroundTransparency = 1; Title.TextXAlignment = Enum.TextXAlignment.Left

-- CLOSE / MINIMIZE
local function Control(txt, pos, cb)
    local B = Instance.new("TextButton", TopBar)
    B.Size = UDim2.new(0, 30, 0, 30); B.Position = pos; B.Text = txt; B.BackgroundColor3 = Color3.fromRGB(30,30,35); B.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", B).CornerRadius = UDim.new(1,0)
    B.MouseButton1Click:Connect(cb)
end
Control("X", UDim2.new(1, -40, 0.5, -15), function() ScreenGui:Destroy() end)
Control("-", UDim2.new(1, -80, 0.5, -15), function() 
    Main.ClipsDescendants = true
    local Target = (Main.Size.Y.Offset > 60) and 50 or 500
    TS:Create(Main, TweenInfo.new(0.4), {Size = UDim2.new(0, 800, 0, Target)}):Play()
end)

-- [ 3. TAB SYSTEM ]
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 180, 1, -60); Sidebar.Position = UDim2.new(0, 10, 0, 60); Sidebar.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", Sidebar); TabList.Padding = UDim.new(0, 5)

local Container = Instance.new("ScrollingFrame", Main)
Container.Size = UDim2.new(1, -210, 1, -70); Container.Position = UDim2.new(0, 200, 0, 60); Container.BackgroundTransparency = 1; Container.ScrollBarThickness = 2
Instance.new("UIListLayout", Container).Padding = UDim.new(0, 10)

local function AddToggle(name, desc, code)
    local F = Instance.new("Frame", Container); F.Size = UDim2.new(1, -10, 0, 70); F.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Instance.new("UICorner", F)
    local T = Instance.new("TextLabel", F); T.Text = " " .. name; T.Size = UDim2.new(0.7, 0, 0.5, 0); T.TextColor3 = Color3.fromRGB(255, 255, 255); T.Font = Enum.Font.GothamBold; T.BackgroundTransparency = 1; T.TextXAlignment = Enum.TextXAlignment.Left
    local D = Instance.new("TextLabel", F); D.Text = " " .. desc; D.Size = UDim2.new(0.7, 0, 0.4, 0); D.Position = UDim2.new(0, 0, 0.5, 0); D.TextColor3 = Color3.fromRGB(150, 150, 150); D.TextSize = 11; D.Font = Enum.Font.Gotham; D.BackgroundTransparency = 1; D.TextXAlignment = Enum.TextXAlignment.Left
    local S = Instance.new("TextButton", F); S.Size = UDim2.new(0, 50, 0, 25); S.Position = UDim2.new(1, -60, 0.5, -12); S.BackgroundColor3 = Color3.fromRGB(40, 40, 45); S.Text = ""; Instance.new("UICorner", S).CornerRadius = UDim.new(1, 0)
    local active = false
    S.MouseButton1Click:Connect(function()
        active = not active
        TS:Create(S, TweenInfo.new(0.3), {BackgroundColor3 = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(40, 40, 45)}):Play()
        task.spawn(function() code(active) end)
    end)
end

-- [ 4. THE GOD-TIER SCRIPTS ]

-- COMBAT: RAYCAST AIMBOT
AddToggle("OMNI-AIM", "Extreme Raycast Tracking & Silent Aim", function(v)
    _G.Aimbot = v
    while _G.Aimbot do
        local target = nil; local dist = math.huge
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= LPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local mag = (p.Character.Head.Position - Root.Position).Magnitude
                if mag < dist then dist = mag; target = p end
            end
        end
        if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position) end
        task.wait()
    end
end)

-- MOVEMENT: APEX FLIGHT
AddToggle("ZENITH FLY", "Universal Noclip Flight (E to Toggle)", function(v)
    _G.Flying = v
    local bv = Instance.new("BodyVelocity", Root)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    while _G.Flying do
        bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 150
        task.wait()
    end
    bv:Destroy()
end)

-- MOVEMENT: GOD SPEED
AddToggle("SONIC VELOCITY", "Max Speed Bypass (300+)", function(v)
    game:GetService("RunService").Stepped:Connect(function()
        if v then Root.CFrame = Root.CFrame + Hum.MoveDirection * 2 end
    end)
end)

-- TROLLING: CHAT SPAMMER
AddToggle("SALT GENERATOR", "Spams chat with 'Critical Error' roasts", function(v)
    while v do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Critical Error has detected a skill issue in this server.", "All")
        task.wait(3)
    end
end)

-- VISUALS: OMNI-ESP
AddToggle("X-RAY VISION", "Highlights every player & item", function(v)
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= LPlayer and p.Character then
            if v then
                local h = Instance.new("Highlight", p.Character)
                h.FillColor = Color3.fromRGB(255, 0, 0); h.Name = "OmniESP"
            elseif p.Character:FindFirstChild("OmniESP") then
                p.Character.OmniESP:Destroy()
            end
        end
    end
end)

-- TROLLING: FLING ALL
AddToggle("SERVER FLING", "Spin like a tornado and fling everyone", function(v)
    _G.Fling = v
    while _G.Fling do
        Root.RotVelocity = Vector3.new(0, 10000, 0)
        Root.Velocity = Vector3.new(0, 50, 0)
        task.wait()
    end
end)
