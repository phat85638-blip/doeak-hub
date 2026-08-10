-- =============================================
-- src/gui/styles.lua - DOEAK HUB
-- Định nghĩa màu sắc, font, kích thước dùng chung
-- =============================================

return {
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
        Small = Enum.Font.Gotham,
    },
    Sizes = {
        ButtonHeight = 35,
        TabHeight = 35,
        FrameWidth = 500,
        FrameHeight = 400,
        TitleHeight = 35,
        ControlSpacing = 10,
    },
    TextSizes = {
        Title = 20,
        Normal = 16,
        Small = 12,
    }
}