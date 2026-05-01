-- [ СИСТЕМА ПРОВЕРКИ КЛЮЧА ] --
local premiumKeysURL = "https://raw.githubusercontent.com/sadia4ek/LfbQWTuozKLtUKEYUwuIbjPOd/refs/heads/main/Keys/premiumkeys.txt"

-- Функция деобфускации внутри проверки
local function checkKey(inputKey)
    local charMap = {
        -- Заглавные
        A = "xQ!3mK@9Tz",  B = "7#mKWj8^n&",  C = "Tz@9!vR4xQ",  D = "!vR42kP$Wj",
        E = "2kP$Wj8^n5",  F = "Wj8^n&5YsbL",  G = "n&5YsbLq16U",  H = "b*Lq16Uf%Mc",
        I = "6Uf%Mc0+=Gh",  J = "Mc0+=Gh3!9r",  K = "=Gh3!9rX~Bw",  L = "9rX~Bw#4zi7",
        M = "Bw#4zi7$VpQe",  N = "i7$VpQe2@Ns",  O = "Qe2@Ns8&1oD",  P = "Ns8&1oDCk6%",
        Q = "1oD^Ck6%Fj!",  R = "Ck6%Fj!9a4H",  S = "Fj!9a4Hy*Zd",  T = "4Hy*Zd3#Gt0",
        U = "Zd3#Gt0@5mA",  V = "Gt0@5mA$Ru7",  W = "5mA$Ru7!=Lw",  X = "Ru7!=Lw2Pb9",
        Y = "=Lw2Pb9~xQ3",  Z = "Pb9~xQ3m!7K",

        -- Строчные
        a = "k3!qX7m#Tz",  b = "7Xm#Tz4@!3",  c = "Tz4@!3rV$2",  d = "!3rV$2kPW8",
        e = "$2kPW8j^&n",  f = "W8j^&nY5*bL",  g = "&nY5*bLq1Uf",  h = "*bLq1Uf%c0=",
        i = "1Uf%c0=Gh9r",  j = "c0=Gh9rX~w4",  k = "Gh9rX~w4zi7",  l = "rX~w4zi7Vp2",
        m = "w4zi7Vp2@Ns",  n = "i7Vp2@Ns8oD",  o = "Vp2@Ns8oD^k",  p = "Ns8oD^k6%Fj",
        q = "oD^k6%Fj9aH",  r = "k6%Fj9aHy*d",  s = "Fj9aHy*d3Gt",  t = "Hy*d3Gt0mA5",
        u = "d3Gt0mA5$u7",  v = "Gt0mA5$u7!w",  w = "mA5$u7!wLb9",  x = "u7!wLb9~Q3x",
        y = "wLb9~Q3xm7K",  z = "b9~Q3xm7K!q",

        -- Цифры
        ["0"] = "xQ3m!7KTz@",  ["1"] = "7KTz@9!vR4",  ["2"] = "z@9!vR42kPW",
        ["3"] = "vR42kPWj8^",  ["4"] = "kPWj8^n&5Y",  ["5"] = "j8^n&5YsbLq",
        ["6"] = "n&5YsbLq16U",  ["7"] = "YsbLq16Uf%",  ["8"] = "q16Uf%Mc0+=",
        ["9"] = "Uf%Mc0+=Gh3",

        -- Спецсимволы
        [" "]  = "Gh3!9rX~Bw",
        ["\t"] = "rX~Bw#4zi7",
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
