# SolarynUI — Complete API Documentation

## Table of Contents
- [Installation](#installation)
- [SolarynUI (Global)](#solarynui-global)
- [Window](#window)
- [Tab](#tab)
- [Section](#section)
- [Components](#components)

---

## Installation

```lua
-- From GitHub (recommended)
local SolarynUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/SolarynUI/main/source.lua"))()

-- From local file
local SolarynUI = loadstring(readfile("SolarynUI/source.lua"))()
```

---

## SolarynUI (Global)

### `SolarynUI:CreateWindow(options)`

Creates the main GUI window. Returns a `Window` object.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Name` | string | `"SolarynUI"` | Window title |
| `Subtitle` | string | `"v1.0"` | Subtitle text |
| `LogoID` | string? | nil | Roblox asset ID for logo icon |
| `Theme` | string | `"Midnight"` | `"Midnight"`, `"Ocean"`, `"Violet"`, `"Rose"` |
| `Size` | table? | `{480, 540}` | `{Width, Height}` |
| `ToggleKey` | Enum.KeyCode | `RightControl` | Key to show/hide GUI |
| `LoadingEnabled` | bool | false | Show loading notification |
| `LoadingTitle` | string | `"SolarynUI"` | Loading notification title |
| `LoadingSubtitle` | string | `"Loading..."` | Loading notification subtitle |
| `ConfigSettings` | table? | nil | `{RootFolder, ConfigFolder}` |
| `KeySystem` | bool | false | Enable key system gate |
| `KeySettings` | table? | nil | See Key System section |

### `SolarynUI:Notify(options)`

Shows a toast notification.

```lua
SolarynUI:Notify({
    Title = "Hello",
    Content = "Welcome to the script!",
    Duration = 5  -- seconds (default: 5)
})
```

### `SolarynUI:SetTheme(name)`

Changes the active theme. Takes effect on next `CreateWindow`.

### `SolarynUI:SaveConfig(name)` / `SolarynUI:LoadConfig(name)`

Saves/loads all flagged values as JSON. Uses `writefile`/`readfile`.

### `SolarynUI:ListConfigs()`

Returns a table of saved config names.

---

## Key System

```lua
KeySettings = {
    Title = "Key Required",
    Subtitle = "Enter your key",
    Note = "Optional note text",
    SaveKey = true,              -- Save key to file
    Key = {"key1", "key2"},      -- Accepted keys
    SecondAction = {
        Enabled = true,
        Type = "Discord",        -- "Discord" or "Link"
        Parameter = "invite123"  -- discord invite or URL
    }
}
```

---

## Window

### `Window:CreateHomeTab(options)`

Creates a Home tab with welcome card, executor info, and Discord button.

| Option | Type | Description |
|--------|------|-------------|
| `SupportedExecutors` | table | List of supported executor names |
| `DiscordInvite` | string? | Discord invite code |

### `Window:CreateTab(options)`

Creates a new tab. Returns a `Tab` object.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Name` | string | `"Tab N"` | Tab display name |

### `Window:Minimize()` / `Window:Destroy()`

Minimize or destroy the window.

---

## Tab

### `Tab:CreateSection(title)`

Creates a section card. Returns a `Section` object with all component methods.

### `Tab:CreateDivider()`

Adds a horizontal line divider between sections.

### `Tab:CreateLabel(options)`

Adds a standalone label to the tab (outside sections).

### `Tab:BuildThemeSection()` / `Tab:BuildConfigSection()`

Adds pre-built theme switcher or config save/load UI.

---

## Section — Components

All components are added via the Section object returned by `Tab:CreateSection()`.

### `Section:AddToggle(options)`

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Name` | string | `"Toggle"` | Display name |
| `Default` | bool | `false` | Initial state |
| `Flag` | string? | nil | Config save key |
| `Callback` | function | nil | `function(boolean)` |

Returns: `{Set = function(self, bool)}`

### `Section:AddSlider(options)`

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Name` | string | `"Slider"` | Display name |
| `Min` | number | `0` | Minimum value |
| `Max` | number | `100` | Maximum value |
| `Default` | number | `Min` | Initial value |
| `Increment` | number | `1` | Step size |
| `Flag` | string? | nil | Config save key |
| `Callback` | function | nil | `function(number)` |

Returns: `{Set = function(self, number)}`

### `Section:AddButton(options)`

| Option | Type | Description |
|--------|------|-------------|
| `Name` | string | Button text |
| `Callback` | function | `function()` on click |

### `Section:AddDropdown(options)`

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Name` | string | `"Dropdown"` | Display name |
| `Options` | table | `{}` | List of string options |
| `Default` | string? | First option | Initial selection |
| `Flag` | string? | nil | Config save key |
| `Callback` | function | nil | `function(string)` |

Returns: `{Set = function(self, string), Refresh = function(self, newOptions)}`

### `Section:AddInput(options)`

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Name` | string | `"Input"` | Label text |
| `Placeholder` | string | `"Type..."` | Placeholder text |
| `Default` | string | `""` | Initial value |
| `Numeric` | bool | `false` | Numbers only |
| `MaxCharacters` | number? | nil | Character limit |
| `EnterOnly` | bool | `false` | Callback only on Enter |
| `Flag` | string? | nil | Config save key |
| `Callback` | function | nil | `function(string)` |

Returns: `{Set = function(self, string)}`

### `Section:AddKeybind(options)`

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Name` | string | `"Keybind"` | Display name |
| `Default` | Enum.KeyCode | `F` | Initial key |
| `Flag` | string? | nil | Config save key |
| `Callback` | function | nil | Called when key is pressed |
| `OnChanged` | function | nil | Called when key is rebound |

Returns: `{Set = function(self, Enum.KeyCode)}`

### `Section:AddColorPicker(options)`

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Name` | string | `"Color"` | Display name |
| `Default` | Color3 | White | Initial color |
| `Flag` | string? | nil | Config save key |
| `Callback` | function | nil | `function(Color3)` |

### `Section:AddLabel(text_or_options)`

```lua
Section:AddLabel("Simple text")
Section:AddLabel({Text = "Info label", Style = 2})  -- 1=default, 2=info(accent), 3=warning(orange)
```

Returns: `{Set = function(self, string)}`

### `Section:AddParagraph(options)`

| Option | Type | Description |
|--------|------|-------------|
| `Title` | string | Bold header |
| `Text` | string | Body text (supports RichText) |

### `Section:AddDivider()`

Adds a thin horizontal line within the section.

---

## Flags System

Any component with a `Flag` option stores its value in `SolarynUI._flags[flag]`. This enables:
- **Config saving** — All flagged values are saved/loaded automatically
- **Cross-reference** — Access any value via `SolarynUI._flags.MyFlag`

```lua
Section:AddToggle({Name = "Auto Farm", Flag = "AutoFarm", Default = false})
-- Later...
print(SolarynUI._flags.AutoFarm) -- true/false
```
