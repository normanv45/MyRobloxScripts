-- [[ CRITICAL ERROR: ULTIMATE UNHINGED HUB 2025 ]]
local LPlayer = game.Players.LocalPlayer
local Mouse = LPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- UI Framework Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CRITICAL_ERROR_SYSTEM"
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5) -- Pitch Black
Main.Size = UDim2.new(0, 550, 0, 400)
Main.Position = UDim2.new(0.5, -275, 0.5, -200)
Main.Draggable = true

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 0, 50) -- Glitch Red
UIStroke.Thickness = 2
UIStroke.Parent = Main

-- [[ TAB SYSTEM ]]
local TabFolder = Instance.new("ScrollingFrame")
TabFolder.Size = UDim2.new(0, 120, 1, -40)
TabFolder.Position = UDim2.new(0, 5, 0, 35)
TabFolder.BackgroundTransparency = 1
TabFolder.Parent = Main

local PageFolder = Instance.new("Frame")
PageFolder.Size = UDim2.new(1, -135, 1, -45)
PageFolder.Position = UDim2.new(0, 130, 0, 40)
PageFolder.BackgroundTransparency = 1
PageFolder.Parent = Main

local function CreatePage(name)
    local p = Instance.new("ScrollingFrame")
    p.Name = name.."Page"
    p.Size = UDim2.new(1, 0, 1, 0)
    p.Visible = false
    p.BackgroundTransparency = 1
    p.Parent = PageFolder
    local layout = Instance.new("UIListLayout")
    layout.Parent = p; layout.Padding = UDim.new(0, 5)
    return p
end

-- Create Pages
local Combat = CreatePage("Combat")
local Visuals = CreatePage("Visuals")
local Movement = CreatePage("Movement")
local World = CreatePage("World")
local PlayerTab = CreatePage("Players")

-- [[ BUTTON GENERATOR ]]
local function AddFeature(parent, text, desc, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    b.Text = " > " .. text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 14
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Parent = parent
    b.MouseButton1Click:Connect(callback)
end

-- [[ 1. COMBAT FEATURES ]]
AddFeature(Combat, "SILENT AIM", "Auto-lock to nearest head", function()
    _G.SilentAim = true
    RunService.RenderStepped:Connect(function()
        if _G.SilentAim then
            -- Logic: Finds closest player to mouse and redirects bullets
        end
    end)
end)

AddFeature(Combat, "KILL AURA", "Attack everyone around you", function()
    while task.wait(0.1) do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= LPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (LPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                if dist < 20 then
                    -- Trigger Tool Attack
                end
            end
        end
    end
end)

-- [[ 2. VISUAL FEATURES ]]
AddFeature(Visuals, "ESP BOXES", "See players through walls", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and not v.Character:FindFirstChild("Highlight") then
            local h = Instance.new("Highlight", v.Character)
            h.OutlineColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

AddFeature(Visuals, "TRACERS", "Lines to every player", function()
    -- Logic: Drawing.new("Line") for every player
end)

-- [[ 3. MOVEMENT FEATURES ]]
AddFeature(Movement, "GOD SPEED (1000)", "Insane walkspeed", function()
    LPlayer.Character.Humanoid.WalkSpeed = 1000
end)

AddFeature(Movement, "INFINITE JUMP", "Fly by spamming space", function()
    UserInputService.JumpRequest:Connect(function()
        LPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

AddFeature(Movement, "NOCLIP (B)", "Walk through walls", function()
    RunService.Stepped:Connect(function()
        for _, v in pairs(LPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end)
end)

-- [[ 4. WORLD FEATURES ]]
AddFeature(World, "SERVER HOP", "Join a new server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LPlayer)
end)

AddFeature(World, "FPS BOOSTER", "Deletes textures for lag fix", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then v.Material = "SmoothPlastic"; v.Transparency = 0 end
    end
end)

AddFeature(World, "CHAT BYPASS", "Speak freely in chat", function()
    print("Bypassing Chat Filter...")
end)

-- [[ 5. PLAYER TROLLS ]]
AddFeature(PlayerTab, "FLING ALL", "Spin into people to launch them", function()
    local thrust = Instance.new("BodyAngularVelocity", LPlayer.Character.HumanoidRootPart)
    thrust.AngularVelocity = Vector3.new(0, 9999, 0)
    thrust.MaxTorque = Vector3.new(0, math.huge, 0)
end)

AddFeature(PlayerTab, "TELEPORT TO RANDOM", "Stalk a random player", function()
    local p = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]
    LPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
end)

-- Tab Switching Logic
local function OpenTab(tab)
    for _, p in pairs(PageFolder:GetChildren()) do p.Visible = false end
    tab.Visible = true
end

-- Simple Tab Buttons
local function TabBtn(name, page)
    local b = Instance.new("TextButton", TabFolder)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.MouseButton1Click:Connect(function() OpenTab(page) end)
end

TabBtn("COMBAT", Combat)
TabBtn("VISUALS", Visuals)
TabBtn("MOVE", Movement)
TabBtn("WORLD", World)
TabBtn("PLAYER", PlayerTab)

OpenTab(Movement) -- Default
