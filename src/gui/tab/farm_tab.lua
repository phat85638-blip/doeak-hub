-- =============================================
-- src/gui/tabs/farm_tab.lua - DOEAK HUB
-- Tab Farm: Điều khiển Auto Farm, chọn khu vực, cài đặt
-- =============================================

local styles = require(script.Parent.Parent.styles)
local autoFarm = require(script.Parent.Parent.features.auto_farm)
local teleport = require(script.Parent.Parent.features.teleport)

local function build(parentFrame)
    local tab = Instance.new("Frame")
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Parent = parentFrame

    -- Nút Toggle Auto Farm
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.9, 0, 0, styles.Sizes.ButtonHeight)
    toggleBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
    toggleBtn.BackgroundColor3 = styles.Colors.Gold
    toggleBtn.BorderSizePixel = 1
    toggleBtn.BorderColor3 = styles.Colors.Red
    toggleBtn.Text = "Auto Farm: OFF"
    toggleBtn.TextColor3 = styles.Colors.Black
    toggleBtn.TextScaled = true
    toggleBtn.Font = styles.Fonts.Normal
    toggleBtn.Parent = tab

    local farmState = false
    toggleBtn.MouseButton1Click:Connect(function()
        farmState = not farmState
        autoFarm.toggle()
        toggleBtn.Text = farmState and "Auto Farm: ON" or "Auto Farm: OFF"
        toggleBtn.BackgroundColor3 = farmState and styles.Colors.Green or styles.Colors.Gold
    end)

    -- Dropdown chọn khu vực farm (dùng danh sách từ auto_farm)
    local zones = autoFarm.getZones()
    local zoneNames = {}
    for _, zone in ipairs(zones) do
        table.insert(zoneNames, zone.zoneName .. " (Lv " .. zone.minLevel .. "-" .. zone.maxLevel .. ")")
    end

    local zoneLabel = Instance.new("TextLabel")
    zoneLabel.Size = UDim2.new(0.4, 0, 0, 30)
    zoneLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
    zoneLabel.BackgroundTransparency = 1
    zoneLabel.Text = "Khu vực:"
    zoneLabel.TextColor3 = styles.Colors.Gold
    zoneLabel.TextScaled = true
    zoneLabel.Font = styles.Fonts.Normal
    zoneLabel.Parent = tab

    local zoneDropdown = Instance.new("TextButton")
    zoneDropdown.Size = UDim2.new(0.4, 0, 0, 30)
    zoneDropdown.Position = UDim2.new(0.5, 0, 0.25, 0)
    zoneDropdown.BackgroundColor3 = styles.Colors.DarkGray
    zoneDropdown.BorderSizePixel = 1
    zoneDropdown.BorderColor3 = styles.Colors.Gold
    zoneDropdown.Text = zoneNames[1] or "Không có"
    zoneDropdown.TextColor3 = styles.Colors.White
    zoneDropdown.TextScaled = true
    zoneDropdown.Font = styles.Fonts.Normal
    zoneDropdown.Parent = tab

    -- Khi click dropdown, hiển thị danh sách (dùng ScrollingFrame) -- đơn giản hóa: chỉ hiện 1 nút
    local dropdownIndex = 1
    zoneDropdown.MouseButton1Click:Connect(function()
        dropdownIndex = dropdownIndex + 1
        if dropdownIndex > #zoneNames then dropdownIndex = 1 end
        local selectedName = zoneNames[dropdownIndex]
        zoneDropdown.Text = selectedName
        -- Tìm zone tương ứng
        for _, zone in ipairs(zones) do
            if zone.zoneName .. " (Lv " .. zone.minLevel .. "-" .. zone.maxLevel .. ")" == selectedName then
                teleport.toPosition(zone.spawnPoint)
                print("[FarmTab] Đã teleport đến " .. zone.zoneName)
                break
            end
        end
    end)

    -- Thanh trượt khoảng cách farm (dùng nút tăng giảm)
    local rangeLabel = Instance.new("TextLabel")
    rangeLabel.Size = UDim2.new(0.4, 0, 0, 30)
    rangeLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
    rangeLabel.BackgroundTransparency = 1
    rangeLabel.Text = "Bán kính: 50"
    rangeLabel.TextColor3 = styles.Colors.Gold
    rangeLabel.TextScaled = true
    rangeLabel.Font = styles.Fonts.Normal
    rangeLabel.Parent = tab

    local rangeBtn = Instance.new("TextButton")
    rangeBtn.Size = UDim2.new(0.1, 0, 0, 30)
    rangeBtn.Position = UDim2.new(0.5, 0, 0.45, 0)
    rangeBtn.BackgroundColor3 = styles.Colors.Gold
    rangeBtn.Text = "+"
    rangeBtn.TextColor3 = styles.Colors.Black
    rangeBtn.TextScaled = true
    rangeBtn.Font = styles.Fonts.Normal
    rangeBtn.Parent = tab
    rangeBtn.MouseButton1Click:Connect(function()
        local current = tonumber(string.match(rangeLabel.Text, "%d+")) or 50
        current = math.min(current + 10, 200)
        rangeLabel.Text = "Bán kính: " .. current
        autoFarm.setRadius(current)
    end)

    local rangeBtnMinus = Instance.new("TextButton")
    rangeBtnMinus.Size = UDim2.new(0.1, 0, 0, 30)
    rangeBtnMinus.Position = UDim2.new(0.65, 0, 0.45, 0)
    rangeBtnMinus.BackgroundColor3 = styles.Colors.Gold
    rangeBtnMinus.Text = "-"
    rangeBtnMinus.TextColor3 = styles.Colors.Black
    rangeBtnMinus.TextScaled = true
    rangeBtnMinus.Font = styles.Fonts.Normal
    rangeBtnMinus.Parent = tab
    rangeBtnMinus.MouseButton1Click:Connect(function()
        local current = tonumber(string.match(rangeLabel.Text, "%d+")) or 50
        current = math.max(current - 10, 10)
        rangeLabel.Text = "Bán kính: " .. current
        autoFarm.setRadius(current)
    end)

    return tab
end

return build