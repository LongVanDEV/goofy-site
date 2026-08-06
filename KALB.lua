-- ================================================================= --
--                     CUSTOM JNKIE KEY SYSTEM                       --
-- ================================================================= --

local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "KALB Modded"
Junkie.identifier = "12681"
Junkie.provider = "Get Key"

local SAVED_KEY_FILE = "jnkie_saved_key.txt"
local TARGET_SCRIPT_URL = "https://api.jnkie.com/api/v1/luascripts/public/8cdba7c7c9b87d82c06afbc419373c055c1934d3c8851fcadb0788eeacf35fe7/download"

-- Direct payload execution
local function executePayload(key)
    getgenv().SCRIPT_KEY = key
    loadstring(game:HttpGet(TARGET_SCRIPT_URL))()
end

-- ================================================================= --
--                     AUTO-LOAD SAVED KEY                           --
-- ================================================================= --

if isfile and isfile(SAVED_KEY_FILE) then
    local savedKey = readfile(SAVED_KEY_FILE)
    if savedKey and savedKey:gsub("%s+", "") ~= "" then
        print("[Key System] Saved key detected. Launching script...")
        executePayload(savedKey)
        return
    end
end

-- ================================================================= --
--                          CUSTOM UI DESIGN                         --
-- ================================================================= --

local CoreGui = game:GetService("CoreGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomJnkieKeyUI"
ScreenGui.ResetOnSpawn = false

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 210)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -105)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(45, 45, 55)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Header Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "Jnkie Key System"
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Status Notice
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 20)
StatusLabel.Position = UDim2.new(0, 20, 0, 42)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Enter your key below to execute"
StatusLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

-- Text Input Box
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 38)
KeyBox.Position = UDim2.new(0, 20, 0, 70)
KeyBox.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderText = "Paste Key Here..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 100)
KeyBox.Text = ""
KeyBox.TextSize = 13
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = KeyBox

-- Submit Button
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.5, -25, 0, 38)
SubmitBtn.Position = UDim2.new(0, 20, 0, 122)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
SubmitBtn.Text = "Submit Key"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 13
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = MainFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 6)
SubmitCorner.Parent = SubmitBtn

-- Get Key Button
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.5, -25, 0, 38)
GetKeyBtn.Position = UDim2.new(0.5, 5, 0, 122)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
GetKeyBtn.TextSize = 13
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = MainFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 6)
GetKeyCorner.Parent = GetKeyBtn

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 10)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame

-- ================================================================= --
--                           ACTIONS                                 --
-- ================================================================= --

-- Safely fetch link without triggering JD_REQ1 crash
GetKeyBtn.MouseButton1Click:Connect(function()
    local success, link = pcall(function()
        return Junkie.get_key_link()
    end)
    
    if success and link and setclipboard then
        setclipboard(link)
        StatusLabel.Text = "Copied key link!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 220, 100)
    else
        -- Fallback link if SDK call fails
        local fallbackUrl = "https://jnkie.com/flow/6c86886d-93ce-4193-b6af-e607028f1524"
        if setclipboard then setclipboard(fallbackUrl) end
        StatusLabel.Text = "Copied fallback key link!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 180, 0)
    end
end)

SubmitBtn.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text:gsub("%s+", "")
    
    if enteredKey == "" then
        StatusLabel.Text = "Enter a key first!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        return
    end
    
    StatusLabel.Text = "Loading target script..."
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    if writefile then
        writefile(SAVED_KEY_FILE, enteredKey)
    end
    
    task.wait(0.3)
    ScreenGui:Destroy()
    
    executePayload(enteredKey)
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
