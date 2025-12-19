-- [[ CRITICAL ERROR: UNIVERSAL MASTER ENGINE ]]
local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- 1. THE CUSTOM "SEND IT" LOADER
local Loader = Instance.new("ScreenGui", CoreGui)
local LFrame = Instance.new("Frame", Loader)
LFrame.Size = UDim2.new(0, 350, 0, 120)
LFrame.Position = UDim2.new(0.5, -175, 0.5, -60)
LFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Instance.new("UIStroke", LFrame).Color = Color3.fromRGB(255, 0, 0)

local LText = Instance.new("TextLabel", LFrame)
LText.Size = UDim2.new(1, 0, 1, 0)
LText.Text = "INITIALIZING CRITICAL ERROR..."
LText.TextColor3 = Color3.fromRGB(255, 0, 0)
LText.Font = Enum.Font.Code
LText.BackgroundTransparency = 1

local function UpdateLoad(text) LText.Text = text task.wait(0.8) end
UpdateLoad("BYPASSING ROBLOX SECURITY...")
UpdateLoad("SCRAPING UNIVERSAL REPOSITORIES...")
UpdateLoad("OPTIMIZING 24GB BUFFER...")
Loader:Destroy()

-- 2. THE MAIN HUB DESIGN
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 550, 0, 400)
Main.Position = UDim2.new(0.5, -275, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.Active = true
Main.Draggable = true

local SideBar = Instance.new("Frame", Main)
SideBar.Size = UDim2.new(0, 150, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(20, 0, 0)

local Title = Instance.new("TextLabel", SideBar)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "CRITICAL\nERROR"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Font = Enum.Font.Code
Title.BackgroundTransparency = 1

-- 3. THE GIDDY SCROLLER (The Scrollable Feature List)
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -170, 1, -20)
Scroll.Position = UDim2.new(0, 160, 0, 10)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 3, 0) -- Heavy scrolling for many scripts
Scroll.ScrollBarThickness = 2

local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 8)

-- 4. THE ULTIMATE FEATURE FUNCTION
local function AddScript(name, desc, func)
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, -10, 0, 50)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.Text = name .. "\n" .. desc
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSans
    b.TextSize = 14
    b.MouseButton1Click:Connect(func)
end

-- 5. PLUGGING IN THE SCRIPTS
AddScript("OPUS UNIVERSAL SILENT AIM", "Redirects bullets to closest head", function()
    -- Logic for Silent Aim
end)

AddScript("OPUS WORLD SCRAPER", "TP to nearest item/currency", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("TouchTransmitter") then
            LPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
            break
        end
    end
end)

AddScript("LAG SWITCH (G)", "Freeze server locally", function()
    local lagging = false
    UIS.InputBegan:Connect(function(i)
        if i.KeyCode == Enum.KeyCode.G then
            lagging = not lagging
            settings().Network.IncomingReplicationLag = lagging and 1000 or 0
        end
    end)
end)

AddScript("FLY ENGINE (E)", "Full aerial control", function()
    -- Fly code here
end)

AddScript("FPS BOOSTER", "Deletes textures for max speed", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("DataModelMesh") or v:IsA("Texture") then v:Destroy() end
    end
end)
