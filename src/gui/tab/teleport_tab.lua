-- =============================================
-- src/gui/tabs/teleport_tab.lua - DOEAK HUB
-- Tab Teleport: Dịch chuyển đến đảo, Boss, NPC
-- =============================================

local styles = require(script.Parent.Parent.styles)
local teleport = require(script.Parent.Parent.features.teleport)

local function build(parentFrame)
    local tab = Instance.new("Frame")
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Parent = parentFrame

    -- Tiêu đề: Đảo
    local islandTitle = Instance.new("TextLabel")
    islandTitle.Size = UDim2.new(1, 0, 0, 25)
    islandTitle.Position = UDim2.new(0, 0, 0, 0)
    islandTitle.BackgroundTransparency = 1
    islandTitle.Text = "🏝️ Đảo"
    islandTitle.TextColor3 = styles.Colors.Gold
    islandTitle.TextScaled = true
    islandTitle.Font = styles.Fonts.Title
    islandTitle.Parent = tab

    -- Danh sách đảo (dùng ScrollingFrame để hiển thị nhiều)
    local islandScroll = Instance.new("ScrollingFrame")
    islandScroll.Size = UDim2.new(1, 0, 0.45, 0)
    islandScroll.Position = UDim2.new(0, 0, 0.07, 0)
    islandScroll.BackgroundColor3 = styles.Colors.DarkRed
    islandScroll.BackgroundTransparency = 0.5
    islandScroll.BorderSizePixel = 1
    islandScroll.BorderColor3 = styles.Colors.Gold
    islandScroll.Parent = tab

    local locations = teleport.getLocations()
    local scrollY = 5
    for _, loc in ipairs(locations) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 30)
        btn.Position = UDim2.new(0.05, 0, 0, scrollY)
        btn.BackgroundColor3 = styles.Colors.Gold
        btn.BorderSizePixel = 1
        btn.BorderColor3 = styles.Colors.Red
        btn.Text = loc.name .. " (Sea " .. loc.sea .. ")"
        btn.TextColor3 = styles.Colors.Black
        btn.TextScaled = true
        btn.Font = styles.Fonts.Normal
        btn.Parent = islandScroll

        btn.MouseButton1Click:Connect(function()
            teleport.toLocation(loc.name)
            print("[TeleportTab] Đã teleport đến " .. loc.name)
        end)

        scrollY = scrollY + 40
        islandScroll.CanvasSize = UDim2.new(0, 0, 0, scrollY + 10)
    end

    -- Tiêu đề: Boss
    local bossTitle = Instance.new("TextLabel")
    bossTitle.Size = UDim2.new(1, 0, 0, 25)
    bossTitle.Position = UDim2.new(0, 0, 0.55, 0)
    bossTitle.BackgroundTransparency = 1
    bossTitle.Text = "👹 Boss"
    bossTitle.TextColor3 = styles.Colors.Gold
    bossTitle.TextScaled = true
    bossTitle.Font = styles.Fonts.Title
    bossTitle.Parent = tab

    local bossScroll = Instance.new("ScrollingFrame")
    bossScroll.Size = UDim2.new(1, 0, 0.35, 0)
    bossScroll.Position = UDim2.new(0, 0, 0.62, 0)
    bossScroll.BackgroundColor3 = styles.Colors.DarkRed
    bossScroll.BackgroundTransparency = 0.5
    bossScroll.BorderSizePixel = 1
    bossScroll.BorderColor3 = styles.Colors.Gold
    bossScroll.Parent = tab

    local bossNames = teleport.getBossList()
    local bossY = 5
    for _, name in ipairs(bossNames) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 30)
        btn.Position = UDim2.new(0.05, 0, 0, bossY)
        btn.BackgroundColor3 = styles.Colors.Gold
        btn.BorderSizePixel = 1
        btn.BorderColor3 = styles.Colors.Red
        btn.Text = name
        btn.TextColor3 = styles.Colors.Black
        btn.TextScaled = true
        btn.Font = styles.Fonts.Normal
        btn.Parent = bossScroll

        btn.MouseButton1Click:Connect(function()
            teleport.toBoss(name)
            print("[TeleportTab] Đang teleport đến Boss: " .. name)
        end)

        bossY = bossY + 40
        bossScroll.CanvasSize = UDim2.new(0, 0, 0, bossY + 10)
    end

    return tab
end

return build