-- =============================================
-- teleport.lua - DOEAK HUB
-- Dịch chuyển đến các địa điểm trong game
-- Hỗ trợ: Đảo, Boss, NPC, vị trí farm
-- Nguồn dữ liệu: bloxredeem.com, bloxfruit.io
-- =============================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- =============================================
-- CẤU HÌNH
-- =============================================
local CONFIG = {
    tweenDuration = 1.5,        -- Thời gian di chuyển (Tween)
    tweenStyle = Enum.EasingStyle.Linear,
    useTween = true,            -- True: di chuyển mượt, False: teleport tức thời
}

-- =============================================
-- DỮ LIỆU ĐIỂM TELEPORT
-- =============================================
local LOCATIONS = {
    -- Sea 1
    { name = "Pirate Starter", pos = Vector3.new(-100, 10, 50), sea = 1 },
    { name = "Marine Fortress", pos = Vector3.new(300, 5, -200), sea = 1 },
    { name = "Jungle", pos = Vector3.new(-500, 20, -800), sea = 1 },
    { name = "Pirate Village", pos = Vector3.new(700, 10, 400), sea = 1 },
    { name = "Desert", pos = Vector3.new(-1200, 15, 1100), sea = 1 },
    { name = "Frozen Village", pos = Vector3.new(1500, 20, -900), sea = 1 },
    { name = "Marine Base", pos = Vector3.new(-1700, 10, 500), sea = 1 },
    { name = "Skylands", pos = Vector3.new(0, 800, 0), sea = 1 },
    { name = "Prison", pos = Vector3.new(-500, -50, -1500), sea = 1 },
    { name = "Fountain City", pos = Vector3.new(800, 0, 1800), sea = 1 },
    { name = "Colosseum", pos = Vector3.new(-2200, 30, 600), sea = 1 },
    { name = "Magma Village", pos = Vector3.new(2400, 20, -300), sea = 1 },
    { name = "Underwater City", pos = Vector3.new(0, -80, 2800), sea = 1 },
    { name = "Upper Skylands", pos = Vector3.new(-300, 1200, 500), sea = 1 },
    -- Sea 2
    { name = "Kingdom of Rose", pos = Vector3.new(-600, 30, -2800), sea = 2 },
    { name = "Green Zone", pos = Vector3.new(300, 20, -3500), sea = 2 },
    { name = "Graveyard", pos = Vector3.new(-800, 40, -4200), sea = 2 },
    { name = "Cursed Ship", pos = Vector3.new(1200, 0, -4800), sea = 2 },
    { name = "Ice Castle", pos = Vector3.new(-1500, 100, -5300), sea = 2 },
    { name = "Dark Arena", pos = Vector3.new(500, 20, -5800), sea = 2 },
    -- Sea 3
    { name = "Port Town", pos = Vector3.new(-200, 10, -6500), sea = 3 },
    { name = "Hydra Island", pos = Vector3.new(800, 30, -7000), sea = 3 },
    { name = "Great Tree", pos = Vector3.new(-500, 200, -7500), sea = 3 },
    { name = "Floating Turtle", pos = Vector3.new(300, 50, -8000), sea = 3 },
    { name = "Castle on Sea", pos = Vector3.new(-1000, 80, -8500), sea = 3 },
    { name = "Cake Island", pos = Vector3.new(1500, 20, -9000), sea = 3 },
    { name = "Sea of Treats", pos = Vector3.new(-700, 10, -9600), sea = 3 },
}

-- Boss Locations (dùng BOSS_DATA từ auto_quest.lua)
-- Ở đây import từ auto_quest (có thể dùng require)
local BOSS_LOCATIONS = {
    -- Sea 1
    "Gorilla King", "Bobby", "Yeti", "Vice Admiral", "Wysper",
    "Swan", "Cyborg", "Greybeard", "Magma Admiral", "Fishman Lord", "Thunder God",
    -- Sea 2
    "Diamond", "Jeremy", "Fajita", "Darkbeard", "Smoke Admiral",
    "Soul Reaper", "Cursed Captain", "Awakened Ice Admiral", "Tide Keeper",
    -- Sea 3
    "Island Empress", "Longma", "rip_indra", "Cake Prince", "Cake Queen", "Dough King",
}

-- =============================================
-- HÀM TIỆN ÍCH
-- =============================================
local function getCharacter()
    return player.Character
end

local function getRootPart()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- Tìm Boss trong Workspace theo tên
local function findBoss(bossName)
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Name == bossName then
            return obj
        end
    end
    return nil
end

-- =============================================
-- HÀM TELEPORT CHÍNH
-- =============================================
local function teleportTo(targetPos, useTween)
    local root = getRootPart()
    if not root then return false end
    
    if useTween == nil then useTween = CONFIG.useTween end
    
    if useTween then
        local tweenInfo = TweenInfo.new(CONFIG.tweenDuration, CONFIG.tweenStyle, Enum.EasingDirection.Out)
        local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPos)})
        tween:Play()
        tween.Completed:Wait()
    else
        root.CFrame = CFrame.new(targetPos)
    end
    return true
end

-- Teleport đến vị trí của một model (Boss)
local function teleportToBoss(bossName)
    local boss = findBoss(bossName)
    if not boss then
        print("[Teleport] Không tìm thấy Boss: " .. bossName)
        return false
    end
    local hrp = boss:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return teleportTo(hrp.Position + Vector3.new(0, 0, -5))
end

-- Teleport đến tọa độ lưu sẵn theo tên
local function teleportToLocation(locationName)
    for _, loc in ipairs(LOCATIONS) do
        if loc.name == locationName then
            return teleportTo(loc.pos)
        end
    end
    print("[Teleport] Không tìm thấy địa điểm: " .. locationName)
    return false
end

-- Teleport đến vị trí của NPC (tìm trong Workspace)
local function teleportToNPC(npcName)
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            if obj.Name and string.find(obj.Name, npcName) then
                local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hrp then
                    return teleportTo(hrp.Position + Vector3.new(0, 0, -3))
                end
            end
        end
    end
    print("[Teleport] Không tìm thấy NPC: " .. npcName)
    return false
end

-- =============================================
-- API CÔNG KHAI
-- =============================================
return {
    toLocation = teleportToLocation,
    toBoss = teleportToBoss,
    toNPC = teleportToNPC,
    toPosition = teleportTo,
    getLocations = function() return LOCATIONS end,
    getBossList = function() return BOSS_LOCATIONS end,
    setTween = function(enabled) CONFIG.useTween = enabled end,
}