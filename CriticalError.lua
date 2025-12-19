-- [[ CRITICAL ERROR: V8 APEX NEBULA ]]
local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("ApexNebula") then CoreGui.ApexNebula:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "ApexNebula"

-- [ MAIN FRAME WITH GLASS EFFECT ]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 720, 0, 460)
Main.Position = UDim2.new(0.5, -360, 0.5, -230)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true 
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 0, 60)
Stroke.Thickness = 2
Stroke.Transparency = 0.5

-- [ TOP BAR / CONTROL STRIP ]
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "  APEX NEBULA // ELITE"
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.TextColor3 = Color3.fromRGB(255, 0, 60)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- [ CONTROL BUTTONS: X / - ]
local function CreateControl(text, pos, color, callback)
    local B = Instance.new("TextButton", TopBar)
    B.Size = UDim2.new(0, 30, 0, 30)
    B.Position = pos
    B.Text = text
    B.BackgroundColor3 = color
    B.TextColor3 = Color3.fromRGB(255, 255, 255)
    B.Font = Enum.Font.GothamBold
    Instance.new("UICorner", B).CornerRadius = UDim.new(1, 0)
    B.MouseButton1Click:Connect(callback)
end

-- CLOSE (X)
CreateControl("X", UDim2.new(1, -40, 0.5, -15), Color3.fromRGB(200, 0, 0), function()
    ScreenGui:Destroy()
end)

-- MINIMIZE (-)
local Minimized = false
CreateControl("-", UDim2.new(1, -75, 0.5, -15), Color3.fromRGB(50, 50, 50), function()
    Minimized = not Minimized
    local targetHeight = Minimized and 45 or 460
    TS:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 720, 0, targetHeight)}):Play()
end)

-- [ FEATURE ADDER (WITH ICONS SPACE) ]
local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -20, 1, -70)
Content.Position = UDim2.new(0, 10, 0, 60)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 2, 0)
Content.ScrollBarThickness = 0
Instance.new("UIListLayout", Content).Padding = UDim.new(0, 10)

local function AddEliteFeature(name, desc, callback)
    local F = Instance.new("Frame", Content)
    F.Size = UDim2.new(1, -10, 0, 75)
    F.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 10)

    local T = Instance.new("TextLabel", F)
    T.Text = " " .. name; T.Size = UDim2.new(0.8, 0, 0.5, 0); T.TextColor3 = Color3.fromRGB(255, 255, 255); T.Font = Enum.Font.GothamBold; T.BackgroundTransparency = 1; T.TextXAlignment = Enum.TextXAlignment.Left
    
    local B = Instance.new("TextButton", F)
    B.Size = UDim2.new(0, 60, 0, 30); B.Position = UDim2.new(1, -70, 0.5, -15); B.BackgroundColor3 = Color3.fromRGB(40, 40, 50); B.Text = ""; Instance.new("UICorner", B).CornerRadius = UDim.new(1, 0)
    
    local state = false
    B.MouseButton1Click:Connect(function()
        state = not state
        TS:Create(B, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(255, 0, 60) or Color3.fromRGB(40, 40, 50)}):Play()
        callback(state)
    end)
end

AddEliteFeature("RAYCAST SILENT AIM", "Reduces spread and locks to nearest hitbox", function(v) end)
AddEliteFeature("OPUS ITEM VACUUM", "Instantly pulls all scrap items within 100 studs", function(v) end)
