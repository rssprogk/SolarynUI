-- ═══════════════════════════════════════════════════════════════════════════
--  SolarynUI — Example Script (Demonstrates Every Feature)
--  Load the library first, then this file shows how to use it
-- ═══════════════════════════════════════════════════════════════════════════

-- Load from GitHub (replace with your actual raw URL):
-- local SolarynUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/SolarynUI/main/source.lua"))()

-- Or for local testing, paste source.lua above this line and use:
local SolarynUI = loadstring(readfile("SolarynUI/source.lua"))()

-- ═══════════ CREATE WINDOW ═══════════
local Window = SolarynUI:CreateWindow({
    Name = "SolarynUI Demo",
    Subtitle = "v1.0 · Premium Library",
    -- LogoID = "82795327169782",     -- Optional Roblox asset ID for logo
    Theme = "Midnight",               -- "Midnight", "Ocean", "Violet", "Rose"
    Size = {480, 540},                -- {Width, Height} or nil for default
    ToggleKey = Enum.KeyCode.RightControl,  -- Key to show/hide GUI

    -- Loading screen
    LoadingEnabled = true,
    LoadingTitle = "SolarynUI",
    LoadingSubtitle = "Loading demo...",

    -- Config settings
    ConfigSettings = {
        RootFolder = nil,             -- Optional parent folder
        ConfigFolder = "SolarynDemo"  -- Folder name for configs
    },

    -- Key System (set KeySystem = true to enable)
    KeySystem = false,
    KeySettings = {
        Title = "SolarynUI Key",
        Subtitle = "Enter Key to Continue",
        Note = "Get your key from our Discord server!",
        SaveKey = true,
        Key = {"solaryn2024", "testkey"},
        SecondAction = {
            Enabled = true,
            Type = "Discord",          -- "Discord" or "Link"
            Parameter = "yourdiscord"  -- discord.gg/yourdiscord
        }
    }
})

-- ═══════════ HOME TAB ═══════════
Window:CreateHomeTab({
    SupportedExecutors = {
        "Synapse X", "Fluxus", "Delta", "Wave",
        "Script-Ware", "Electron", "Comet", "Celery"
    },
    DiscordInvite = "yourdiscord",  -- discord.gg/yourdiscord
})

-- ═══════════ MAIN TAB ═══════════
local MainTab = Window:CreateTab({Name = "Main"})

local Controls = MainTab:CreateSection("⚡ Controls")

Controls:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Flag = "AutoFarm",
    Callback = function(value)
        print("Auto Farm:", value)
    end
})

Controls:AddToggle({
    Name = "Auto Collect",
    Default = true,
    Flag = "AutoCollect",
    Callback = function(value)
        print("Auto Collect:", value)
    end
})

Controls:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    Flag = "WalkSpeed",
    Callback = function(value)
        print("Walk Speed:", value)
    end
})

Controls:AddSlider({
    Name = "Jump Power",
    Min = 0,
    Max = 300,
    Default = 50,
    Increment = 5,
    Flag = "JumpPower",
    Callback = function(value)
        print("Jump Power:", value)
    end
})

Controls:AddButton({
    Name = "🎯 Teleport to Spawn",
    Callback = function()
        print("Teleporting!")
        SolarynUI:Notify({Title = "Teleport", Content = "Teleported to spawn!", Duration = 3})
    end
})

Controls:AddDropdown({
    Name = "Game Mode",
    Options = {"Easy", "Normal", "Hard", "Impossible"},
    Default = "Normal",
    Flag = "GameMode",
    Callback = function(selected)
        print("Mode:", selected)
    end
})

-- ═══════════ COMBAT TAB ═══════════
local CombatTab = Window:CreateTab({Name = "Combat"})

local Combat = CombatTab:CreateSection("⚔ Combat Settings")

Combat:AddToggle({
    Name = "Auto Attack",
    Default = false,
    Flag = "AutoAttack",
    Callback = function(v) print("Auto Attack:", v) end
})

Combat:AddInput({
    Name = "Target Player",
    Placeholder = "Enter username...",
    Default = "",
    Flag = "TargetPlayer",
    Callback = function(text)
        print("Target:", text)
    end
})

Combat:AddKeybind({
    Name = "Attack Key",
    Default = Enum.KeyCode.Q,
    Flag = "AttackKey",
    Callback = function(key)
        print("Attack key pressed!")
    end,
    OnChanged = function(newKey)
        print("Key changed to:", newKey.Name)
    end
})

Combat:AddColorPicker({
    Name = "ESP Color",
    Default = Color3.fromRGB(85, 170, 255),
    Flag = "ESPColor",
    Callback = function(color)
        print("ESP Color:", color)
    end
})

local Info = CombatTab:CreateSection("ℹ Info")
Info:AddLabel("Auto Attack will target nearest player")
Info:AddLabel({Text = "ESP requires line of sight", Style = 2})  -- Info style (accent color)
Info:AddLabel({Text = "Use at your own risk!", Style = 3})        -- Warning style (orange)
Info:AddDivider()
Info:AddParagraph({
    Title = "How It Works",
    Text = "The combat system uses <b>raycasting</b> to detect nearby players and automatically engages them. You can customize the <i>target range</i> and <i>attack speed</i> using the sliders above."
})

-- ═══════════ SETTINGS TAB ═══════════
local SettingsTab = Window:CreateTab({Name = "Settings"})
SettingsTab:BuildThemeSection()
SettingsTab:BuildConfigSection()

local About = SettingsTab:CreateSection("ℹ About")
About:AddLabel("SolarynUI — Premium GUI Library")
About:AddLabel({Text = "Made by Solaryn", Style = 1})
About:AddLabel({Text = "Version 1.0.0", Style = 1})

-- ═══════════ DONE ═══════════
print("✅ SolarynUI Demo loaded! Press RCtrl to toggle GUI.")
