-- =============================================
-- src/gui/tabs/settings_tab.lua - DOEAK HUB
-- Tab Settings: Cài đặt chung
-- =============================================

local styles = require(script.Parent.Parent.styles)
local autoFarm = require(script.Parent.Parent.features.auto_farm)
local teleport = require(script.Parent.Parent.features.teleport)

local function build(parentFrame)
    local tab = Instance.new("Frame")
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Parent = parentFrame

    -- Toggle dùng Tween (di chuyển mượt)
    local tweenBtn = Instance.new("TextButton")
    tweenBtn.Size = UDim2.new(0.9, 0, 0, 40)
    tweenBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
    tweenBtn.BackgroundColor3 = styles.Colors.Gold
    tweenBtn.BorderSizePixel = 1
    tweenBtn.BorderColor3 = styles.Colors.Red
    tweenBtn.Text = "Tween: ON"
    tweenBtn.TextColor3 = styles.Colors.Black
    tweenBtn.TextScaled = true
    tweenBtn.Font = styles.Fonts.Normal
    tweenBtn.Parent = tab

    local tweenState = true
    tweenBtn.MouseButton1Click:Connect(function()
        tweenState = not tweenState
        teleport.setTween(tweenState)
        tweenBtn.Text = "Tween: " .. (tweenState and "ON" or "OFF")
        tweenBtn.BackgroundColor3 = tweenState and styles.Colors.Green or styles.Colors.Gold
    end)

    -- Toggle Auto Heal
    local healBtn = Instance.new("TextButton")
    healBtn.Size = UDim2.new(0.9, 0, 0, 40)
    healBtn.Position = UDim2.new(0.05, 0, 0.20, 0)
    healBtn.BackgroundColor3 = styles.Colors.Gold
    healBtn.BorderSizePixel = 1
    healBtn.BorderColor3 = styles.Colors.Red
    healBtn.Text = "Auto Heal: ON"
    healBtn.TextColor3 = styles.Colors.Black
    healBtn.TextScaled = true
    healBtn.Font = styles.Fonts.Normal
    healBtn.Parent = tab

    local healState = true
    healBtn.MouseButton1Click:Connect(function()
        healState = not healState
        -- Cập nhật trong auto_farm (cần thêm API)
        autoFarm.setHeal(healState)  -- giả định có hàm này
        healBtn.Text = "Auto Heal: " .. (healState and "ON" or "OFF")
        healBtn.BackgroundColor3 = healState and styles.Colors.Green or styles.Colors.Gold
    end)

    -- Nút Reset toàn bộ
    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.6, 0, 0, 50)
    resetBtn.Position = UDim2.new(0.2, 0, 0.50, 0)
    resetBtn.BackgroundColor3 = styles.Colors.Red
    resetBtn.BorderSizePixel = 2
    resetBtn.BorderColor3 = styles.Colors.Gold
    resetBtn.Text = "RESET ALL"
    resetBtn.TextColor3 = styles.Colors.White
    resetBtn.TextScaled = true
    resetBtn.Font = styles.Fonts.Title
    resetBtn.Parent = tab
    resetBtn.MouseButton1Click:Connect(function()
        -- Tạm thời in ra, sau này có thể reset biến
        print("[SettingsTab] Reset tất cả cài đặt")
        -- Có thể gọi các hàm reset từ các module
    end)

    return tab
end

return build