-- =============================================
-- auto_farm.lua - DOEAK HUB
-- Tự động tìm và tiêu diệt quái vật theo cấp độ
-- Hỗ trợ Farm theo khu vực, ưu tiên quái phù hợp level
-- Nguồn dữ liệu: bloxredeem.com, bloxfruit.io
-- =============================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- =============================================
-- CẤU HÌNH
-- =============================================
local CONFIG = {
    farmRadius = 50,            -- Bán kính tìm quái (có thể điều chỉnh)
    attackCooldown = 0.3,       -- Delay giữa các đòn đánh
    checkInterval = 0.2,        -- Tần suất quét
    autoHeal = true,            -- Tự động hồi máu khi dưới ngưỡng
    healThreshold = 30,         -- Ngưỡng máu % để hồi
    maxLevelFarm = 2600,        -- Tối đa level farm (để không đi quá xa)
    enableBossFarm = false,     -- Có tấn công boss hay không (mặc định tắt)
}

-- =============================================
-- DỮ LIỆU QUÁI VẬT THEO KHU VỰC
-- =============================================
-- Dựa trên các quest đã định nghĩa trong auto_quest.lua
-- Mỗi khu vực có danh sách tên quái, level khuyến nghị và tọa độ gần đúng
-- =============================================

local MOB_ZONES = {
    -- Sea 1
    {
        zoneName = "Pirate Starter",
        minLevel = 1,
        maxLevel = 15,
        mobs = {"Bandits", "Trainees"},
        spawnPoint = Vector3.new(-100, 10, 50),  -- Tọa độ gần đúng (cần tinh chỉnh)
    },
    {
        zoneName = "Marine Fortress",
        minLevel = 15,
        maxLevel = 40,
        mobs = {"Marines", "Chief Petty Officers"},
        spawnPoint = Vector3.new(300, 5, -200),
    },
    {
        zoneName = "Jungle",
        minLevel = 30,
        maxLevel = 70,
        mobs = {"Monkey", "Gorilla"},
        spawnPoint = Vector3.new(-500, 20, -800),
    },
    {
        zoneName = "Pirate Village",
        minLevel = 60,
        maxLevel = 100,
        mobs = {"Pirates", "Brutes"},
        spawnPoint = Vector3.new(700, 10, 400),
    },
    {
        zoneName = "Desert",
        minLevel = 90,
        maxLevel = 130,
        mobs = {"Desert Bandits", "Desert Officers"},
        spawnPoint = Vector3.new(-1200, 15, 1100),
    },
    {
        zoneName = "Frozen Village",
        minLevel = 120,
        maxLevel = 160,
        mobs = {"Snow Bandits", "Snowmen"},
        spawnPoint = Vector3.new(1500, 20, -900),
    },
    {
        zoneName = "Marine Base",
        minLevel = 150,
        maxLevel = 200,
        mobs = {"Vice Admirals"},
        spawnPoint = Vector3.new(-1700, 10, 500),
    },
    {
        zoneName = "Skylands",
        minLevel = 200,
        maxLevel = 280,
        mobs = {"Sky Bandits", "Dark Masters", "God's Guards"},
        spawnPoint = Vector3.new(0, 800, 0),
    },
    {
        zoneName = "Prison",
        minLevel = 275,
        maxLevel = 360,
        mobs = {"Prisoners", "Dangerous Prisoners"},
        spawnPoint = Vector3.new(-500, -50, -1500),
    },
    {
        zoneName = "Fountain City",
        minLevel = 275,
        maxLevel = 360,
        mobs = {"Galley Pirates", "Galley Captains"},
        spawnPoint = Vector3.new(800, 0, 1800),
    },
    {
        zoneName = "Colosseum",
        minLevel = 350,
        maxLevel = 420,
        mobs = {"Toga Warriors", "Gladiators"},
        spawnPoint = Vector3.new(-2200, 30, 600),
    },
    {
        zoneName = "Magma Village",
        minLevel = 400,
        maxLevel = 470,
        mobs = {"Military Soldiers", "Military Spies"},
        spawnPoint = Vector3.new(2400, 20, -300),
    },
    {
        zoneName = "Underwater City",
        minLevel = 450,
        maxLevel = 520,
        mobs = {"Fishman Warriors", "Fishman Commandos"},
        spawnPoint = Vector3.new(0, -80, 2800),
    },
    {
        zoneName = "Upper Skylands",
        minLevel = 500,
        maxLevel = 620,
        mobs = {"Sky Bandits", "Shandas"},
        spawnPoint = Vector3.new(-300, 1200, 500),
    },
    -- Sea 2
    {
        zoneName = "Kingdom of Rose",
        minLevel = 700,
        maxLevel = 870,
        mobs = {"Swan Pirates", "Raiders", "Mercenaries"},
        spawnPoint = Vector3.new(-600, 30, -2800),
    },
    {
        zoneName = "Green Zone",
        minLevel = 850,
        maxLevel = 1050,
        mobs = {"Marine Lieutenant", "Marine Captain", "Raid NPCs"},
        spawnPoint = Vector3.new(300, 20, -3500),
    },
    {
        zoneName = "Graveyard",
        minLevel = 1000,
        maxLevel = 1150,
        mobs = {"Zombies", "Possessed Mummy", "Demonic Soul"},
        spawnPoint = Vector3.new(-800, 40, -4200),
    },
    {
        zoneName = "Cursed Ship",
        minLevel = 1100,
        maxLevel = 1250,
        mobs = {"Cursed Crew"},
        spawnPoint = Vector3.new(1200, 0, -4800),
    },
    {
        zoneName = "Ice Castle",
        minLevel = 1200,
        maxLevel = 1375,
        mobs = {"Ice Pirates"},
        spawnPoint = Vector3.new(-1500, 100, -5300),
    },
    {
        zoneName = "Dark Arena",
        minLevel = 1000,
        maxLevel = 1550,
        mobs = {"Dark Enemies"},
        spawnPoint = Vector3.new(500, 20, -5800),
    },
    -- Sea 3
    {
        zoneName = "Port Town",
        minLevel = 1500,
        maxLevel = 1600,
        mobs = {"Port Pirates"},
        spawnPoint = Vector3.new(-200, 10, -6500),
    },
    {
        zoneName = "Hydra Island",
        minLevel = 1575,
        maxLevel = 1725,
        mobs = {"Hydra Crew"},
        spawnPoint = Vector3.new(800, 30, -7000),
    },
    {
        zoneName = "Great Tree",
        minLevel = 1700,
        maxLevel = 1850,
        mobs = {"Tree NPCs"},
        spawnPoint = Vector3.new(-500, 200, -7500),
    },
    {
        zoneName = "Floating Turtle",
        minLevel = 1800,
        maxLevel = 1975,
        mobs = {"Turtle Guardians"},
        spawnPoint = Vector3.new(300, 50, -8000),
    },
    {
        zoneName = "Castle on Sea",
        minLevel = 1925,
        maxLevel = 2100,
        mobs = {"Castle Guards"},
        spawnPoint = Vector3.new(-1000, 80, -8500),
    },
    {
        zoneName = "Cake Island",
        minLevel = 1700,
        maxLevel = 2100,
        mobs = {"Cake Soldiers"},
        spawnPoint = Vector3.new(1500, 20, -9000),
    },
    {
        zoneName = "Sea of Treats",
        minLevel = 2000,
        maxLevel = 9999,
        mobs = {"Treat NPCs", "Ice Cream Chefs"},
        spawnPoint = Vector3.new(-700, 10, -9600),
    },
}

-- =============================================
-- HÀM TIỆN ÍCH
-- =============================================

local function getPlayerLevel()
    local level = player:FindFirstChild("Data") and player.Data:FindFirstChild("Level")
    return level and level.Value or 0
end

local function getCharacter()
    local char = player.Character
    if not char or not char.Parent then return nil end
    return char
end

local function getHumanoid()
    local char = getCharacter()
    return char and char:FindFirstChild("Humanoid")
end

local function getRootPart()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- Tìm quái vật trong một khu vực
local function findMobsInZone(zone, radius)
    local mobs = {}
    local root = getRootPart()
    if not root then return mobs end
    
    local zoneMobNames = zone.mobs
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            local name = obj.Name
            -- Kiểm tra tên có khớp với danh sách không
            local matched = false
            for _, mobName in ipairs(zoneMobNames) do
                if string.find(name, mobName) then
                    matched = true
                    break
                end
            end
            if matched then
                local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - root.Position).Magnitude
                    if dist <= radius then
                        table.insert(mobs, {
                            model = obj,
                            hrp = hrp,
                            distance = dist,
                        })
                    end
                end
            end
        end
    end
    -- Sắp xếp theo khoảng cách từ gần đến xa
    table.sort(mobs, function(a, b) return a.distance < b.distance end)
    return mobs
end

-- Tìm khu vực phù hợp với level hiện tại
local function findBestZone()
    local level = getPlayerLevel()
    local bestZone = nil
    local bestScore = -1
    
    for _, zone in ipairs(MOB_ZONES) do
        if level >= zone.minLevel and level <= zone.maxLevel then
            -- Ưu tiên zone có maxLevel cao hơn (để farm lâu dài)
            if zone.maxLevel > bestScore then
                bestScore = zone.maxLevel
                bestZone = zone
            end
        end
    end
    return bestZone
end

-- Teleport đến điểm spawn của khu vực
local function teleportToZone(zone)
    local root = getRootPart()
    if not root or not zone then return false end
    
    root.CFrame = CFrame.new(zone.spawnPoint)
    task.wait(0.3)
    return true
end

-- =============================================
-- TỰ ĐỘNG HỒI MÁU
-- =============================================
local function autoHeal()
    local hum = getHumanoid()
    if not hum then return end
    
    local healthPercent = (hum.Health / hum.MaxHealth) * 100
    if healthPercent < CONFIG.healThreshold and CONFIG.autoHeal then
        -- Một số cách hồi máu: dùng trái cây (như Buddha), dùng food, hoặc dùng RemoteEvent
        -- Giả định dùng food trong inventory
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, item in pairs(backpack:GetChildren()) do
                if item:IsA("Tool") and item.Name and string.find(item.Name, "Food") then
                    -- Kích hoạt tool để ăn (cần kiểm tra cơ chế)
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and 
                                   game:GetService("ReplicatedStorage").Remotes:FindFirstChild("CommF_")
                    if remote then
                        remote:InvokeServer("Use", item.Name)
                        task.wait(0.5)
                        break
                    end
                end
            end
        end
    end
end

-- =============================================
-- VÒNG LẶP FARM CHÍNH
-- =============================================

local farmRunning = false
local currentZone = nil

local function farmLoop()
    while farmRunning do
        task.wait(CONFIG.checkInterval)
        
        -- Kiểm tra nhân vật
        local char = getCharacter()
        local hum = getHumanoid()
        local root = getRootPart()
        if not char or not hum or not root then
            player.CharacterAdded:Wait()
            continue
        end
        
        -- Tự động hồi máu
        autoHeal()
        
        -- Tìm zone phù hợp
        if not currentZone then
            currentZone = findBestZone()
            if not currentZone then
                print("[AutoFarm] Không tìm thấy khu vực phù hợp cho level " .. getPlayerLevel())
                task.wait(2)
                continue
            end
            print("[AutoFarm] Chọn khu vực: " .. currentZone.zoneName)
            teleportToZone(currentZone)
        end
        
        -- Tìm quái trong bán kính
        local mobs = findMobsInZone(currentZone, CONFIG.farmRadius)
        if #mobs == 0 then
            -- Nếu không có quái trong bán kính, teleport lại spawn
            teleportToZone(currentZone)
            task.wait(0.5)
            continue
        end
        
        -- Chọn quái gần nhất còn sống
        local target = nil
        for _, mob in ipairs(mobs) do
            local humTarget = mob.model:FindFirstChild("Humanoid")
            if humTarget and humTarget.Health > 0 then
                target = mob
                break
            end
        end
        
        if not target then
            teleportToZone(currentZone)
            continue
        end
        
        -- Di chuyển đến quái
        root.CFrame = target.hrp.CFrame * CFrame.new(0, 0, -3)
        task.wait(0.1)
        
        -- Tấn công
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
        
        -- Nếu quái chết, đợi một chút rồi quét lại
        local humTarget = target.model:FindFirstChild("Humanoid")
        if humTarget and humTarget.Health <= 0 then
            task.wait(0.3)
        end
        
        -- Nếu level thay đổi, kiểm tra lại zone
        if getPlayerLevel() > currentZone.maxLevel then
            currentZone = nil
            print("[AutoFarm] Level đã lên, tìm khu vực mới...")
        end
    end
end

-- =============================================
-- API CÔNG KHAI
-- =============================================

-- Bật/tắt Auto Farm
local function toggleAutoFarm()
    farmRunning = not farmRunning
    if farmRunning then
        print("[AutoFarm] Đã BẬT")
        currentZone = findBestZone()
        if currentZone then
            teleportToZone(currentZone)
        end
        task.spawn(farmLoop)
    else
        print("[AutoFarm] Đã TẮT")
    end
    return farmRunning
end

-- Lấy trạng thái
local function isFarmRunning()
    return farmRunning
end

-- Lấy zone hiện tại
local function getCurrentZone()
    return currentZone
end

-- Cập nhật bán kính farm
local function setFarmRadius(radius)
    CONFIG.farmRadius = math.clamp(radius, 10, 200)
end

-- Teleport đến zone theo tên hoặc index
local function teleportToZoneByName(zoneName)
    for _, zone in ipairs(MOB_ZONES) do
        if zone.zoneName == zoneName then
            return teleportToZone(zone)
        end
    end
    return false
end

-- =============================================
-- EXPORT
-- =============================================
return {
    toggle = toggleAutoFarm,
    isRunning = isFarmRunning,
    getCurrentZone = getCurrentZone,
    setRadius = setFarmRadius,
    teleportToZone = teleportToZoneByName,
    getZones = function() return MOB_ZONES end,
}