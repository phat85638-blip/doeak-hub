-- =============================================
-- auto_quest.lua - DOEAK HUB
-- Tự động nhận và hoàn thành quest theo level
-- Hỗ trợ Sea 1, 2, 3 với đầy đủ boss và quái
-- Nguồn tham khảo: bloxredeem.com, bloxfruit.io, gamedevourer.com
-- =============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- =============================================
-- CẤU HÌNH
-- =============================================
local CONFIG = {
    questCheckInterval = 1,
    teleportDelay = 0.5,
    autoAcceptQuest = true,
    autoCompleteQuest = true,
    autoTeleportToNPC = true,
    maxQuestDistance = 100,
}

-- =============================================
-- DỮ LIỆU QUEST THEO SEA (ĐÃ CHI TIẾT HÓA)
-- =============================================

-- Sea 1: Level 1 - 700
-- Nguồn: https://bloxredeem.com/wiki/blox-fruits/quests/ [reference:2]
local SEA1_QUESTS = {
    {
        name = "Bandit",
        npc = "Bandit Quest Giver",
        island = "Pirate Starter Island",
        minLevel = 1,
        maxLevel = 10,
        enemies = {"Bandits", "Trainees"}, -- Chi tiết hơn [reference:3]
        boss = nil,
    },
    {
        name = "Marine",
        npc = "Marine Leader",
        island = "Marine Fortress",
        minLevel = 15,
        maxLevel = 30,
        enemies = {"Marines", "Chief Petty Officers"}, -- [reference:4]
        boss = "Bobby",
    },
    {
        name = "Gorilla",
        npc = "Adventurer",
        island = "Jungle",
        minLevel = 30,
        maxLevel = 60,
        enemies = {"Monkey", "Gorilla"}, -- [reference:5]
        boss = "Gorilla King",
    },
    {
        name = "Pirate",
        npc = "Pirate Quest Giver",
        island = "Pirate Village",
        minLevel = 60,
        maxLevel = 90,
        enemies = {"Pirates", "Brutes"}, -- [reference:6]
        boss = nil,
    },
    {
        name = "Desert",
        npc = "Desert Adventurer",
        island = "Desert",
        minLevel = 90,
        maxLevel = 120,
        enemies = {"Desert Bandits", "Desert Officers"}, -- [reference:7]
        boss = nil,
    },
    {
        name = "Snow",
        npc = "Frozen Quest Giver",
        island = "Frozen Village",
        minLevel = 120,
        maxLevel = 150,
        enemies = {"Snow Bandits", "Snowmen"}, -- [reference:8]
        boss = "Yeti",
    },
    {
        name = "Vice Admiral",
        npc = "Marine Leader",
        island = "Marine Base",
        minLevel = 150,
        maxLevel = 190,
        enemies = {"Vice Admirals"}, -- [reference:9]
        boss = "Vice Admiral",
    },
    {
        name = "Sky",
        npc = "Sky Adventurer",
        island = "Skylands",
        minLevel = 200,
        maxLevel = 275,
        enemies = {"Sky Bandits", "Dark Masters", "God's Guards"}, -- [reference:10]
        boss = "Wysper",
    },
    {
        name = "Prison",
        npc = "Head Jailer",
        island = "Prison",
        minLevel = 275,
        maxLevel = 350,
        enemies = {"Prisoners", "Dangerous Prisoners"}, -- [reference:11]
        boss = "Swan",
    },
    {
        name = "Galley",
        npc = "Fountain Quest Giver",
        island = "Fountain City",
        minLevel = 275,
        maxLevel = 350,
        enemies = {"Galley Pirates", "Galley Captains"}, -- [reference:12]
        boss = "Cyborg",
    },
    {
        name = "Gladiator",
        npc = "Colosseum Quest Giver",
        island = "Colosseum",
        minLevel = 350,
        maxLevel = 400,
        enemies = {"Toga Warriors", "Gladiators"}, -- [reference:13]
        boss = "Greybeard",
    },
    {
        name = "Magma",
        npc = "Magma Quest Giver",
        island = "Magma Village",
        minLevel = 400,
        maxLevel = 450,
        enemies = {"Military Soldiers", "Military Spies"}, -- [reference:14]
        boss = "Magma Admiral",
    },
    {
        name = "Fishman",
        npc = "Submerged Quest Giver 1",
        island = "Underwater City",
        minLevel = 450,
        maxLevel = 500,
        enemies = {"Fishman Warriors", "Fishman Commandos"}, -- [reference:15]
        boss = "Fishman Lord",
    },
    {
        name = "Upper Sky",
        npc = "Sky Quest Giver 2",
        island = "Upper Skylands",
        minLevel = 500,
        maxLevel = 600,
        enemies = {"Sky Bandits", "Shandas"}, -- [reference:16]
        boss = "Thunder God",
    },
}

-- Sea 2: Level 700 - 1500
-- Nguồn: https://bloxredeem.com/wiki/blox-fruits/quests/ [reference:17]
local SEA2_QUESTS = {
    {
        name = "Swan",
        npc = "Kingdom Quest Giver",
        island = "Kingdom of Rose",
        minLevel = 700,
        maxLevel = 850,
        enemies = {"Swan Pirates", "Raiders", "Mercenaries"}, -- [reference:18]
        boss = "Diamond",
    },
    {
        name = "Green Zone",
        npc = "Fajita",
        island = "Green Zone",
        minLevel = 850,
        maxLevel = 1000,
        enemies = {"Marine Lieutenant", "Marine Captain", "Raid NPCs"}, -- [reference:19]
        boss = nil,
    },
    {
        name = "Graveyard",
        npc = "Graveyard Quest Giver",
        island = "Graveyard",
        minLevel = 1000,
        maxLevel = 1100,
        enemies = {"Zombies", "Possessed Mummy", "Demonic Soul"}, -- [reference:20]
        boss = "Soul Reaper",
    },
    {
        name = "Cursed",
        npc = "Cursed Quest Giver",
        island = "Cursed Ship",
        minLevel = 1100,
        maxLevel = 1200,
        enemies = {"Cursed Crew"}, -- [reference:21]
        boss = "Cursed Captain",
    },
    {
        name = "Ice",
        npc = "Ice Quest Giver",
        island = "Ice Castle",
        minLevel = 1200,
        maxLevel = 1325,
        enemies = {"Ice Pirates"}, -- [reference:22]
        boss = "Awakened Ice Admiral",
    },
    {
        name = "Dark",
        npc = "Dark Arena Quest Giver",
        island = "Dark Arena",
        minLevel = 1000,
        maxLevel = 1500,
        enemies = {"Dark Enemies"}, -- [reference:23]
        boss = "Darkbeard",
    },
}

-- Sea 3: Level 1500+
-- Nguồn: https://bloxredeem.com/wiki/blox-fruits/quests/ [reference:24]
local SEA3_QUESTS = {
    {
        name = "Port",
        npc = "Port Quest Giver",
        island = "Port Town",
        minLevel = 1500,
        maxLevel = 1575,
        enemies = {"Port Pirates"}, -- [reference:25]
        boss = nil,
    },
    {
        name = "Hydra",
        npc = "Hydra Quest Giver",
        island = "Hydra Island",
        minLevel = 1575,
        maxLevel = 1700,
        enemies = {"Hydra Crew"}, -- [reference:26]
        boss = "Island Empress",
    },
    {
        name = "Tree",
        npc = "Tree Quest Giver",
        island = "Great Tree",
        minLevel = 1700,
        maxLevel = 1800,
        enemies = {"Tree NPCs"}, -- [reference:27]
        boss = nil,
    },
    {
        name = "Turtle",
        npc = "Turtle Quest Giver",
        island = "Floating Turtle",
        minLevel = 1800,
        maxLevel = 1925,
        enemies = {"Turtle Guardians"}, -- [reference:28]
        boss = "Longma",
    },
    {
        name = "Castle",
        npc = "Castle Quest Giver",
        island = "Castle on Sea",
        minLevel = 1925,
        maxLevel = 2000,
        enemies = {"Castle Guards"}, -- [reference:29]
        boss = "rip_indra",
    },
    {
        name = "Cake",
        npc = "Cake Quest Giver",
        island = "Cake Island",
        minLevel = 1700,
        maxLevel = 2000,
        enemies = {"Cake Soldiers"}, -- [reference:30]
        boss = "Cake Prince",
    },
    {
        name = "Treats",
        npc = "Treat Quest Giver",
        island = "Sea of Treats",
        minLevel = 2000,
        maxLevel = 9999,
        enemies = {"Treat NPCs", "Ice Cream Chefs"}, -- [reference:31][reference:32]
        boss = "Cake Queen",
    },
}

-- =============================================
-- DỮ LIỆU BOSS CHI TIẾT (ĐÃ MỞ RỘNG)
-- Nguồn: bloxfruit.io, gamedevourer.com [reference:33][reference:34]
-- =============================================
local BOSS_DATA = {
    -- Sea 1 Bosses
    ["Gorilla King"] = { level = 25, sea = 1, island = "Jungle", respawn = 240, drops = "EXP & Money" }, -- [reference:35]
    ["Bobby"] = { level = 55, sea = 1, island = "Pirate Village", respawn = 600, drops = "EXP & Money" }, -- [reference:36]
    ["Yeti"] = { level = 110, sea = 1, island = "Frozen Village", respawn = 300, drops = "EXP & Money" }, -- [reference:37]
    ["Vice Admiral"] = { level = 130, sea = 1, island = "Marine Fortress", respawn = 600, drops = "Vice Admiral Coat" }, -- [reference:38][reference:39]
    ["Wysper"] = { level = 500, sea = 1, island = "Skylands", respawn = 1800, drops = "Bazooka (10%)" }, -- [reference:40]
    ["Swan"] = { level = 240, sea = 1, island = "Prison", respawn = 600, drops = "Pink Coat (5%)" }, -- [reference:41]
    ["Cyborg"] = { level = 675, sea = 1, island = "Fountain City", respawn = 900, drops = "Cool Shades (1%)" }, -- [reference:42]
    ["Greybeard"] = { level = 750, sea = 1, island = "Marine Fortress", respawn = 14400, drops = "Saber (quest)" }, -- [reference:43]
    ["Magma Admiral"] = { level = 350, sea = 1, island = "Magma Village", respawn = 600, drops = "Refined Musket (10%)" }, -- [reference:44]
    ["Fishman Lord"] = { level = 425, sea = 1, island = "Underwater City", respawn = 600, drops = "Trident (10%)" }, -- [reference:45]
    ["Thunder God"] = { level = 575, sea = 1, island = "Upper Skylands", respawn = 600, drops = "Pole (8%)" }, -- [reference:46]
    -- Sea 2 Bosses
    ["Diamond"] = { level = 750, sea = 2, island = "Kingdom of Rose", respawn = 1200, drops = "Longsword (10%)" }, -- [reference:47]
    ["Jeremy"] = { level = 850, sea = 2, island = "Kingdom of Rose", respawn = 1200, drops = "Black Spikey Coat (10%)" }, -- [reference:48]
    ["Fajita"] = { level = 925, sea = 2, island = "Green Zone", respawn = 1200, drops = "Gravity Cane (10%)" }, -- [reference:49]
    ["Darkbeard"] = { level = 1000, sea = 2, island = "Dark Arena", respawn = 900, drops = "Dark Coat (2%)" }, -- [reference:50][reference:51]
    ["Smoke Admiral"] = { level = 1150, sea = 2, island = "Hot & Cold", respawn = 1200, drops = "Jitte (15%)" }, -- [reference:52]
    ["Soul Reaper"] = { level = 2100, sea = 2, island = "Haunted Castle", respawn = 2700, drops = "Hallow Scythe, Holy Crown" }, -- [reference:53]
    ["Cursed Captain"] = { level = 1325, sea = 2, island = "Cursed Ship", respawn = 600, drops = "Red/Blue Spikey Coat" }, -- [reference:54][reference:55]
    ["Awakened Ice Admiral"] = { level = 1400, sea = 2, island = "Ice Castle", respawn = 1200, drops = "Library Key, Hidden Key" }, -- [reference:56][reference:57]
    ["Tide Keeper"] = { level = 1475, sea = 2, island = "Forgotten Island", respawn = 1800, drops = "Water Key, Dragon Trident" }, -- [reference:58]
    -- Sea 3 Bosses
    ["Island Empress"] = { level = 1575, sea = 3, island = "Hydra Island", respawn = 600, drops = "Serpent Bow" }, -- [reference:59]
    ["Longma"] = { level = 2000, sea = 3, island = "Floating Turtle", respawn = 1200, drops = "Tushita (quest)" }, -- [reference:60]
    ["rip_indra"] = { level = 5000, sea = 3, island = "Castle on Sea", respawn = 420, drops = "God's Chalice, Tushita" }, -- [reference:61]
    ["Cake Prince"] = { level = 1700, sea = 3, island = "Cake Island", respawn = 600, drops = "Pale Scarf" }, -- [reference:62]
    ["Cake Queen"] = { level = 2175, sea = 3, island = "Sea of Treats", respawn = 360, drops = "Buddy Sword (5%)" }, -- [reference:63][reference:64]
    ["Dough King"] = { level = 2300, sea = 3, island = "Dough Kingdom", respawn = 16200, drops = "Red Key, Dough Microchip" }, -- [reference:65]
}