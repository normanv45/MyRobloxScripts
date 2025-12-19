-- [[ CRITICAL ERROR: THE COMPLETE UNHINGED MASTER SCRIPT 2025 ]]
local LPlayer = game.Players.LocalPlayer
local Mouse = LPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CRITICAL_ERROR_SYSTEM"
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Main.Size = UDim2.new(0, 550, 0, 400)
Main.Position = UDim2.new(0.5, -275, 0.5, -200)
Main.Active = true
Main.Draggable = true

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 0, 50) -- Neon Red
UIStroke.Thickness = 2
UIStroke.Parent = Main

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Text = "CRITICAL ERROR // UNHINGED"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 0, 50)
Title.Font = Enum.Font.Code
Title.TextSize = 20

-- Tab & Page Logic
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Size = UDim2.new(0, 120, 1, -50)
TabContainer.Position = UDim2.new(0, 5, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Main

local PageFolder = Instance.new("Frame")
PageFolder.Size = UDim2.new(1, -135, 1, -55)
PageFolder.Position = UDim2.new(0, 130, 0, 50)
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

local Combat = CreatePage("Combat")
local Visuals = CreatePage("Visuals")
local Movement = CreatePage("Movement")
local World = CreatePage("World")

local function AddFeature(parent, text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    b.Text = " [ " .. text .. " ] "
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.Parent = parent
    b.MouseButton1Click:Connect(callback)
end

-- [[ FEATURES ]]

-- COMBAT (Aimbot)
AddFeature(Combat, "HEAD-LOCK AIMBOT", function()
    _G.Aimbot = true
    RunService.RenderStepped:Connect(function()
        if _G.Aimbot then
            local Target = nil
            local Dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= LPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    local Pos, OnScreen = Camera:WorldToScreenPoint(v.Character.Head.Position)
                    if OnScreen then
                        local Mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Pos.X, Pos.Y)).Magnitude
                        if Mag < Dist then Target = v; Dist = Mag end
                    end
                end
            end
            if Target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position) end
        end
    end)
end)

-- VISUALS (ESP)
AddFeature(Visuals, "NEON ESP", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and not v.Character:FindFirstChild("Highlight") then
            local h = Instance.new("Highlight", v.Character)
            h.OutlineColor = Color3.fromRGB(255, 0, 50)
        end
    end
end)

-- MOVEMENT
AddFeature(Movement, "GOD SPEED", function() LPlayer.Character.Humanoid.WalkSpeed = 500 end)
AddFeature(Movement, "NOCLIP (B)", function() 
    RunService.Stepped:Connect(function()
        for _, v in pairs(LPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end)
end)

-- WORLD (Destruction)
AddFeature(World, "SERVER HOP", function() game:GetService("TeleportService"):Teleport(game.PlaceId, LPlayer) end)
AddFeature(World, "LAG SERVER (SPAM)", function() 
    while task.wait() do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("CRITICAL ERROR LOADING...", "All") end
end)

-- Tab Switcher
local function TabBtn(name, page)
    local b = Instance.new("TextButton", TabContainer)
    b.Size = UDim2.new(1, 0, 0, 30); b.Text = name; b.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.MouseButton1Click:Connect(function()
        for _, p in pairs(PageFolder:GetChildren()) do p.Visible = false end
        page.Visible = true
    end)
end

TabBtn("COMBAT", Combat); TabBtn("VISUALS", Visuals); TabBtn("MOVE", Movement); TabBtn("WORLD", World)
Movement.Visible = true
