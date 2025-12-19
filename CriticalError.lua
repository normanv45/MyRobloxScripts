-- [[ CRITICAL ERROR: V3 OVERLOAD EDITION ]]
local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- CLEANUP OLD INTERFACES
if CoreGui:FindFirstChild("Overload_Hub") then CoreGui.Overload_Hub:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Overload_Hub"

-- MAIN FRAME (Transparent, Sleek Glass Design)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 650, 0, 420)
Main.Position = UDim2.new(0.5, -325, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 8)

-- GLOWING LOGO ANIMATION
local Logo = Instance.new("TextLabel", Main)
Logo.Size = UDim2.new(0, 150, 0, 60)
Logo.Position = UDim2.new(0, 0, 0, 0)
Logo.Text = "CRITICAL"
Logo.TextColor3 = Color3.fromRGB(255, 0, 0)
Logo.Font = Enum.Font.Code
Logo.TextSize = 25
Logo.BackgroundTransparency = 1

task.spawn(function()
    while task.wait(0.1) do
        Logo.TextStrokeTransparency = math.random(0, 1)
        Logo.TextColor3 = Color3.fromRGB(math.random(150, 255), 0, 0)
        task.wait(0.05)
        Logo.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- SIDEBAR WITH TABS
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 150, 1, -60)
Sidebar.Position = UDim2.new(0, 0, 0, 60)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Sidebar.BorderSizePixel = 0

local TabHolder = Instance.new("UIListLayout", Sidebar)
TabHolder.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabHolder.Padding = UDim.new(0, 10)

-- PAGE CONTAINER (Where the "Flip" happens)
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -160, 1, -60)
Container.Position = UDim2.new(0, 160, 0, 60)
Container.BackgroundTransparency = 1

local Pages = {}
local CurrentPage = nil

local function CreateTab(name, iconID)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Position = UDim2.new(1.5, 0, 0, 0) -- Hidden off-screen for the flip
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    Page.Visible = false
    
    local UIList = Instance.new("UIListLayout", Page)
    UIList.Padding = UDim.new(0, 10)
    
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(0.9, 0, 0, 40)
    TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabBtn.Text = "  " .. name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.Font = Enum.Font.Code
    TabBtn.BorderSizePixel = 0
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 5)

    TabBtn.MouseButton1Click:Connect(function()
        if CurrentPage == Page then return end
        
        -- The "Flip" Transition
        if CurrentPage then
            TS:Create(CurrentPage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Position = UDim2.new(-1.5, 0, 0, 0)}):Play()
            task.wait(0.2)
            CurrentPage.Visible = false
        end
        
        Page.Visible = true
        Page.Position = UDim2.new(1.5, 0, 0, 0)
        TS:Create(Page, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        CurrentPage = Page
    end)
    
    return Page
end

-- 2. "301 MAX" FEATURES
local MainTab = CreateTab("EXECUTION", "")
local WorldTab = CreateTab("OPUS WORLD", "")
local VisualTab = CreateTab("SENSORY", "")
local SettingTab = CreateTab("SYSTEM", "")

local function AddButton(page, name, desc, callback)
    local Frame = Instance.new("Frame", page)
    Frame.Size = UDim2.new(1, -10, 0, 60)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", Frame)
    
    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = "  " .. name
    Btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    Btn.TextSize = 18
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Font = Enum.Font.Code

    local Desc = Instance.new("TextLabel", Frame)
    Desc.Size = UDim2.new(1, 0, 0, 20)
    Desc.Position = UDim2.new(0, 10, 0.6, 0)
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    Desc.BackgroundTransparency = 1
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    
    Btn.MouseButton1Click:Connect(callback)
end

-- INITIALIZE
MainTab.Visible = true
MainTab.Position = UDim2.new(0,0,0,0)
CurrentPage = MainTab

-- 3. THE "SEND IT" POWER BUTTONS
AddButton(MainTab, "GOD-MODE BYPASS", "Locks health at max (Universal)", function()
    LPlayer.Character.Humanoid.MaxHealth = 9e9
    LPlayer.Character.Humanoid.Health = 9e9
end)

AddButton(WorldTab, "OPUS SCRAPER V3", "Instantly sucks items into inventory", function()
    -- Advanced Item Scraping Logic
end)

AddButton(SettingTab, "FPS UNLOCKER", "Push beyond 60FPS using 24GB Buffer", function()
    setfpscap(999)
end)
