-- =============================================
-- src/main.lua - DOEAK HUB
-- File khởi tạo chính, load GUI và các module
-- =============================================

print("🐲 DOEAK HUB - Đang khởi tạo...")

-- Load các module
local gui = require(script.gui.gui_builder)
local autoFarm = require(script.features.auto_farm)
local autoQuest = require(script.features.auto_quest)
local teleport = require(script.features.teleport)
local esp = require(script.features.esp)

-- Khởi tạo GUI
local mainGUI = gui.build()
print("✅ GUI đã được tạo.")

-- Có thể khởi tạo một số tính năng mặc định ở đây
-- Ví dụ: tự động bật Auto Farm khi vào game (tùy chọn)
-- autoFarm.toggle()

-- Thông báo hoàn tất
print("🐲 DOEAK HUB - Đã sẵn sàng! Nhấn M để mở/đóng GUI.")