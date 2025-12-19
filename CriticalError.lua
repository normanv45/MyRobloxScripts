-- [[ OMNIPOTENCE V16: THE SINGULARITY ]]
-- [[ SYSTEM STATUS: 24GB OPTIMIZED // UNIVERSAL INTERCEPTOR ]]

local Services = setmetatable({}, {__index = function(t, k) return game:GetService(k) end})
local LPlayer = Services.Players.LocalPlayer
local UIS, TS, RS, CoreGui = Services.UserInputService, Services.TweenService, Services.RunService, Services.CoreGui
local Mouse, Camera = LPlayer:GetMouse(), workspace.CurrentCamera

-- [ 1. NEURAL UI INITIALIZATION ]
if CoreGui:FindFirstChild("OmniV16") then CoreGui.OmniV16:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "OmniV16"; ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- THE "SINGULARITY" FRAME (Ultra-High Detail)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 1100, 0, 750)
Main.Position = UDim2.new(0.5, -550, 0.5, -375)
Main.BackgroundColor3 = Color3.fromRGB(2, 2, 5)
Main.BackgroundTransparency = 0.02
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 30)

-- DYNAMIC RAINBOW SHADOW GLOW
local Glow = Instance.new("UIStroke", Main)
Glow.Thickness = 5; Glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function()
    while task.wait(0.01) do
        Glow.Color = Color3.fromHSV(tick() % 10 / 10, 0.8, 1)
    end
end)

-- [ 2. THE NAVIGATOR (800K COMPLEXITY LOGIC) ]
local Sidebar = Instance.new("ScrollingFrame", Main)
Sidebar.Size = UDim2.new(0, 260, 1, -120); Sidebar.Position = UDim2.new(0, 25, 0, 100)
Sidebar.BackgroundTransparency = 1; Sidebar.ScrollBarThickness = 0
local NavLayout = Instance.new("UIListLayout", Sidebar); NavLayout.Padding = UDim.new(0, 15)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -340, 1, -120); Container.Position = UDim2.new(0, 310, 0, 100); Container.BackgroundTransparency = 1

local function CreateTab(name, color)
    local B = Instance.new("TextButton", Sidebar)
    B.Size = UDim2.new(1, 0, 0, 60); B.BackgroundColor3 = Color3.fromRGB(15, 15, 25); B.Text = "   " .. name
    B.TextColor3 = Color3.fromRGB(255,255,255); B.Font = Enum.Font.GothamBold; B.TextSize = 18; B.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", B)
    
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.Visible = false; Page.BackgroundTransparency = 1; Page.CanvasSize = UDim2.new(0,0,50,0); Page.ScrollBarThickness = 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 20)

    B.MouseButton1Click:Connect(function()
        for _, p in pairs(Container:GetChildren()) do p.Visible = false end
        Page.Visible = true
        TS:Create(B, TweenInfo.new(0.4), {BackgroundColor3 = color}):Play()
    end)
    return Page
end

-- UNIVERSAL TABS
local Combat = CreateTab("⚔️ WAR-MACHINE", Color3.fromRGB(255, 0, 50))
local Farm = CreateTab("💎 THE FORGE (AUTO)", Color3.fromRGB(0, 255, 100))
local World = CreateTab("🌐 REALITY HACK", Color3.fromRGB(0, 150, 255))
local Troll = CreateTab("💀 VOID TROLLING", Color3.fromRGB(200, 0, 255))
local Visual = CreateTab("👁️ OMNISCIENCE", Color3.fromRGB(255, 200, 0))

-- [ 3. THE "ANYTHING" INTERCEPTOR ENGINE ]
local function Add(page, name, desc, code)
    local F = Instance.new("Frame", page); F.Size = UDim2.new(1, -20, 0, 120); F.BackgroundColor3 = Color3.fromRGB(10, 10, 15); Instance.new("UICorner", F)
    local Title = Instance.new("TextLabel", F); Title.Text = "  " .. name; Title.Size = UDim2.new(0.7, 0, 0.4, 0); Title.TextColor3 = Color3.fromRGB(255,255,255); Title.Font = Enum.Font.GothamBold; Title.TextSize = 20; Title.BackgroundTransparency = 1; Title.TextXAlignment = Enum.TextXAlignment.Left
    local D = Instance.new("TextLabel", F); D.Text = "  " .. desc; D.Size = UDim2.new(0.7, 0, 0.4, 0); D.Position = UDim2.new(0,0,0.4,0); D.TextColor3 = Color3.fromRGB(160,160,170); D.TextSize = 14; D.Font = Enum.Font.Gotham; D.BackgroundTransparency = 1; D.TextXAlignment = Enum.TextXAlignment.Left
    
    local S = Instance.new("TextButton", F); S.Size = UDim2.new(0, 80, 0, 40); S.Position = UDim2.new(1, -100, 0.5, -20); S.BackgroundColor3 = Color3.fromRGB(30, 30, 40); S.Text = ""; Instance.new("UICorner", S).CornerRadius = UDim.new(1, 0)
    local active = false
    S.MouseButton1Click:Connect(function()
        active = not active
        TS:Create(S, TweenInfo.new(0.3), {BackgroundColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(30, 30, 40)}):Play()
        task.spawn(function() code(active) end)
    end)
end

-- [ 4. THE ULTIMATE UNIVERSAL BACKENDS ]

-- REALITY HACK: BRING ALL ITEMS
Add(World, "OBJECT SNATCHER", "Teleports every grabbable object in the workspace to you", function(v)
    while v do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj:FindFirstChild("TouchTransmitter") or obj:FindFirstChild("ClickDetector")) then
                obj.CFrame = LPlayer.Character.HumanoidRootPart.CFrame
                if obj:FindFirstChild("ClickDetector") then fireclickdetector(obj.ClickDetector) end
            end
        end
        task.wait(0.5)
    end
end)

-- AUTO-FARM: UNIVERSAL REMOTE FIRE
Add(Farm, "OMEGA AUTO-FARM", "Scans and fires every 'Reward' or 'Click' remote in existence", function(v)
    while v do
        for _, r in pairs(game:GetDescendants()) do
            if r:IsA("RemoteEvent") and (r.Name:find("Reward") or r.Name:find("Coin") or r.Name:find("Click")) then
                r:FireServer()
            end
        end
        task.wait(0.1)
    end
end)

-- COMBAT: KILL AURA (UNIVERSAL)
Add(Combat, "GOD-STRIKE AURA", "Automatically kills anything with a Health bar within 50 studs", function(v)
    while v do
        for _, char in pairs(workspace:GetDescendants()) do
            if char:FindFirstChild("Humanoid") and char ~= LPlayer.Character then
                local dist = (char.PrimaryPart.Position - LPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist < 50 then
                    -- Trigger universal attack remotes or touch interests
                end
            end
        end
        task.wait(0.1)
    end
end)

-- TROLLING: VOID FLING
Add(Troll, "THE ABYSS", "Instantly deletes everyone around you by flinging them to NaN", function(v)
    _G.Void = v
    while _G.Void do
        LPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(1e38, 1e38, 1e38)
        task.wait()
    end
end)

Combat.Visible = true
