-- [ СИСТЕМА ПРОВЕРКИ КЛЮЧА ] --
local premiumKeysURL = "https://raw.githubusercontent.com/sadia4ek/LfbQWTuozKLtUKEYUwuIbjPOd/refs/heads/main/Keys/premiumkeys.txt"

-- Функция деобфускации внутри проверки
local function checkKey(inputKey)
    local charMap = {
        A = "¤7&@1x", B = "¿#9!$%", C = "π~4+|=", D = "§8^}2?", E = "∞3*<:;", F = "¥0/!6>", G = "¢5=\\9]", H = "∆{2&8~",
        I = "°1+?7/", J = "©4!|0$", K = "µ8^3#@", L = "¶2>6:=", M = "Ω9~1*!", N = "≈5|7&%", O = "√3#8/?", P = "÷6@0+^",
        Q = "ƒ1&9~!", R = "∂7|3$=", S = "ß4/8+?", T = "ø0#5^@", U = "æ9~2&!", V = "†3|6*%", W = "‡8?1+/", X = "¬5$7#=",
        Y = "±2@9~!", Z = "∞6|0*%",
        a = "!7%~3#", b = "@2^8&!", c = "/9+1?=", d = "|4$6~*", e = "0#8@2!", f = "^5&1?~", g = "*3/7+=", h = "~9|2$#",
        i = "+6@0^!", j = "?1*8~&", k = "#7|3+%", l = "&2/9?~", m = "4$0!^*", n = "8~6@1#", o = "%3+7|!", p = "2^9?&~",
        q = "*5@0#|", r = "!7~3&+", s = "6/1?8^", t = "~2$9*#", u = "+0@4|!", v = "?8^6~&", w = "3#7/1*", x = "&5+9?~",
        y = "|2@8!^", z = "7~0*3#",
        ["0"] = "~!3#7@", ["1"] = "&9?2*^", ["2"] = "|5+0!~", ["3"] = "@7#1/8", ["4"] = "*2^9?&", 
        ["5"] = "6~!3|0", ["6"] = "?8+4@1", ["7"] = "#0*5~2", ["8"] = "&3|9!^", ["9"] = "@1~7+5",
        [" "] = "%~0|#@", ["\t"] = "@»3|8«@"
    }
    local rev = {} for k, v in pairs(charMap) do rev[v] = k end
    
    local success, content = pcall(function() return game:HttpGet(premiumKeysURL) end)
    if not success or not content then return false end

    for line in content:gmatch("[^\r\n]+") do
        local decoded = ""
        local i = 1
        while i <= #line do
            local part = line:sub(i, i + 5)
            if rev[part] then decoded = decoded .. rev[part] i = i + 6
            else i = i + 1 end
        end
        if inputKey == decoded then return true end
    end
    return false
end

-- Проверка
if not _G.KEY or not checkKey(_G.KEY) then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ZalupaWare",
        Text = "Such a premium key does not exist.",
        Duration = 10
    })
    return -- Стопаем выполнение скрипта
end

-- [ ИНИЦИАЛИЗАЦИЯ LINORIA LIB ] --
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Sense = loadstring(game:HttpGet('https://sirius.menu/sense'))()

local Window = Library:CreateWindow({
    Title = 'ZalupaWare | Premium Access',
    Center = true, AutoShow = true, TabPadding = 8
})

local Tabs = {
    ESP = Window:AddTab('ESP'),
    Player = Window:AddTab('Player'),
    Visual = Window:AddTab('Visual'),
    Misc = Window:AddTab('Misc'),
    Settings = Window:AddTab('Settings'),
}

-- =============================================================================
-- ВКЛАДКА ESP (Группировка)
-- =============================================================================

-- Лево: Настройка цветов
local ESPColors = Tabs.ESP:AddLeftGroupbox('ESP Colors')
ESPColors:AddLabel('Box Color'):AddColorPicker('col_box', { Default = Color3.new(1,1,1), Callback = function(v) Sense.teamSettings.enemy.boxColor = {v, 1} end })
ESPColors:AddLabel('Fill Color'):AddColorPicker('col_fill', { Default = Color3.new(1,1,1), Callback = function(v) Sense.teamSettings.enemy.boxFillColor = {v, 0.5} end })
ESPColors:AddLabel('Name Color'):AddColorPicker('col_name', { Default = Color3.new(1,1,1), Callback = function(v) Sense.teamSettings.enemy.nameColor = {v, 1} end })
ESPColors:AddLabel('Tracer Color'):AddColorPicker('col_tracers', { Default = Color3.new(1,1,1), Callback = function(v) Sense.teamSettings.enemy.tracerColor = {v, 1} end })
ESPColors:AddLabel('Chams Color'):AddColorPicker('col_chams', { Default = Color3.new(1,1,1), Callback = function(v) Sense.teamSettings.enemy.chamsFillColor = {v, 0.5} end })

-- Право: Переключатели
local ESPVisuals = Tabs.ESP:AddRightGroupbox('ESP Visuals')
ESPVisuals:AddToggle('e_esp', { Text = 'Enable ESP', Default = false, Callback = function(v) Sense.teamSettings.enemy.enabled = v end })
ESPVisuals:AddToggle('e_box', { Text = 'Boxes', Default = false, Callback = function(v) Sense.teamSettings.enemy.box = v end })
ESPVisuals:AddToggle('e_fill', { Text = 'Box Fill', Default = false, Callback = function(v) Sense.teamSettings.enemy.boxFill = v end })
ESPVisuals:AddToggle('e_names', { Text = 'Names', Default = false, Callback = function(v) Sense.teamSettings.enemy.name = v end })
ESPVisuals:AddToggle('e_dist', { Text = 'Distance', Default = false, Callback = function(v) Sense.teamSettings.enemy.distance = v end })
ESPVisuals:AddToggle('e_health', { Text = 'Health Bar', Default = false, Callback = function(v) Sense.teamSettings.enemy.healthBar = v end })
ESPVisuals:AddToggle('e_tracers', { Text = 'Tracers', Default = false, Callback = function(v) Sense.teamSettings.enemy.tracer = v end })
ESPVisuals:AddToggle('e_chams', { Text = 'Chams', Default = false, Callback = function(v) Sense.teamSettings.enemy.chams = v end })

local ESPControl = Tabs.ESP:AddRightGroupbox('Controls')
ESPControl:AddButton('Load ESP', function() Sense.Load() end)
ESPControl:AddButton('Unload ESP', function() Sense.Unload() end)

-- =============================================================================
-- ОСТАЛЬНЫЕ ВКЛАДКИ
-- =============================================================================

-- Player
local Movement = Tabs.Player:AddLeftGroupbox('Movement')
Movement:AddToggle('inf_jump', { Text = 'Infinite Jump', Default = false, Callback = function(v) _G.InfJump = v end })

-- Visual (Weapon Color)
local WeaponGroup = Tabs.Visual:AddLeftGroupbox('Weapon Customization')
local WeaponColorEnabled = false
local CurrentWeaponColor = Color3.fromRGB(0, 255, 0)

WeaponGroup:AddToggle('w_col_enabled', { Text = 'Custom Weapon Color', Default = false, Callback = function(v) WeaponColorEnabled = v end })
    :AddColorPicker('w_col_pick', { Default = CurrentWeaponColor, Callback = function(v) CurrentWeaponColor = v end })

-- Misc
local Utils = Tabs.Misc:AddLeftGroupbox('Utilities')
local UnlockMouseEnabled = true
Utils:AddToggle('u_mouse', { Text = 'Unlock Mouse (LALT)', Default = true, Callback = function(v) UnlockMouseEnabled = v end })

-- =============================================================================
-- ФОНОВЫЕ ПРОЦЕССЫ
-- =============================================================================

-- Цикл для цвета оружия
task.spawn(function()
    while true do
        if WeaponColorEnabled then
            pcall(function()
                local fp = workspace:FindFirstChild("ViewModels") and workspace.ViewModels:FindFirstChild("FirstPerson")
                if fp then
                    for _, m in pairs(fp:GetChildren()) do
                        local vis = m:FindFirstChild("ItemVisual")
                        if vis then
                            for _, p in pairs(vis:GetDescendants()) do
                                if (p:IsA("BasePart") or p:IsA("MeshPart")) and p.Transparency < 1 then
                                    p.Color = CurrentWeaponColor
                                end
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.2)
    end
end)

-- Прыжки и Мышь
game:GetService("UserInputService").JumpRequest:Connect(function() if _G.InfJump then game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping") end end)

local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(i, gp)
    if UnlockMouseEnabled and i.KeyCode == Enum.KeyCode.LeftAlt and not gp then
        UIS.MouseBehavior = Enum.MouseBehavior.Default
        UIS.MouseIconEnabled = true
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.LeftAlt then
        UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
    end
end)

-- [ НАСТРОЙКИ МЕНЮ ] --
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
ThemeManager:SetFolder('ZalupaWare')
SaveManager:SetFolder('ZalupaWare/configs')
ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Library:Notify("Access Granted. Welcome, " .. tostring(_G.KEY), 5)
