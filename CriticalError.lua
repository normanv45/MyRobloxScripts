-- [[ OMNIPOTENCE V21: THE NEXUS CORE — SINGLE-FILE, SAFE, REFACTORED ]]
-- All-in-one LocalScript: modular structure, cleanup (Maid), theme, UI builder, and safe demo modules.
-- NOTE: This file intentionally avoids any exploit/cheat functionality. All features are local-only and visual/debugging oriented.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    warn("[NexusCore] LocalPlayer not available — run as a LocalScript.")
    return
end

-- ======= Maid (cleanup helper) =================================================
local Maid = {}
Maid.__index = Maid

function Maid.new()
    return setmetatable({ _tasks = {} }, Maid)
end

function Maid:Give(task)
    if not task then return end
    table.insert(self._tasks, task)
    return task
end

function Maid:DoCleaning()
    for _, task in ipairs(self._tasks) do
        local ttype = typeof(task)
        if ttype == "RBXScriptConnection" then
            pcall(function() task:Disconnect() end)
        elseif ttype == "Instance" then
            pcall(function() if task.Destroy then task:Destroy() end end)
        elseif ttype == "function" then
            pcall(task)
        end
    end
    self._tasks = {}
end

function Maid:Destroy()
    self:DoCleaning()
    setmetatable(self, nil)
end

-- ======= Theme / Config ======================================================
local Theme = {
    Colors = {
        Background = Color3.fromRGB(5,5,10),
        Panel = Color3.fromRGB(15,15,25),
        Accent = Color3.fromRGB(255,0,80),
        AccentAlt = Color3.fromRGB(0,200,255),
        Text = Color3.fromRGB(255,255,255),
        Subtext = Color3.fromRGB(150,150,160),
        ToggleOff = Color3.fromRGB(40,40,50),
        ToggleOn = Color3.fromRGB(0,200,120),
    },
    Sizes = {
        MainWidth = 1000,
        MainHeight = 650,
        SidebarWidth = 240,
    },
    Animation = {
        GradientRotateSpeed = 30, -- degrees per second
    },
}

-- ======= Utility constructor ==================================================
local function new(className, props)
    local inst = Instance.new(className)
    if props then
        for k, v in pairs(props) do
            inst[k] = v
        end
    end
    return inst
end

-- ======= Clean previous GUI ==================================================
if CoreGui:FindFirstChild("NexusCore") then
    CoreGui.NexusCore:Destroy()
end

-- ======= Root GUI ============================================================
local ScreenGui = new("ScreenGui", { Name = "NexusCore", ResetOnSpawn = false })
ScreenGui.Parent = CoreGui

-- Main Frame
local Main = new("Frame", {
    Name = "Main",
    Size = UDim2.new(0, Theme.Sizes.MainWidth, 0, Theme.Sizes.MainHeight),
    Position = UDim2.new(0.5, -Theme.Sizes.MainWidth/2, 0.5, -Theme.Sizes.MainHeight/2),
    BackgroundColor3 = Theme.Colors.Background,
    BackgroundTransparency = 0.15,
    Active = true,
    Draggable = true,
})
Main.Parent = ScreenGui
new("UICorner", { Parent = Main, CornerRadius = UDim.new(0, 20) })

-- Stroke + gradient
local Stroke = new("UIStroke", { Parent = Main, Thickness = 4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
local Gradient = new("UIGradient", { Parent = Stroke })
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.Colors.Accent),
    ColorSequenceKeypoint.new(0.5, Theme.Colors.AccentAlt),
    ColorSequenceKeypoint.new(1, Theme.Colors.Accent),
}
Gradient.Rotation = 0

-- rotate gradient
local gradientConnection = RunService.RenderStepped:Connect(function(dt)
    Gradient.Rotation = (Gradient.Rotation + Theme.Animation.GradientRotateSpeed * dt) % 360
end)

-- Sidebar & Container
local Sidebar = new("Frame", { Parent = Main, Size = UDim2.new(0, Theme.Sizes.SidebarWidth, 1, -80), Position = UDim2.new(0, 20, 0, 60), BackgroundTransparency = 1 })
new("UIListLayout", { Parent = Sidebar, Padding = UDim.new(0, 10) })

local Container = new("Frame", { Parent = Main, Size = UDim2.new(1, -Theme.Sizes.SidebarWidth - 60, 1, -100), Position = UDim2.new(0, Theme.Sizes.SidebarWidth + 40, 0, 80), BackgroundTransparency = 1 })

-- Keep track of pages
local pages = {}

-- ======= Tab / Page factory ==================================================
local function CreateTab(name)
    local btn = new("TextButton", {
        Parent = Sidebar,
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = Color3.fromRGB(20,20,30),
        Text = "  " .. name,
        TextColor3 = Theme.Colors.Text,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    new("UICorner", { Parent = btn })

    local page = new("ScrollingFrame", {
        Parent = Container,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = false,
        BackgroundTransparency = 1,
        ScrollBarThickness = 6,
    })
    new("UIListLayout", { Parent = page, Padding = UDim.new(0, 15), SortOrder = Enum.SortOrder.LayoutOrder })

    btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Container:GetChildren()) do
            if p:IsA("ScrollingFrame") then p.Visible = false end
        end
        page.Visible = true
        local tween = TweenService:Create(btn, TweenInfo.new(0.18), { BackgroundColor3 = Theme.Colors.Accent })
        tween:Play()
        tween.Completed:Wait()
        task.delay(0.25, function()
            TweenService:Create(btn, TweenInfo.new(0.18), { BackgroundColor3 = Color3.fromRGB(20,20,30) }):Play()
        end)
    end)

    pages[name] = page
    return page
end

-- ======= AddModule pattern (returns cleanup when enabled) ====================
local function AddModule(page, title, description, onToggle)
    local M = new("Frame", { Parent = page, Size = UDim2.new(1, -10, 0, 100), BackgroundColor3 = Theme.Colors.Panel })
    new("UICorner", { Parent = M })
    local T = new("TextLabel", { Parent = M, Text = "  " .. title, Size = UDim2.new(0.7, 0, 0.4, 0), TextColor3 = Theme.Colors.Text, Font = Enum.Font.GothamBold, BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left })
    local D = new("TextLabel", { Parent = M, Text = "  " .. description, Size = UDim2.new(0.7, 0, 0.4, 0), Position = UDim2.new(0,0,0.4,0), TextColor3 = Theme.Colors.Subtext, TextSize = 12, Font = Enum.Font.SourceSans, BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left })
    local Toggle = new("TextButton", { Parent = M, Size = UDim2.new(0, 60, 0, 30), Position = UDim2.new(1, -75, 0.5, -15), BackgroundColor3 = Theme.Colors.ToggleOff, Text = "OFF", TextColor3 = Theme.Colors.Text })
    new("UICorner", { Parent = Toggle })

    local active = false
    local cleanup -- function or Maid

    local function setActive(v)
        if v == active then return end
        active = v
        Toggle.Text = active and "ON" or "OFF"
        TweenService:Create(Toggle, TweenInfo.new(0.18), { BackgroundColor3 = active and Theme.Colors.ToggleOn or Theme.Colors.ToggleOff }):Play()

        -- cleanup previous
        if cleanup then
            pcall(function()
                if type(cleanup) == "function" then cleanup() end
                if typeof(cleanup) == "RBXScriptConnection" then cleanup:Disconnect() end
                if type(cleanup) == "table" and cleanup.Destroy then cleanup:Destroy() end
            end)
            cleanup = nil
        end

        local ok, result = pcall(onToggle, active)
        if ok and result ~= nil then
            cleanup = result
        end
    end

    Toggle.MouseButton1Click:Connect(function() setActive(not active) end)

    return {
        SetActive = setActive,
        IsActive = function() return active end,
        Cleanup = function() if cleanup then pcall(function() if type(cleanup) == "function" then cleanup() end end) end end,
    }
end

-- ======= Pages & Modules ====================================================
local Combat = CreateTab("WAR-MACHINE 2.0")
local World = CreateTab("REALITY BENDER")
local Tools = CreateTab("THE FORGE (AI)")

-- 1) Aim Demo: local crosshair only, shows worldray info (no ray manipulation)
AddModule(Combat, "AIM DEMO", "Local crosshair and world-ray readout for learning/debugging.", function(enabled)
    local maid = Maid.new()
    local cross
    if enabled then
        cross = new("Frame", { Parent = Main, Size = UDim2.new(0, 6, 0, 6), BackgroundColor3 = Theme.Colors.Accent, AnchorPoint = Vector2.new(0.5, 0.5) })
        new("UICorner", { Parent = cross, CornerRadius = UDim.new(0, 3) })
        maid:Give(cross)

        local label = new("TextLabel", { Parent = Main, Size = UDim2.new(0, 200, 0, 24), Position = UDim2.new(0, 10, 1, -34), BackgroundTransparency = 0.5, BackgroundColor3 = Theme.Colors.Panel, TextColor3 = Theme.Colors.Text, Font = Enum.Font.Gotham, Text = "WorldRay: (x,y,z)", TextSize = 12 })
        new("UICorner", { Parent = label })
        maid:Give(label)

        local conn = RunService.RenderStepped:Connect(function()
            local mouseLoc = UserInputService:GetMouseLocation()
            cross.Position = UDim2.fromOffset(mouseLoc.X, mouseLoc.Y)
            local mouse = LocalPlayer:GetMouse()
            local unitRay = workspace.CurrentCamera:ScreenPointToRay(mouse.X, mouse.Y)
            local origin = unitRay.Origin
            local dir = unitRay.Direction
            label.Text = string.format("Ray Origin: %.1f, %.1f, %.1f | Dir: %.2f, %.2f, %.2f", origin.X, origin.Y, origin.Z, dir.X, dir.Y, dir.Z)
        end)
        maid:Give(conn)
    end

    return function() maid:Destroy() end
end)

-- 2) Object Highlight: visually highlight nearby non-character BaseParts (visual-only)
AddModule(World, "OBJECT HIGHLIGHT", "Highlights nearby non-character parts (within radius).", function(enabled)
    local maid = Maid.new()
    local highlights = {}

    if enabled then
        local radius = 50
        local function refresh()
            -- remove invalid highlights
            for part, sel in pairs(highlights) do
                if not part:IsDescendantOf(workspace) or not part:IsA("BasePart") then
                    pcall(function() sel:Destroy() end)
                    highlights[part] = nil
                end
            end

            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
                    local dist = (obj.Position - hrp.Position).Magnitude
                    if dist <= radius and not highlights[obj] then
                        local sel = new("SelectionBox", { Parent = obj, Adornee = obj })
                        sel.LineThickness = 0.02
                        sel.SurfaceTransparency = 0.8
                        sel.Color3 = Theme.Colors.AccentAlt
                        highlights[obj] = sel
                        maid:Give(sel)
                    end
                end
            end
        end

        local last = 0
        local conn = RunService.Heartbeat:Connect(function(dt)
            last = last + dt
            if last >= 0.5 then -- throttle to 0.5s
                last = 0
                refresh()
            end
        end)
        maid:Give(conn)

        -- also cleanup selection boxes on character removal
        local charConn = LocalPlayer.CharacterRemoving:Connect(function()
            for part, sel in pairs(highlights) do
                pcall(function() sel:Destroy() end)
                highlights[part] = nil
            end
        end)
        maid:Give(charConn)
    end

    return function() maid:Destroy() end
end)

-- 3) FPS Meter
AddModule(Tools, "FPS METER", "Shows an approximate FPS counter.", function(enabled)
    local maid = Maid.new()
    if enabled then
        local label = new("TextLabel", { Parent = Main, Size = UDim2.new(0, 120, 0, 30), Position = UDim2.new(1, -140, 0, 10), BackgroundTransparency = 0.5, BackgroundColor3 = Theme.Colors.Panel, TextColor3 = Theme.Colors.Text, Font = Enum.Font.Gotham, Text = "FPS: ...", TextSize = 14 })
        new("UICorner", { Parent = label })
        maid:Give(label)

        local last = tick()
        local frames = 0
        local conn = RunService.RenderStepped:Connect(function()
            frames = frames + 1
            local now = tick()
            if now - last >= 1 then
                local fps = math.floor(frames / (now - last) + 0.5)
                label.Text = "FPS: " .. tostring(fps)
                last = now
                frames = 0
            end
        end)
        maid:Give(conn)
    end
    return function() maid:Destroy() end
end)

-- ======= Show first page by default =========================================
local firstShown = false
for _, p in pairs(Container:GetChildren()) do
    if p:IsA("ScrollingFrame") and not firstShown then
        p.Visible = true
        firstShown = true
    else
        if p:IsA("ScrollingFrame") then p.Visible = false end
    end
end

-- ======= Cleanup on player removal ==========================================
local function destroyAll()
    if gradientConnection and gradientConnection.Connected then
        gradientConnection:Disconnect()
    end
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
end

Players.AncestryChanged:Connect(function()
    if not LocalPlayer:IsDescendantOf(game) then
        destroyAll()
    end
end)

-- Optional API (if this file is require()'d by another script)
return {
    Destroy = destroyAll,
}
