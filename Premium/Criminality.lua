-- [ СИСТЕМА ПРОВЕРКИ КЛЮЧА ] --
local premiumKeysURL = "https://raw.githubusercontent.com/sadia4ek/LfbQWTuozKLtUKEYUwuIbjPOd/refs/heads/main/Keys/premiumkeys.txt"

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

if not _G.KEY or not checkKey(_G.KEY) then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ZalupaWare",
        Text = "Such a premium key does not exist.",
        Duration = 10
    })
    return 
end

-- [ ИНИЦИАЛИЗАЦИЯ ] --
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Sense = loadstring(game:HttpGet('https://sirius.menu/sense'))()
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/sadia4ek/ZalupaWareIndustries/refs/heads/main/Libs/ExunysAimbot.lua"))()

Aimbot.Load()
Sense.Load()

-- Default States
ExunysDeveloperAimbot.FOVSettings.Enabled = false
ExunysDeveloperAimbot.Settings.Enabled = false
Sense.teamSettings.enemy.tracerOutline = false

local Window = Library:CreateWindow({ Title = 'ZalupaWare | Premium', Center = true, AutoShow = true })

local Tabs = {
    Player = Window:AddTab('Player'),
    Aimbot = Window:AddTab('Aimbot'),
    ESP = Window:AddTab('ESP'),
    Visual = Window:AddTab('Visual'),
    Settings = Window:AddTab('Settings'),
}

-- =============================================================================
-- PLAYER (Movements & Strafes)
-- =============================================================================
local MoveGroup = Tabs.Player:AddLeftGroupbox('Movements')
local strafeEnabled = false
local strafePower = 60 

MoveGroup:AddToggle('strafe_enabled', { Text = 'Strafe', Default = false, Callback = function(v) strafeEnabled = v end })
MoveGroup:AddSlider('strafe_pwr', { Text = 'Strafe Power', Default = 60, Min = 10, Max = 200, Rounding = 0, Callback = function(v) strafePower = v end })

-- Strafe Logic
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local lastStrafe = 0
local function hardStrafe(direction)
    if not strafeEnabled then return end 
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local hum = character and character:FindFirstChild("Humanoid")
    if root and hum and hum.Health > 0 then
        local state = hum:GetState()
        if state ~= Enum.HumanoidStateType.Freefall and state ~= Enum.HumanoidStateType.Jumping then return end
        if tick() - lastStrafe < 0.05 then return end
        lastStrafe = tick()
        local moveVector = (direction == "Right") and workspace.CurrentCamera.CFrame.RightVector or -workspace.CurrentCamera.CFrame.RightVector
        root.AssemblyLinearVelocity = Vector3.new(moveVector.X * strafePower, root.AssemblyLinearVelocity.Y, moveVector.Z * strafePower)
    end
end
UIS.InputBegan:Connect(function(i, gp) if not gp then if i.KeyCode == Enum.KeyCode.D then hardStrafe("Right") elseif i.KeyCode == Enum.KeyCode.A then hardStrafe("Left") end end end)

-- =============================================================================
-- AIMBOT (Exunys)
-- =============================================================================
local AimMain = Tabs.Aimbot:AddLeftGroupbox('Aimbot Settings')
AimMain:AddToggle('aim_en', { Text = 'Enabled', Default = false, Callback = function(v) ExunysDeveloperAimbot.Settings.Enabled = v end })
AimMain:AddToggle('aim_alive', { Text = 'Alive Check', Default = false, Callback = function(v) ExunysDeveloperAimbot.Settings.AliveCheck = v end })
AimMain:AddToggle('aim_wall', { Text = 'Wall Check', Default = false, Callback = function(v) ExunysDeveloperAimbot.Settings.WallCheck = v end })
AimMain:AddToggle('aim_toggle', { Text = 'Toggle Mode', Default = false, Callback = function(v) ExunysDeveloperAimbot.Settings.Toggle = v end })
AimMain:AddLabel('Aim Key'):AddKeyPicker('aim_key', { Default = 'RightClick', NoUserShortcut = true, Callback = function(v) ExunysDeveloperAimbot.Settings.TriggerKey = v end })

local AimFOV = Tabs.Aimbot:AddRightGroupbox('FOV Settings')
AimFOV:AddToggle('fov_en', { Text = 'Enabled', Default = false, Callback = function(v) ExunysDeveloperAimbot.FOVSettings.Enabled = v end })
AimFOV:AddToggle('fov_vis', { Text = 'Visible', Default = false, Callback = function(v) ExunysDeveloperAimbot.FOVSettings.Visible = v end })
AimFOV:AddToggle('fov_fill', { Text = 'Filled', Default = false, Callback = function(v) ExunysDeveloperAimbot.FOVSettings.Filled = v end })
AimFOV:AddSlider('fov_rad', { Text = 'Radius', Default = 180, Min = 1, Max = 360, Rounding = 0, Callback = function(v) ExunysDeveloperAimbot.FOVSettings.Radius = v end })
AimFOV:AddSlider('fov_trans', { Text = 'Transparency', Default = 1, Min = 0, Max = 1, Rounding = 1, Callback = function(v) ExunysDeveloperAimbot.FOVSettings.Transparency = v end })
AimFOV:AddSlider('fov_thick', { Text = 'Thickness', Default = 1, Min = 0, Max = 1, Rounding = 1, Callback = function(v) ExunysDeveloperAimbot.FOVSettings.Thickness = v end })

-- =============================================================================
-- ESP (Sense)
-- =============================================================================
local ESPMain = Tabs.ESP:AddRightGroupbox('Visuals') -- Туглы справа
ESPMain:AddToggle('e_en', { Text = 'ESP Master', Default = false, Callback = function(v) Sense.teamSettings.enemy.enabled = v end })
ESPMain:AddToggle('e_box', { Text = 'Box', Default = false, Callback = function(v) Sense.teamSettings.enemy.box = v end })
ESPMain:AddToggle('e_boxo', { Text = 'Box Outline', Default = false, Callback = function(v) Sense.teamSettings.enemy.boxOutline = v end })
ESPMain:AddToggle('e_boxf', { Text = 'Box Fill', Default = false, Callback = function(v) Sense.teamSettings.enemy.boxFill = v end })
ESPMain:AddToggle('e_box3', { Text = '3D Box', Default = false, Callback = function(v) Sense.teamSettings.enemy.box3d = v end })
ESPMain:AddToggle('e_hp', { Text = 'Health Bar', Default = false, Callback = function(v) Sense.teamSettings.enemy.healthBar = v end })
ESPMain:AddToggle('e_hpo', { Text = 'Health Bar Outline', Default = false, Callback = function(v) Sense.teamSettings.enemy.healthBarOutline = v end })
ESPMain:AddToggle('e_hpt', { Text = 'Health Text', Default = false, Callback = function(v) Sense.teamSettings.enemy.healthText = v end })
ESPMain:AddToggle('e_hpto', { Text = 'Health Text Outline', Default = false, Callback = function(v) Sense.teamSettings.enemy.healthTextOutline = v end })
ESPMain:AddToggle('e_name', { Text = 'Name', Default = false, Callback = function(v) Sense.teamSettings.enemy.name = v end })
ESPMain:AddToggle('e_nameo', { Text = 'Name Outline', Default = false, Callback = function(v) Sense.teamSettings.enemy.nameOutline = v end })
ESPMain:AddToggle('e_dist', { Text = 'Distance', Default = false, Callback = function(v) Sense.teamSettings.enemy.distance = v end })
ESPMain:AddToggle('e_disto', { Text = 'Distance Outline', Default = false, Callback = function(v) Sense.teamSettings.enemy.distanceOutline = v end })
ESPMain:AddToggle('e_tr', { Text = 'Tracers', Default = false, Callback = function(v) Sense.teamSettings.enemy.tracer = v end })
ESPMain:AddToggle('e_tro', { Text = 'Tracers Outline', Default = false, Callback = function(v) Sense.teamSettings.enemy.tracerOutline = v end })
ESPMain:AddDropdown('e_trpos', { Values = { "Bottom", "Middle", "Top" }, Default = 1, Text = 'Tracer Position', Callback = function(v) Sense.teamSettings.enemy.tracerOrigin = v end })
ESPMain:AddToggle('e_arr', { Text = 'OffScreen Arrows', Default = false, Callback = function(v) Sense.teamSettings.enemy.offScreenArrow = v end })
ESPMain:AddToggle('e_arro', { Text = 'Arrows Outline', Default = false, Callback = function(v) Sense.teamSettings.enemy.offScreenArrowOutline = v end })
ESPMain:AddSlider('e_arrs', { Text = 'Arrows Size', Default = 15, Min = 5, Max = 50, Rounding = 0, Callback = function(v) Sense.teamSettings.enemy.offScreenArrowSize = v end })
ESPMain:AddSlider('e_arrr', { Text = 'Arrows Radius', Default = 150, Min = 50, Max = 500, Rounding = 0, Callback = function(v) Sense.teamSettings.enemy.offScreenArrowRadius = v end })
ESPMain:AddToggle('e_ch', { Text = 'Chams', Default = false, Callback = function(v) Sense.teamSettings.enemy.chams = v end })
ESPMain:AddToggle('e_chv', { Text = 'Chams Visible Only', Default = false, Callback = function(v) Sense.teamSettings.enemy.chamsVisibleOnly = v end })
ESPMain:AddToggle('e_wp', { Text = 'Weapon', Default = false, Callback = function(v) Sense.teamSettings.enemy.weapon = v end })
ESPMain:AddToggle('e_wpo', { Text = 'Weapon Outline', Default = false, Callback = function(v) Sense.teamSettings.enemy.weaponOutline = v end })

local ESPColors = Tabs.ESP:AddLeftGroupbox('Colors & Controls') -- Цвета слева
ESPColors:AddLabel('Box Color'):AddColorPicker('c_box', { Default = Color3.new(1,1,1), Callback = function(v) Sense.teamSettings.enemy.boxColor = {v, 1} end })
ESPColors:AddLabel('Fill Color'):AddColorPicker('c_fill', { Default = Color3.new(1,1,1), Callback = function(v) Sense.teamSettings.enemy.boxFillColor = {v, 0.5} end })
ESPColors:AddLabel('Name Color'):AddColorPicker('c_name', { Default = Color3.new(1,1,1), Callback = function(v) Sense.teamSettings.enemy.nameColor = {v, 1} end })
ESPColors:AddLabel('Tracer Color'):AddColorPicker('c_tr', { Default = Color3.new(1,1,1), Callback = function(v) Sense.teamSettings.enemy.tracerColor = {v, 1} end })
ESPColors:AddButton('Load ESP', function() Sense.Load() end)
ESPColors:AddButton('Unload ESP', function() Sense.Unload() end)

-- =============================================================================
-- VISUAL (World & Screen)
-- =============================================================================
local WorldGroup = Tabs.Visual:AddLeftGroupbox('World')
local Lighting = game:GetService("Lighting")
local original = { Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime, GlobalShadows = Lighting.GlobalShadows, Ambient = Lighting.Ambient, FogEnd = Lighting.FogEnd }

WorldGroup:AddToggle('full_bright', { Text = 'Full Bright', Default = false, Callback = function(state)
    if state then
        _G.FB = game:GetService("RunService").RenderStepped:Connect(function()
            Lighting.Brightness = 2; Lighting.ClockTime = 12; Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.new(1,1,1); Lighting.OutdoorAmbient = Color3.new(1,1,1)
        end)
    else
        if _G.FB then _G.FB:Disconnect() end
        Lighting.Brightness = original.Brightness; Lighting.ClockTime = original.ClockTime
        Lighting.GlobalShadows = original.GlobalShadows; Lighting.Ambient = original.Ambient
    end
end})

WorldGroup:AddToggle('no_fog', { Text = 'Disable Fog', Default = false, Callback = function(v) Lighting.FogEnd = v and 100000 or original.FogEnd end })

local ScreenGroup = Tabs.Visual:AddRightGroupbox('Screen')
ScreenGroup:AddSlider('fov_ch', { Text = 'FOV Changer', Default = 70, Min = 50, Max = 120, Rounding = 0, Callback = function(v) workspace.CurrentCamera.FieldOfView = v end })

-- [ SETTINGS ] --
ThemeManager:SetLibrary(Library); SaveManager:SetLibrary(Library)
ThemeManager:SetFolder('ZalupaWare'); SaveManager:SetFolder('ZalupaWare/configs')
ThemeManager:ApplyToTab(Tabs.Settings); SaveManager:BuildConfigSection(Tabs.Settings)

Library:Notify("ZalupaWare Premium Loaded!", 5)
