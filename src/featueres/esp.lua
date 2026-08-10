-- =============================================
-- esp.lua - DOEAK HUB
-- Hiển thị vị trí của người chơi, quái vật, boss, trái cây, rương
-- Sử dụng Highlight và BillboardGui
-- =============================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- =============================================
-- CẤU HÌNH
-- =============================================
local CONFIG = {
    espColorPlayer = Color3.fromRGB(0, 255, 255),    -- Xanh cho người chơi
    espColorMob = Color3.fromRGB(255, 0, 0),         -- Đỏ cho quái
    espColorBoss = Color3.fromRGB(255, 215, 0),      -- Vàng cho Boss
    espColorFruit = Color3.fromRGB(255, 0, 255),     -- Tím cho trái cây
    espColorChest = Color3.fromRGB(255, 165, 0),     -- Cam cho rương
    espThickness = 2,
    espTransparency = 0.5,
    espDistance = 500,                               -- Khoảng cách tối đa hiển thị
}

-- =============================================
-- ESP CORE
-- =============================================

local espObjects = {} -- Lưu các Highlight đang hoạt động

local function createHighlight(model, color)
    if not model or not model:IsA("Model") then return end
    local highlight = Instance.new("Highlight")
    highlight.Adornee = model
    highlight.FillColor = color
    highlight.FillTransparency = CONFIG.espTransparency
    highlight.OutlineColor = color
    highlight.OutlineTransparency = 0
    highlight.Thickness = CONFIG.espThickness
    highlight.Parent = model
    return highlight
end

local function removeHighlight(model)
    local highlight = model:FindFirstChild("Highlight")
    if highlight then highlight:Destroy() end
end

local function clearAllESP()
    for _, obj in pairs(espObjects) do
        removeHighlight(obj)
    end
    espObjects = {}
end

-- =============================================
-- ESP TYPES
-- =============================================

-- ESP Player (người chơi khác)
local espPlayerActive = false
local function espPlayerLoop()
    while espPlayerActive do
        task.wait(0.5)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                local char = plr.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local dist = (char.HumanoidRootPart.Position - (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or Vector3.new(0,0,0))).Magnitude
                    if dist <= CONFIG.espDistance then
                        if not char:FindFirstChild("Highlight") then
                            createHighlight(char, CONFIG.espColorPlayer)
                        end
                    else
                        removeHighlight(char)
                    end
                end
            end
        end
        -- Xóa highlight cũ của các nhân vật đã rời khỏi game
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("Highlight") then
                if not obj:FindFirstChild("Humanoid") or obj.Name == player.Name then
                    removeHighlight(obj)
                end
            end
        end
    end
    clearAllESP()
end

-- ESP Mob (quái vật)
local espMobActive = false
local mobZone = {}  -- Lưu các tên quái cần ESP (lấy từ auto_quest)
-- Hàm này sẽ lấy danh sách quái từ auto_quest (có thể require)
local function getMobNames()
    -- Giả định có require
    local quest = require(script.Parent.auto_quest)
    local mobs = {}
    for _, zone in ipairs(quest.SEA1_QUESTS) do
        for _, name in ipairs(zone.enemies) do
            table.insert(mobs, name)
        end
    end
    for _, zone in ipairs(quest.SEA2_QUESTS) do
        for _, name in ipairs(zone.enemies) do
            table.insert(mobs, name)
        end
    end
    for _, zone in ipairs(quest.SEA3_QUESTS) do
        for _, name in ipairs(zone.enemies) do
            table.insert(mobs, name)
        end
    end
    return mobs
end

local function espMobLoop()
    local mobNames = getMobNames()
    while espMobActive do
        task.wait(0.5)
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Name ~= player.Name then
                local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - root.Position).Magnitude
                    if dist <= CONFIG.espDistance then
                        local isMob = false
                        for _, mobName in ipairs(mobNames) do
                            if string.find(obj.Name, mobName) then
                                isMob = true
                                break
                            end
                        end
                        if isMob then
                            if not obj:FindFirstChild("Highlight") then
                                createHighlight(obj, CONFIG.espColorMob)
                            end
                        else
                            removeHighlight(obj)
                        end
                    else
                        removeHighlight(obj)
                    end
                end
            end
        end
    end
    clearAllESP()
end

-- ESP Boss
local espBossActive = false
local function espBossLoop()
    local bossNames = require(script.Parent.auto_quest).BOSS_DATA
    while espBossActive do
        task.wait(1)
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
                local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - root.Position).Magnitude
                    if dist <= CONFIG.espDistance and bossNames[obj.Name] then
                        if not obj:FindFirstChild("Highlight") then
                            createHighlight(obj, CONFIG.espColorBoss)
                        end
                    else
                        removeHighlight(obj)
                    end
                end
            end
        end
    end
    clearAllESP()
end

-- ESP Fruit
local espFruitActive = false
local function espFruitLoop()
    while espFruitActive do
        task.wait(0.5)
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("Handle") and obj.Name:find("Fruit") then
                local hrp = obj:FindFirstChild("Handle") or obj:FindFirstChild("PrimaryPart") or obj:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - root.Position).Magnitude
                    if dist <= CONFIG.espDistance then
                        if not obj:FindFirstChild("Highlight") then
                            createHighlight(obj, CONFIG.espColorFruit)
                        end
                    else
                        removeHighlight(obj)
                    end
                end
            end
        end
    end
    clearAllESP()
end

-- =============================================
-- API CÔNG KHAI
-- =============================================

local ESP = {}

function ESP.togglePlayer()
    espPlayerActive = not espPlayerActive
    if espPlayerActive then
        task.spawn(espPlayerLoop)
    else
        clearAllESP()
    end
    return espPlayerActive
end

function ESP.toggleMob()
    espMobActive = not espMobActive
    if espMobActive then
        task.spawn(espMobLoop)
    else
        clearAllESP()
    end
    return espMobActive
end

function ESP.toggleBoss()
    espBossActive = not espBossActive
    if espBossActive then
        task.spawn(espBossLoop)
    else
        clearAllESP()
    end
    return espBossActive
end

function ESP.toggleFruit()
    espFruitActive = not espFruitActive
    if espFruitActive then
        task.spawn(espFruitLoop)
    else
        clearAllESP()
    end
    return espFruitActive
end

function ESP.clearAll()
    clearAllESP()
end

return ESP