-- [[ CRITICAL ERROR: V8 APEX NEBULA ]]
-- [[ THE FINAL MASTERPIECE ]]

local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- [ CLEANUP ]
if CoreGui:FindFirstChild("ApexNebula") then CoreGui.ApexNebula:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "ApexNebula"

-- [ THE NEBULA MAIN FRAME ]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 720, 0, 460)
Main.Position = UDim2.new(0.5, -360, 0.5, -230)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true 
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- [ TOP BAR / CONTROL STRIP ]
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TopBar.BorderSizePixel = 0
local TB_Corner = Instance.new("UICorner", TopBar)
TB_Corner.CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "  CRITICAL ERROR // APEX NEBULA"
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.TextColor3 = Color3.fromRGB(255, 0, 60)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- [ SEARCH BAR ]
local Search = Instance.new("TextBox", TopBar)
Search.Size = UDim2.new(0, 180, 0, 25)
Search.Position = UDim2.new(0.6, 0, 0.5, -12)
Search.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Search.Text = ""
Search.PlaceholderText = "Search Hacks..."
Search.TextColor3 = Color3.fromRGB(200, 200, 200)
Instance.new("UICorner", Search)

-- [ CONTROL BUTTONS: X / - / [] ]
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
    return B
end

-- CLOSE (X)
CreateControl("X", UDim2.new(1, -40, 0.5, -15), Color3.fromRGB(200, 0, 0), function()
    ScreenGui:Destroy()
end)

-- MINIMIZE (-)
local Minimized = false
CreateControl("-", UDim2.new(1, -75, 0.5, -15), Color3.fromRGB(50, 50, 50), function()
    Minimized = not Minimized
    TS:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = Minimized and UDim2.new(0, 720, 0, 45) or UDim2.new(0, 720, 0, 460)}):Play()
end)

-- [ CONTENT AREA ]
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -20, 1, -65)
Content.Position = UDim2.new(0, 10, 0, 55)
Content.BackgroundTransparency = 1

-- [ TAB SYSTEM ]
local TabHolder = Instance.new("Frame", Content)
TabHolder.Size = UDim2.new(0, 160, 1, 0)
TabHolder.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", TabHolder)
TabList.Padding = UDim.new(0, 10)

-- [ FINAL TOGGLE WITH ANIMATED DOT ]
local function AddFeature(name, callback)
    local F = Instance.new("Frame", Content) -- Simple placement for now
    F.Size = UDim2.new(0.7, 0, 0, 60)
    F.Position = UDim2.new(0.25, 0, 0, 0)
    F.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", F)

    local T = Instance.new("TextLabel", F)
    T.Text = "  " .. name; T.Size = UDim2.new(1, 0, 1, 0); T.TextColor3 = Color3.fromRGB(255, 255, 255); T.Font = Enum.Font.GothamBold; T.BackgroundTransparency = 1; T.TextXAlignment = Enum.TextXAlignment.Left
    
    local B = Instance.new("TextButton", F)
    B.Size = UDim2.new(0, 50, 0, 26); B.Position = UDim2.new(1, -60, 0.5, -13); B.BackgroundColor3 = Color3.fromRGB(40, 40, 50); B.Text = ""; Instance.new("UICorner", B).CornerRadius = UDim.new(1, 0)
    
    local state = false
    B.MouseButton1Click:Connect(function()
        state = not state
        TS:Create(B, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(255, 0, 60) or Color3.fromRGB(40, 40, 50)}):Play()
        callback(state)
    end)
end

AddFeature("OPUS SCRAPER", function(v) end)
AddFeature("ZENITH FLY", function(v) end)
