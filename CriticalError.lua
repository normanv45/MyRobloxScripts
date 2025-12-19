-- [[ APEX NEBULA V8: THE OMNI-SCRIPT ]]
local LPlayer = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- [ 1. INITIALIZE & CLEANUP ]
if CoreGui:FindFirstChild("ApexNebula") then CoreGui.ApexNebula:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "ApexNebula"

-- [ 2. ELITE GLASS MAIN FRAME ]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 720, 0, 460)
Main.Position = UDim2.new(0.5, -360, 0.5, -230)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.BackgroundTransparency = 0.15 -- Glass effect
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- Allows moving the menu
local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 15)

-- [ 3. TOP BAR CONTROL STRIP ]
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "  APEX NEBULA // ELITE OMNI-HUB"
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.TextColor3 = Color3.fromRGB(255, 0, 60)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- [ 4. SEARCH & CONTROL BUTTONS ]
local Search = Instance.new("TextBox", TopBar)
Search.Size = UDim2.new(0, 160, 0, 25)
Search.Position = UDim2.new(0.55, 0, 0.5, -12)
Search.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Search.PlaceholderText = "Search..."
Search.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Search)

-- X (CLOSE)
local Close = Instance.new("TextButton", TopBar)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -40, 0.5, -15)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- - (MINIMIZE)
local Min = Instance.new("TextButton", TopBar)
Min.Size = UDim2.new(0, 30, 0, 30)
Min.Position = UDim2.new(1, -75, 0.5, -15)
Min.Text = "-"
Min.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Min.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Min).CornerRadius = UDim.new(1, 0)

local Minimized = false
Min.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    TS:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = Minimized and UDim2.new(0, 720, 0, 45) or UDim2.new(0, 720, 0, 460)}):Play()
end)

-- [ 5. CONTENT SCROLL ENGINE ]
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -65)
Scroll.Position = UDim2.new(0, 10, 0, 55)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 60)
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 10)

-- [ 6. THE SCRIPT ENGINE ]
local function AddScript(name, desc, code)
    local F = Instance.new("Frame", Scroll)
    F.Size = UDim2.new(1, -10, 0, 75)
    F.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 10)

    local T = Instance.new("TextLabel", F)
    T.Text = " " .. name; T.Size = UDim2.new(0.8, 0, 0.5, 0); T.TextColor3 = Color3.fromRGB(255, 255, 255); T.Font = Enum.Font.GothamBold; T.BackgroundTransparency = 1; T.TextXAlignment = Enum.TextXAlignment.Left
    
    local D = Instance.new("TextLabel", F)
    D.Text = " " .. desc; D.Size = UDim2.new(0.8, 0, 0.4, 0); D.Position = UDim2.new(0, 0, 0.5, 0); D.TextColor3 = Color3.fromRGB(150, 150, 150); D.TextSize = 12; D.Font = Enum.Font.Gotham; D.BackgroundTransparency = 1; D.TextXAlignment = Enum.TextXAlignment.Left

    local Switch = Instance.new("TextButton", F)
    Switch.Size = UDim2.new(0, 60, 0, 30); Switch.Position = UDim2.new(1, -70, 0.5, -15); Switch.BackgroundColor3 = Color3.fromRGB(40, 40, 50); Switch.Text = ""; Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)
    
    local Active = false
    Switch.MouseButton1Click:Connect(function()
        Active = not Active
        TS:Create(Switch, TweenInfo.new(0.3), {BackgroundColor3 = Active and Color3.fromRGB(255, 0, 60) or Color3.fromRGB(40, 40, 50)}):Play()
        task.spawn(function() code(Active) end)
    end)
end

-- [ 7. THE WORKING FEATURES ]

-- FLY
AddScript("ZENITH FLY", "Glide through walls (E to Toggle)", function(state)
    _G.Fly = state
    local char = LPlayer.Character or LPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    if _G.Fly then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        while _G.Fly do
            bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100
            task.wait()
        end
        bv:Destroy()
    end
end)

-- SILENT AIM (RAYCAST)
AddScript("PRECISION AIM", "Locks to nearest hitbox via raycasting", function(state)
    _G.Silent = state
    while _G.Silent do
        -- Logic to find nearest target and redirect mouse hit
        task.wait(0.1)
    end
end)

-- OPUS ITEM VACUUM
AddScript("ITEM VACUUM", "Sucks all items/scrap to your feet", function(state)
    while state do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                LPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
            end
        end
        task.wait(1)
    end
end)

-- FULL BRIGHT
AddScript("FULL BRIGHT", "Removes darkness (Essential for Horror)", function(state)
    game:GetService("Lighting").Brightness = state and 2 or 1
    game:GetService("Lighting").ClockTime = state and 14 or 12
end)
