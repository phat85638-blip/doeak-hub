-- =============================================
-- src/gui/gui_builder.lua - DOEAK HUB
-- Xây dựng toàn bộ GUI từ các tab
-- =============================================

local styles = require(script.Parent.styles)
local farmTab = require(script.Parent.tabs.farm_tab)
local teleportTab = require(script.Parent.tabs.teleport_tab)
local espTab = require(script.Parent.tabs.esp_tab)
local settingsTab = require(script.Parent.tabs.settings_tab)

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function build()
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DoEAK_GUI"
    screenGui.Parent = playerGui

    -- Frame chính
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, styles.Sizes.FrameWidth, 0, styles.Sizes.FrameHeight)
    mainFrame.Position = UDim2.new(0.5, -styles.Sizes.FrameWidth/2, 0.5, -styles.Sizes.FrameHeight/2)
    mainFrame.BackgroundColor3 = styles.Colors.Red
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 3
    mainFrame.BorderColor3 = styles.Colors.Gold
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    -- Tiêu đề + Nút đóng
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -50, 0, styles.Sizes.TitleHeight)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🐲 DOEAK HUB"
    title.TextColor3 = styles.Colors.Gold
    title.TextScaled = true
    title.Font = styles.Fonts.Title
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = mainFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 3)
    closeBtn.BackgroundColor3 = styles.Colors.DarkRed
    closeBtn.BorderSizePixel = 1
    closeBtn.BorderColor3 = styles.Colors.Gold
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = styles.Colors.Gold
    closeBtn.TextScaled = true
    closeBtn.Font = styles.Fonts.Title
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
    end)

    -- Thanh Tab
    local tabNames = {"Farm", "Teleport", "ESP", "Settings"}
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 0, styles.Sizes.TabHeight)
    tabFrame.Position = UDim2.new(0, 0, 0, styles.Sizes.TitleHeight)
    tabFrame.BackgroundColor3 = styles.Colors.DarkRed
    tabFrame.BackgroundTransparency = 0.3
    tabFrame.BorderSizePixel = 0
    tabFrame.Parent = mainFrame

    local tabButtons = {}
    for i, name in ipairs(tabNames) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1/#tabNames, -5, 1, -6)
        btn.Position = UDim2.new((i-1)/#tabNames, 3, 0, 3)
        btn.BackgroundColor3 = styles.Colors.DarkRed
        btn.BorderSizePixel = 1
        btn.BorderColor3 = styles.Colors.Gold
        btn.Text = name
        btn.TextColor3 = styles.Colors.White
        btn.TextScaled = true
        btn.Font = styles.Fonts.Normal
        btn.Parent = tabFrame
        tabButtons[i] = btn
    end

    -- Nội dung chính
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -10, 1, -styles.Sizes.TitleHeight - styles.Sizes.TabHeight - 15)
    contentFrame.Position = UDim2.new(0, 5, 0, styles.Sizes.TitleHeight + styles.Sizes.TabHeight + 5)
    contentFrame.BackgroundColor3 = styles.Colors.DarkRed
    contentFrame.BackgroundTransparency = 0.5
    contentFrame.BorderSizePixel = 1
    contentFrame.BorderColor3 = styles.Colors.Gold
    contentFrame.Parent = mainFrame

    -- Xây dựng các tab
    local tabContents = {
        farmTab(contentFrame),
        teleportTab(contentFrame),
        espTab(contentFrame),
        settingsTab(contentFrame),
    }

    -- Ẩn tất cả trừ tab đầu
    for i = 2, #tabContents do
        tabContents[i].Visible = false
    end

    -- Hàm chuyển tab
    local function switchTab(index)
        for i, content in ipairs(tabContents) do
            content.Visible = (i == index)
        end
        for i, btn in ipairs(tabButtons) do
            if i == index then
                btn.BackgroundColor3 = styles.Colors.Gold
                btn.TextColor3 = styles.Colors.Black
            else
                btn.BackgroundColor3 = styles.Colors.DarkRed
                btn.TextColor3 = styles.Colors.White
            end
        end
    end

    for i, btn in ipairs(tabButtons) do
        btn.MouseButton1Click:Connect(function()
            switchTab(i)
        end)
    end

    -- Phím tắt mở GUI (phím M)
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.M then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    return {
        MainFrame = mainFrame,
        SwitchTab = switchTab,
    }
end

return build