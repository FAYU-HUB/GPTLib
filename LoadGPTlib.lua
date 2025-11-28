--============================================================--
--                     GPTLib (PlayerGui Version)
--              Full UI Library • Semua di PlayerGui
--============================================================--

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--============================================================--
--                     SMOOTH DRAG SYSTEM
--============================================================--

local function SmoothDrag(Frame)
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        local goal = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)

        TweenService:Create(Frame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = goal
        }):Play()
    end

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

--============================================================--
--                    CLEAR OLD UI & CREATE BASE
--============================================================--

if PlayerGui:FindFirstChild("GPTLibUI") then
    PlayerGui.GPTLibUI:Destroy()
end

local UI = Instance.new("ScreenGui")
UI.Name = "GPTLibUI"
UI.ResetOnSpawn = false
UI.Parent = PlayerGui

-- MAIN WINDOW
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 460, 0, 330)
Main.Position = UDim2.new(0.3, 0, 0.25, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Parent = UI
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Apply Smooth Drag
SmoothDrag(Main)

-- TITLE BAR
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "GPTLib - PlayerGui Version"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Main
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local TabList = Instance.new("UIListLayout", Sidebar)
TabList.Padding = UDim.new(0, 6)
TabList.SortOrder = Enum.SortOrder.LayoutOrder

-- PAGES
local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1, -130, 1, -40)
Pages.Position = UDim2.new(0, 130, 0, 40)
Pages.BackgroundTransparency = 1
Pages.Parent = Main

--============================================================--
--                       GPTLib SYSTEM
--============================================================--

local GPTLib = {}

function GPTLib:CreateTab(Name)
    local Tab = {}
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.Text = Name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.Parent = Sidebar
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

    -- PAGE
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.ScrollBarThickness = 4
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = Pages

    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Auto Update Scroll
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 20)
    end)

    Button.MouseButton1Click:Connect(function()
        for _,v in pairs(Pages:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        Page.Visible = true
    end)

    -------------------------------------------------------------
    -- ELEMENTS (Button, Toggle, Slider, Dropdown, Textbox, Keybind)
    -------------------------------------------------------------
    
    function Tab:Button(Text, Callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -20, 0, 40)
        Btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Btn.Text = Text
        Btn.Parent = Page
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
        Btn.MouseButton1Click:Connect(Callback)
    end

    -- (TOGGLE, SLIDER, DROPDOWN, TEXTBOX, KEYBIND)
    -- SEMUA BAGIAN DI BAWAH TIDAK DIUBAH — HANYA DIBIARKAN ASLI
    -- ******************************************************************
    -- *** Seluruh code Toggle, Slider, Dropdown, Textbox, Keybind ***  
    -- *** tetap sama seperti scriptmu di atas (100% sama).        ***
    -- ******************************************************************

    -- COPY PERSIS BAGIANMU (sudah benar)
    -------------------------------------------------------------
    -- TOGGLE
    -------------------------------------------------------------
    function Tab:Toggle(Text, Default, Callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -20, 0, 40)
        Frame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        Frame.Parent = Page
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.7, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text = Text
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 14
        Label.Parent = Frame

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0.3, -5, 0.6, 0)
        Btn.Position = UDim2.new(0.7, 0, 0.2, 0)
        Btn.Text = Default and "ON" or "OFF"
        Btn.BackgroundColor3 = Default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 12
        Btn.Parent = Frame
        
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

        local state = Default

        Btn.MouseButton1Click:Connect(function()
            state = not state
            Btn.Text = state and "ON" or "OFF"
            Btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(150, 0, 0)
            Callback(state)
        end)
    end

    -------------------------------------------------------------
    -- SLIDER (sama seperti scriptmu)
    -------------------------------------------------------------
    function Tab:Slider(Text, Min, Max, Default, Callback)
        local Holder = Instance.new("Frame")
        Holder.Size = UDim2.new(1, -20, 0, 60)
        Holder.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        Holder.Parent = Page
        Instance.new("UICorner", Holder)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0.4, 0)
        Label.Text = Text.." : "..Default
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 14
        Label.Parent = Holder

        local Bar = Instance.new("Frame")
        Bar.Size = UDim2.new(1, -20, 0, 10)
        Bar.Position = UDim2.new(0, 10, 0.6, 0)
        Bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Bar.Parent = Holder
        Instance.new("UICorner", Bar)

        local Fill = Instance.new("Frame")
        Fill.Size = UDim2.new((Default-Min)/(Max-Min), 0, 1, 0)
        Fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        Fill.Parent = Bar
        Instance.new("UICorner", Fill)

        local dragging = false

        Bar.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
        end)
        Bar.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
        end)

        UIS.InputChanged:Connect(function(i)
            if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                local pos = math.clamp((i.Position.X - Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X, 0, 1)
                Fill.Size = UDim2.new(pos, 0, 1, 0)
                local val = math.floor(Min + (Max-Min)*pos)
                Label.Text = Text.." : "..val
                Callback(val)
            end
        end)
    end

    -------------------------------------------------------------
    -- DROPDOWN (copy full — sama persis)
    -------------------------------------------------------------
    function Tab:Dropdown(Text, List, Callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -20, 0, 40)
        Frame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        Frame.Parent = Page
        Instance.new("UICorner", Frame)

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 1, 0)
        Btn.BackgroundTransparency = 1
        Btn.Text = Text.." ▼"
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Btn.Parent = Frame

        local expand = false
        
        Btn.MouseButton1Click:Connect(function()
            expand = not expand
        end)

        coroutine.wrap(function()
            while task.wait() do
                if expand then
                    Frame.Size = UDim2.new(1, -20, 0, 40 + (#List * 30))
                else
                    Frame.Size = UDim2.new(1, -20, 0, 40)
                end
            end
        end)()

        for i,v in ipairs(List) do
            local Option = Instance.new("TextButton")
            Option.Size = UDim2.new(1, -10, 0, 30)
            Option.Position = UDim2.new(0, 5, 0, 40 + ((i-1)*30))
            Option.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Option.Text = v
            Option.TextColor3 = Color3.fromRGB(255, 255, 255)
            Option.Font = Enum.Font.Gotham
            Option.TextSize = 12
            Option.Parent = Frame
            Instance.new("UICorner", Option)

            Option.MouseButton1Click:Connect(function()
                Btn.Text = Text.." : "..v
                Callback(v)
                expand = false
            end)
        end
    end

    -------------------------------------------------------------
    -- TEXTBOX
    -------------------------------------------------------------
    function Tab:Textbox(Text, Callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -20, 0, 40)
        Frame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        Frame.Parent = Page
        Instance.new("UICorner", Frame)

        local Box = Instance.new("TextBox")
        Box.Size = UDim2.new(1, -10, 1, -10)
        Box.Position = UDim2.new(0, 5, 0, 5)
        Box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Box.PlaceholderText = Text
        Box.Text = ""
        Box.TextColor3 = Color3.fromRGB(255, 255, 255)
        Box.Font = Enum.Font.Gotham
        Box.TextSize = 14
        Box.Parent = Frame
        Instance.new("UICorner", Box)

        Box.FocusLost:Connect(function()
            Callback(Box.Text)
        end)
    end

    -------------------------------------------------------------
    -- KEYBIND
    -------------------------------------------------------------
    function Tab:Keybind(Text, DefaultKey, Callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -20, 0, 40)
        Frame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        Frame.Parent = Page
        Instance.new("UICorner", Frame)

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 1, 0)
        Btn.BackgroundTransparency = 1
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Btn.Text = Text.." : ["..DefaultKey.."]"
        Btn.Parent = Frame

        local waiting = false
        local bind = Enum.KeyCode[DefaultKey]

        Btn.MouseButton1Click:Connect(function()
            waiting = true
            Btn.Text = "Press a key..."
        end)

        UIS.InputBegan:Connect(function(input)
            if waiting then
                waiting = false
                bind = input.KeyCode
                Btn.Text = Text.." : ["..bind.Name.."]"
            elseif input.KeyCode == bind then
                Callback()
            end
        end)
    end

    return Tab
end


--============================================================--
--                     EXAMPLE USAGE
--============================================================--
