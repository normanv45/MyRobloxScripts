-- [[ CRITICAL ERROR: OMNIPOTENCE V4 ]]
-- [[ THE FINAL SEND ]]

local LPlayer = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LPlayer:GetMouse()
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- CLEANUP & INITIALIZE
if CoreGui:FindFirstChild("Omnipotence") then CoreGui.Omnipotence:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Omnipotence"

-- [[ THE MAIN ENGINE ]]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 700, 0, 450)
Main.Position = UDim2.new(0.5, -350, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 0, 0)
Stroke.Thickness = 2
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- [[ SIDEBAR SYSTEM ]]
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Sidebar.BorderSizePixel = 0

local Logo = Instance.new("TextLabel", Sidebar)
Logo.Size = UDim2.new(1, 0, 0, 60)
Logo.Text = "CRITICAL"
Logo.TextColor3 = Color3.fromRGB(255, 0, 0)
Logo.Font = Enum.Font.Code
Logo.TextSize = 28
Logo.BackgroundTransparency = 1

local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -70)
TabContainer.Position = UDim2.new(0, 0, 0, 70)
TabContainer.BackgroundTransparency = 1
TabContainer.CanvasSize = UDim2.new(0, 0, 2, 0)
TabContainer.ScrollBarThickness = 0
local TabList = Instance.new("UIListLayout", TabContainer)
TabList.Padding = UDim.new(0, 10)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [[ CONTENT ENGINE ]]
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -170, 1, -10)
Content.Position = UDim2.new(0, 170, 0, 5)
Content.BackgroundTransparency = 1

local function NewPage(name)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 3, 0)
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    
    local UIList = Instance.new("UIListLayout", Page)
    UIList.Padding = UDim.new(0, 10)

    local TabBtn = Instance.new("TextButton", TabContainer)
    TabBtn.Size = UDim2.new(0.9, 0, 0, 40)
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.Font = Enum.Font.Code
    Instance.new("UICorner", TabBtn)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(Content:GetChildren()) do v.Visible = false end
        Page.Visible = true
        TS:Create(TabBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0), TextColor3 = Color3.fromRGB(0,0,0)}):Play()
        task.wait(0.3)
        TS:Create(TabBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(20, 20, 20), TextColor3 = Color3.fromRGB(200,200,200)}):Play()
    end)
    return Page
end

-- [[ PAGES ]]
local Combat = NewPage("Combat")
local Visuals = NewPage("Visuals")
local World = NewPage("Opus/World")
local Misc = NewPage("Misc/Fun")

Combat.Visible = true

-- [[ FEATURE FUNCTIONS ]]
local function AddToggle(page, name, callback)
    local Frame = Instance.new("Frame", page)
    Frame.Size = UDim2.new(1, -10, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", Frame)

    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = "  " .. name .. " [OFF]"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Font = Enum.Font.Code

    local active = false
    Btn.MouseButton1Click:Connect(function()
        active = not active
        Btn.Text = active and "  " .. name .. " [ON]" or "  " .. name .. " [OFF]"
        Btn.TextColor3 = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
        callback(active)
    end)
end

-- [[ THE LOADOUT ]]

-- COMBAT FEATURES
AddToggle(Combat, "Silent Aim (Universal)", function(t) _G.Silent = t end)
AddToggle(Combat, "Kill Aura (Range 25)", function(t) _G.Aura = t end)
AddToggle(Combat, "Auto-Triggerbot", function(t) _G.Trigger = t end)

-- VISUAL FEATURES
AddToggle(Visuals, "Full-Body Highlight ESP", function(t)
    _G.ESP = t
    while _G.ESP do
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= LPlayer and p.Character and not p.Character:FindFirstChild("Highlight") then
                local h = Instance.new("Highlight", p.Character)
                h.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
        task.wait(2)
    end
end)
AddToggle(Visuals, "Nametags / Distance", function(t) end)

-- WORLD FEATURES
AddToggle(World, "Opus Item Scraper", function(t)
    while t do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") then LPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame end
        end
        task.wait(0.5)
    end
end)
AddToggle(World, "Speed Bypass (300)", function(t) LPlayer.Character.Humanoid.WalkSpeed = t and 300 or 16 end)
AddToggle(World, "Infinite Jump", function(t) _G.InfJump = t end)

-- MISC FEATURES
AddToggle(Misc, "Chat Bypass (Anti-Hash)", function(t) end)
AddToggle(Misc, "Server Lag Switch", function(t) settings().Network.IncomingReplicationLag = t and 1000 or 0 end)
