# 🌟 SolarynUI — Premium Roblox GUI Library

A premium acrylic-glass GUI library for Roblox with smooth animations, multi-theme support, key system, config saving, and 12+ components.

![SolarynUI Banner](https://img.shields.io/badge/SolarynUI-v1.0.0-blue?style=for-the-badge)
![Lua](https://img.shields.io/badge/Lua-5.1-blue?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

## ✨ Features

- 🎨 **4 Built-in Themes** — Midnight, Ocean, Violet, Rose
- 🔑 **Key System** — Protect your scripts with saved keys & Discord/link integration
- 💾 **Config Save/Load** — JSON-based persistent settings
- 🏠 **Home Tab** — Welcome card, executor detection, Discord button
- 📱 **Mobile Responsive** — Touch-friendly with auto-sizing
- 🪟 **Premium Acrylic Design** — Noise overlay, outer glow, gradient accents
- 🎭 **Smooth Animations** — Intro, fade, tab slide, toggle/slider tweens
- ⚽ **Floating Reopen Button** — Pulsing reopen when GUI is hidden
- 📊 **12+ Components** — Toggle, Slider, Button, Dropdown, Input, Keybind, ColorPicker, Label, Paragraph, Divider, and more

## 🚀 Quick Start

```lua
local SolarynUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/SolarynUI/main/source.lua"))()

local Window = SolarynUI:CreateWindow({
    Name = "My Hub",
    Subtitle = "v1.0",
    Theme = "Midnight",
})

local Tab = Window:CreateTab({Name = "Main"})
local Section = Tab:CreateSection("⚡ Controls")

Section:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(v) print(v) end
})

Section:AddSlider({
    Name = "Speed",
    Min = 0, Max = 100, Default = 50,
    Callback = function(v) print(v) end
})

Section:AddButton({
    Name = "Execute",
    Callback = function() print("Clicked!") end
})
```

## 📖 Full Documentation

See [Documentation.md](Documentation.md) for the complete API reference.

## 📁 File Structure

```
SolarynUI/
├── source.lua          # Main library (load this)
├── Example.lua         # Full demo with every component
├── README.md           # This file
└── Documentation.md    # Complete API reference
```

## 🎨 Themes

| Theme | Accent | Style |
|-------|--------|-------|
| **Midnight** | Blue/Purple | Dark navy, cool blue accents |
| **Ocean** | Cyan/Blue | Deep sea, teal highlights |
| **Violet** | Purple/Pink | Rich purple, magenta glow |
| **Rose** | Pink/Orange | Warm rose, coral accents |

## 🔑 Key System

```lua
local Window = SolarynUI:CreateWindow({
    KeySystem = true,
    KeySettings = {
        Title = "My Script Key",
        Subtitle = "Enter Key",
        Note = "Get your key from our Discord!",
        SaveKey = true,
        Key = {"key123", "vipkey"},
        SecondAction = {
            Enabled = true,
            Type = "Discord",
            Parameter = "yourdiscord"
        }
    }
})
```

## 💾 Config System

```lua
-- Save all flagged values
SolarynUI:SaveConfig("MyConfig")

-- Load them back
SolarynUI:LoadConfig("MyConfig")

-- List saved configs
local configs = SolarynUI:ListConfigs()
```

## 📜 License

MIT License — Free to use, modify, and distribute.

## 🤝 Credits

- **SolarynUI** — Built from the premium Solaryn GK Macro GUI
- Inspired by Luna Interface Suite
