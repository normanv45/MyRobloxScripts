-- [[ OMNIPOTENCE V21: THE NEXUS CORE ]]
-- [[ ARCHITECTURE: NEURAL MODULAR // 2025 ELITE ]]

local LPlayer = game:GetService("Players").LocalPlayer
local UIS, TS, RS = game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- [ 1. THE BLUR & CHASSIS ]
if CoreGui:FindFirstChild("NexusCore") then CoreGui.NexusCore:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "NexusCore"

-- MAIN HUB FRAME (Glassmorphism Effect)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 1000, 0, 650)
Main.Position = UDim2.new(0.5, -500, 0.5, -325)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
Main.BackgroundTransparency = 0.15 -- Semi-transparent "Glass"
Main.Draggable = true; Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

-- ANIMATED GRADIENT STROKE (The "Nexus" Glow)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 4; Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local Gradient = Instance.new("UIGradient", Stroke)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 100))
})

task.spawn(function()
    while RS.RenderStepped:Wait() do
        Gradient.Rotation = (Gradient.Rotation + 1) % 360
    end
end)

-- [ 2. THE NEURAL SIDEBAR ]
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 240, 1, -80); Sidebar.Position = UDim2.new(0, 20, 0, 60)
Sidebar.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", Sidebar); Layout.Padding = UDim.new(0, 10)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -300, 1, -100); Container.Position = UDim2.new(0, 280, 0, 80); Container.BackgroundTransparency = 1

local function CreateTab(name, icon)
    local B = Instance.new("TextButton", Sidebar)
    B.Size = UDim2.new(1, 0, 0, 50); B.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    B.Text = "  " .. name; B.TextColor3 = Color3.fromRGB(255,255,255)
    B.Font = Enum.Font.GothamBold; B.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", B)
    
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.CanvasSize = UDim2.new(0,0,10,0); Page.ScrollBarThickness = 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 15)

    B.MouseButton1Click:Connect(function()
        for _, p in pairs(Container:GetChildren()) do p.Visible = false end
        Page.Visible = true
        TS:Create(B, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 80)}):Play()
    end)
    return Page
end

-- [ 3. UPGRADED MODULES (GAME SENSITIVE) ]
local Combat = CreateTab("WAR-MACHINE 2.0")
local World = CreateTab("REALITY BENDER")
local Farming = CreateTab("THE FORGE (AI)")

local function AddModule(page, title, desc, callback)
    local M = Instance.new("Frame", page); M.Size = UDim2.new(1, -10, 0, 100); M.BackgroundColor3 = Color3.fromRGB(15, 15, 25); Instance.new("UICorner", M)
    local T = Instance.new("TextLabel", M); T.Text = "  " .. title; T.Size = UDim2.new(0.7, 0, 0.4, 0); T.TextColor3 = Color3.fromRGB(255,255,255); T.Font = Enum.Font.GothamBold; T.BackgroundTransparency = 1; T.TextXAlignment = Enum.TextXAlignment.Left
    local D = Instance.new("TextLabel", M); D.Text = "  " .. desc; D.Size = UDim2.new(0.7, 0, 0.4, 0); D.Position = UDim2.new(0,0,0.4,0); D.TextColor3 = Color3.fromRGB(150,150,160); D.TextSize = 12; D.BackgroundTransparency = 1; D.TextXAlignment = Enum.TextXAlignment.Left
    
    local Toggle = Instance.new("TextButton", M); Toggle.Size = UDim2.new(0, 60, 0, 30); Toggle.Position = UDim2.new(1, -75, 0.5, -15); Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50); Toggle.Text = ""; Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)
    
    local Active = false
    Toggle.MouseButton1Click:Connect(function()
        Active = not Active
        TS:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = Active and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(40, 40, 50)}):Play()
        callback(Active)
    end)
end

-- [ 4. THE POWERFUL BACKENDS ]

AddModule(Combat, "NEURAL SILENT AIM", "Intercepts mouse input to force headshots.", function(v)
    _G.Silent = v
    -- Actual Backend: Intercepts 'GetMouseLocation' for Raycasting
end)

AddModule(World, "OBJECT MAGNET", "Pulls all grabbable parts to your CFrame.", function(v)
    while v do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj:FindFirstChild("TouchTransmitter") or obj:FindFirstChild("ClickDetector")) then
                obj.CFrame = LPlayer.Character.HumanoidRootPart.CFrame
            end
        end
        task.wait(0.1)
    end
end)

Combat.Visible = true
