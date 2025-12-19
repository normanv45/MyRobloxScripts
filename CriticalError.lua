-- [[ CRITICAL ERROR: V2 HORIZON NATIVE ]]
local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Clean up old versions
if CoreGui:FindFirstChild("Horizon_Hub") then CoreGui.Horizon_Hub:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Horizon_Hub"

-- MAIN FRAME
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Position = UDim2.new(0.5, -275, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- Standard for exploit menus

-- NEON ACCENT BORDER
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 0, 50)
Stroke.Thickness = 2

-- TOP BAR (Minimize / Close)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "  CRITICAL ERROR // V2"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.Code
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- THE MINIMIZE SYSTEM
local Minimized = false
local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -70, 0, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        Main:TweenSize(UDim2.new(0, 550, 0, 35), "Out", "Quint", 0.3, true)
        task.wait(0.3)
        Main.ClipsDescendants = true
    else
        Main.ClipsDescendants = false
        Main:TweenSize(UDim2.new(0, 550, 0, 350), "Out", "Quint", 0.3, true)
    end
end)

-- SIDEBAR (For Tabs)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 130, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.BorderSizePixel = 0

local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.CanvasSize = UDim2.new(0, 0, 1.5, 0)
TabContainer.ScrollBarThickness = 0

local TabList = Instance.new("UIListLayout", TabContainer)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Padding = UDim.new(0, 5)

-- CONTENT AREA (Where buttons go)
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -140, 1, -45)
Content.Position = UDim2.new(0, 135, 0, 40)
Content.BackgroundTransparency = 1

local Pages = {}
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 2, 0)
    Page.ScrollBarThickness = 2
    
    local PageList = Instance.new("UIListLayout", Page)
    PageList.Padding = UDim.new(0, 10)
    
    local TabBtn = Instance.new("TextButton", TabContainer)
    TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
    TabBtn.Text = name
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabBtn.Font = Enum.Font.Code
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
    end)
    
    Pages[name] = Page
    return Page
end

-- 2. ADDING THE BETTER TABS
local Combat = CreatePage("Combat")
local Visuals = CreatePage("Visuals")
local Opus = CreatePage("Opus/World")

-- UNIVERSAL BUTTON CREATOR
local function AddToggle(page, name, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(1, -10, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.Text = "  [OFF] " .. name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextXAlignment = Enum.TextXAlignment.Left
    
    local enabled = false
    b.MouseButton1Click:Connect(function()
        enabled = not enabled
        b.Text = enabled and "  [ON] " .. name or "  [OFF] " .. name
        b.TextColor3 = enabled and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(255, 255, 255)
        callback(enabled)
    end)
end

-- 3. LOAD THE GOD FEATURES
Combat.Visible = true -- Set default page

AddToggle(Combat, "Silent Aim", function(v) _G.SilentAim = v end)
AddToggle(Combat, "Kill Aura", function(v) _G.Aura = v end)

AddToggle(Visuals, "Entity ESP", function(v) 
    -- Trigger the ESP Highlight Script
end)

AddToggle(Opus, "Auto-Collect Scrap", function(v)
    while v do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("TouchTransmitter") then
                LPlayer.Character.HumanoidRootPart.CFrame = obj.Parent.CFrame
            end
        end
        task.wait(1)
    end
end)
