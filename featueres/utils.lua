-- =============================================
-- UTILS - Hàm tiện ích dùng chung
-- =============================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Lấy nhân vật hiện tại (xử lý respawn)
local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

-- Lấy HumanoidRootPart của nhân vật
local function getRootPart()
    local char = getCharacter()
    return char:FindFirstChild("HumanoidRootPart")
end

-- Kiểm tra nhân vật còn sống
local function isAlive()
    local char = getCharacter()
    return char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0
end

-- Tìm quái gần nhất trong phạm vi
local function findNearestMob(radius)
    radius = radius or 50
    local root = getRootPart()
    if not root then return nil, math.huge end
    
    local nearest = nil
    local minDist = radius
    local pos = root.Position
    
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Name ~= player.Name then
            local hrp = obj:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (hrp.Position - pos).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = obj
                end
            end
        end
    end
    return nearest, minDist
end

-- Tìm trái cây gần nhất
local function findNearestFruit(radius)
    radius = radius or 200
    local root = getRootPart()
    if not root then return nil end
    
    local nearest = nil
    local minDist = radius
    local pos = root.Position
    
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Handle") and obj.Name:find("Fruit") then
            local primary = obj:FindFirstChild("PrimaryPart") or obj:FindFirstChild("Handle")
            if primary then
                local dist = (primary.Position - pos).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = obj
                end
            end
        end
    end
    return nearest, minDist
end

-- Di chuyển tức thời đến vị trí
local function teleportTo(position)
    local root = getRootPart()
    if root then
        root.CFrame = CFrame.new(position)
    end
end

-- Di chuyển từ từ (dùng TweenService)
local function tweenTo(position, speed)
    speed = speed or 10
    local root = getRootPart()
    if not root then return end
    
    local tweenService = game:GetService("TweenService")
    local goal = {}
    goal.CFrame = CFrame.new(position)
    local tweenInfo = TweenInfo.new(
        (root.Position - position).Magnitude / speed,
        Enum.EasingStyle.Linear
    )
    local tween = tweenService:Create(root, tweenInfo, goal)
    tween:Play()
    return tween
end

-- Tìm vũ khí (Tool) đang có
local function getWeapon()
    local char = getCharacter()
    return char:FindFirstChildOfClass("Tool")
end

-- Tấn công (kích hoạt tool)
local function attack()
    local tool = getWeapon()
    if tool then
        tool:Activate()
    end
end

-- Export các hàm
return {
    getCharacter = getCharacter,
    getRootPart = getRootPart,
    isAlive = isAlive,
    findNearestMob = findNearestMob,
    findNearestFruit = findNearestFruit,
    teleportTo = teleportTo,
    tweenTo = tweenTo,
    getWeapon = getWeapon,
    attack = attack,
}