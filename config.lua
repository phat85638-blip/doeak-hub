-- =============================================
-- CONFIG - Các tham số cài đặt toàn cục
-- =============================================

local Config = {
    -- Khoảng cách tấn công tối đa (Auto Farm)
    FarmRadius = 30,
    
    -- Tốc độ di chuyển khi farm (CFrame teleport)
    FarmSpeed = 1,
    
    -- Khoảng cách ESP
    ESPRadius = 500,
    
    -- Màu sắc ESP
    ESPColors = {
        Player = Color3.fromRGB(0, 255, 255),
        Fruit = Color3.fromRGB(255, 0, 255),
        Chest = Color3.fromRGB(255, 255, 0),
        Boss = Color3.fromRGB(255, 0, 0),
    },
    
    -- Danh sách các đảo để teleport (sẽ cập nhật theo level)
    Islands = {
        {name = "Jungle", position = Vector3.new(0, 0, 0)}, -- Thay bằng tọa độ thực
        {name = "Pirate Village", position = Vector3.new(0, 0, 0)},
        {name = "Ice Island", position = Vector3.new(0, 0, 0)},
        -- ... thêm các đảo khác
    },
    
    -- Danh sách Boss (tên model trong game)
    BossNames = {
        "Boss",
        "Awakened Ice Admiral",
        "Diamond",
        "Greybeard",
        -- ... thêm boss khác
    },
}

return Config