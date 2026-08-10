-- =============================================
-- DOEAK HUB - FULL SCRIPT (GỘP)
-- Chạy trên Madium Executor
-- =============================================

print("🐲 DOEAK HUB - Đang khởi tạo...")

-- =============================================
-- STYLES (Màu sắc, font, kích thước)
-- =============================================
local Styles = {
    Colors = {
        Red = Color3.fromRGB(178, 0, 0),
        DarkRed = Color3.fromRGB(60, 0, 0),
        Gold = Color3.fromRGB(255, 215, 0),
        White = Color3.fromRGB(255, 255, 255),
        Black = Color3.fromRGB(0, 0, 0),
        Green = Color3.fromRGB(0, 255, 0),
        Gray = Color3.fromRGB(100, 100, 100),
        DarkGray = Color3.fromRGB(40, 40, 40),
    },
    Fonts = {
        Title = Enum.Font.GothamBold,
        Normal = Enum.Font.Gotham,
    },
    Sizes = {
        ButtonHeight = 35,
        TabHeight = 35,
        FrameWidth = 500,
        FrameHeight = 400,
        TitleHeight = 35,
    }
}

-- =============================================
-- DỮ LIỆU QUEST THEO SEA
-- =============================================
local SEA1_QUESTS = {
    { name = "Bandit", npc = "Bandit Quest Giver", island = "Pirate Starter Island", minLevel = 1, maxLevel = 10, enemies = {"Bandits", "Trainees"}, boss = nil },
    { name = "Marine", npc = "Marine Leader", island = "Marine Fortress", minLevel = 15, maxLevel = 30, enemies = {"Marines", "Chief Petty Officers"}, boss = "Bobby" },
    { name = "Gorilla", npc = "Adventurer", island = "Jungle", minLevel = 30, maxLevel = 60, enemies = {"Monkey", "Gorilla"}, boss = "Gorilla King" },
    { name = "Pirate", npc = "Pirate Quest Giver", island = "Pirate Village", minLevel = 60, maxLevel = 90, enemies = {"Pirates", "Brutes"}, boss = nil },
    { name = "Desert", npc = "Desert Adventurer", island = "Desert", minLevel = 90, maxLevel = 120, enemies = {"Desert Bandits", "Desert Officers"}, boss = nil },
    { name = "Snow", npc = "Frozen Quest Giver", island = "Frozen Village", minLevel = 120, maxLevel = 150, enemies = {"Snow Bandits", "Snowmen"}, boss = "Yeti" },
    { name = "Vice Admiral", npc = "Marine Leader", island = "Marine Base", minLevel = 150, maxLevel = 190, enemies = {"Vice Admirals"}, boss = "Vice Admiral" },
    { name = "Sky", npc = "Sky Adventurer", island = "Skylands", minLevel = 200, maxLevel = 275, enemies = {"Sky Bandits", "Dark Masters", "God's Guards"}, boss = "Wysper" },
    { name = "Prison", npc = "Head Jailer", island = "Prison", minLevel = 275, maxLevel = 350, enemies = {"Prisoners", "Dangerous Prisoners"}, boss = "Swan" },
    { name = "Galley", npc = "Fountain Quest Giver", island = "Fountain City", minLevel = 275, maxLevel = 350, enemies = {"Galley Pirates", "Galley Captains"}, boss = "Cyborg" },
    { name = "Gladiator", npc = "Colosseum Quest Giver", island = "Colosseum", minLevel = 350, maxLevel = 400, enemies = {"Toga Warriors", "Gladiators"}, boss = "Greybeard" },
    { name = "Magma", npc = "Magma Quest Giver", island = "Magma Village", minLevel = 400, maxLevel = 450, enemies = {"Military Soldiers", "Military Spies"}, boss = "Magma Admiral" },
    { name = "Fishman", npc = "Submerged Quest Giver 1", island = "Underwater City", minLevel = 450, maxLevel = 500, enemies = {"Fishman Warriors", "Fishman Commandos"}, boss = "Fishman Lord" },
    { name = "Upper Sky", npc = "Sky Quest Giver 2", island = "Upper Skylands", minLevel = 500, maxLevel = 600, enemies = {"Sky Bandits", "Shandas"}, boss = "Thunder God" },
}
local SEA2_QUESTS = {
    { name = "Swan", npc = "Kingdom Quest Giver", island = "Kingdom of Rose", minLevel = 700, maxLevel = 850, enemies = {"Swan Pirates", "Raiders", "Mercenaries"}, boss = "Diamond" },
    { name = "Green Zone", npc = "Fajita", island = "Green Zone", minLevel = 850, maxLevel = 1000, enemies = {"Marine Lieutenant", "Marine Captain", "Raid NPCs"}, boss = nil },
    { name = "Graveyard", npc = "Graveyard Quest Giver", island = "Graveyard", minLevel = 1000, maxLevel = 1100, enemies = {"Zombies", "Possessed Mummy", "Demonic Soul"}, boss = "Soul Reaper" },
    { name = "Cursed", npc = "Cursed Quest Giver", island = "Cursed Ship", minLevel = 1100, maxLevel = 1200, enemies = {"Cursed Crew"}, boss = "Cursed Captain" },
    { name = "Ice", npc = "Ice Quest Giver", island = "Ice Castle", minLevel = 1200, maxLevel = 1325, enemies = {"Ice Pirates"}, boss = "Awakened Ice Admiral" },
    { name = "Dark", npc = "Dark Arena Quest Giver", island = "Dark Arena", minLevel = 1000, maxLevel = 1500, enemies = {"Dark Enemies"}, boss = "Darkbeard" },
}
local SEA3_QUESTS = {
    { name = "Port", npc = "Port Quest Giver", island = "Port Town", minLevel = 1500, maxLevel = 1575, enemies = {"Port Pirates"}, boss = nil },
    { name = "Hydra", npc = "Hydra Quest Giver", island = "Hydra Island", minLevel = 1575, maxLevel = 1700, enemies = {"Hydra Crew"}, boss = "Island Empress" },
    { name = "Tree", npc = "Tree Quest Giver", island = "Great Tree", minLevel = 1700, maxLevel = 1800, enemies = {"Tree NPCs"}, boss = nil },
    { name = "Turtle", npc = "Turtle Quest Giver", island = "Floating Turtle", minLevel = 1800, maxLevel = 1925, enemies = {"Turtle Guardians"}, boss = "Longma" },
    { name = "Castle", npc = "Castle Quest Giver", island = "Castle on Sea", minLevel = 1925, maxLevel = 2000, enemies = {"Castle Guards"}, boss = "rip_indra" },
    { name = "Cake", npc = "Cake Quest Giver", island = "Cake Island", minLevel = 1700, maxLevel = 2000, enemies = {"Cake Soldiers"}, boss = "Cake Prince" },
    { name = "Treats", npc = "Treat Quest Giver", island = "Sea of Treats", minLevel = 2000, maxLevel = 9999, enemies = {"Treat NPCs", "Ice Cream Chefs"}, boss = "Cake Queen" },
}
local BOSS_DATA = {
    ["Gorilla King"] = { level = 25, sea = 1, island = "Jungle", respawn = 240, drops = "EXP & Money" },
    ["Bobby"] = { level = 55, sea = 1, island = "Pirate Village", respawn = 600, drops = "EXP & Money" },
    ["Yeti"] = { level = 110, sea = 1, island = "Frozen Village", respawn = 300, drops = "EXP & Money" },
    ["Vice Admiral"] = { level = 130, sea = 1, island = "Marine Fortress", respawn = 600, drops = "Vice Admiral Coat" },
    ["Wysper"] = { level = 500, sea = 1, island = "Skylands", respawn = 1800, drops = "Bazooka (10%)" },
    ["Swan"] = { level = 240, sea = 1, island = "Prison", respawn = 600, drops = "Pink Coat (5%)" },
    ["Cyborg"] = { level = 675, sea = 1, island = "Fountain City", respawn = 900, drops = "Cool Shades (1%)" },
    ["Greybeard"] = { level = 750, sea = 1, island = "Marine Fortress", respawn = 14400, drops = "Saber (quest)" },
    ["Magma Admiral"] = { level = 350, sea = 1, island = "Magma Village", respawn = 600, drops = "Refined Musket (10%)" },
    ["Fishman Lord"] = { level = 425, sea = 1, island = "Underwater City", respawn = 600, drops = "Trident (10%)" },
    ["Thunder God"] = { level = 575, sea = 1, island = "Upper Skylands", respawn = 600, drops = "Pole (8%)" },
    ["Diamond"] = { level = 750, sea = 2, island = "Kingdom of Rose", respawn = 1200, drops = "Longsword (10%)" },
    ["Jeremy"] = { level = 850, sea = 2, island = "Kingdom of Rose", respawn = 1200, drops = "Black Spikey Coat (10%)" },
    ["Fajita"] = { level = 925, sea = 2, island = "Green Zone", respawn = 1200, drops = "Gravity Cane (10%)" },
    ["Darkbeard"] = { level = 1000, sea = 2, island = "Dark Arena", respawn = 900, drops = "Dark Coat (2%)" },
    ["Smoke Admiral"] = { level = 1150, sea = 2, island = "Hot & Cold", respawn = 1200, drops = "Jitte (15%)" },
    ["Soul Reaper"] = { level = 2100, sea = 2, island = "Haunted Castle", respawn = 2700, drops = "Hallow Scythe, Holy Crown" },
    ["Cursed Captain"] = { level = 1325, sea = 2, island = "Cursed Ship", respawn = 600, drops = "Red/Blue Spikey Coat" },
    ["Awakened Ice Admiral"] = { level = 1400, sea = 2, island = "Ice Castle", respawn = 1200, drops = "Library Key, Hidden Key" },
    ["Tide Keeper"] = { level = 1475, sea = 2, island = "Forgotten Island", respawn = 1800, drops = "Water Key, Dragon Trident" },
    ["Island Empress"] = { level = 1575, sea = 3, island = "Hydra Island", respawn = 600, drops = "Serpent Bow" },
    ["Longma"] = { level = 2000, sea = 3, island = "Floating Turtle", respawn = 1200, drops = "Tushita (quest)" },
    ["rip_indra"] = { level = 5000, sea = 3, island = "Castle on Sea", respawn = 420, drops = "God's Chalice, Tushita" },
    ["Cake Prince"] = { level = 1700, sea = 3, island = "Cake Island", respawn = 600, drops = "Pale Scarf" },
    ["Cake Queen"] = { level = 2175, sea = 3, island = "Sea of Treats", respawn = 360, drops = "Buddy Sword (5%)" },
    ["Dough King"] = { level = 2300, sea = 3, island = "Dough Kingdom", respawn = 16200, drops = "Red Key, Dough Microchip" },
}

-- =============================================
-- FEATURES: UTILITY
-- =============================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function getPlayerLevel()
    local level = player:FindFirstChild("Data") and player.Data:FindFirstChild("Level")
    return level and level.Value or 0
end

local function getCharacter()
    local char = player.Character
    if not char or not char.Parent then return nil end
    return char
end

local function getRootPart()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function teleportTo(pos)
    local root = getRootPart()
    if not root then return false end
    root.CFrame = CFrame.new(pos)
    task.wait(0.2)
    return true
end

-- =============================================
-- FEATURES: AUTO FARM
-- =============================================
local MOB_ZONES = {
    { zoneName = "Pirate Starter", minLevel = 1, maxLevel = 15, mobs = {"Bandits", "Trainees"}, spawnPoint = Vector3.new(-100, 10, 50) },
    { zoneName = "Marine Fortress", minLevel = 15, maxLevel = 40, mobs = {"Marines", "Chief Petty Officers"}, spawnPoint = Vector3.new(300, 5, -200) },
    { zoneName = "Jungle", minLevel = 30, maxLevel = 70, mobs = {"Monkey", "Gorilla"}, spawnPoint = Vector3.new(-500, 20, -800) },
    { zoneName = "Pirate Village", minLevel = 60, maxLevel = 100, mobs = {"Pirates", "Brutes"}, spawnPoint = Vector3.new(700, 10, 400) },
    { zoneName = "Desert", minLevel = 90, maxLevel = 130, mobs = {"Desert Bandits", "Desert Officers"}, spawnPoint = Vector3.new(-1200, 15, 1100) },
    { zoneName = "Frozen Village", minLevel = 120, maxLevel = 160, mobs = {"Snow Bandits", "Snowmen"}, spawnPoint = Vector3.new(1500, 20, -900) },
    { zoneName = "Marine Base", minLevel = 150, maxLevel = 200, mobs = {"Vice Admirals"}, spawnPoint = Vector3.new(-1700, 10, 500) },
    { zoneName = "Skylands", minLevel = 200, maxLevel = 280, mobs = {"Sky Bandits", "Dark Masters", "God's Guards"}, spawnPoint = Vector3.new(0, 800, 0) },
    { zoneName = "Prison", minLevel = 275, maxLevel = 360, mobs = {"Prisoners", "Dangerous Prisoners"}, spawnPoint = Vector3.new(-500, -50, -1500) },
    { zoneName = "Fountain City", minLevel = 275, maxLevel = 360, mobs = {"Galley Pirates", "Galley Captains"}, spawnPoint = Vector3.new(800, 0, 1800) },
    { zoneName = "Colosseum", minLevel = 350, maxLevel = 420, mobs = {"Toga Warriors", "Gladiators"}, spawnPoint = Vector3.new(-2200, 30, 600) },
    { zoneName = "Magma Village", minLevel = 400, maxLevel = 470, mobs = {"Military Soldiers", "Military Spies"}, spawnPoint = Vector3.new(2400, 20, -300) },
    { zoneName = "Underwater City", minLevel = 450, maxLevel = 520, mobs = {"Fishman Warriors", "Fishman Commandos"}, spawnPoint = Vector3.new(0, -80, 2800) },
    { zoneName = "Upper Skylands", minLevel = 500, maxLevel = 620, mobs = {"Sky Bandits", "Shandas"}, spawnPoint = Vector3.new(-300, 1200, 500) },
    { zoneName = "Kingdom of Rose", minLevel = 700, maxLevel = 870, mobs = {"Swan Pirates", "Raiders", "Mercenaries"}, spawnPoint = Vector3.new(-600, 30, -2800) },
    { zoneName = "Green Zone", minLevel = 850, maxLevel = 1050, mobs = {"Marine Lieutenant", "Marine Captain", "Raid NPCs"}, spawnPoint = Vector3.new(300, 20, -3500) },
    { zoneName = "Graveyard", minLevel = 1000, maxLevel = 1150, mobs = {"Zombies", "Possessed Mummy", "Demonic Soul"}, spawnPoint = Vector3.new(-800, 40, -4200) },
    { zoneName = "Cursed Ship", minLevel = 1100, maxLevel = 1250, mobs = {"Cursed Crew"}, spawnPoint = Vector3.new(1200, 0, -4800) },
    { zoneName = "Ice Castle", minLevel = 1200, maxLevel = 1375, mobs = {"Ice Pirates"}, spawnPoint = Vector3.new(-1500, 100, -5300) },
    { zoneName = "Dark Arena", minLevel = 1000, maxLevel = 1550, mobs = {"Dark Enemies"}, spawnPoint = Vector3.new(500, 20, -5800) },
    { zoneName = "Port Town", minLevel = 1500, maxLevel = 1600, mobs = {"Port Pirates"}, spawnPoint = Vector3.new(-200, 10, -6500) },
    { zoneName = "Hydra Island", minLevel = 1575, maxLevel = 1725, mobs = {"Hydra Crew"}, spawnPoint = Vector3.new(800, 30, -7000) },
    { zoneName = "Great Tree", minLevel = 1700, maxLevel = 1850, mobs = {"Tree NPCs"}, spawnPoint = Vector3.new(-500, 200, -7500) },
    { zoneName = "Floating Turtle", minLevel = 1800, maxLevel = 1975, mobs = {"Turtle Guardians"}, spawnPoint = Vector3.new(300, 50, -8000) },
    { zoneName = "Castle on Sea", minLevel = 1925, maxLevel = 2100, mobs = {"Castle Guards"}, spawnPoint = Vector3.new(-1000, 80, -8500) },
    { zoneName = "Cake Island", minLevel = 1700, maxLevel = 2100, mobs = {"Cake Soldiers"}, spawnPoint = Vector3.new(1500, 20, -9000) },
    { zoneName = "Sea of Treats", minLevel = 2000, maxLevel = 9999, mobs = {"Treat NPCs", "Ice Cream Chefs"}, spawnPoint = Vector3.new(-700, 10, -9600) },
}

local farmRunning = false
local farmRadius = 50
local currentZone = nil

local function findBestZone()
    local level = getPlayerLevel()
    local best = nil
    local bestScore = -1
    for _, zone in ipairs(MOB_ZONES) do
        if level >= zone.minLevel and level <= zone.maxLevel and zone.maxLevel > bestScore then
            bestScore = zone.maxLevel
            best = zone
        end
    end
    return best
end

local function findMobsInZone(zone, radius)
    local mobs = {}
    local root = getRootPart()
    if not root then return mobs end
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            local matched = false
            for _, mobName in ipairs(zone.mobs) do
                if string.find(obj.Name, mobName) then
                    matched = true
                    break
                end
            end
            if matched then
                local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - root.Position).Magnitude
                    if dist <= radius then
                        table.insert(mobs, { model = obj, hrp = hrp, distance = dist })
                    end
                end
            end
        end
    end
    table.sort(mobs, function(a, b) return a.distance < b.distance end)
    return mobs
end

local function farmLoop()
    while farmRunning do
        task.wait(0.2)
        local char = getCharacter()
        local hum = char and char:FindFirstChild("Humanoid")
        local root = getRootPart()
        if not char or not hum or not root then
            player.CharacterAdded:Wait()
            continue
        end
        if not currentZone then
            currentZone = findBestZone()
            if not currentZone then
                task.wait(2)
                continue
            end
            teleportTo(currentZone.spawnPoint)
        end
        local mobs = findMobsInZone(currentZone, farmRadius)
        if #mobs == 0 then
            teleportTo(currentZone.spawnPoint)
            continue
        end
        local target = nil
        for _, mob in ipairs(mobs) do
            local humTarget = mob.model:FindFirstChild("Humanoid")
            if humTarget and humTarget.Health > 0 then
                target = mob
                break
            end
        end
        if not target then
            teleportTo(currentZone.spawnPoint)
            continue
        end
        root.CFrame = target.hrp.CFrame * CFrame.new(0, 0, -3)
        task.wait(0.1)
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
        if getPlayerLevel() > currentZone.maxLevel then
            currentZone = nil
        end
    end
end

local function toggleFarm()
    farmRunning = not farmRunning
    if farmRunning then
        currentZone = findBestZone()
        if currentZone then teleportTo(currentZone.spawnPoint) end
        task.spawn(farmLoop)
    end
    return farmRunning
end

-- =============================================
-- FEATURES: TELEPORT
-- =============================================
local LOCATIONS = {
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
    { name = "Kingdom of Rose", pos = Vector3.new(-600, 30, -2800), sea = 2 },
    { name = "Green Zone", pos = Vector3.new(300, 20, -3500), sea = 2 },
    { name = "Graveyard", pos = Vector3.new(-800, 40, -4200), sea = 2 },
    { name = "Cursed Ship", pos = Vector3.new(1200, 0, -4800), sea = 2 },
    { name = "Ice Castle", pos = Vector3.new(-1500, 100, -5300), sea = 2 },
    { name = "Dark Arena", pos = Vector3.new(500, 20, -5800), sea = 2 },
    { name = "Port Town", pos = Vector3.new(-200, 10, -6500), sea = 3 },
    { name = "Hydra Island", pos = Vector3.new(800, 30, -7000), sea = 3 },
    { name = "Great Tree", pos = Vector3.new(-500, 200, -7500), sea = 3 },
    { name = "Floating Turtle", pos = Vector3.new(300, 50, -8000), sea = 3 },
    { name = "Castle on Sea", pos = Vector3.new(-1000, 80, -8500), sea = 3 },
    { name = "Cake Island", pos = Vector3.new(1500, 20, -9000), sea = 3 },
    { name = "Sea of Treats", pos = Vector3.new(-700, 10, -9600), sea = 3 },
}
local BOSS_NAMES = {"Gorilla King","Bobby","Yeti","Vice Admiral","Wysper","Swan","Cyborg","Greybeard","Magma Admiral","Fishman Lord","Thunder God","Diamond","Jeremy","Fajita","Darkbeard","Smoke Admiral","Soul Reaper","Cursed Captain","Awakened Ice Admiral","Tide Keeper","Island Empress","Longma","rip_indra","Cake Prince","Cake Queen","Dough King"}

local function teleportToBoss(name)
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Model") and obj.Name == name and obj:FindFirstChild("HumanoidRootPart") then
            return teleportTo(obj.HumanoidRootPart.Position + Vector3.new(0, 0, -5))
        end
    end
    return false
end

-- =============================================
-- FEATURES: ESP
-- =============================================
local espActive = {}
local function createHighlight(model, color)
    if not model or model:FindFirstChild("Highlight") then return end
    local h = Instance.new("Highlight")
    h.Adornee = model
    h.FillColor = color
    h.FillTransparency = 0.5
    h.OutlineColor = color
    h.Thickness = 2
    h.Parent = model
end
local function removeHighlight(model)
    local h = model:FindFirstChild("Highlight")
    if h then h:Destroy() end
end
local function clearAllESP()
    for _, obj in pairs(Workspace:GetChildren()) do
        removeHighlight(obj)
    end
end

local function espLoop(type, color, filter)
    while espActive[type] do
        task.wait(0.5)
        local root = getRootPart()
        if not root then continue end
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj ~= player.Character then
                local dist = (obj.HumanoidRootPart.Position - root.Position).Magnitude
                if dist <= 500 and filter(obj) then
                    createHighlight(obj, color)
                else
                    removeHighlight(obj)
                end
            end
        end
    end
    clearAllESP()
end

function toggleESPPlayer()
    espActive.player = not espActive.player
    if espActive.player then
        task.spawn(function() espLoop("player", Color3.fromRGB(0,255,255), function(o) return o:FindFirstChild("Humanoid") and not o.Name:find("Fruit") and not BOSS_DATA[o.Name] end) end)
    else
        clearAllESP()
    end
    return espActive.player
end

function toggleESPMob()
    espActive.mob = not espActive.mob
    if espActive.mob then
        task.spawn(function()
            local mobNames = {}
            for _, q in ipairs(SEA1_QUESTS) do for _, e in ipairs(q.enemies) do table.insert(mobNames, e) end end
            for _, q in ipairs(SEA2_QUESTS) do for _, e in ipairs(q.enemies) do table.insert(mobNames, e) end end
            for _, q in ipairs(SEA3_QUESTS) do for _, e in ipairs(q.enemies) do table.insert(mobNames, e) end end
            espLoop("mob", Color3.fromRGB(255,0,0), function(o)
                local hum = o:FindFirstChild("Humanoid")
                if not hum then return false end
                for _, name in ipairs(mobNames) do if string.find(o.Name, name) then return true end end
                return false
            end)
        end)
    else
        clearAllESP()
    end
    return espActive.mob
end

function toggleESPBoss()
    espActive.boss = not espActive.boss
    if espActive.boss then
        task.spawn(function()
            espLoop("boss", Color3.fromRGB(255,215,0), function(o) return BOSS_DATA[o.Name] ~= nil end)
        end)
    else
        clearAllESP()
    end
    return espActive.boss
end

function toggleESPFruit()
    espActive.fruit = not espActive.fruit
    if espActive.fruit then
        task.spawn(function()
            espLoop("fruit", Color3.fromRGB(255,0,255), function(o) return o.Name and string.find(o.Name, "Fruit") end)
        end)
    else
        clearAllESP()
    end
    return espActive.fruit
end

-- =============================================
-- GUI BUILDER
-- =============================================
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DoEAK_GUI"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, Styles.Sizes.FrameWidth, 0, Styles.Sizes.FrameHeight)
mainFrame.Position = UDim2.new(0.5, -Styles.Sizes.FrameWidth/2, 0.5, -Styles.Sizes.FrameHeight/2)
mainFrame.BackgroundColor3 = Styles.Colors.Red
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Styles.Colors.Gold
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, Styles.Sizes.TitleHeight)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🐲 DOEAK HUB"
title.TextColor3 = Styles.Colors.Gold
title.TextScaled = true
title.Font = Styles.Fonts.Title
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 3)
closeBtn.BackgroundColor3 = Styles.Colors.DarkRed
closeBtn.BorderSizePixel = 1
closeBtn.BorderColor3 = Styles.Colors.Gold
closeBtn.Text = "✕"
closeBtn.TextColor3 = Styles.Colors.Gold
closeBtn.TextScaled = true
closeBtn.Font = Styles.Fonts.Title
closeBtn.Parent = mainFrame
closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

-- Tabs
local tabNames = {"Farm", "Teleport", "ESP", "Settings"}
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, Styles.Sizes.TabHeight)
tabFrame.Position = UDim2.new(0, 0, 0, Styles.Sizes.TitleHeight)
tabFrame.BackgroundColor3 = Styles.Colors.DarkRed
tabFrame.BackgroundTransparency = 0.3
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabButtons = {}
for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#tabNames, -5, 1, -6)
    btn.Position = UDim2.new((i-1)/#tabNames, 3, 0, 3)
    btn.BackgroundColor3 = Styles.Colors.DarkRed
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Styles.Colors.Gold
    btn.Text = name
    btn.TextColor3 = Styles.Colors.White
    btn.TextScaled = true
    btn.Font = Styles.Fonts.Normal
    btn.Parent = tabFrame
    tabButtons[i] = btn
end

-- Content frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -10, 1, -Styles.Sizes.TitleHeight - Styles.Sizes.TabHeight - 15)
contentFrame.Position = UDim2.new(0, 5, 0, Styles.Sizes.TitleHeight + Styles.Sizes.TabHeight + 5)
contentFrame.BackgroundColor3 = Styles.Colors.DarkRed
contentFrame.BackgroundTransparency = 0.5
contentFrame.BorderSizePixel = 1
contentFrame.BorderColor3 = Styles.Colors.Gold
contentFrame.Parent = mainFrame

-- Tabs content
local farmContent = Instance.new("Frame")
farmContent.Size = UDim2.new(1, 0, 1, 0)
farmContent.BackgroundTransparency = 1
farmContent.Parent = contentFrame

local teleportContent = Instance.new("Frame")
teleportContent.Size = UDim2.new(1, 0, 1, 0)
teleportContent.BackgroundTransparency = 1
teleportContent.Visible = false
teleportContent.Parent = contentFrame

local espContent = Instance.new("Frame")
espContent.Size = UDim2.new(1, 0, 1, 0)
espContent.BackgroundTransparency = 1
espContent.Visible = false
espContent.Parent = contentFrame

local settingsContent = Instance.new("Frame")
settingsContent.Size = UDim2.new(1, 0, 1, 0)
settingsContent.BackgroundTransparency = 1
settingsContent.Visible = false
settingsContent.Parent = contentFrame

local tabContents = {farmContent, teleportContent, espContent, settingsContent}

-- Farm Tab
local farmToggle = Instance.new("TextButton")
farmToggle.Size = UDim2.new(0.9, 0, 0, 35)
farmToggle.Position = UDim2.new(0.05, 0, 0.05, 0)
farmToggle.BackgroundColor3 = Styles.Colors.Gold
farmToggle.BorderSizePixel = 1
farmToggle.BorderColor3 = Styles.Colors.Red
farmToggle.Text = "Auto Farm: OFF"
farmToggle.TextColor3 = Styles.Colors.Black
farmToggle.TextScaled = true
farmToggle.Font = Styles.Fonts.Normal
farmToggle.Parent = farmContent
local farmState = false
farmToggle.MouseButton1Click:Connect(function()
    farmState = toggleFarm()
    farmToggle.Text = farmState and "Auto Farm: ON" or "Auto Farm: OFF"
    farmToggle.BackgroundColor3 = farmState and Styles.Colors.Green or Styles.Colors.Gold
end)

local rangeLabel = Instance.new("TextLabel")
rangeLabel.Size = UDim2.new(0.4, 0, 0, 30)
rangeLabel.Position = UDim2.new(0.05, 0, 0.30, 0)
rangeLabel.BackgroundTransparency = 1
rangeLabel.Text = "Bán kính: 50"
rangeLabel.TextColor3 = Styles.Colors.Gold
rangeLabel.TextScaled = true
rangeLabel.Font = Styles.Fonts.Normal
rangeLabel.Parent = farmContent

local rangeBtn = Instance.new("TextButton")
rangeBtn.Size = UDim2.new(0.1, 0, 0, 30)
rangeBtn.Position = UDim2.new(0.5, 0, 0.30, 0)
rangeBtn.BackgroundColor3 = Styles.Colors.Gold
rangeBtn.Text = "+"
rangeBtn.TextColor3 = Styles.Colors.Black
rangeBtn.TextScaled = true
rangeBtn.Font = Styles.Fonts.Normal
rangeBtn.Parent = farmContent
rangeBtn.MouseButton1Click:Connect(function()
    local cur = tonumber(string.match(rangeLabel.Text, "%d+")) or 50
    cur = math.min(cur + 10, 200)
    farmRadius = cur
    rangeLabel.Text = "Bán kính: " .. cur
end)

local rangeBtnMinus = Instance.new("TextButton")
rangeBtnMinus.Size = UDim2.new(0.1, 0, 0, 30)
rangeBtnMinus.Position = UDim2.new(0.65, 0, 0.30, 0)
rangeBtnMinus.BackgroundColor3 = Styles.Colors.Gold
rangeBtnMinus.Text = "-"
rangeBtnMinus.TextColor3 = Styles.Colors.Black
rangeBtnMinus.TextScaled = true
rangeBtnMinus.Font = Styles.Fonts.Normal
rangeBtnMinus.Parent = farmContent
rangeBtnMinus.MouseButton1Click:Connect(function()
    local cur = tonumber(string.match(rangeLabel.Text, "%d+")) or 50
    cur = math.max(cur - 10, 10)
    farmRadius = cur
    rangeLabel.Text = "Bán kính: " .. cur
end)

-- Teleport Tab
local islandScroll = Instance.new("ScrollingFrame")
islandScroll.Size = UDim2.new(1, 0, 0.45, 0)
islandScroll.Position = UDim2.new(0, 0, 0.05, 0)
islandScroll.BackgroundColor3 = Styles.Colors.DarkRed
islandScroll.BackgroundTransparency = 0.5
islandScroll.BorderSizePixel = 1
islandScroll.BorderColor3 = Styles.Colors.Gold
islandScroll.Parent = teleportContent
local y = 5
for _, loc in ipairs(LOCATIONS) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Styles.Colors.Gold
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Styles.Colors.Red
    btn.Text = loc.name .. " (Sea " .. loc.sea .. ")"
    btn.TextColor3 = Styles.Colors.Black
    btn.TextScaled = true
    btn.Font = Styles.Fonts.Normal
    btn.Parent = islandScroll
    btn.MouseButton1Click:Connect(function()
        teleportTo(loc.pos)
        print("[Teleport] Đã đến " .. loc.name)
    end)
    y = y + 40
    islandScroll.CanvasSize = UDim2.new(0, 0, 0, y + 10)
end

local bossScroll = Instance.new("ScrollingFrame")
bossScroll.Size = UDim2.new(1, 0, 0.4, 0)
bossScroll.Position = UDim2.new(0, 0, 0.55, 0)
bossScroll.BackgroundColor3 = Styles.Colors.DarkRed
bossScroll.BackgroundTransparency = 0.5
bossScroll.BorderSizePixel = 1
bossScroll.BorderColor3 = Styles.Colors.Gold
bossScroll.Parent = teleportContent
local by = 5
for _, name in ipairs(BOSS_NAMES) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, by)
    btn.BackgroundColor3 = Styles.Colors.Gold
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Styles.Colors.Red
    btn.Text = name
    btn.TextColor3 = Styles.Colors.Black
    btn.TextScaled = true
    btn.Font = Styles.Fonts.Normal
    btn.Parent = bossScroll
    btn.MouseButton1Click:Connect(function()
        teleportToBoss(name)
        print("[Teleport] Đang đến Boss: " .. name)
    end)
    by = by + 40
    bossScroll.CanvasSize = UDim2.new(0, 0, 0, by + 10)
end

-- ESP Tab
local function createESPToggle(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, yPos, 0)
    btn.BackgroundColor3 = Styles.Colors.Gold
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Styles.Colors.Red
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Styles.Colors.Black
    btn.TextScaled = true
    btn.Font = Styles.Fonts.Normal
    btn.Parent = espContent
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = callback()
        btn.Text = text .. ": " .. (state and "ON" or "OFF")
        btn.BackgroundColor3 = state and Styles.Colors.Green or Styles.Colors.Gold
    end)
end

createESPToggle("ESP Player", 0.05, toggleESPPlayer)
createESPToggle("ESP Mob", 0.25, toggleESPMob)
createESPToggle("ESP Boss", 0.45, toggleESPBoss)
createESPToggle("ESP Fruit", 0.65, toggleESPFruit)

-- Settings Tab
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.6, 0, 0, 50)
resetBtn.Position = UDim2.new(0.2, 0, 0.35, 0)
resetBtn.BackgroundColor3 = Styles.Colors.Red
resetBtn.BorderSizePixel = 2
resetBtn.BorderColor3 = Styles.Colors.Gold
resetBtn.Text = "RESET ALL"
resetBtn.TextColor3 = Styles.Colors.White
resetBtn.TextScaled = true
resetBtn.Font = Styles.Fonts.Title
resetBtn.Parent = settingsContent
resetBtn.MouseButton1Click:Connect(function()
    farmRunning = false
    clearAllESP()
    espActive = {}
    print("[Settings] Reset tất cả")
end)

-- Switch tab function
local function switchTab(index)
    for i, content in ipairs(tabContents) do
        content.Visible = (i == index)
    end
    for i, btn in ipairs(tabButtons) do
        if i == index then
            btn.BackgroundColor3 = Styles.Colors.Gold
            btn.TextColor3 = Styles.Colors.Black
        else
            btn.BackgroundColor3 = Styles.Colors.DarkRed
            btn.TextColor3 = Styles.Colors.White
        end
    end
end

for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(i) end)
end
switchTab(1)

-- Hotkey M
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.M then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("🐲 DOEAK HUB - Đã sẵn sàng! Nhấn M để mở/đóng GUI.")
