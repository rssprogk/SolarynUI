-- ═══════════════════════════════════════════════════════════════════════════
--  SolarynUI — Premium Acrylic GUI Library v1.1.0
--  Mobile-Optimized | Key System | Config System | Multi-Theme
-- ═══════════════════════════════════════════════════════════════════════════

local SolarynUI = {_version="1.1.0",_flags={},_configs={},_notifs={}}
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local Http=game:GetService("HttpService")
local RS=game:GetService("RunService")
local core=game:GetService("CoreGui")
local LP=Players.LocalPlayer
local mob=UIS.TouchEnabled and not UIS.KeyboardEnabled

local Themes={
    Midnight={bg=Color3.fromRGB(12,14,28),card=Color3.fromRGB(20,26,48),card2=Color3.fromRGB(30,38,65),accent=Color3.fromRGB(85,170,255),accent2=Color3.fromRGB(150,110,255),glow=Color3.fromRGB(60,130,255),white=Color3.fromRGB(240,242,250),dim=Color3.fromRGB(120,130,160),red=Color3.fromRGB(255,80,80),green=Color3.fromRGB(50,220,120),btnC=Color3.fromRGB(35,45,80),btnH=Color3.fromRGB(55,70,120),slTrack=Color3.fromRGB(40,50,85),slFill=Color3.fromRGB(85,170,255),togOff=Color3.fromRGB(55,60,90)},
    Ocean={bg=Color3.fromRGB(10,18,30),card=Color3.fromRGB(16,30,52),card2=Color3.fromRGB(24,42,68),accent=Color3.fromRGB(0,200,200),accent2=Color3.fromRGB(0,150,255),glow=Color3.fromRGB(0,160,200),white=Color3.fromRGB(230,245,250),dim=Color3.fromRGB(100,140,160),red=Color3.fromRGB(255,90,90),green=Color3.fromRGB(0,230,140),btnC=Color3.fromRGB(20,42,70),btnH=Color3.fromRGB(30,60,95),slTrack=Color3.fromRGB(20,44,72),slFill=Color3.fromRGB(0,200,200),togOff=Color3.fromRGB(40,55,80)},
    Violet={bg=Color3.fromRGB(18,12,28),card=Color3.fromRGB(28,20,48),card2=Color3.fromRGB(42,30,68),accent=Color3.fromRGB(180,100,255),accent2=Color3.fromRGB(255,80,200),glow=Color3.fromRGB(150,60,255),white=Color3.fromRGB(245,240,255),dim=Color3.fromRGB(140,120,170),red=Color3.fromRGB(255,80,100),green=Color3.fromRGB(100,230,150),btnC=Color3.fromRGB(45,30,75),btnH=Color3.fromRGB(65,45,100),slTrack=Color3.fromRGB(48,32,78),slFill=Color3.fromRGB(180,100,255),togOff=Color3.fromRGB(60,45,85)},
    Rose={bg=Color3.fromRGB(24,12,18),card=Color3.fromRGB(38,20,30),card2=Color3.fromRGB(55,30,42),accent=Color3.fromRGB(255,100,140),accent2=Color3.fromRGB(255,160,100),glow=Color3.fromRGB(255,70,120),white=Color3.fromRGB(255,240,245),dim=Color3.fromRGB(170,120,140),red=Color3.fromRGB(255,70,70),green=Color3.fromRGB(80,230,140),btnC=Color3.fromRGB(65,30,45),btnH=Color3.fromRGB(90,45,60),slTrack=Color3.fromRGB(68,32,48),slFill=Color3.fromRGB(255,100,140),togOff=Color3.fromRGB(75,45,60)},
}
local T=Themes.Midnight

local function mk(c,p) local i=Instance.new(c) for k,v in pairs(p or{}) do pcall(function() i[k]=v end) end return i end
local function rnd(o,r) mk("UICorner",{CornerRadius=UDim.new(0,r or 8),Parent=o}) end
local function tw(o,p,d) TS:Create(o,TweenInfo.new(d or 0.3,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),p):Play() end
local function pad(o,t,b,l,r) mk("UIPadding",{PaddingTop=UDim.new(0,t),PaddingBottom=UDim.new(0,b),PaddingLeft=UDim.new(0,l),PaddingRight=UDim.new(0,r),Parent=o}) end

local notifGui
function SolarynUI:Notify(opts)
    if not notifGui then
        notifGui=mk("ScreenGui",{Name="SolarynNotifs",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=core})
    end
    local title=opts.Title or "Notification"
    local content=opts.Content or ""
    local dur=opts.Duration or 5
    local nf=mk("Frame",{Parent=notifGui,BackgroundColor3=T.card,Size=UDim2.new(0,300,0,0),AutomaticSize=Enum.AutomaticSize.Y,Position=UDim2.new(1,320,1,-10),AnchorPoint=Vector2.new(1,1),BorderSizePixel=0})
    rnd(nf,12)
    mk("UIStroke",{Color=T.accent,Thickness=1,Transparency=0.5,Parent=nf})
    pad(nf,12,12,14,14)
    mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=nf})
    mk("TextLabel",{Parent=nf,Text=title,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=T.accent,BackgroundTransparency=1,Size=UDim2.new(1,0,0,18),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1})
    if content~="" then mk("TextLabel",{Parent=nf,Text=content,Font=Enum.Font.Gotham,TextSize=11,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,LayoutOrder=2}) end
    -- slide in
    tw(nf,{Position=UDim2.new(1,-20,1,-10)},0.4)
    task.delay(dur,function()
        tw(nf,{Position=UDim2.new(1,320,1,-10)},0.3)
        task.wait(0.35)
        nf:Destroy()
    end)
end

local configFolder="SolarynUI"
function SolarynUI:SetConfigFolder(root,folder)
    if root then configFolder=root.."/"..folder else configFolder=folder or"SolarynUI" end
end
function SolarynUI:SaveConfig(name)
    local data={}
    for flag,val in pairs(self._flags) do
        if typeof(val)=="Color3" then data[flag]={R=val.R,G=val.G,B=val.B,_t="c3"}
        elseif typeof(val)=="EnumItem" then data[flag]={_t="enum",v=tostring(val)}
        elseif type(val)=="table" then data[flag]={_t="tbl",v=val}
        else data[flag]=val end
    end
    pcall(function()
        if not isfolder(configFolder) then makefolder(configFolder) end
        writefile(configFolder.."/"..name..".json",Http:JSONEncode(data))
    end)
    self:Notify({Title="Config Saved",Content="Saved as "..name,Duration=3})
end
function SolarynUI:LoadConfig(name)
    local ok,raw=pcall(function() return readfile(configFolder.."/"..name..".json") end)
    if not ok then self:Notify({Title="Error",Content="Config not found",Duration=3}) return end
    local data=Http:JSONDecode(raw)
    for flag,val in pairs(data) do
        if type(val)=="table" and val._t=="c3" then self._flags[flag]=Color3.new(val.R,val.G,val.B)
        elseif type(val)=="table" and val._t=="tbl" then self._flags[flag]=val.v
        else self._flags[flag]=val end
    end
    self:Notify({Title="Config Loaded",Content="Loaded "..name,Duration=3})
end
function SolarynUI:ListConfigs()
    local list={}
    pcall(function() for _,f in ipairs(listfiles(configFolder)) do
        if f:match("%.json$") then table.insert(list,f:match("([^/\\]+)%.json$")) end
    end end)
    return list
end

local function runKeySystem(opts)
    if not opts or not opts.Key then return true end
    -- check saved key
    local keyFile=configFolder.."/key.txt"
    if opts.SaveKey then
        local ok,saved=pcall(function() return readfile(keyFile) end)
        if ok then for _,k in ipairs(opts.Key) do if saved==k then return true end end end
    end
    local passed=false
    local ks=mk("ScreenGui",{Name="SolarynKey",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=core})
    local bg=mk("Frame",{Parent=ks,Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.3})
    local box=mk("Frame",{Parent=ks,Size=UDim2.new(0,380,0,0),AutomaticSize=Enum.AutomaticSize.Y,Position=UDim2.new(0.5,0,0.5,0),AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=T.bg,BorderSizePixel=0})
    rnd(box,16)
    mk("UIStroke",{Color=T.accent,Thickness=1,Transparency=0.4,Parent=box})
    pad(box,24,24,24,24)
    mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,10),Parent=box,HorizontalAlignment=Enum.HorizontalAlignment.Center})
    -- acrylic
    mk("ImageLabel",{Parent=box,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Image="rbxassetid://8992230677",ImageTransparency=0.93,ImageColor3=Color3.fromRGB(200,210,255),ScaleType=Enum.ScaleType.Tile,TileSize=UDim2.new(0,128,0,128),ZIndex=0})
    mk("TextLabel",{Parent=box,Text=opts.Title or"Key System",Font=Enum.Font.GothamBlack,TextSize=20,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,24),LayoutOrder=1})
    mk("TextLabel",{Parent=box,Text=opts.Subtitle or"Enter your key",Font=Enum.Font.Gotham,TextSize=12,TextColor3=T.dim,BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),LayoutOrder=2})
    if opts.Note then mk("TextLabel",{Parent=box,Text=opts.Note,Font=Enum.Font.Gotham,TextSize=11,TextColor3=T.dim,BackgroundTransparency=1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,TextWrapped=true,LayoutOrder=3}) end
    local inp=mk("TextBox",{Parent=box,PlaceholderText="Enter key here...",Text="",Font=Enum.Font.Gotham,TextSize=13,TextColor3=T.white,PlaceholderColor3=T.dim,BackgroundColor3=T.card,Size=UDim2.new(1,0,0,38),BorderSizePixel=0,ClearTextOnFocus=false,LayoutOrder=4})
    rnd(inp,10) pad(inp,0,0,12,12)
    mk("UIStroke",{Color=T.accent,Thickness=1,Transparency=0.6,Parent=inp})
    local statusLbl=mk("TextLabel",{Parent=box,Text="",Font=Enum.Font.GothamBold,TextSize=11,TextColor3=T.red,BackgroundTransparency=1,Size=UDim2.new(1,0,0,14),LayoutOrder=5})
    local submit=mk("TextButton",{Parent=box,Text="Submit Key",Font=Enum.Font.GothamBold,TextSize=13,TextColor3=T.white,BackgroundColor3=T.accent,Size=UDim2.new(1,0,0,36),BorderSizePixel=0,LayoutOrder=6})
    rnd(submit,10)
    submit.MouseEnter:Connect(function() tw(submit,{BackgroundColor3=T.accent2},0.15) end)
    submit.MouseLeave:Connect(function() tw(submit,{BackgroundColor3=T.accent},0.15) end)
    -- link/discord button
    if opts.SecondAction and opts.SecondAction.Enabled then
        local linkBtn=mk("TextButton",{Parent=box,Text=opts.SecondAction.Type=="Discord" and "Join Discord" or "Get Key",Font=Enum.Font.GothamBold,TextSize=12,TextColor3=T.accent,BackgroundColor3=T.card,Size=UDim2.new(1,0,0,32),BorderSizePixel=0,LayoutOrder=7})
        rnd(linkBtn,10) mk("UIStroke",{Color=T.accent,Thickness=1,Transparency=0.5,Parent=linkBtn})
        linkBtn.MouseButton1Click:Connect(function()
            local url=opts.SecondAction.Type=="Discord" and("https://discord.gg/"..opts.SecondAction.Parameter) or opts.SecondAction.Parameter
            pcall(function() setclipboard(url) end)
            statusLbl.Text="Link copied to clipboard!"
            statusLbl.TextColor3=T.green
        end)
    end
    submit.MouseButton1Click:Connect(function()
        local txt=inp.Text
        for _,k in ipairs(opts.Key) do
            if txt==k then
                passed=true
                if opts.SaveKey then pcall(function()
                    if not isfolder(configFolder) then makefolder(configFolder) end
                    writefile(keyFile,txt)
                end) end
                statusLbl.Text="✓ Key accepted!"
                statusLbl.TextColor3=T.green
                task.wait(0.8)
                ks:Destroy()
                return
            end
        end
        statusLbl.Text="✗ Invalid key"
        statusLbl.TextColor3=T.red
        tw(inp,{Position=UDim2.new(0,5,0,0)},0.05)
        task.wait(0.05)
        tw(inp,{Position=UDim2.new(0,-5,0,0)},0.05)
        task.wait(0.05)
        tw(inp,{Position=UDim2.new(0,0,0,0)},0.05)
    end)
    while not passed and ks.Parent do task.wait(0.1) end
    return passed
end

function SolarynUI:SetTheme(name)
    if Themes[name] then T=Themes[name] end
end

function SolarynUI:CreateWindow(opts)
    opts=opts or{}
    if opts.Theme and Themes[opts.Theme] then T=Themes[opts.Theme] end
    if opts.ConfigSettings then self:SetConfigFolder(opts.ConfigSettings.RootFolder,opts.ConfigSettings.ConfigFolder) end

    -- Key system gate
    if opts.KeySystem then
        local ok=runKeySystem(opts.KeySettings)
        if not ok then LP:Kick("Invalid key.") return end
    end

    pcall(function() if core:FindFirstChild("SolarynUI") then core.SolarynUI:Destroy() end end)
    local W=opts.Size and opts.Size[1] or(mob and 280 or 480)
    local H=opts.Size and opts.Size[2] or(mob and 380 or 540)
    local fs=mob and 9 or 11

    local gui=mk("ScreenGui",{Name="SolarynUI",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=core})
    local main=mk("Frame",{Name="M",Parent=gui,Size=UDim2.new(0,W,0,H),Position=UDim2.new(0.5,-W/2,0.5,-H/2),BackgroundColor3=T.bg,BackgroundTransparency=0.08,BorderSizePixel=0})
    rnd(main,16)
    -- acrylic noise
    mk("ImageLabel",{Parent=main,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Image="rbxassetid://8992230677",ImageTransparency=0.93,ImageColor3=Color3.fromRGB(200,210,255),ScaleType=Enum.ScaleType.Tile,TileSize=UDim2.new(0,128,0,128),ZIndex=0})
    -- outer glow
    mk("ImageLabel",{Parent=main,Size=UDim2.new(1,60,1,60),Position=UDim2.new(0,-30,0,-30),BackgroundTransparency=1,Image="rbxassetid://6015897843",ImageColor3=T.glow,ImageTransparency=0.82,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=0})
    -- top accent line
    local topLine=mk("Frame",{Parent=main,Size=UDim2.new(0.7,0,0,2),Position=UDim2.new(0.15,0,0,0),BackgroundColor3=T.accent,BorderSizePixel=0})
    mk("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T.accent2),ColorSequenceKeypoint.new(0.5,T.accent),ColorSequenceKeypoint.new(1,T.accent2)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.8),NumberSequenceKeypoint.new(0.5,0),NumberSequenceKeypoint.new(1,0.8)}),Parent=topLine})

    -- Title bar
    local topBar=mk("Frame",{Parent=main,Size=UDim2.new(1,0,0,54),BackgroundTransparency=1,BorderSizePixel=0})
    mk("ImageLabel",{Parent=topBar,Size=UDim2.new(0,28,0,28),Position=UDim2.new(0,14,0,12),BackgroundTransparency=1,Image=opts.LogoID and("rbxassetid://"..opts.LogoID) or "rbxassetid://6031280882",ImageColor3=T.accent})
    local titleTxt=opts.Name or opts.Title or"SolarynUI"
    mk("TextLabel",{Parent=topBar,Text=titleTxt,Font=Enum.Font.GothamBlack,TextSize=mob and 15 or 17,TextColor3=T.white,BackgroundTransparency=1,Position=UDim2.new(0,48,0,10),Size=UDim2.new(0,200,0,20),TextXAlignment=Enum.TextXAlignment.Left})
    mk("TextLabel",{Parent=topBar,Text=opts.Subtitle or"v1.0",Font=Enum.Font.Gotham,TextSize=9,TextColor3=T.dim,BackgroundTransparency=1,Position=UDim2.new(0,48,0,32),Size=UDim2.new(0,200,0,14),TextXAlignment=Enum.TextXAlignment.Left})
    -- session timer
    local sesLbl=mk("TextLabel",{Parent=topBar,Text="⏱ 0:00",Font=Enum.Font.GothamBold,TextSize=11,TextColor3=T.accent,BackgroundTransparency=1,Position=UDim2.new(1,mob and-100 or-110,0,16),Size=UDim2.new(0,65,0,18),TextXAlignment=Enum.TextXAlignment.Right})
    local t0=tick()
    task.spawn(function() while task.wait(1) do local el=tick()-t0;sesLbl.Text="⏱ "..string.format("%d:%02d",math.floor(el/60),math.floor(el%60)) end end)
    -- minimize / close
    local minBtn=mk("TextButton",{Parent=topBar,Text="—",Font=Enum.Font.GothamBold,TextSize=14,TextColor3=T.dim,BackgroundColor3=T.card2,Size=UDim2.new(0,28,0,28),Position=UDim2.new(1,-72,0,13)})
    rnd(minBtn,8)
    local xBtn=mk("TextButton",{Parent=topBar,Text="✕",Font=Enum.Font.GothamBold,TextSize=14,TextColor3=T.red,BackgroundColor3=Color3.fromRGB(55,22,28),Size=UDim2.new(0,28,0,28),Position=UDim2.new(1,-40,0,13)})
    rnd(xBtn,8)
    mk("Frame",{Parent=main,Size=UDim2.new(1,-28,0,1),Position=UDim2.new(0,14,0,53),BackgroundColor3=T.card2,BorderSizePixel=0,BackgroundTransparency=0.2})

    -- Drag
    local dg,ds,sp
    topBar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=true;ds=i.Position;sp=main.Position end end)
    topBar.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end end)
    UIS.InputChanged:Connect(function(i) if dg and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local d=i.Position-ds;main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end)

    -- Tab bar
    local tabDefs,tBtns,tPages={},{},{}
    local tBar=mk("Frame",{Parent=main,BackgroundColor3=T.card,BackgroundTransparency=0.2,Size=UDim2.new(1,-16,0,34),Position=UDim2.new(0,8,0,58),BorderSizePixel=0})
    rnd(tBar,10)
    local tabLine=mk("Frame",{Parent=tBar,Size=UDim2.new(0,40,0,3),Position=UDim2.new(0,6,1,-4),BackgroundColor3=T.accent,BorderSizePixel=0})
    rnd(tabLine,2)
    mk("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T.accent),ColorSequenceKeypoint.new(1,T.accent2)}),Parent=tabLine})
    local contentF=mk("Frame",{Parent=main,BackgroundTransparency=1,Size=UDim2.new(1,-12,1,-100),Position=UDim2.new(0,6,0,96),ClipsDescendants=true})

    local minimized=false
    local fullH=H
    minBtn.MouseButton1Click:Connect(function()
        minimized=not minimized
        if minimized then tw(main,{Size=UDim2.new(0,W,0,58)},0.3);contentF.Visible=false;tBar.Visible=false;minBtn.Text="+"
        else tw(main,{Size=UDim2.new(0,W,0,fullH)},0.3);task.wait(0.15);contentF.Visible=true;tBar.Visible=true;minBtn.Text="—" end
    end)

    local function setTab(n)
        local tw2=math.floor((W-24)/#tabDefs)
        for i,b in ipairs(tBtns) do tw(b,{TextColor3=i==n and T.white or T.dim},0.2);tPages[i].Visible=i==n end
        tw(tabLine,{Position=UDim2.new(0,(n-1)*tw2+6,1,-4),Size=UDim2.new(0,tw2-12,0,3)},0.3)
    end

    -- Fade / reopen
    local guiOn=true
    local reopen=mk("TextButton",{Parent=gui,Text="⚽",Font=Enum.Font.GothamBold,TextSize=22,TextColor3=T.white,BackgroundColor3=T.card,BackgroundTransparency=0.05,Size=UDim2.new(0,46,0,46),Position=UDim2.new(0,10,0.5,-23),Visible=false,ZIndex=10})
    rnd(reopen,23) mk("UIStroke",{Color=T.accent,Thickness=1.5,Transparency=0.4,Parent=reopen})
    task.spawn(function() while true do task.wait(1.2);if reopen.Visible then tw(reopen,{Size=UDim2.new(0,50,0,50),Position=UDim2.new(0,8,0.5,-25)},0.5);task.wait(0.5);tw(reopen,{Size=UDim2.new(0,46,0,46),Position=UDim2.new(0,10,0.5,-23)},0.5) end end end)

    local function fadeGui(show)
        guiOn=show
        if show then main.Visible=true;reopen.Visible=false;tw(main,{BackgroundTransparency=0.08},0.4)
            for _,d in ipairs(main:GetDescendants()) do pcall(function()
                if d:IsA("TextLabel") or d:IsA("TextButton") then tw(d,{TextTransparency=0},0.35) end
                if d:IsA("TextBox") then tw(d,{TextTransparency=0},0.35) end
                if d:IsA("Frame") then tw(d,{BackgroundTransparency=d:GetAttribute("origTrans") or 0},0.35) end
                if d:IsA("ImageLabel") then tw(d,{ImageTransparency=d:GetAttribute("origImg") or 0},0.35) end
                if d:IsA("ScrollingFrame") then tw(d,{ScrollBarImageTransparency=0},0.35) end
                if d:IsA("UIStroke") then tw(d,{Transparency=d:GetAttribute("origStroke") or 0.4},0.35) end
            end) end
        else tw(main,{BackgroundTransparency=1},0.35)
            for _,d in ipairs(main:GetDescendants()) do pcall(function()
                if d:IsA("Frame") and not d:GetAttribute("origTrans") then d:SetAttribute("origTrans",d.BackgroundTransparency) end
                if d:IsA("ImageLabel") and not d:GetAttribute("origImg") then d:SetAttribute("origImg",d.ImageTransparency) end
                if d:IsA("UIStroke") and not d:GetAttribute("origStroke") then d:SetAttribute("origStroke",d.Transparency) end
                if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then tw(d,{TextTransparency=1,BackgroundTransparency=1},0.3)
                elseif d:IsA("Frame") then tw(d,{BackgroundTransparency=1},0.3)
                elseif d:IsA("ImageLabel") then tw(d,{ImageTransparency=1},0.3)
                elseif d:IsA("ScrollingFrame") then tw(d,{ScrollBarImageTransparency=1},0.3)
                elseif d:IsA("UIStroke") then tw(d,{Transparency=1},0.3) end
            end) end
            task.wait(0.35);main.Visible=false;reopen.Visible=true
        end
    end
    xBtn.MouseButton1Click:Connect(function() fadeGui(false) end)
    reopen.MouseButton1Click:Connect(function() fadeGui(true) end)

    -- Keybind to toggle GUI
    local toggleKey=opts.ToggleKey or Enum.KeyCode.RightControl
    UIS.InputBegan:Connect(function(inp) if inp.KeyCode==toggleKey then fadeGui(not guiOn) end end)

    -- ═══════════ WINDOW OBJECT ═══════════
    local Window={_gui=gui,_main=main,_tabs=tabDefs,_tBtns=tBtns,_tPages=tPages,_tBar=tBar,_tabLine=tabLine,_contentF=contentF,_setTab=setTab,_fs=fs,_W=W}

    function Window:Minimize() minBtn.MouseButton1Click:Fire() end
    function Window:Destroy() gui:Destroy() end

    -- ═══════════ HOME TAB (Luna-Style) ═══════════
    function Window:CreateHomeTab(hOpts)
        hOpts=hOpts or{}
        local idx=#tabDefs+1
        table.insert(tabDefs,"Home")
        local tw2=math.floor((W-24)/#tabDefs)
        for _,b in ipairs(tBtns) do b:Destroy() end
        tBtns={}
        for i,name in ipairs(tabDefs) do
            local tb=mk("TextButton",{Parent=tBar,Text=name,Font=Enum.Font.GothamBold,TextSize=mob and 9 or 11,TextColor3=i==1 and T.white or T.dim,BackgroundTransparency=1,Size=UDim2.new(0,tw2,1,0),Position=UDim2.new(0,(i-1)*tw2,0,0),BorderSizePixel=0})
            tBtns[i]=tb
            tb.MouseButton1Click:Connect(function() setTab(i) end)
        end
        Window._tBtns=tBtns
        local pg=mk("ScrollingFrame",{Parent=contentF,Visible=idx==1,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ScrollBarThickness=3,ScrollBarImageColor3=T.accent,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,BorderSizePixel=0})
        mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=pg})
        pad(pg,4,8,2,2)
        tPages[idx]=pg

        -- ═══ AVATAR + WELCOME CARD ═══
        local avCard=mk("Frame",{Parent=pg,BackgroundColor3=T.card,BackgroundTransparency=0.05,Size=UDim2.new(1,0,0,mob and 60 or 70),BorderSizePixel=0,LayoutOrder=1})
        rnd(avCard,12)
        mk("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T.card2),ColorSequenceKeypoint.new(1,T.card)}),Parent=avCard})
        local avSize=mob and 42 or 52
        local avImg=mk("ImageLabel",{Parent=avCard,Size=UDim2.new(0,avSize,0,avSize),Position=UDim2.new(0,12,0.5,-avSize/2),BackgroundColor3=T.card2,BorderSizePixel=0,Image="https://www.roblox.com/headshot-thumbnail/image?userId="..LP.UserId.."&width=150&height=150"})
        rnd(avImg,avSize/2)
        mk("TextLabel",{Parent=avCard,Text="Hello, "..LP.DisplayName,Font=Enum.Font.GothamBold,TextSize=mob and 13 or 15,TextColor3=T.white,BackgroundTransparency=1,Position=UDim2.new(0,avSize+22,0,mob and 10 or 14),Size=UDim2.new(1,-avSize-30,0,20),TextXAlignment=Enum.TextXAlignment.Left})
        local windowName=opts.Name or opts.Title or"SolarynUI"
        mk("TextLabel",{Parent=avCard,Text=LP.Name.." · "..windowName,Font=Enum.Font.Gotham,TextSize=mob and 10 or 11,TextColor3=T.dim,BackgroundTransparency=1,Position=UDim2.new(0,avSize+22,0,mob and 30 or 36),Size=UDim2.new(1,-avSize-30,0,16),TextXAlignment=Enum.TextXAlignment.Left})

        -- ═══ SERVER INFO GRID ═══
        local svCard=mk("Frame",{Parent=pg,BackgroundColor3=T.card,BackgroundTransparency=0.1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BorderSizePixel=0,LayoutOrder=2})
        rnd(svCard,12) pad(svCard,10,10,10,10)
        mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=svCard})
        mk("TextLabel",{Parent=svCard,Text="Server",Font=Enum.Font.GothamBold,TextSize=mob and 12 or 14,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,18),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=0})
        mk("TextLabel",{Parent=svCard,Text="Information on the session you're currently in",Font=Enum.Font.Gotham,TextSize=mob and 9 or 10,TextColor3=T.dim,BackgroundTransparency=1,Size=UDim2.new(1,0,0,14),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1})

        -- Helper: mini info card
        local function miniCard(parent,label,value,order)
            local mc=mk("Frame",{Parent=parent,BackgroundColor3=T.card2,Size=UDim2.new(0.48,0,0,mob and 32 or 38),BorderSizePixel=0,LayoutOrder=order})
            rnd(mc,8) pad(mc,6,6,10,10)
            mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,1),Parent=mc})
            mk("TextLabel",{Parent=mc,Text=label,Font=Enum.Font.GothamBold,TextSize=mob and 9 or 10,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,12),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1})
            local vLbl=mk("TextLabel",{Parent=mc,Text=value,Font=Enum.Font.Gotham,TextSize=mob and 8 or 9,TextColor3=T.dim,BackgroundTransparency=1,Size=UDim2.new(1,0,0,12),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=2})
            return vLbl
        end

        local gridRow1=mk("Frame",{Parent=svCard,BackgroundTransparency=1,Size=UDim2.new(1,0,0,mob and 32 or 38),LayoutOrder=2})
        mk("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,6),Parent=gridRow1})
        miniCard(gridRow1,"Players",tostring(#Players:GetPlayers()).." playing",1)
        miniCard(gridRow1,"Maximum Players",tostring(Players.MaxPlayers).." can join",2)

        local gridRow2=mk("Frame",{Parent=svCard,BackgroundTransparency=1,Size=UDim2.new(1,0,0,mob and 32 or 38),LayoutOrder=3})
        mk("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,6),Parent=gridRow2})
        local ping="N/A"
        pcall(function() ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()).."ms" end)
        miniCard(gridRow2,"Latency",ping,1)
        local region="VN"
        pcall(function() region=string.split(game.JobId,"-")[1] end)
        miniCard(gridRow2,"Server Region",region,2)

        local gridRow3=mk("Frame",{Parent=svCard,BackgroundTransparency=1,Size=UDim2.new(1,0,0,mob and 32 or 38),LayoutOrder=4})
        mk("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,6),Parent=gridRow3})
        local inForLbl=miniCard(gridRow3,"In Server For","00:00:00",1)
        local joinBtn=miniCard(gridRow3,"Join Script","Tap to copy",2)
        -- Update in-server timer
        local svT0=tick()
        task.spawn(function() while task.wait(1) do local e=tick()-svT0;inForLbl.Text=string.format("%02d:%02d:%02d",math.floor(e/3600),math.floor(e/60)%60,math.floor(e)%60) end end)
        -- Make join script copyable
        local joinHit=mk("TextButton",{Parent=gridRow3,Text="",BackgroundTransparency=1,Size=UDim2.new(0.48,0,1,0),Position=UDim2.new(0.52,0,0,0)})
        joinHit.MouseButton1Click:Connect(function()
            local js='game:GetService("TeleportService"):TeleportToPlaceInstance('..game.PlaceId..', "'..game.JobId..'")'
            pcall(function() setclipboard(js) end)
            SolarynUI:Notify({Title="Copied",Content="Join script copied!",Duration=3})
        end)

        -- ═══ EXECUTOR SUPPORT CARD ═══
        local exName="Unknown"
        pcall(function() if identifyexecutor then exName=identifyexecutor() elseif getexecutorname then exName=getexecutorname() end end)
        local supported=false
        if hOpts.SupportedExecutors then for _,e in ipairs(hOpts.SupportedExecutors) do if exName:lower():find(e:lower()) then supported=true break end end end
        local exCard=mk("Frame",{Parent=pg,BackgroundColor3=supported and Color3.fromRGB(20,50,30) or Color3.fromRGB(60,35,15),Size=UDim2.new(1,0,0,mob and 50 or 58),BorderSizePixel=0,LayoutOrder=3})
        rnd(exCard,12) pad(exCard,10,10,14,14)
        mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,3),Parent=exCard})
        mk("TextLabel",{Parent=exCard,Text=exName,Font=Enum.Font.GothamBold,TextSize=mob and 13 or 15,TextColor3=supported and T.green or Color3.fromRGB(255,180,60),BackgroundTransparency=1,Size=UDim2.new(1,0,0,20),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1})
        mk("TextLabel",{Parent=exCard,Text=supported and "Your Executor Is Officially Supported!" or "Your Executor Isn't Officially Supported.",Font=Enum.Font.Gotham,TextSize=mob and 9 or 11,TextColor3=supported and T.green or Color3.fromRGB(255,180,60),BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=2})

        -- ═══ FRIENDS SECTION ═══
        local frCard=mk("Frame",{Parent=pg,BackgroundColor3=T.card,BackgroundTransparency=0.1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BorderSizePixel=0,LayoutOrder=4})
        rnd(frCard,12) pad(frCard,10,10,10,10)
        mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=frCard})
        mk("TextLabel",{Parent=frCard,Text="Friends",Font=Enum.Font.GothamBold,TextSize=mob and 12 or 14,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=0})
        mk("TextLabel",{Parent=frCard,Text="Find out what your friends are doing",Font=Enum.Font.Gotham,TextSize=mob and 9 or 10,TextColor3=T.dim,BackgroundTransparency=1,Size=UDim2.new(1,0,0,12),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1})
        -- Friends counts
        local inSv,online,offline,total=0,0,0,0
        pcall(function()
            local fp=LP:GetFriendsOnline(200)
            for _,f in ipairs(fp) do
                total=total+1
                if f.PlaceId==game.PlaceId and f.GameId==game.JobId then inSv=inSv+1 end
                if f.IsOnline then online=online+1 else offline=offline+1 end
            end
        end)
        local frGrid=mk("Frame",{Parent=frCard,BackgroundTransparency=1,Size=UDim2.new(1,0,0,mob and 32 or 38),LayoutOrder=2})
        mk("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,4),Parent=frGrid})
        local function frMini(label,val,col,order)
            local fc=mk("Frame",{Parent=frGrid,BackgroundColor3=T.card2,Size=UDim2.new(0.24,-3,1,0),BorderSizePixel=0,LayoutOrder=order})
            rnd(fc,6) pad(fc,4,4,6,6)
            mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,1),Parent=fc})
            mk("TextLabel",{Parent=fc,Text=label,Font=Enum.Font.GothamBold,TextSize=mob and 8 or 9,TextColor3=col or T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,10),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1})
            mk("TextLabel",{Parent=fc,Text=val.." friends",Font=Enum.Font.Gotham,TextSize=mob and 7 or 8,TextColor3=T.dim,BackgroundTransparency=1,Size=UDim2.new(1,0,0,10),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=2})
        end
        frMini("In Server",tostring(inSv),T.green,1)
        frMini("Online",tostring(online),T.green,2)
        frMini("Offline",tostring(offline),T.red,3)
        frMini("All",tostring(total),T.white,4)

        -- ═══ DISCORD CARD ═══
        if hOpts.DiscordInvite then
            local dcCard=mk("TextButton",{Parent=pg,Text="",BackgroundColor3=Color3.fromRGB(88,101,242),Size=UDim2.new(1,0,0,mob and 48 or 56),BorderSizePixel=0,LayoutOrder=5})
            rnd(dcCard,12)
            mk("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(88,101,242)),ColorSequenceKeypoint.new(1,Color3.fromRGB(70,80,200))}),Parent=dcCard})
            mk("TextLabel",{Parent=dcCard,Text="Discord",Font=Enum.Font.GothamBold,TextSize=mob and 14 or 16,TextColor3=T.white,BackgroundTransparency=1,Position=UDim2.new(0,14,0,mob and 8 or 10),Size=UDim2.new(1,-20,0,20),TextXAlignment=Enum.TextXAlignment.Left})
            mk("TextLabel",{Parent=dcCard,Text="Tap to join the Discord Server",Font=Enum.Font.Gotham,TextSize=mob and 10 or 11,TextColor3=Color3.fromRGB(200,210,255),BackgroundTransparency=1,Position=UDim2.new(0,14,0,mob and 28 or 32),Size=UDim2.new(1,-20,0,16),TextXAlignment=Enum.TextXAlignment.Left})
            dcCard.MouseButton1Click:Connect(function()
                pcall(function() setclipboard("https://discord.gg/"..hOpts.DiscordInvite) end)
                SolarynUI:Notify({Title="Discord",Content="Invite link copied to clipboard!",Duration=3})
            end)
        end

        setTab(1)
        return pg
    end

    -- ═══════════ CREATE TAB ═══════════
    function Window:CreateTab(tOpts)
        tOpts=tOpts or{}
        local idx=#tabDefs+1
        table.insert(tabDefs,tOpts.Name or("Tab "..idx))
        local tw2=math.floor((W-24)/#tabDefs)
        for _,b in ipairs(tBtns) do b:Destroy() end
        tBtns={}
        for i,name in ipairs(tabDefs) do
            local tb=mk("TextButton",{Parent=tBar,Text=name,Font=Enum.Font.GothamBold,TextSize=mob and 10 or 11,TextColor3=i==1 and T.white or T.dim,BackgroundTransparency=1,Size=UDim2.new(0,tw2,1,0),Position=UDim2.new(0,(i-1)*tw2,0,0),BorderSizePixel=0})
            tBtns[i]=tb
            tb.MouseButton1Click:Connect(function() setTab(i) end)
        end
        Window._tBtns=tBtns
        local pg=mk("ScrollingFrame",{Parent=contentF,Visible=false,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ScrollBarThickness=3,ScrollBarImageColor3=T.accent,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,BorderSizePixel=0})
        mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=pg})
        pad(pg,2,8,2,2)
        tPages[idx]=pg
        if #tabDefs==1 then setTab(1) end
        tabLine.Size=UDim2.new(0,tw2-12,0,3)

        -- ═══════════ TAB OBJECT ═══════════
        local Tab={_page=pg,_order=0}

        function Tab:CreateSection(title)
            Tab._order=Tab._order+1
            local f=mk("Frame",{Parent=pg,BackgroundColor3=T.card,BackgroundTransparency=0.1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BorderSizePixel=0,LayoutOrder=Tab._order})
            rnd(f,10) pad(f,10,10,12,12)
            mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=f})
            mk("TextLabel",{Parent=f,Text="  "..title,Font=Enum.Font.GothamBold,TextSize=fs+1,TextColor3=T.accent,BackgroundTransparency=1,Size=UDim2.new(1,0,0,18),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=0})
            -- Section object
            local Sec={_f=f,_o=0}

            function Sec:AddToggle(o)
                Sec._o=Sec._o+1
                local fr=mk("Frame",{Parent=f,BackgroundTransparency=1,Size=UDim2.new(1,0,0,24),LayoutOrder=Sec._o})
                local track=mk("Frame",{Parent=fr,BackgroundColor3=o.Default and T.accent or T.togOff,Size=UDim2.new(0,36,0,18),Position=UDim2.new(0,0,0,3)})
                rnd(track,9)
                mk("UIStroke",{Color=o.Default and T.accent or Color3.fromRGB(80,90,120),Thickness=1,Transparency=0.4,Parent=track})
                local knob=mk("Frame",{Parent=track,BackgroundColor3=T.white,Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,o.Default and 19 or 3,0.5,-7)})
                rnd(knob,7)
                mk("TextLabel",{Parent=fr,Text=o.Name or"Toggle",Font=Enum.Font.Gotham,TextSize=fs,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,-44,1,0),Position=UDim2.new(0,42,0,0),TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true})
                local on=o.Default or false
                if o.Flag then SolarynUI._flags[o.Flag]=on end
                local hit=mk("TextButton",{Parent=fr,Text="",BackgroundTransparency=1,Size=UDim2.new(1,0,1,0)})
                hit.MouseButton1Click:Connect(function()
                    on=not on
                    tw(track,{BackgroundColor3=on and T.accent or T.togOff},0.25)
                    tw(knob,{Position=UDim2.new(0,on and 19 or 3,0.5,-7)},0.25)
                    if o.Flag then SolarynUI._flags[o.Flag]=on end
                    if o.Callback then o.Callback(on) end
                end)
                return{Set=function(_,v)on=v;tw(track,{BackgroundColor3=on and T.accent or T.togOff},0.2);tw(knob,{Position=UDim2.new(0,on and 19 or 3,0.5,-7)},0.2);if o.Flag then SolarynUI._flags[o.Flag]=on end end}
            end

            function Sec:AddSlider(o)
                Sec._o=Sec._o+1
                local lo,hi=o.Min or 0,o.Max or 100
                local def=o.Default or lo
                local fr=mk("Frame",{Parent=f,BackgroundTransparency=1,Size=UDim2.new(1,0,0,38),LayoutOrder=Sec._o})
                local l=mk("TextLabel",{Parent=fr,Text=(o.Name or"Slider")..": "..def,Font=Enum.Font.GothamBold,TextSize=fs,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),TextXAlignment=Enum.TextXAlignment.Left})
                local t=mk("Frame",{Parent=fr,BackgroundColor3=T.slTrack,Size=UDim2.new(1,0,0,8),Position=UDim2.new(0,0,0,22)})
                rnd(t,4)
                local fl=mk("Frame",{Parent=t,BackgroundColor3=T.slFill,Size=UDim2.new((def-lo)/(hi-lo),0,1,0)})
                rnd(fl,4)
                mk("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T.accent2),ColorSequenceKeypoint.new(1,T.accent)}),Parent=fl})
                local kn=mk("Frame",{Parent=t,BackgroundColor3=T.white,Size=UDim2.new(0,16,0,16),Position=UDim2.new((def-lo)/(hi-lo),-8,0.5,-8),ZIndex=3})
                rnd(kn,8) mk("UIStroke",{Color=T.accent,Thickness=2,Transparency=0.3,Parent=kn})
                local sl=false
                local inc=o.Increment or 1
                if o.Flag then SolarynUI._flags[o.Flag]=def end
                local function upd(inp)
                    local r=math.clamp((inp.Position.X-t.AbsolutePosition.X)/t.AbsoluteSize.X,0,1)
                    local v=math.floor((lo+r*(hi-lo))/inc)*inc
                    v=math.clamp(v,lo,hi)
                    r=(v-lo)/(hi-lo)
                    fl.Size=UDim2.new(r,0,1,0);kn.Position=UDim2.new(r,-8,0.5,-8)
                    l.Text=(o.Name or"Slider")..": "..v
                    if o.Flag then SolarynUI._flags[o.Flag]=v end
                    if o.Callback then o.Callback(v) end
                end
                t.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sl=true;upd(i) end end)
                UIS.InputChanged:Connect(function(i) if sl and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then upd(i) end end)
                UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sl=false end end)
                return{Set=function(_,v) local r=(v-lo)/(hi-lo);fl.Size=UDim2.new(r,0,1,0);kn.Position=UDim2.new(r,-8,0.5,-8);l.Text=(o.Name or"Slider")..": "..v;if o.Flag then SolarynUI._flags[o.Flag]=v end end}
            end

            function Sec:AddButton(o)
                Sec._o=Sec._o+1
                local b=mk("TextButton",{Parent=f,Text="  "..(o.Name or"Button").."  ",Font=Enum.Font.GothamBold,TextSize=mob and 10 or 11,TextColor3=T.white,BackgroundColor3=T.btnC,Size=UDim2.new(1,0,0,32),BorderSizePixel=0,LayoutOrder=Sec._o})
                rnd(b,8) mk("UIStroke",{Color=T.accent,Thickness=1,Transparency=0.6,Parent=b})
                b.MouseEnter:Connect(function() tw(b,{BackgroundColor3=T.btnH},0.15) end)
                b.MouseLeave:Connect(function() tw(b,{BackgroundColor3=T.btnC},0.15) end)
                if o.Callback then b.MouseButton1Click:Connect(o.Callback) end
                return b
            end

            function Sec:AddDropdown(o)
                Sec._o=Sec._o+1
                local fr=mk("Frame",{Parent=f,BackgroundTransparency=1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,LayoutOrder=Sec._o,ClipsDescendants=true})
                mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=fr})
                local cur=o.Default or(o.Options and o.Options[1] or"Select...")
                if o.Flag then SolarynUI._flags[o.Flag]=cur end
                local btn=mk("TextButton",{Parent=fr,Text="  "..(o.Name or"Dropdown")..": "..tostring(cur).."  ▼",Font=Enum.Font.GothamBold,TextSize=fs,TextColor3=T.white,BackgroundColor3=T.btnC,Size=UDim2.new(1,0,0,30),BorderSizePixel=0,LayoutOrder=0,TextXAlignment=Enum.TextXAlignment.Left})
                rnd(btn,8) mk("UIStroke",{Color=T.accent,Thickness=1,Transparency=0.6,Parent=btn})
                local list=mk("Frame",{Parent=fr,BackgroundColor3=T.card2,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Visible=false,BorderSizePixel=0,LayoutOrder=1})
                rnd(list,8) mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,1),Parent=list}) pad(list,4,4,4,4)
                local open=false
                for idx,opt in ipairs(o.Options or{}) do
                    local ob=mk("TextButton",{Parent=list,Text="  "..opt,Font=Enum.Font.Gotham,TextSize=fs,TextColor3=T.dim,BackgroundColor3=T.card,Size=UDim2.new(1,0,0,26),BorderSizePixel=0,LayoutOrder=idx,TextXAlignment=Enum.TextXAlignment.Left})
                    rnd(ob,6)
                    ob.MouseEnter:Connect(function() tw(ob,{BackgroundColor3=T.btnH,TextColor3=T.white},0.15) end)
                    ob.MouseLeave:Connect(function() tw(ob,{BackgroundColor3=T.card,TextColor3=T.dim},0.15) end)
                    ob.MouseButton1Click:Connect(function()
                        cur=opt;btn.Text="  "..(o.Name or"Dropdown")..": "..cur.."  ▼"
                        open=false;list.Visible=false
                        if o.Flag then SolarynUI._flags[o.Flag]=cur end
                        if o.Callback then o.Callback(cur) end
                    end)
                end
                btn.MouseButton1Click:Connect(function() open=not open;list.Visible=open end)
                return{Set=function(_,v)cur=v;btn.Text="  "..(o.Name or"Dropdown")..": "..cur.."  ▼";if o.Flag then SolarynUI._flags[o.Flag]=cur end end,Refresh=function(_,opts2)for _2,c in ipairs(list:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end;for i2,opt in ipairs(opts2) do local ob=mk("TextButton",{Parent=list,Text="  "..opt,Font=Enum.Font.Gotham,TextSize=fs,TextColor3=T.dim,BackgroundColor3=T.card,Size=UDim2.new(1,0,0,26),BorderSizePixel=0,LayoutOrder=i2,TextXAlignment=Enum.TextXAlignment.Left});rnd(ob,6);ob.MouseEnter:Connect(function() tw(ob,{BackgroundColor3=T.btnH,TextColor3=T.white},0.15) end);ob.MouseLeave:Connect(function() tw(ob,{BackgroundColor3=T.card,TextColor3=T.dim},0.15) end);ob.MouseButton1Click:Connect(function() cur=opt;btn.Text="  "..(o.Name or"Dropdown")..": "..cur.."  ▼";open=false;list.Visible=false;if o.Flag then SolarynUI._flags[o.Flag]=cur end;if o.Callback then o.Callback(cur) end end) end end}
            end

            function Sec:AddInput(o)
                Sec._o=Sec._o+1
                local fr=mk("Frame",{Parent=f,BackgroundTransparency=1,Size=UDim2.new(1,0,0,52),LayoutOrder=Sec._o})
                mk("TextLabel",{Parent=fr,Text=o.Name or"Input",Font=Enum.Font.GothamBold,TextSize=fs,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),TextXAlignment=Enum.TextXAlignment.Left})
                local inp=mk("TextBox",{Parent=fr,PlaceholderText=o.Placeholder or"Type...",Text=o.Default or"",Font=Enum.Font.Gotham,TextSize=12,TextColor3=T.white,PlaceholderColor3=T.dim,BackgroundColor3=T.card,Size=UDim2.new(1,0,0,30),Position=UDim2.new(0,0,0,20),BorderSizePixel=0,ClearTextOnFocus=false})
                rnd(inp,8) pad(inp,0,0,10,10) mk("UIStroke",{Color=T.accent,Thickness=1,Transparency=0.6,Parent=inp})
                if o.Numeric then inp:GetPropertyChangedSignal("Text"):Connect(function() inp.Text=inp.Text:gsub("[^%d%.%-]","") end) end
                if o.MaxCharacters then inp:GetPropertyChangedSignal("Text"):Connect(function() if #inp.Text>o.MaxCharacters then inp.Text=inp.Text:sub(1,o.MaxCharacters) end end) end
                inp.FocusLost:Connect(function(enter)
                    if o.Flag then SolarynUI._flags[o.Flag]=inp.Text end
                    if o.Callback and(not o.EnterOnly or enter) then o.Callback(inp.Text) end
                end)
                return{Set=function(_,v) inp.Text=v end}
            end

            function Sec:AddKeybind(o)
                Sec._o=Sec._o+1
                local cur=o.Default or Enum.KeyCode.F
                local fr=mk("Frame",{Parent=f,BackgroundTransparency=1,Size=UDim2.new(1,0,0,26),LayoutOrder=Sec._o})
                mk("TextLabel",{Parent=fr,Text=o.Name or"Keybind",Font=Enum.Font.Gotham,TextSize=fs,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(0.6,0,1,0),TextXAlignment=Enum.TextXAlignment.Left})
                local btn=mk("TextButton",{Parent=fr,Text="[ "..cur.Name.." ]",Font=Enum.Font.GothamBold,TextSize=fs,TextColor3=T.accent,BackgroundColor3=T.card,Size=UDim2.new(0.38,0,0,24),Position=UDim2.new(0.62,0,0,1),BorderSizePixel=0})
                rnd(btn,6) mk("UIStroke",{Color=T.accent,Thickness=1,Transparency=0.5,Parent=btn})
                if o.Flag then SolarynUI._flags[o.Flag]=cur end
                local listening=false
                btn.MouseButton1Click:Connect(function()
                    if listening then return end;listening=true;btn.Text="[ ... ]"
                    local conn;conn=UIS.InputBegan:Connect(function(inp2,gpe)
                        if inp2.UserInputType==Enum.UserInputType.Keyboard then
                            cur=inp2.KeyCode;btn.Text="[ "..cur.Name.." ]"
                            if o.Flag then SolarynUI._flags[o.Flag]=cur end
                            if o.OnChanged then o.OnChanged(cur) end
                            listening=false;conn:Disconnect()
                        end
                    end)
                end)
                UIS.InputBegan:Connect(function(inp2,gpe) if not gpe and inp2.KeyCode==cur and not listening then if o.Callback then o.Callback(cur) end end end)
                return{Set=function(_,v) cur=v;btn.Text="[ "..cur.Name.." ]";if o.Flag then SolarynUI._flags[o.Flag]=cur end end}
            end

            function Sec:AddColorPicker(o)
                Sec._o=Sec._o+1
                local cur=o.Default or Color3.fromRGB(255,255,255)
                local fr=mk("Frame",{Parent=f,BackgroundTransparency=1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,LayoutOrder=Sec._o})
                mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=fr})
                local row=mk("Frame",{Parent=fr,BackgroundTransparency=1,Size=UDim2.new(1,0,0,24),LayoutOrder=0})
                mk("TextLabel",{Parent=row,Text=o.Name or"Color",Font=Enum.Font.Gotham,TextSize=fs,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(0.7,0,1,0),TextXAlignment=Enum.TextXAlignment.Left})
                local swatch=mk("TextButton",{Parent=row,Text="",BackgroundColor3=cur,Size=UDim2.new(0,30,0,20),Position=UDim2.new(1,-30,0,2),BorderSizePixel=0})
                rnd(swatch,6) mk("UIStroke",{Color=T.white,Thickness=1,Transparency=0.5,Parent=swatch})
                if o.Flag then SolarynUI._flags[o.Flag]=cur end
                -- color sliders (RGB)
                local open=false
                local cpanel=mk("Frame",{Parent=fr,BackgroundColor3=T.card,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Visible=false,BorderSizePixel=0,LayoutOrder=1})
                rnd(cpanel,8) pad(cpanel,8,8,8,8)
                mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=cpanel})
                local rv,gv,bv=math.floor(cur.R*255),math.floor(cur.G*255),math.floor(cur.B*255)
                local function updColor() cur=Color3.fromRGB(rv,gv,bv);swatch.BackgroundColor3=cur;if o.Flag then SolarynUI._flags[o.Flag]=cur end;if o.Callback then o.Callback(cur) end end
                for _,ch in ipairs({{name="R",get=function()return rv end,set=function(v)rv=v end,c=Color3.fromRGB(255,80,80)},{name="G",get=function()return gv end,set=function(v)gv=v end,c=Color3.fromRGB(80,255,80)},{name="B",get=function()return bv end,set=function(v)bv=v end,c=Color3.fromRGB(80,130,255)}}) do
                    local crf=mk("Frame",{Parent=cpanel,BackgroundTransparency=1,Size=UDim2.new(1,0,0,18),LayoutOrder=_})
                    local cl=mk("TextLabel",{Parent=crf,Text=ch.name..": "..ch.get(),Font=Enum.Font.Gotham,TextSize=10,TextColor3=ch.c,BackgroundTransparency=1,Size=UDim2.new(0.25,0,1,0),TextXAlignment=Enum.TextXAlignment.Left})
                    local ct=mk("Frame",{Parent=crf,BackgroundColor3=T.slTrack,Size=UDim2.new(0.72,0,0,6),Position=UDim2.new(0.26,0,0.5,-3)})
                    rnd(ct,3)
                    local cfl=mk("Frame",{Parent=ct,BackgroundColor3=ch.c,Size=UDim2.new(ch.get()/255,0,1,0)})
                    rnd(cfl,3)
                    local csl=false
                    ct.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then csl=true end end)
                    UIS.InputChanged:Connect(function(i) if csl then local r=math.clamp((i.Position.X-ct.AbsolutePosition.X)/ct.AbsoluteSize.X,0,1);ch.set(math.floor(r*255));cfl.Size=UDim2.new(r,0,1,0);cl.Text=ch.name..": "..ch.get();updColor() end end)
                    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then csl=false end end)
                end
                swatch.MouseButton1Click:Connect(function() open=not open;cpanel.Visible=open end)
            end

            function Sec:AddLabel(o)
                Sec._o=Sec._o+1
                local txt=type(o)=="string" and o or(o.Text or"Label")
                local style=(type(o)=="table" and o.Style) or 1
                local c=style==2 and T.accent or(style==3 and Color3.fromRGB(255,180,60) or T.dim)
                local lbl=mk("TextLabel",{Parent=f,Text=txt,Font=Enum.Font.Gotham,TextSize=fs,TextColor3=c,BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=Sec._o,TextWrapped=true})
                return{Set=function(_,v) lbl.Text=v end}
            end

            function Sec:AddParagraph(o)
                Sec._o=Sec._o+1
                local pf=mk("Frame",{Parent=f,BackgroundColor3=T.card2,BackgroundTransparency=0.3,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BorderSizePixel=0,LayoutOrder=Sec._o})
                rnd(pf,8) pad(pf,8,8,10,10)
                mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=pf})
                mk("TextLabel",{Parent=pf,Text=o.Title or"Info",Font=Enum.Font.GothamBold,TextSize=fs+1,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,18),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1})
                mk("TextLabel",{Parent=pf,Text=o.Text or"",Font=Enum.Font.Gotham,TextSize=fs,TextColor3=T.dim,BackgroundTransparency=1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,RichText=true,LayoutOrder=2})
            end

            function Sec:AddDivider()
                Sec._o=Sec._o+1
                local d=mk("Frame",{Parent=f,BackgroundColor3=T.card2,Size=UDim2.new(1,0,0,1),BorderSizePixel=0,LayoutOrder=Sec._o})
            end

            function Sec:AddProgressBar(o)
                Sec._o=Sec._o+1
                local fr=mk("Frame",{Parent=f,BackgroundTransparency=1,Size=UDim2.new(1,0,0,32),LayoutOrder=Sec._o})
                local l=mk("TextLabel",{Parent=fr,Text=(o.Name or"Progress")..": "..(o.Default or 0).."%",Font=Enum.Font.GothamBold,TextSize=fs,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,14),TextXAlignment=Enum.TextXAlignment.Left})
                local t=mk("Frame",{Parent=fr,BackgroundColor3=T.slTrack,Size=UDim2.new(1,0,0,8),Position=UDim2.new(0,0,0,20)})
                rnd(t,4)
                local fl=mk("Frame",{Parent=t,BackgroundColor3=T.slFill,Size=UDim2.new(math.clamp((o.Default or 0)/100,0,1),0,1,0)})
                rnd(fl,4)
                mk("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T.accent2),ColorSequenceKeypoint.new(1,T.accent)}),Parent=fl})
                return{Set=function(_,v) v=math.clamp(v,0,100);tw(fl,{Size=UDim2.new(v/100,0,1,0)},0.3);l.Text=(o.Name or"Progress")..": "..math.floor(v).."%" end}
            end

            function Sec:AddMultiToggle(o)
                Sec._o=Sec._o+1
                local fr=mk("Frame",{Parent=f,BackgroundTransparency=1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,LayoutOrder=Sec._o})
                mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,3),Parent=fr})
                mk("TextLabel",{Parent=fr,Text=o.Name or"Select",Font=Enum.Font.GothamBold,TextSize=fs,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=0})
                local cur=o.Default or(o.Options and o.Options[1] or"")
                if o.Flag then SolarynUI._flags[o.Flag]=cur end
                local btns={}
                for idx,opt in ipairs(o.Options or{}) do
                    local ob=mk("TextButton",{Parent=fr,Text="  "..opt,Font=Enum.Font.Gotham,TextSize=fs,TextColor3=opt==cur and T.white or T.dim,BackgroundColor3=opt==cur and T.accent or T.card,Size=UDim2.new(1,0,0,mob and 24 or 26),BorderSizePixel=0,LayoutOrder=idx,TextXAlignment=Enum.TextXAlignment.Left})
                    rnd(ob,6)
                    btns[idx]={btn=ob,opt=opt}
                    ob.MouseButton1Click:Connect(function()
                        cur=opt
                        for _,b in ipairs(btns) do tw(b.btn,{BackgroundColor3=b.opt==cur and T.accent or T.card,TextColor3=b.opt==cur and T.white or T.dim},0.2) end
                        if o.Flag then SolarynUI._flags[o.Flag]=cur end
                        if o.Callback then o.Callback(cur) end
                    end)
                end
                return{Set=function(_,v) cur=v;for _2,b in ipairs(btns) do tw(b.btn,{BackgroundColor3=b.opt==cur and T.accent or T.card,TextColor3=b.opt==cur and T.white or T.dim},0.2) end;if o.Flag then SolarynUI._flags[o.Flag]=cur end end}
            end

            return Sec
        end

        function Tab:CreateDivider()
            Tab._order=Tab._order+1
            mk("Frame",{Parent=pg,BackgroundColor3=T.card2,Size=UDim2.new(1,-8,0,1),BorderSizePixel=0,LayoutOrder=Tab._order})
        end

        function Tab:CreateLabel(o)
            Tab._order=Tab._order+1
            local txt=type(o)=="string" and o or(o.Text or"Label")
            local style=(type(o)=="table" and o.Style) or 1
            local c=style==2 and T.accent or(style==3 and Color3.fromRGB(255,180,60) or T.white)
            return mk("TextLabel",{Parent=pg,Text=txt,Font=Enum.Font.Gotham,TextSize=fs,TextColor3=c,BackgroundTransparency=1,Size=UDim2.new(1,0,0,18),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=Tab._order,TextWrapped=true})
        end

        -- Config section builder with full scrollable config list UI
        function Tab:BuildConfigSection()
            Tab._order=Tab._order+1
            local sec=mk("Frame",{Parent=pg,BackgroundColor3=T.card,BackgroundTransparency=0.1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BorderSizePixel=0,LayoutOrder=Tab._order})
            rnd(sec,10) pad(sec,10,10,12,12)
            mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=sec})
            mk("TextLabel",{Parent=sec,Text="  💾 Configs",Font=Enum.Font.GothamBold,TextSize=fs+1,TextColor3=T.accent,BackgroundTransparency=1,Size=UDim2.new(1,0,0,18),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=0})
            local nameBox=mk("TextBox",{Parent=sec,PlaceholderText="Config name...",Text="",Font=Enum.Font.Gotham,TextSize=mob and 10 or 12,TextColor3=T.white,PlaceholderColor3=T.dim,BackgroundColor3=T.card2,Size=UDim2.new(1,0,0,mob and 26 or 28),BorderSizePixel=0,ClearTextOnFocus=false,LayoutOrder=1})
            rnd(nameBox,6) pad(nameBox,0,0,8,8)
            local bRow=mk("Frame",{Parent=sec,BackgroundTransparency=1,Size=UDim2.new(1,0,0,mob and 26 or 30),LayoutOrder=2})
            mk("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,4),Parent=bRow})
            local function cfgBtn(txt,cb)
                local b=mk("TextButton",{Parent=bRow,Text=txt,Font=Enum.Font.GothamBold,TextSize=mob and 9 or 10,TextColor3=T.white,BackgroundColor3=T.btnC,Size=UDim2.new(0,0,0,mob and 24 or 28),AutomaticSize=Enum.AutomaticSize.X,BorderSizePixel=0})
                rnd(b,6) mk("UIPadding",{PaddingLeft=UDim.new(0,8),PaddingRight=UDim.new(0,8),Parent=b})
                mk("UIStroke",{Color=T.accent,Thickness=1,Transparency=0.6,Parent=b})
                b.MouseEnter:Connect(function() tw(b,{BackgroundColor3=T.btnH},0.15) end)
                b.MouseLeave:Connect(function() tw(b,{BackgroundColor3=T.btnC},0.15) end)
                b.MouseButton1Click:Connect(cb)
            end
            -- Config list container
            local cfgListF=mk("Frame",{Parent=sec,BackgroundColor3=T.card2,BackgroundTransparency=0.3,Size=UDim2.new(1,0,0,0),Visible=false,AutomaticSize=Enum.AutomaticSize.Y,BorderSizePixel=0,LayoutOrder=3,ClipsDescendants=true})
            rnd(cfgListF,8) pad(cfgListF,6,6,6,6)
            mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,3),Parent=cfgListF})
            mk("TextLabel",{Parent=cfgListF,Text="  📂 Saved Configs",Font=Enum.Font.GothamBold,TextSize=mob and 9 or 10,TextColor3=T.accent,BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=0})
            local cfgScroll=mk("ScrollingFrame",{Parent=cfgListF,Size=UDim2.new(1,0,0,mob and 100 or 130),BackgroundTransparency=1,ScrollBarThickness=2,ScrollBarImageColor3=T.accent,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,BorderSizePixel=0,LayoutOrder=1})
            mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=cfgScroll})
            local noConfLbl=mk("TextLabel",{Parent=cfgScroll,Text="  No configs saved yet",Font=Enum.Font.Gotham,TextSize=mob and 9 or 10,TextColor3=T.dim,BackgroundTransparency=1,Size=UDim2.new(1,0,0,24),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=0})

            local function refreshCfgList()
                for _,c in ipairs(cfgScroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
                local cfgs=SolarynUI:ListConfigs()
                noConfLbl.Visible=#cfgs==0
                for idx,cName in ipairs(cfgs) do
                    local row=mk("Frame",{Parent=cfgScroll,BackgroundColor3=T.card,Size=UDim2.new(1,0,0,mob and 26 or 30),BorderSizePixel=0,LayoutOrder=idx})
                    rnd(row,6)
                    mk("TextLabel",{Parent=row,Text="  📄 "..cName,Font=Enum.Font.Gotham,TextSize=mob and 9 or 10,TextColor3=T.white,BackgroundTransparency=1,Size=UDim2.new(0.55,0,1,0),TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd})
                    -- Load button
                    local lb=mk("TextButton",{Parent=row,Text="Load",Font=Enum.Font.GothamBold,TextSize=mob and 8 or 9,TextColor3=T.accent,BackgroundColor3=T.btnC,Size=UDim2.new(0,mob and 36 or 44,0,mob and 20 or 22),Position=UDim2.new(1,mob and -80 or -100,0.5,mob and -10 or -11),BorderSizePixel=0})
                    rnd(lb,5)
                    lb.MouseButton1Click:Connect(function() SolarynUI:LoadConfig(cName);nameBox.Text=cName end)
                    -- Delete button
                    local db=mk("TextButton",{Parent=row,Text="✕",Font=Enum.Font.GothamBold,TextSize=mob and 9 or 10,TextColor3=T.red,BackgroundColor3=Color3.fromRGB(55,22,28),Size=UDim2.new(0,mob and 20 or 22,0,mob and 20 or 22),Position=UDim2.new(1,mob and -26 or -30,0.5,mob and -10 or -11),BorderSizePixel=0})
                    rnd(db,5)
                    db.MouseButton1Click:Connect(function()
                        pcall(function() delfile(configFolder.."/"..cName..".json") end)
                        SolarynUI:Notify({Title="Deleted",Content="Removed "..cName,Duration=2})
                        refreshCfgList()
                    end)
                end
            end

            cfgBtn("Save",function() if nameBox.Text~="" then SolarynUI:SaveConfig(nameBox.Text);refreshCfgList() end end)
            cfgBtn("Load",function() if nameBox.Text~="" then SolarynUI:LoadConfig(nameBox.Text) end end)
            cfgBtn("📂 List",function()
                cfgListF.Visible=not cfgListF.Visible
                if cfgListF.Visible then refreshCfgList() end
            end)
        end

        -- Theme section builder
        function Tab:BuildThemeSection()
            Tab._order=Tab._order+1
            local sec=mk("Frame",{Parent=pg,BackgroundColor3=T.card,BackgroundTransparency=0.1,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BorderSizePixel=0,LayoutOrder=Tab._order})
            rnd(sec,10) pad(sec,10,10,12,12)
            mk("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=sec})
            mk("TextLabel",{Parent=sec,Text="  🎨 Themes",Font=Enum.Font.GothamBold,TextSize=fs+1,TextColor3=T.accent,BackgroundTransparency=1,Size=UDim2.new(1,0,0,18),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=0})
            mk("TextLabel",{Parent=sec,Text="Theme changes apply on next window creation",Font=Enum.Font.Gotham,TextSize=10,TextColor3=T.dim,BackgroundTransparency=1,Size=UDim2.new(1,0,0,14),TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1})
            local row=mk("Frame",{Parent=sec,BackgroundTransparency=1,Size=UDim2.new(1,0,0,30),LayoutOrder=2})
            mk("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,6),Parent=row})
            for _,name in ipairs({"Midnight","Ocean","Violet","Rose"}) do
                local tb=mk("TextButton",{Parent=row,Text=name,Font=Enum.Font.GothamBold,TextSize=10,TextColor3=Themes[name].white,BackgroundColor3=Themes[name].accent,Size=UDim2.new(0,0,0,28),AutomaticSize=Enum.AutomaticSize.X,BorderSizePixel=0})
                rnd(tb,6) mk("UIPadding",{PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,10),Parent=tb})
                tb.MouseButton1Click:Connect(function() SolarynUI:SetTheme(name);SolarynUI:Notify({Title="Theme",Content="Set to "..name,Duration=3}) end)
            end
        end

        return Tab
    end

    -- ═══════════ INTRO ANIMATION ═══════════
    main.BackgroundTransparency=1
    main.Position=UDim2.new(0.5,-W/2,0.55,-H/2)
    for _,d in ipairs(main:GetDescendants()) do pcall(function()
        if d:IsA("TextLabel") or d:IsA("TextButton") then d.TextTransparency=1;d.BackgroundTransparency=1 end
        if d:IsA("Frame") then d:SetAttribute("origTrans",d.BackgroundTransparency);d.BackgroundTransparency=1 end
        if d:IsA("ImageLabel") then d:SetAttribute("origImg",d.ImageTransparency);d.ImageTransparency=1 end
        if d:IsA("UIStroke") then d:SetAttribute("origStroke",d.Transparency);d.Transparency=1 end
    end) end
    task.wait(0.05)
    tw(main,{BackgroundTransparency=0.08,Position=UDim2.new(0.5,-W/2,0.5,-H/2)},0.6)
    task.wait(0.12)
    for _,d in ipairs(main:GetDescendants()) do pcall(function()
        if d:IsA("TextLabel") or d:IsA("TextButton") then tw(d,{TextTransparency=0},0.45) end
        if d:IsA("Frame") then tw(d,{BackgroundTransparency=d:GetAttribute("origTrans") or 0},0.45) end
        if d:IsA("ImageLabel") then tw(d,{ImageTransparency=d:GetAttribute("origImg") or 0},0.45) end
        if d:IsA("UIStroke") then tw(d,{Transparency=d:GetAttribute("origStroke") or 0.4},0.45) end
    end) end

    -- Loading screen
    if opts.LoadingEnabled then
        SolarynUI:Notify({Title=opts.LoadingTitle or"SolarynUI",Content=opts.LoadingSubtitle or"Loading...",Duration=3})
    end

    return Window
end

return SolarynUI
