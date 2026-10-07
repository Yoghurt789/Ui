-- AURAPRO Dark Cyber UI (uiv2.lua)
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("AURAPRO_UI") then
    CoreGui.AURAPRO_UI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AURAPRO_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Library = {}
Library.__index = Library

function Library.new(title)
    local self = setmetatable({}, Library)
    
    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 230, 0, 36)
    main.Position = UDim2.new(0.5, -115, 0.3, 0)
    main.BackgroundColor3 = Color3.fromRGB(15, 17, 22)
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    main.ClipsDescendants = true
    main.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = main

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 36)
    header.BackgroundColor3 = Color3.fromRGB(22, 25, 32)
    header.BorderSizePixel = 0
    header.Parent = main

    local hCorner = Instance.new("UICorner")
    hCorner.CornerRadius = UDim.new(0, 8)
    hCorner.Parent = header

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -35, 1, 0)
    titleLbl.Position = UDim2.new(0, 10, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title or "AURAPRO"
    titleLbl.TextColor3 = Color3.fromRGB(0, 255, 136)
    titleLbl.TextSize = 14
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = header

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 30, 1, 0)
    toggleBtn.Position = UDim2.new(1, -30, 0, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = "▼"
    toggleBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    toggleBtn.TextSize = 12
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = header

    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, -12, 0, 320)
    container.Position = UDim2.new(0, 6, 0, 42)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 2
    container.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 136)
    container.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = container

    local open = false
    toggleBtn.MouseButton1Click:Connect(function()
        open = not open
        toggleBtn.Text = open and "▲" or "▼"
        toggleBtn.TextColor3 = open and Color3.fromRGB(0, 255, 136) or Color3.fromRGB(150, 150, 150)
        main.Size = open and UDim2.new(0, 230, 0, 370) or UDim2.new(0, 230, 0, 36)
    end)

    self.container = container
    return self
end

function Library:AddSection(name)
    local sec = {}
    
    local secFrame = Instance.new("Frame")
    secFrame.Size = UDim2.new(1, 0, 0, 28)
    secFrame.BackgroundColor3 = Color3.fromRGB(25, 28, 36)
    secFrame.BorderSizePixel = 0
    secFrame.Parent = self.container

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 6)
    sCorner.Parent = secFrame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -26, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(140, 150, 170)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = secFrame

    local secBtn = Instance.new("TextButton")
    secBtn.Size = UDim2.new(0, 26, 1, 0)
    secBtn.Position = UDim2.new(1, -26, 0, 0)
    secBtn.BackgroundTransparency = 1
    secBtn.Text = "▼"
    secBtn.TextColor3 = Color3.fromRGB(140, 150, 170)
    secBtn.TextSize = 10
    secBtn.Font = Enum.Font.GothamBold
    secBtn.Parent = secFrame

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 0, 0)
    content.BackgroundTransparency = 1
    content.AutomaticSize = Enum.AutomaticSize.Y
    content.Parent = self.container

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = content

    local secOpen = true
    secBtn.MouseButton1Click:Connect(function()
        secOpen = not secOpen
        secBtn.Text = secOpen and "▼" or "▲"
        content.Visible = secOpen
    end)

    function sec:AddButton(text, danger, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.BackgroundColor3 = danger and Color3.fromRGB(220, 50, 70) or Color3.fromRGB(0, 255, 136)
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = danger and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(12, 15, 20)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.Parent = content

        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 6)
        bCorner.Parent = btn

        btn.MouseButton1Click:Connect(callback or function() end)
    end

    function sec:AddToggle(text, default, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(20, 23, 30)
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.Parent = content

        local tCorner = Instance.new("UICorner")
        tCorner.CornerRadius = UDim.new(0, 6)
        tCorner.Parent = btn

        local tLbl = Instance.new("TextLabel")
        tLbl.Size = UDim2.new(1, -40, 1, 0)
        tLbl.Position = UDim2.new(0, 10, 0, 0)
        tLbl.BackgroundTransparency = 1
        tLbl.Text = text
        tLbl.TextColor3 = Color3.fromRGB(230, 235, 245)
        tLbl.TextSize = 12
        tLbl.Font = Enum.Font.GothamBold
        tLbl.TextXAlignment = Enum.TextXAlignment.Left
        tLbl.Parent = btn

        local switch = Instance.new("Frame")
        switch.Size = UDim2.new(0, 32, 0, 16)
        switch.Position = UDim2.new(1, -38, 0.5, -8)
        switch.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
        switch.BorderSizePixel = 0
        switch.Parent = btn

        local swCorner = Instance.new("UICorner")
        swCorner.CornerRadius = UDim.new(1, 0)
        swCorner.Parent = switch

        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 12, 0, 12)
        dot.Position = UDim2.new(0, 2, 0.5, -6)
        dot.BackgroundColor3 = Color3.fromRGB(120, 130, 150)
        dot.BorderSizePixel = 0
        dot.Parent = switch

        local dCorner = Instance.new("UICorner")
        dCorner.CornerRadius = UDim.new(1, 0)
        dCorner.Parent = dot

        local state = default or false
        local function update()
            switch.BackgroundColor3 = state and Color3.fromRGB(0, 180, 95) or Color3.fromRGB(35, 40, 50)
            dot.BackgroundColor3 = state and Color3.fromRGB(0, 255, 136) or Color3.fromRGB(120, 130, 150)
            dot.Position = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
        end
        update()

        btn.MouseButton1Click:Connect(function()
            state = not state
            update()
            if callback then callback(state) end
        end)
    end

    function sec:AddSlider(text, min, max, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 36)
        frame.BackgroundColor3 = Color3.fromRGB(20, 23, 30)
        frame.BorderSizePixel = 0
        frame.Parent = content

        local slCorner = Instance.new("UICorner")
        slCorner.CornerRadius = UDim.new(0, 6)
        slCorner.Parent = frame

        local sLbl = Instance.new("TextLabel")
        sLbl.Size = UDim2.new(0.6, 0, 0, 18)
        sLbl.Position = UDim2.new(0, 10, 0, 2)
        sLbl.BackgroundTransparency = 1
        sLbl.Text = text
        sLbl.TextColor3 = Color3.fromRGB(230, 235, 245)
        sLbl.TextSize = 12
        sLbl.Font = Enum.Font.GothamBold
        sLbl.TextXAlignment = Enum.TextXAlignment.Left
        sLbl.Parent = frame

        local vLbl = Instance.new("TextLabel")
        vLbl.Size = UDim2.new(0.3, 0, 0, 18)
        vLbl.Position = UDim2.new(0.7, -10, 0, 2)
        vLbl.BackgroundTransparency = 1
        vLbl.Text = tostring(default or min)
        vLbl.TextColor3 = Color3.fromRGB(0, 255, 136)
        vLbl.TextSize = 12
        vLbl.Font = Enum.Font.GothamBold
        vLbl.TextXAlignment = Enum.TextXAlignment.Right
        vLbl.Parent = frame

        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, -20, 0, 4)
        track.Position = UDim2.new(0, 10, 0, 24)
        track.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
        track.BorderSizePixel = 0
        track.Parent = frame

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(((default or min) - min)/(max - min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 255, 136)
        fill.BorderSizePixel = 0
        fill.Parent = track

        local dragging = false
        local function update(input)
            local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + ((max - min) * pos))
            vLbl.Text = tostring(val)
            if callback then callback(val) end
        end

        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                update(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end
        end)
    end

    function sec:AddDropdown(text, list, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 28)
        frame.BackgroundColor3 = Color3.fromRGB(20, 23, 30)
        frame.BorderSizePixel = 0
        frame.ClipsDescendants = true
        frame.Parent = content

        local dCorner = Instance.new("UICorner")
        dCorner.CornerRadius = UDim.new(0, 6)
        dCorner.Parent = frame

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.BackgroundTransparency = 1
        btn.Text = "  " .. text
        btn.TextColor3 = Color3.fromRGB(230, 235, 245)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = frame

        local arrow = Instance.new("TextLabel")
        arrow.Size = UDim2.new(0, 20, 0, 28)
        arrow.Position = UDim2.new(1, -25, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.Text = "▼"
        arrow.TextColor3 = Color3.fromRGB(0, 255, 136)
        arrow.TextSize = 10
        arrow.Font = Enum.Font.GothamBold
        arrow.Parent = frame

        local dLayout = Instance.new("UIListLayout")
        dLayout.Parent = frame

        for _, v in ipairs(list or {}) do
            local opt = Instance.new("TextButton")
            opt.Size = UDim2.new(1, 0, 0, 24)
            opt.BackgroundColor3 = Color3.fromRGB(28, 32, 42)
            opt.BorderSizePixel = 0
            opt.Text = v
            opt.TextColor3 = Color3.fromRGB(150, 160, 180)
            opt.TextSize = 11
            opt.Font = Enum.Font.GothamBold
            opt.Parent = frame
            
            opt.MouseButton1Click:Connect(function()
                frame.Size = UDim2.new(1, 0, 0, 28)
                btn.Text = "  " .. text .. " (" .. v .. ")"
                if callback then callback(v) end
            end)
        end

        local dOpen = false
        btn.MouseButton1Click:Connect(function()
            dOpen = not dOpen
            frame.Size = dOpen and UDim2.new(1, 0, 0, 28 + (#list * 24)) or UDim2.new(1, 0, 0, 28)
        end)
    end

    function sec:AddBind(text, defaultKey, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 28)
        frame.BackgroundColor3 = Color3.fromRGB(20, 23, 30)
        frame.BorderSizePixel = 0
        frame.Parent = content

        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 6)
        bCorner.Parent = frame

        local bLbl = Instance.new("TextLabel")
        bLbl.Size = UDim2.new(1, -50, 1, 0)
        bLbl.Position = UDim2.new(0, 10, 0, 0)
        bLbl.BackgroundTransparency = 1
        bLbl.Text = text
        bLbl.TextColor3 = Color3.fromRGB(230, 235, 245)
        bLbl.TextSize = 12
        bLbl.Font = Enum.Font.GothamBold
        bLbl.TextXAlignment = Enum.TextXAlignment.Left
        bLbl.Parent = frame

        local bBtn = Instance.new("TextButton")
        bBtn.Size = UDim2.new(0, 40, 0, 18)
        bBtn.Position = UDim2.new(1, -48, 0.5, -9)
        bBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
        bBtn.BorderSizePixel = 0
        bBtn.Text = defaultKey and defaultKey.Name or "C"
        bBtn.TextColor3 = Color3.fromRGB(0, 255, 136)
        bBtn.TextSize = 11
        bBtn.Font = Enum.Font.GothamBold
        bBtn.Parent = frame

        local bbCorner = Instance.new("UICorner")
        bbCorner.CornerRadius = UDim.new(0, 4)
        bbCorner.Parent = bBtn

        local key = defaultKey or Enum.KeyCode.C
        local listening = false

        bBtn.MouseButton1Click:Connect(function()
            listening = true
            bBtn.Text = "..."
        end)

        UserInputService.InputBegan:Connect(function(input, gpe)
            if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                listening = false
                key = input.KeyCode
                bBtn.Text = key.Name
            elseif not gpe and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == key then
                if callback then callback(key) end
            end
        end)
    end

    function sec:AddBox(text, holder, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 28)
        frame.BackgroundColor3 = Color3.fromRGB(20, 23, 30)
        frame.BorderSizePixel = 0
        frame.Parent = content

        local bxCorner = Instance.new("UICorner")
        bxCorner.CornerRadius = UDim.new(0, 6)
        bxCorner.Parent = frame

        local xLbl = Instance.new("TextLabel")
        xLbl.Size = UDim2.new(0.5, 0, 1, 0)
        xLbl.Position = UDim2.new(0, 10, 0, 0)
        xLbl.BackgroundTransparency = 1
        xLbl.Text = text
        xLbl.TextColor3 = Color3.fromRGB(230, 235, 245)
        xLbl.TextSize = 12
        xLbl.Font = Enum.Font.GothamBold
        xLbl.TextXAlignment = Enum.TextXAlignment.Left
        xLbl.Parent = frame

        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0.45, 0, 0, 18)
        box.Position = UDim2.new(0.5, 0, 0.5, -9)
        box.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
        box.BorderSizePixel = 0
        box.Text = ""
        box.PlaceholderText = holder or ""
        box.TextColor3 = Color3.fromRGB(0, 255, 136)
        box.TextSize = 11
        box.Font = Enum.Font.GothamBold
        box.Parent = frame

        local ibCorner = Instance.new("UICorner")
        ibCorner.CornerRadius = UDim.new(0, 4)
        ibCorner.Parent = box

        box.FocusLost:Connect(function(enter)
            if callback then callback(box.Text, enter) end
        end)
    end

    return sec
end

-- ส่งค่า Library ออกไปให้ loadstring ดึงไปใช้งาน
return Library