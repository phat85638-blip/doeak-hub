-- =============================================
-- src/gui/tabs/esp_tab.lua - DOEAK HUB
-- Tab ESP: Bật/tắt các chế độ ESP
-- =============================================

local styles = require(script.Parent.Parent.styles)
local esp = require(script.Parent.Parent.features.esp)

local function build(parentFrame)
    local tab = Instance.new("Frame")
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Parent = parentFrame

    -- Hàm tạo toggle button
    local function createToggle(text, yPos, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 40)
        btn.Position = UDim2.new(0.05, 0, yPos, 0)
        btn.BackgroundColor3 = styles.Colors.Gold
        btn.BorderSizePixel = 1
        btn.BorderColor3 = styles.Colors.Red
        btn.Text = text .. ": OFF"
        btn.TextColor3 = styles.Colors.Black
        btn.TextScaled = true
        btn.Font = styles.Fonts.Normal
        btn.Parent = tab

        local state = false
        btn.MouseButton1Click:Connect(function()
            state = not state
            local result = callback(state)
            btn.Text = text .. ": " .. (result and "ON" or "OFF")
            btn.BackgroundColor3 = result and styles.Colors.Green or styles.Colors.Gold
        end)
        return btn
    end

    createToggle("ESP Player", 0.05, function(state)
        return esp.togglePlayer()
    end)

    createToggle("ESP Mob", 0.20, function(state)
        return esp.toggleMob()
    end)

    createToggle("ESP Boss", 0.35, function(state)
        return esp.toggleBoss()
    end)

    createToggle("ESP Fruit", 0.50, function(state)
        return esp.toggleFruit()
    end)

    -- Nút Clear all ESP
    local clearBtn = Instance.new("TextButton")
    clearBtn.Size = UDim2.new(0.6, 0, 0, 40)
    clearBtn.Position = UDim2.new(0.2, 0, 0.70, 0)
    clearBtn.BackgroundColor3 = styles.Colors.Red
    clearBtn.BorderSizePixel = 1
    clearBtn.BorderColor3 = styles.Colors.Gold
    clearBtn.Text = "Xóa tất cả ESP"
    clearBtn.TextColor3 = styles.Colors.White
    clearBtn.TextScaled = true
    clearBtn.Font = styles.Fonts.Normal
    clearBtn.Parent = tab
    clearBtn.MouseButton1Click:Connect(function()
        esp.clearAll()
        print("[ESPTab] Đã xóa tất cả ESP")
    end)

    return tab
end

return build