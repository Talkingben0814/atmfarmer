--Services
local HttpService = game:GetService("HttpService")
local request = http_request or request or HttpPost or syn.request
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local GroupService = game:GetService("GroupService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")



--Module scripts
local mainModule = require(ReplicatedStorage:WaitForChild("MainModule"))

-- setting up functions for testing when not obfuscated
if not LPH_OBFUSCATED then  -- set these if not obfuscated so your script can run without obfuscation for when you are testing
    LPH_JIT = function(...) return (...) end; -- (mostly normal obfuscation with some performance gains)  - Fast
    LPH_JIT_MAX = function(...) return (...) end; -- (still obfuscated, but more optimized) - Faster
    LPH_NO_VIRTUALIZE = function(...) return (...) end; -- (no virtualization) - Fastest
    LRM_IsUserPremium = true


end

--Consts
local PLAYER = Players.LocalPlayer
local MOUSE = PLAYER:GetMouse()
local DATA_FOLDER = PLAYER:WaitForChild("DataFolder")
local INVENTORY = DATA_FOLDER:WaitForChild("Inventory")
local PLAYER_CASH = DATA_FOLDER:WaitForChild("Currency")
local INFORMATION = DATA_FOLDER:WaitForChild("Information")
local ORIGINAL_CASH_AMOUNT = PLAYER_CASH.Value
local IGNORED = workspace:WaitForChild("Ignored")
local ATMS = workspace:WaitForChild("Cashiers")
local PLAYERS_FOLDER = workspace:WaitForChild("Players")
local SHOP = IGNORED:WaitForChild("Shop")
local ITEMS_DROP = IGNORED:WaitForChild("ItemsDrop")
local CASH_DROP = IGNORED:WaitForChild("Drop")
local SHOPS = SHOP:GetChildren()
local SPAWN = IGNORED:WaitForChild("Spawn")
local LIGHTS = workspace:WaitForChild("Lights")
local MAIN_EVENT = ReplicatedStorage:WaitForChild("MainEvent")
local PLAYER_CASH = PLAYER.DataFolder:WaitForChild("Currency")
local ORIGINAL_CASH_AMOUNT = PLAYER_CASH.Value
local REQUIRED_ITEMS = {
	["[Knife] - $159"] = 2,
	["[Revolver] - $1379"] = 1,
	["12 [Revolver Ammo] - $80"] = 1,
	["[Key] - $133"] = 1,
}
local REQUIRED_CHAR_PARTS = {
    ["Humanoid"] = true,
    ["HumanoidRootPart"] = true,
    ["UpperTorso"] = true,
    ["LowerTorso"] = true,
    ["Head"] = true,
}

--Ui
local PLAYER_GUI = PLAYER:WaitForChild("PlayerGui")
local CORE_GUI = game.CoreGui

-- BetterDaHood Gui to Lua
--------------------------

--AtmFarm (of 'ScreenGui' class)
local AtmFarm = Instance.new("ScreenGui")
AtmFarm.Name = "AtmFarm"
AtmFarm.IgnoreGuiInset = true
AtmFarm.ResetOnSpawn = false
AtmFarm.DisplayOrder = 99
AtmFarm.Parent = CORE_GUI

--Create instances
local Advert = Instance.new("Frame")
local AdvertDescription1 = Instance.new("TextLabel")
local AdvertGdt = Instance.new("UIGradient")
local AdvertTitle = Instance.new("TextLabel")
local SkipAd = Instance.new("TextButton")
local SkipAdGdt = Instance.new("UIGradient")
local SkipAdText = Instance.new("TextLabel")
local SkipProgress = Instance.new("Frame")
local AdvertImage = Instance.new("ImageLabel")
local AdvertDescription2 = Instance.new("TextLabel")
local PriceLbl = Instance.new("TextLabel")
local FarmerFrame = Instance.new("Frame")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local DestroyMap = Instance.new("TextButton")
local DestroyMapDesc = Instance.new("TextLabel")
local FpsCapTxt = Instance.new("TextBox")
local FpsCapDesc = Instance.new("TextLabel")
local LowGfx = Instance.new("TextButton")
local LowGfxDesc = Instance.new("TextLabel")
local KnifeFarm = Instance.new("TextButton")
local GunFarm = Instance.new("TextButton")
local GunFarmLbl = Instance.new("TextLabel")
local GunFarmGdt = Instance.new("UIGradient")
local FarmTimeRemaining = Instance.new("TextLabel")
local Fps = Instance.new("TextLabel")
local FpsLbl = Instance.new("TextLabel")
local Ping = Instance.new("TextLabel")
local PingLbl = Instance.new("TextLabel")
local KnifeFarmStatusBack = Instance.new("Frame")
local KnifeFarmStatus = Instance.new("TextLabel")
local GunFarmStatusBack = Instance.new("Frame")
local GunFarmStatus = Instance.new("TextLabel")
local FarmNote = Instance.new("TextLabel")
local SettingsFrame = Instance.new("Frame")
local SettingsTitle = Instance.new("TextLabel")
local GunSpeedFrame = Instance.new("Frame")
local GunSpeedLbl = Instance.new("TextLabel")
local GunSpeedDec = Instance.new("TextButton")
local GunSpeedInc = Instance.new("TextButton")
local GunSpeedTitle = Instance.new("TextLabel")
local KnifeSpeedFrame = Instance.new("Frame")
local KnifeSpeedLbl = Instance.new("TextLabel")
local KnifeSpeedDec = Instance.new("TextButton")
local KnifeSpeedInc = Instance.new("TextButton")
local KnifeSpeedTitle = Instance.new("TextLabel")
local SettingsDesc = Instance.new("TextLabel")
local CrasherGdt = Instance.new("UIGradient")
local GetLink = Instance.new("TextButton")
local GetLinkGdt = Instance.new("UIGradient")
local GetLinkText = Instance.new("TextLabel")
local LinkImage = Instance.new("ImageLabel")
local SettingsBtn = Instance.new("TextButton")
local SettingsGdt = Instance.new("UIGradient")
local SettingsText = Instance.new("TextLabel")
local SettingsImage = Instance.new("ImageLabel")
local MoreInfo = Instance.new("Frame")
local MoreInfoLbl = Instance.new("TextLabel")
local MoreInfoGdt = Instance.new("UIGradient")
local InfoTitle = Instance.new("TextLabel")
local AcceptBtn = Instance.new("TextButton")
local AcceptGdt = Instance.new("UIGradient")
local AcceptLbl = Instance.new("TextLabel")
local CancelBtn = Instance.new("TextButton")
local CancelLbl = Instance.new("TextLabel")
local BDHLogo = Instance.new("ImageLabel")
local Cursor = Instance.new("Frame")

--Set attributes
LPH_JIT_MAX(function()


	--Secondary instances
	local secondaryInsts = {{["ClassName"] = "UICorner", ["Parent"] = Advert, ["Properties"] = {["CornerRadius"] = UDim.new(0.05, 0),}},{["ClassName"] = "UIStroke", ["Parent"] = Advert, ["Properties"] = {}},{["ClassName"] = "UIStroke", ["Parent"] = SkipAd, ["Properties"] = {["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border,}},{["ClassName"] = "UICorner", ["Parent"] = SkipAd, ["Properties"] = {["CornerRadius"] = UDim.new(0.25, 0),}},{["ClassName"] = "UICorner", ["Parent"] = SkipProgress, ["Properties"] = {["CornerRadius"] = UDim.new(0.25, 0),}},{["ClassName"] = "UICorner", ["Parent"] = DestroyMap, ["Properties"] = {}},{["ClassName"] = "UICorner", ["Parent"] = LowGfx, ["Properties"] = {}},{["ClassName"] = "UICorner", ["Parent"] = KnifeFarm, ["Properties"] = {}},{["ClassName"] = "UICorner", ["Parent"] = GunFarm, ["Properties"] = {}},{["ClassName"] = "UIPadding", ["Parent"] = KnifeFarmStatusBack, ["Properties"] = {["PaddingBottom"] = UDim.new(0.05, 0),["PaddingTop"] = UDim.new(0.05, 0),["PaddingLeft"] = UDim.new(0.019, 0),["PaddingRight"] = UDim.new(0.019, 0),}},{["ClassName"] = "UICorner", ["Parent"] = KnifeFarmStatusBack, ["Properties"] = {}},{["ClassName"] = "UICorner", ["Parent"] = GunFarmStatusBack, ["Properties"] = {}},{["ClassName"] = "UIPadding", ["Parent"] = GunFarmStatusBack, ["Properties"] = {["PaddingBottom"] = UDim.new(0.05, 0),["PaddingTop"] = UDim.new(0.05, 0),["PaddingLeft"] = UDim.new(0.019, 0),["PaddingRight"] = UDim.new(0.019, 0),}},{["ClassName"] = "UICorner", ["Parent"] = FarmerFrame, ["Properties"] = {["CornerRadius"] = UDim.new(0.05, 0),}},{["ClassName"] = "UIStroke", ["Parent"] = FarmerFrame, ["Properties"] = {}},{["ClassName"] = "UICorner", ["Parent"] = GunSpeedDec, ["Properties"] = {["CornerRadius"] = UDim.new(0.5, 0),}},{["ClassName"] = "UICorner", ["Parent"] = GunSpeedInc, ["Properties"] = {["CornerRadius"] = UDim.new(0.5, 0),}},{["ClassName"] = "UICorner", ["Parent"] = GunSpeedFrame, ["Properties"] = {["CornerRadius"] = UDim.new(0.1, 0),}},{["ClassName"] = "UICorner", ["Parent"] = KnifeSpeedDec, ["Properties"] = {["CornerRadius"] = UDim.new(0.5, 0),}},{["ClassName"] = "UICorner", ["Parent"] = KnifeSpeedInc, ["Properties"] = {["CornerRadius"] = UDim.new(0.5, 0),}},{["ClassName"] = "UICorner", ["Parent"] = KnifeSpeedFrame, ["Properties"] = {["CornerRadius"] = UDim.new(0.1, 0),}},{["ClassName"] = "UIStroke", ["Parent"] = GetLink, ["Properties"] = {["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border,}},{["ClassName"] = "UICorner", ["Parent"] = GetLink, ["Properties"] = {["CornerRadius"] = UDim.new(0.25, 0),}},{["ClassName"] = "UIStroke", ["Parent"] = SettingsBtn, ["Properties"] = {["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border,}},{["ClassName"] = "UICorner", ["Parent"] = SettingsBtn, ["Properties"] = {["CornerRadius"] = UDim.new(0.25, 0),}},{["ClassName"] = "UICorner", ["Parent"] = MoreInfo, ["Properties"] = {["CornerRadius"] = UDim.new(0.05, 0),}},{["ClassName"] = "UIStroke", ["Parent"] = MoreInfo, ["Properties"] = {}},{["ClassName"] = "UIStroke", ["Parent"] = AcceptBtn, ["Properties"] = {["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border,}},{["ClassName"] = "UICorner", ["Parent"] = AcceptBtn, ["Properties"] = {["CornerRadius"] = UDim.new(0.25, 0),}},{["ClassName"] = "UIStroke", ["Parent"] = CancelBtn, ["Properties"] = {["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border,}},{["ClassName"] = "UICorner", ["Parent"] = CancelBtn, ["Properties"] = {["CornerRadius"] = UDim.new(0.25, 0),}},{["ClassName"] = "UICorner", ["Parent"] = BDHLogo, ["Properties"] = {["CornerRadius"] = UDim.new(0.15, 0),}},{["ClassName"] = "UICorner", ["Parent"] = Cursor, ["Properties"] = {}},{["ClassName"] = "UIStroke", ["Parent"] = Cursor, ["Properties"] = {["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border,}},}
	for _, instInfo in ipairs(secondaryInsts) do
		local inst = Instance.new(instInfo.ClassName)
		for propertyName, value in pairs(instInfo.Properties) do
			inst[propertyName] = value
		end
		inst.Parent = instInfo.Parent
	end
end)();

-- Connect the function to update the cash text when it changes
PLAYER_CASH.Changed:Connect(function()
    if LowGfxTitle then
        LowGfxTitle.Text = tostring(PLAYER_CASH.Value)
    else
        print("LowGfxTitle not found")
    end
end)

-- Create LowGfxScreenGui (of 'ScreenGui' class) if it doesn't exist
local LowGfxScreenGui = CORE_GUI:FindFirstChild("LowGfxScreenGui")
if not LowGfxScreenGui then
    LowGfxScreenGui = Instance.new("ScreenGui")
    LowGfxScreenGui.Name = "LowGfxScreenGui"
    LowGfxScreenGui.Enabled = false
    LowGfxScreenGui.IgnoreGuiInset = true
    LowGfxScreenGui.Parent = CORE_GUI

    -- Create LowGfxBackground Frame
    local LowGfxBackground = Instance.new("Frame")
    LowGfxBackground.Name = "LowGfxBackground"
    LowGfxBackground.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
    LowGfxBackground.BackgroundColor3 = Color3.new(1, 1, 1)
    LowGfxBackground.Size = UDim2.new(1, 0, 1, 0)
    LowGfxBackground.Parent = LowGfxScreenGui

    -- Create LowGfxTitle TextLabel
    LowGfxTitle = Instance.new("TextLabel")
    LowGfxTitle.Name = tostring(PLAYER_CASH.Value)
    LowGfxTitle.LayoutOrder = 1
    LowGfxTitle.TextTransparency = 0.7799999713897705
    LowGfxTitle.TextStrokeTransparency = 0.75
    LowGfxTitle.AnchorPoint = Vector2.new(0.5, 0.5)
    LowGfxTitle.Size = UDim2.new(0.5, 0, 0.075, 0)
    LowGfxTitle.TextColor3 = Color3.new(1, 1, 1)
    LowGfxTitle.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
    LowGfxTitle.TextSize = 14
    LowGfxTitle.Font = Enum.Font.SourceSans
    LowGfxTitle.BackgroundTransparency = 1
    LowGfxTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
    LowGfxTitle.TextScaled = true
    LowGfxTitle.BackgroundColor3 = Color3.new(1, 1, 1)
    LowGfxTitle.Parent = LowGfxBackground

    -- Create LGFXUIGradient UIGradient
    local LGFXUIGradient = Instance.new("UIGradient")
    LGFXUIGradient.Name = "LGFXUIGradient"
    LGFXUIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),ColorSequenceKeypoint.new(1, Color3.new(0.176471, 0.176471, 0.176471))}
    LGFXUIGradient.Rotation = 290
    LGFXUIGradient.Parent = LowGfxBackground
end

-- Set initial cash value on LowGfxTitle if it exists
if LowGfxTitle then
    LowGfxTitle.Text = tostring(PLAYER_CASH.Value)
else
    print("LowGfxTitle not found")
end




--Tooltip
--Tooltip Gui for showing extra info about commands
--Create tooltip
local tooltip = Instance.new("Frame")
tooltip.Name = "Tooltip"
tooltip.BackgroundTransparency = 1
tooltip.Size = UDim2.new(0, 100, 0, 40)
tooltip.Visible = false
tooltip.Parent = AtmFarm
local title = Instance.new("TextLabel")
title.Name = "Title"
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.BackgroundTransparency = 0.1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Size = UDim2.new(1, 0, 0.4, 0)
title.TextScaled = true
title.Parent = tooltip
local content = Instance.new("TextLabel")
content.Name = "Content"
content.TextXAlignment = Enum.TextXAlignment.Left
content.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
content.BackgroundTransparency = 0.3
content.TextColor3 = Color3.fromRGB(255, 255, 255)
content.Size = UDim2.new(1, 0, 0.6, 0)
content.Position = UDim2.new(0, 0, 0.4, 0)
content.TextScaled = true
content.Parent = tooltip

--Anti-anti-cheat
if getgenv().antiCheatEnabled ~= true then
    getgenv().antiCheatEnabled = true
    LPH_JIT_MAX(function()
        local events = {"OneMoreTime", "TeleportDetect", "CHECKER_1", "CHECKER_2", "OneMoreTime", "BreathingHAMON", "VirusCough"}
        local hook = nil
        hook = hookmetamethod(game, "__namecall", function(...)
            local Args = {...}
            local self = Args[1]
            local namecall = getnamecallmethod()
            local calledFromExecutor = checkcaller()
            --local callingScript = getcallingscript()

            if namecall == "FireServer" and self == MAIN_EVENT then
                if table.find(events, Args[2]) then -- anti-anti-cheat
                    return nil
                elseif calledFromExecutor == false then
                    if Args[2] == "UpdateMousePos" then
                        --print("UpdateMousePos Blocked")
                        return nil
                    elseif Args[2] == "AnimationPack" then
                        if Args[3] == "Lay [X]" then
                            return hook(self, "AnimationPack", "Lay")
                        elseif Args[3] == "Greet [C]" then
                            return hook(self, "AnimationPack", "Greet")
                        end
                    end
                end
            --[[
            elseif namecall == "Activate" then
                for i,v in pairs(Args) do
                    print(tostring(i).." = "..tostring(v))
                end
                --]]
            end
            return hook(...)
        end)
    end)();
end

--Clean up seats
LPH_JIT_MAX(function() 
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Seat") or v:IsA("VehicleSeat") then
            v.Disabled = true
        end
    end
end)();

--- MAIN SCRIPT ---

--Tooltip setup information
local uiElements = {
	[GunFarm] = {Title = "Gun Farm", Content = "Uses gun to farm ATMs (Faster than Knife Farm)"},
	[KnifeFarm] = {Title = "Knife Farm", Content = "Uses knife to farm ATMs"},
	[LowGfx] = {Title = "Low Gfx", Content = "Reduces CPU + GPU usage whilst active"},
	[DestroyMap] = {Title = "Destroy Map", Content = "Destroys the map to reduce memory + CPU usage"},
    [GetLink] = {Title = "Copy Discord link", Content = "Join our discord to purchase BetterDaHood Premium, get support for our scripts, and more!"},
	[KnifeSpeedInc] = {Title = "Increase Speed", Content = "Increase speed of knife farm (Higher risk of getting kicked by anti-cheat)"},
	[GunSpeedInc] = {Title = "Increase Speed", Content = "Increase speed of gun farm (Higher risk of getting kicked by anti-cheat)"},
	[KnifeSpeedDec] = {Title = "Decrease Speed", Content = "Decrease speed of knife farm (Less risk of getting kicked by anti-cheat)"},
	[GunSpeedDec] = {Title = "Decrease Speed", Content = "Decrease speed of gun farm (Less risk of getting kicked by anti-cheat)"},
}

--Setup Gui values
KnifeSpeedLbl:SetAttribute("OriginalSize", KnifeSpeedLbl.Size)
GunSpeedLbl:SetAttribute("OriginalSize", GunSpeedLbl.Size)

--Setup Gui
MoreInfo.Visible = false
MoreInfo:SetAttribute("OriginalSize", MoreInfo.Size)
MoreInfo.Size = UDim2.new(0, 0, 0, 0)
FarmerFrame.Visible = false
FarmerFrame:SetAttribute("OriginalSize", FarmerFrame.Size)
FarmerFrame.Size = UDim2.new(0, 0, 0, 0)
FarmerFrame.Active = true
FarmerFrame.Draggable = true

MainFrame.Visible = true
SettingsFrame.Visible = false

local altGui = CORE_GUI:FindFirstChild("AltGui")
--if not altGui and not PLAYER.Character.HumanoidRootPart:FindFirstChild("BDHGui") then -- Show the advert if player is not Premium and isn't an BDH Alt
if not LRM_IsUserPremium then -- Show the advert if player is not Premium
    --Set PriceLbl text
    local priceLabelTexts = {
        "Very Optimized!",
        "Updates Often!",
        "Awesome Features!",
        "Good Value!",
        "Perfect For You!",
        "It's Betterifed!",
        "You're Cool :)",
        "Very OP! 😎 ",
        "It's Thuggified!",
        "It's REALLY Cool!",
        "Buy Premium! 💸",
        "Certified Thug Script!",
        "Thug Asf!",
        "It's AWESOME!",
        "#1 Best Script!",
        "💥💥CRASH💥💥",
        "Thugs Only!",
    }
    PriceLbl.Text = priceLabelTexts[math.random(#priceLabelTexts)]
    PriceLbl.Visible = true

    Advert.Visible = true
    Advert:SetAttribute("OriginalSize", Advert.Size)
    Advert.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(Advert, TweenInfo.new(0.35), {Size = Advert:GetAttribute("OriginalSize")}):Play()

    --PriceLbl jiggle
    local originalRotation = PriceLbl.Rotation
    task.spawn(function()
        while Advert.Visible == true do
            originalRotation += 10
            local Number2 = math.rad(originalRotation)
            local Number3 = math.sin(Number2) * 6 + 20
            PriceLbl.Rotation = Number3
            task.wait(0.04)
        end
    end)

    --Join Discord
    task.spawn(function()
        local success, response = pcall(function()
            syn.request(
            {
                Url = "http://127.0.0.1:6463/rpc?v=1",
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["origin"] = "https://discord.com",
                },
                Body = HttpService:JSONEncode(
                {
                    ["args"] = {
                        ["code"] = "jFrNyAtKHP",
                    },
                    ["cmd"] = "INVITE_BROWSER",
                    ["nonce"] = "."
                })
            })
        end)
    end)

    --Advert
    TweenService:Create(SkipProgress, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()
    for count = 3, 1, -1 do
        SkipAdText.Text = count.."s"
        task.wait(1)
    end
    SkipAdText.Text = "Skip Ad"
    SkipAd.MouseButton1Down:Wait()
    TweenService:Create(Advert, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.2 * 2)
end

Advert.Visible = false

--Main script
if altGui then -- If player is an alt
    --Put the crasher inside the crasher frame
    for _, v in ipairs(FarmerFrame:GetChildren()) do
        if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("TextBox") then
            v.Parent = altGui.Background.FarmerFrame
        end
    end
    --Put the accept window in the background
    MoreInfo.Parent = altGui.Background

    --Make utility buttons non-visible
    FpsCapTxt.Visible = false
    DestroyMap.Visible = false
    LowGfx.Visible = false
    GetLink.Visible = false
else
    FarmerFrame.Visible = true
    TweenService:Create(FarmerFrame, TweenInfo.new(0.2), {Size = FarmerFrame:GetAttribute("OriginalSize")}):Play()
end

--Team crasher stuff
--Team Crasher functions
local teamCrash
local canClientsTeamCrash
--Vars
local playerOldPosition
local gunFarm = false
local knifeFarm = false

--Load settings
--Default settings
local farmerSettings = {
	["GodMode"] = false,
	["UseCDWorkaround"] = false,
	["UseSnowballs"] = false,
	["KnifeFarmSpeed"] = getgenv().speed, 
	["GunFarmSpeed"] = 50,
}

local farmerSettingsFunctions = {
	["KnifeFarmSpeed"] = function(newStrength)
		if newStrength <= 150 and newStrength >= 5 then
			KnifeSpeedLbl.Text = newStrength.."%"
			KnifeSpeedLbl.Size = KnifeSpeedLbl.Size + UDim2.new(0, 0, 0.04, 0)
			TweenService:Create(KnifeSpeedLbl, TweenInfo.new(0.2), {Size = KnifeSpeedLbl:GetAttribute("OriginalSize")}):Play()
			farmerSettings.KnifeFarmSpeed = newStrength
		end
	end,
	["GunFarmSpeed"] = function(newStrength)
		if newStrength <= 150 and newStrength >= 5 then
			GunSpeedLbl.Text = newStrength.."%"
			GunSpeedLbl.Size = GunSpeedLbl.Size + UDim2.new(0, 0, 0.04, 0)
			TweenService:Create(GunSpeedLbl, TweenInfo.new(0.2), {Size = GunSpeedLbl:GetAttribute("OriginalSize")}):Play()
			farmerSettings.GunFarmSpeed = newStrength
		end
	end,
}

local function loadData()
    if isfile("FarmerSettings.bdh") then
        local contents = HttpService:JSONDecode(readfile("FarmerSettings.bdh"))
		for propertyName, value in pairs(contents) do
			farmerSettings[propertyName] = value
			farmerSettingsFunctions[propertyName](value)
		end
    end
end

local function saveData()
    if isfile("FarmerSettings.bdh") then
        delfile("FarmerSettings.bdh")
	end
    writefile("FarmerSettings.bdh", HttpService:JSONEncode(farmerSettings))
end

--Load data
pcall(function() loadData() end)

--Check executor fireclickdetector() compatibility
--local isCompatibleExecutor = false
--local executorName = string.lower(identifyexecutor())
--if string.match(executorName, "synapse") or string.match(executorName, "script") or string.match(executorName, "krnl") or string.match(executorName, "fluxus") or string.match(executorName, "trigon") then
--    isCompatibleExecutor = true
--else
    --StarterGui:SetCore("SendNotification", {
    --    Title = "Warning",
    --    Text = "Your executor MIGHT be incompatible with fireclickdetector(), Item Crash will use a different method",
    --    Duration = 45,
    --    Button1 = "Okay",
    --})

    --Reset all required amounts to 1 for compatibility purposes
    --for itemName, amountRequired in pairs(REQUIRED_ITEMS) do
    --    REQUIRED_ITEMS[itemName] = 1
    --end
--end

--Functions
local function fireClickDetectorWorkaround(clickDetector)
    --Hold ctrl
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)

    local part
    if clickDetector.Parent:IsA("BasePart") then
        part = clickDetector.Parent
    else
        part = clickDetector.Parent.Head
    end

    workspace.Camera.CameraType = Enum.CameraType.Scriptable
	--local lookatCFrame = CFrame.lookAt((part.Position + Vector3.new(math.random(-0.3, 0.3), 2, math.random(-0.3, 0.3))), part.Position)
    --workspace.Camera.CFrame = lookatCFrame
    task.wait(0.15)
    VirtualInputManager:SendMouseButtonEvent((workspace.Camera.ViewportSize.X/2), (workspace.Camera.ViewportSize.Y/2), 0, true, game, 1)
	--VirtualUser:ClickButton1(Vector2.new(workspace.Camera.ViewportSize.X/2, workspace.Camera.ViewportSize.Y/2), lookatCFrame)
	--mouse1click() 
    task.wait(0.15)
    VirtualInputManager:SendMouseButtonEvent((workspace.Camera.ViewportSize.X/2), (workspace.Camera.ViewportSize.Y/2), 0, false, game, 1)
    --workspace.Camera.CameraType = Enum.CameraType.Custom
end

local function updateMousePosWithDebounce(position)
    getgenv().sendingMessage = true
    wait()
    wait()
    MAIN_EVENT:FireServer("UpdateMousePos", position)
    wait()
    wait()
    getgenv().sendingMessage = false
end

local function getClosestPart(part, partList)
	local closestPart, closestDistance
	for _, v in ipairs(partList) do
		if closestPart then
			local distance = (part.Position - v.Position).magnitude
			if distance < closestDistance then
				closestPart = v
				closestDistance = distance
			end
		else
			closestPart = v
			closestDistance = (part.Position - v.Position).magnitude
		end
	end
	return closestPart, closestDistance
end

local function cancelVelocity(enabled)
    while PLAYER.Character == nil do task.wait() end
    local humanoidRootPart = PLAYER.Character:WaitForChild("HumanoidRootPart")

	if enabled == true then 
		if not humanoidRootPart:FindFirstChild("CustomVelocity") then 
			local vel = Instance.new("BodyVelocity")
			vel.MaxForce = Vector3.new(1, 1, 1) * math.huge
			vel.P = math.huge
			vel.Velocity = Vector3.new(0, 0, 0)
			vel.Name = "CustomVelocity"
			vel.Parent = humanoidRootPart
		end
	else
		if humanoidRootPart:FindFirstChild("CustomVelocity") then 
			humanoidRootPart:FindFirstChild("CustomVelocity"):Destroy()
		end
	end
end

local function getValidBills()
	local drops = CASH_DROP:GetChildren()
	local bills = {}
	if #drops >= 50 then -- If number of bills on the floor exceeds limit, pick them all up regardless of distance(To prevent lag)
		for _, v in ipairs(CASH_DROP:GetChildren()) do
			if v.Name == "MoneyDrop" then
				bills[#bills+1] = v
			end
		end
	else
		for _, v in ipairs(drops) do
			if v.Name == "MoneyDrop" and (PLAYER.Character.HumanoidRootPart.Position - v.Position).magnitude < 50 then
				bills[#bills+1] = v
			end
		end
	end
	return bills
end

local function roundNumber(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function Format(Int)
	return string.format("%02i", Int)
end

local function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

local function commaValue(amount)
	local formatted = amount
	local k
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

local timerTurnedOn = false
local function startStopTimer(toggle)
	local farmType = knifeFarm == true and "Knife" or gunFarm == true and "Gun" or "?"

    if toggle == true then
		--Send "Farm Started" webhook
		task.spawn(function()
			if not LRM_IsUserPremium then return end
			request({Url = getgenv().farmerSettings.DiscordWebhook, Body = HttpService:JSONEncode({
				["embeds"] = {{
				["title"] = "'"..PLAYER.Name.."' Started Farming",
					["description"] = "Using "..farmType,
					["color"] = tonumber(0xFFFAFA),
				}},
			}), Method = "POST", Headers = {["content-type"] = "application/json"}})
		end)

        timerTurnedOn = true
		local seconds = 0
        task.spawn(function()
            local turnTimerOff = false
            task.spawn(function() -- for delay
                while timerTurnedOn == true do
                    task.wait()
                end
                turnTimerOff = true
            end)
			--Timer
			task.spawn(function()
				while turnTimerOff == false do
					FarmTimeRemaining.Text = convertToHMS(seconds)
					task.wait(1)
					seconds += 1
				end
			end)
			--Farm update webhook
			while turnTimerOff == false do
				task.wait(getgenv().farmerSettings.UpdateIntervals * 60)
				if turnTimerOff == true then break end
				--Send "Farm Update" webhook
				task.spawn(function()
					if not LRM_IsUserPremium then return end
					request({Url = getgenv().farmerSettings.DiscordWebhook, Body = HttpService:JSONEncode({
						["embeds"] = {{
							["title"] = "'"..PLAYER.Name.."' is farming...",
							["color"] = tonumber(0xFFFAFA),
							["fields"] = {
								{
									["name"] = "Cash Farmed",
									["value"] = "$"..commaValue(PLAYER_CASH.Value - ORIGINAL_CASH_AMOUNT),
									["inline"] = true
								},
								{
									["name"] = "Time Spent Farming",
									["value"] = convertToHMS(seconds),
									["inline"] = true
								},
								{
									["name"] = "Cash",
									["value"] = "$"..commaValue(PLAYER_CASH.Value),
									["inline"] = true
								},
							}
						}},
					}), Method = "POST", Headers = {["content-type"] = "application/json"}})
				end)
			end
        end)
    elseif toggle == false then
		--Send "Farm Stopped" webhook
		task.spawn(function()
			if not LRM_IsUserPremium then return end
			request({Url = getgenv().farmerSettings.DiscordWebhook, Body = HttpService:JSONEncode({
				["embeds"] = {{
				["title"] = "'"..PLAYER.Name.."' Stopped Farming",
					["color"] = tonumber(0xFFFAFA),
				}},
			}), Method = "POST", Headers = {["content-type"] = "application/json"}})
		end)

        timerTurnedOn = false
        FarmTimeRemaining.Text = convertToHMS(0)
    else
        timerTurnedOn = false
    end
end

local function isCharacterLoaded(player)
    if player.Character then
        for partName, _ in pairs(REQUIRED_CHAR_PARTS) do
            if not player.Character:FindFirstChild(partName) then
                return false
            end
        end
        return true
    else
        return false
    end
end

local cleanedItems = {}
local function cleanupItem(item)
    if not cleanedItems[item] and item:IsA("Tool") then
        task.wait(2)
        for _, descendant in ipairs(item:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 1
                descendant.Material = Enum.Material.SmoothPlastic
                if descendant:IsA("MeshPart") then
                    descendant.MeshId = ""
                    descendant.TextureID = ""
                end
            elseif descendant:IsA("Decal") then
                descendant.Transparency = 1
            elseif descendant:IsA("BillboardGui") then
                descendant.Enabled = false
            elseif descendant:IsA("TextLabel") then
                descendant.Visible = false
            elseif descendant:IsA("Sound") then
                descendant.SoundId = ""
            elseif descendant:IsA("Mesh") then
                descendant.MeshId = ""
                descendant.TextureID = ""
            end
        end
        cleanedItems[item] = true
    end

    --If it's a can, make sure it's parented to character
    --while item.Parent == nil do task.wait() end
    --if item.Name == "[SprayCan]" and item.Parent == PLAYER.Backpack then
    --    item.Parent = PLAYER.Character
    --end
end

local function toolCount(player)
    if player == nil then player = PLAYER end

    local toolCount = 0
    for _, v in ipairs(PLAYER.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            toolCount += 1
        end
    end
    for _, v in ipairs(PLAYER.Character:GetChildren()) do
        if v:IsA("Tool") then
            toolCount += 1
        end
    end

    return toolCount
end

local function itemCount(itemName, player)
    if player == nil then player = PLAYER end

    local count = 0
    for _, v in ipairs(player.Backpack:GetChildren()) do
        if v.Name == itemName then
            count += 1
        end
    end
    for _, v in ipairs(player.Character:GetChildren()) do
        if v.Name == itemName then
            count += 1
        end
    end
    return count
end

--KnifeFarm
local function knifeFarmFunction()
	knifeFarm = not knifeFarm
	if knifeFarm == true then
		

		startStopTimer(true)
		cancelVelocity(true)

		while not isCharacterLoaded(PLAYER) do task.wait() end
		playerOldPosition = PLAYER.Character.HumanoidRootPart.CFrame
		print(playerOldPosition)
		while knifeFarm == true do
			local character = PLAYER.Character or PLAYER.CharacterAdded:Wait()
			
			for _, atm in ipairs(workspace.Cashiers:GetChildren()) do
				local atmHumanoid = atm:WaitForChild("Humanoid", 3)
				if knifeFarm == false or not atmHumanoid then 
					break
				elseif atmHumanoid.Health > 20 then
					KnifeFarmStatus.Text = "Waiting for character to load..."
					while not isCharacterLoaded(PLAYER) do task.wait() end
					PLAYER.Character.HumanoidRootPart.CFrame = CFrame.new(atm.Open.Position + Vector3.new(0, 0, 0))
					character = PLAYER.Character or PLAYER.CharacterAdded:Wait()

					--Purchase knife
					KnifeFarmStatus.Text = "Purchasing knife..."
					local knife = character:FindFirstChild("[Knife]") or PLAYER.Backpack:FindFirstChild("[Knife]")
					while knife == nil and knifeFarm == true do
						character.HumanoidRootPart.CFrame = CFrame.new(IGNORED.Shop["[Knife] - $159"].Head.Position + Vector3.new(0, 3, 0))
						task.wait(0.05)
						fireclickdetector(IGNORED.Shop["[Knife] - $159"].ClickDetector)
						knife = character:FindFirstChild("[Knife]") or PLAYER.Backpack:FindFirstChild("[Knife]")
					end

					--Equip knife
					KnifeFarmStatus.Text = "Equipping knife..."
					while knife.Parent ~= character and knifeFarm == true do
						knife.Parent = character
						task.wait(0.1)
					end

					--Check ATM isn't one of the 'special' ATMs that need to be hit from a specific place
					local newPos = atm.Open.Position
					if atm.Head.Position == Vector3.new(-623.9984741210938, 24.90001678466797, -285.0622253417969) then
						newPos = Vector3.new(-621.9984741210938, 24.90001678466797, -285.0622253417969)
					elseif atm.Head.Position == Vector3.new(-626.9984741210938, 24.90001678466797, -285.0621643066406) then
						newPos = Vector3.new(-628.9984741210938, 24.90001678466797, -285.0622253417969)
					end

					--Hit ATM
					KnifeFarmStatus.Text = "Hitting ATM..."
					while atmHumanoid.Health > 20 and knifeFarm == true do
						knife:Activate()
						task.spawn(function()
							while atmHumanoid.Health > 20 and knifeFarm == true do
								while not isCharacterLoaded(PLAYER) do task.wait() end
								character.HumanoidRootPart.CFrame = CFrame.new(newPos)
								task.wait(0.05)
							end
						end)
						task.wait(0.85)
					end
					task.wait(0.25)
				end

				

				--Pick up cash
				KnifeFarmStatus.Text = "Picking up cash..."

				--Build list of valid pickupable bills
				local bills = getValidBills()

				while #bills >= 1 and knifeFarm == true do
					--Wait for character to load
					while not isCharacterLoaded(PLAYER) do task.wait() end

					--Rebuild list
					bills = getValidBills()

					--Select a suitable dollarbill
					local dollarBill, distance = getClosestPart(PLAYER.Character.HumanoidRootPart, bills)

					if dollarBill then
						--Keep teleporting to the cash
						task.spawn(function()
							while dollarBill.Parent ~= nil and knifeFarm == true do
								while not isCharacterLoaded(PLAYER) do task.wait() end
								character.HumanoidRootPart.CFrame = CFrame.new(dollarBill.Position + Vector3.new(0, 3, 0))
								task.wait(0.05)
							end
						end)

						--Wait extra if it's outside of max collection distance
						if distance > 12 then
							task.wait(1.5)
						end
						task.wait(0.4 / (farmerSettings.KnifeFarmSpeed / 100))

						--Click the cash
						if dollarBill:FindFirstChild("ClickDetector") then
							fireclickdetector(dollarBill.ClickDetector)
						end
					end
				end
			end

			task.wait(0.05)
		end
	elseif knifeFarm == false then
		startStopTimer(false)
		cancelVelocity(false)
		while not isCharacterLoaded(PLAYER) do task.wait() end
		PLAYER.Character.HumanoidRootPart.CFrame = playerOldPosition
		KnifeFarm.BackgroundColor3 = Color3.new(0, 1, 0)
		KnifeFarm.Text = "Knife Farm<br />(Free)"
		KnifeFarmStatus.Visible = false
	end
end







--GunFarm
local previousAtm
local function gunFarmFunction()
	if LRM_IsUserPremium == true then
		gunFarm = not gunFarm
		if gunFarm == true then
			GunFarmGdt.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
			GunFarmLbl.Text = "Farming..."
			GunFarmStatus.Visible = true
	
			startStopTimer(true)
			cancelVelocity(true)
	
			while not isCharacterLoaded(PLAYER) do task.wait() end
			playerOldPosition = PLAYER.Character.HumanoidRootPart.CFrame
			while gunFarm == true do
				local character = PLAYER.Character or PLAYER.CharacterAdded:Wait()
				cancelVelocity(true)
				for _, atm in ipairs(workspace.Cashiers:GetChildren()) do
					local atmHumanoid = atm:FindFirstChild("Humanoid")
					if gunFarm == false or not atmHumanoid then
						break
					elseif atmHumanoid.Health > 20  then
						GunFarmStatus.Text = "Waiting for character to load..."
						character = PLAYER.Character or PLAYER.CharacterAdded:Wait()
						while not isCharacterLoaded(PLAYER) do task.wait() end
						character.HumanoidRootPart.CFrame = CFrame.new(atm.Open.Position + Vector3.new(0, 0, 0))

						--Buy gun
						GunFarmStatus.Text = "Purchasing gun..."
						local gun = character:FindFirstChild("[Revolver]") or PLAYER.Backpack:FindFirstChild("[Revolver]")
						while gun == nil and gunFarm == true do
							character.HumanoidRootPart.CFrame = CFrame.new(IGNORED.Shop["[Revolver] - $1339"].Head.Position + Vector3.new(0, 3, 0))
							task.wait(0.05)
							fireclickdetector(IGNORED.Shop["[Revolver] - $1339"].ClickDetector)
							gun = character:FindFirstChild("[Revolver]") or PLAYER.Backpack:FindFirstChild("[Revolver]")
						end

						--Equip gun
						GunFarmStatus.Text = "Equipping gun..."
						while gun.Parent ~= character and gunFarm == true do
							gun.Parent = character
							task.wait(0.1)
						end

						--Check ammo
						local ammo = INVENTORY:WaitForChild("[Revolver]", 10)
						if not ammo then
							StarterGui:SetCore("SendNotification", {
								Title = "Error",
								Text = "Please leave and rejoin the game to fix. If you see this error please send a screenshot to BetterDaHood.",
								Duration = 180,
								Button1 = "Okay"
							})
							warn("[BDH] Please leave and rejoin the game to fix. If you see this error please send a screenshot to BetterDaHood.")
							break
						elseif tonumber(ammo.Value) < 6 then
							gun.Parent = PLAYER.Backpack
							while tonumber(ammo.Value) < 100 and gunFarm == true do
								character.HumanoidRootPart.CFrame = CFrame.new(IGNORED.Shop["12 [Revolver Ammo] - $52"].Head.Position + Vector3.new(0, 3, 0))
								task.wait(0.05)
								fireclickdetector(IGNORED.Shop["12 [Revolver Ammo] - $52"].ClickDetector)
							end
							gun.Parent = character
						end
						
						--Shoot ATM
						GunFarmStatus.Text = "Shooting ATM..."
						while atmHumanoid.Health > 20 and gunFarm == true do
							task.spawn(function()
								while atmHumanoid.Health > 20 and gunFarm == true do
									while not isCharacterLoaded(PLAYER) do task.wait() end
									character.HumanoidRootPart.CFrame = CFrame.new(atm.Open.Position)
									task.wait(0.05)
								end
							end)
							MAIN_EVENT:FireServer("UpdateMousePos", atm.Open.Position)
							task.wait(0.3)
							for count = 1, 3 do
								gun:Activate()
								task.wait(0.3)
							end
							MAIN_EVENT:FireServer("Reload", gun)
						end

						--Wait extra if next ATM is far away
						if previousAtm then
							local nextAtmDistance = (atm.Head.Position - previousAtm.Head.Position).magnitude
							if nextAtmDistance > 12 then
								task.wait(1.5)
							end
						end
						task.wait(0.1)
						previousAtm = atm
					end

					if gunFarm == false then break end
		
					--Pick up cash
					GunFarmStatus.Text = "Picking up cash..."

					--Build list of valid pickupable bills
					local bills = getValidBills()

					while #bills >= 1 and gunFarm == true do
						--Wait for character to load
						while not isCharacterLoaded(PLAYER) do task.wait() end

						--Rebuild list
						bills = getValidBills()

						--Select a suitable dollarbill
						local dollarBill, distance = getClosestPart(PLAYER.Character.HumanoidRootPart, bills)

						if dollarBill then
							--Keep teleporting to the cash
							task.spawn(function()
								while dollarBill.Parent ~= nil and gunFarm == true do
									while not isCharacterLoaded(PLAYER) do task.wait() end
									character.HumanoidRootPart.CFrame = CFrame.new(dollarBill.Position + Vector3.new(0, 3, 0))
									task.wait(0.05)
								end
							end)

							--Wait extra if it's outside of max collection distance
							if distance > 12 then
								task.wait(1.5)
							end
							task.wait(0.4 / (farmerSettings.GunFarmSpeed / 100))

							--Click the cash
							if dollarBill:FindFirstChild("ClickDetector") then
								fireclickdetector(dollarBill.ClickDetector)
							end
						end
					end
				end
	
				task.wait(0.05)
			end
		elseif gunFarm == false then
			startStopTimer(false)
			cancelVelocity(false)
			while not isCharacterLoaded(PLAYER) do task.wait() end
			PLAYER.Character.HumanoidRootPart.CFrame = playerOldPosition
			GunFarmGdt.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.new(1, 0.615686, 0)),ColorSequenceKeypoint.new(1, Color3.new(1, 0.878431, 0.188235)),}
			GunFarmLbl.Text = "Gun Farm<br />(Premium)"
			GunFarmStatus.Visible = false
		end
	else
		--Not Premium notification
		local bindable = Instance.new("BindableFunction")
		function bindable.OnInvoke(response)
			if response == "Join Discord" then
				syn.request(
				{
					Url = "http://127.0.0.1:6463/rpc?v=1",
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json",
						["origin"] = "https://discord.com",
					},
					Body = HttpService:JSONEncode(
					{
						["args"] = {
							["code"] = "GHk4tzRjDH",
						},
						["cmd"] = "INVITE_BROWSER",
						["nonce"] = "."
					})
				})
			end
		end
	
		StarterGui:SetCore("SendNotification", {
			Title = "No Premium",
			Text = "You must have BDH Premium to use Premium farm. Buy it from our Discord!",
			Duration = 15,
			Callback = bindable,
			Button1 = "Okay",
			Button2 = "Join Discord",
		})
    end
end



-- Destroy map setup
local DestroyMapWhitelist = {
    ["Names"] = {
        ["Siren"] = true,
        ["SNOWs_"] = true,
        ["Radius"] = true,
    },
    ["DescendantOf"] = {
        ATMS,
        PLAYERS_FOLDER,
        SHOP,
        LIGHTS,
    },
}

local function destroyWhitelist(inst)
    if DestroyMapWhitelist.Names[inst.Name] == true then
        return false
    end

    for _, descendantToCheck in ipairs(DestroyMapWhitelist.DescendantOf) do
        if inst:IsDescendantOf(descendantToCheck) then
            return false
        end
    end

    return true
end

-- Setup shops
for i, v in ipairs(SHOPS) do
    if REQUIRED_ITEMS[v.Name] then
        v.Head.Size = Vector3.new(10, 0.5, 10)
        v.Head.Color = Color3.fromRGB(255, 215, 0)
        v.Head.CanCollide = true
        v.Head.Transparency = 1
        v.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    else
        v:Destroy()
    end
end

-- Destroy the map
for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") or v:IsA("WedgePart") then
        v.Material = "SmoothPlastic"
        v.Reflectance = 0
        if destroyWhitelist(v) == true then
            v:Destroy()
        elseif v.Parent == SPAWN then
            v.CanCollide = true
        elseif v.Parent == ITEMS_DROP then
            -- Platform the item drop locations
            local platform = Instance.new("Part")
            platform.Name = "ItemPlatform"
            platform.Anchored = true
            platform.Transparency = 1
            platform.Size = Vector3.new(5, 0.1, 5)
            platform.Position = v.Position - Vector3.new(0, 3, 0)
            platform.Parent = SPAWN
        end
    elseif v:IsA("Decal") then
        v:Destroy()
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    end
end

-- Snow
local snowSkippedFlag = false -- leave 1 snow left
for _, v in ipairs(IGNORED:GetChildren()) do
    if v.Name == "SNOWs_" then
        if snowSkippedFlag == false then
            snowSkippedFlag = true
        else
            v:Destroy()
        end
    end
end
for _, v in ipairs(Lighting:GetDescendants()) do
    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
        v.Enabled = false
    end
end

-- Platform the player
local platform = Instance.new("Part")
platform.Anchored = true
platform.Size = Vector3.new(10, 0.5, 10)
platform.Position = PLAYER.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
platform.Parent = workspace

-- Big Floor platform
local floorPlatform = Instance.new("Part")
floorPlatform.Name = "BigFloorPlatform"
floorPlatform.Anchored = true
floorPlatform.CanCollide = true
floorPlatform.Position = Vector3.new(-30, -450, -350)
floorPlatform.Size = Vector3.new(2047, 1, 2047)
floorPlatform.Parent = workspace





if 1 == 1 then
	LowGfx.BackgroundColor3 = Color3.new(0, 255, 0)
	LowGfxScreenGui.Enabled = true
end

--CancelBtn
CancelBtn.MouseButton1Down:Connect(function() --Close MoreInfo
    TweenService:Create(MoreInfo, TweenInfo.new(0.15), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.35)
    MoreInfo.Visible = false
end)

--Connect
if LRM_IsUserPremium == true then --------------------------IF PLAYER IS PREMIUM--------------------------

else ---------------------------------------IF PLAYER IS NOT PREMIUM---------------------------------------
    AcceptBtn.MouseButton1Down:Connect(function()
        --Not Premium notification
        local bindable = Instance.new("BindableFunction")
        function bindable.OnInvoke(response)
            if response == "Join Discord" then
                syn.request(
                {
                    Url = "http://127.0.0.1:6463/rpc?v=1",
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["origin"] = "https://discord.com",
                    },
                    Body = game:GetService("HttpService"):JSONEncode(
                    {
                        ["args"] = {
                            ["code"] = "GHk4tzRjDH",
                        },
                        ["cmd"] = "INVITE_BROWSER",
                        ["nonce"] = "."
                    })
                })
            end
        end
    
        StarterGui:SetCore("SendNotification", {
            Title = "No Premium",
            Text = "You must have BDH Premium to use Premium farm. Buy it from our Discord!",
            Duration = 15,
            Callback = bindable,
            Button1 = "Okay",
            Button2 = "Join Discord",
        })

        --Close MoreInfo
        TweenService:Create(MoreInfo, TweenInfo.new(0.15), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.15)
        MoreInfo.Visible = false
    end)
end


setfpscap(getgenv().fps)


--Anti-afk
PLAYER.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

--Get Discord link
GetLink.MouseButton1Down:Connect(function()
    setclipboard("https://discord.gg/GHk4tzRjDH")
end)

local settingsToggle = false
SettingsBtn.MouseButton1Down:Connect(function()
    settingsToggle = not settingsToggle

    MainFrame.Visible = not settingsToggle
    SettingsFrame.Visible = settingsToggle

    if settingsToggle == true then -- open
        --TweenService:Create(MainFrame, TweenInfo.new(0.25), {Position = MainFrame.Position - UDim2.new(1, 0, 0, 0)}):Play()
        --TweenService:Create(SettingsFrame, TweenInfo.new(0.25), {Position = SettingsFrame.Position - UDim2.new(1, 0, 0, 0)}):Play()
        SettingsText.Text = "Back"
        SettingsImage.Image = "rbxassetid://9388739304"
    elseif settingsToggle == false then
        --TweenService:Create(MainFrame, TweenInfo.new(0.25), {Position = MainFrame.Position + UDim2.new(1, 0, 0, 0)}):Play()
        --TweenService:Create(SettingsFrame, TweenInfo.new(0.25), {Position = SettingsFrame.Position + UDim2.new(1, 0, 0, 0)}):Play()
        SettingsText.Text = "Settings"
        SettingsImage.Image = "rbxassetid://8285095937"
    end
end)

--Speed increase/decrease
KnifeSpeedInc.MouseButton1Down:Connect(function()
	farmerSettingsFunctions.KnifeFarmSpeed(farmerSettings.KnifeFarmSpeed + 5)
	saveData()
end)

KnifeSpeedDec.MouseButton1Down:Connect(function()
	farmerSettingsFunctions.KnifeFarmSpeed(farmerSettings.KnifeFarmSpeed - 5)
	saveData()
end)

GunSpeedInc.MouseButton1Down:Connect(function()
	farmerSettingsFunctions.GunFarmSpeed(farmerSettings.GunFarmSpeed + 5)
	saveData()
end)

GunSpeedDec.MouseButton1Down:Connect(function()
	farmerSettingsFunctions.GunFarmSpeed(farmerSettings.GunFarmSpeed - 5)
	saveData()
end)

--Fps count
local frames = 0
RunService.RenderStepped:Connect(function(frame)
    frames += 1
end)

--Ping + fps display
task.spawn(function()
    while task.wait(1) do
        Ping.Text = math.round(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        Fps.Text = frames
        frames = 0
    end
end)

--Tooltip connection
local stillHoveringInElement = false
local toolTipTweenTime = 0.3
for uiElement, tooltipInfo in pairs(uiElements) do
	uiElement.MouseEnter:Connect(function()
		stillHoveringInElement = true
		
		--Setup tooltip
		tooltip.Title.Text = tooltipInfo.Title
		tooltip.Content.Text = tooltipInfo.Content
		
		--Cooldown before anim
		local cooldownCount = 0
		while stillHoveringInElement == true and cooldownCount < 30 do
			cooldownCount += 1
			task.wait()
		end
		
		--Setup tooltip
        tooltip.Size = UDim2.new(0, #tooltipInfo.Content * 5.5, 0, 40)
		title.TextTransparency = 1
		content.TextTransparency = 1
		title.BackgroundTransparency = 1
		content.BackgroundTransparency = 1
		tooltip.Visible = true
		
		--Tooltip animation
		TweenService:Create(title, TweenInfo.new(toolTipTweenTime * 1.5), {TextTransparency = 0}):Play()
		TweenService:Create(content, TweenInfo.new(toolTipTweenTime * 1.5), {TextTransparency = 0}):Play()
		TweenService:Create(title, TweenInfo.new(toolTipTweenTime * 1.5), {BackgroundTransparency = 0.1}):Play()
		TweenService:Create(content, TweenInfo.new(toolTipTweenTime * 1.5), {BackgroundTransparency = 0.3}):Play()
		--Keep tooltip next to mouse
		while stillHoveringInElement == true do
			tooltip.Position = UDim2.new(0, MOUSE.X + 15, 0, MOUSE.Y - 5)
			task.wait()
		end
		tooltip.Visible = false
	end)

	uiElement.MouseLeave:Connect(function()
		stillHoveringInElement = false
	end)
end

--Mouse pos update bypass
LPH_JIT_MAX(function()
	RunService.Heartbeat:Connect(function()
		if mainModule.GunHold(PLAYER.Character) ~= false and getgenv().sendingMessage == false then
			if silentAim == true then
				--Get closest character
				local humanoidRootParts = {}
				for _, character in ipairs(PLAYERS_FOLDER:GetChildren()) do
					if character:FindFirstChild("HumanoidRootPart") and PLAYER.Character ~= character then
						humanoidRootParts[#humanoidRootParts + 1] = character.HumanoidRootPart
					end
				end
				local closestHumanoidRootPartInfo = getClosestPartFromArray(humanoidRootParts)
	
				--Get closest part in character
				if closestHumanoidRootPartInfo and closestHumanoidRootPartInfo.Distance < getgenv().silentAimSettings.Radius then
					--Get closest part in character
					local character = closestHumanoidRootPartInfo.Part.Parent
					local closestPartInCharInfo = getClosestPartFromArray(character:GetChildren())
					--Other info
					local fullyLoadedChar = character:FindFirstChild("FULLY_LOADED_CHAR")
					local predictedPosition = closestPartInCharInfo.Part.Position + closestHumanoidRootPartInfo.Part.Velocity * 0.102421
	
					if fullyLoadedChar then-- Check if character is loaded
						local randomValue = math.random(1, 100)
						--More info if the character is loaded
						local humanoid = character:FindFirstChild("Humanoid")
						local bodyEffects = character.BodyEffects
	
						if silentAimWhitelistCheck(character, bodyEffects) == false then -- Whitelist checks
							predictedPosition = MOUSE.Hit.p
						else
							if humanoid and humanoid.FloorMaterial == Enum.Material.Air then -- Jumping
								if randomValue > getgenv().silentAimSettings.JumpingHitChance then -- % chance to not hit airshot
									predictedPosition = MOUSE.Hit.p
								end
							else -- Not jumping
								if randomValue > getgenv().silentAimSettings.WalkingHitChance then -- % chance to not hit groundshot
									predictedPosition = MOUSE.Hit.p
								end
							end
						end
					end
	
					MAIN_EVENT:FireServer("UpdateMousePos", predictedPosition)
				else
					MAIN_EVENT:FireServer("UpdateMousePos", MOUSE.Hit.p)
				end
			elseif silentAim == false then
				MAIN_EVENT:FireServer("UpdateMousePos", MOUSE.Hit.p)
			end
		end
	end)
end)();



--Auto-unarrest
local JAIL = INFORMATION:WaitForChild("Jail")
print("player jail value found")
JAIL.Changed:Connect(function()
	if tonumber(JAIL.Value) > 0 then
		print("jailed")

		--Get farm function
		local farmFunction
		if gunFarm == true then
			gunFarm = false
			farmFunction = gunFarmFunction
		elseif knifeFarm == true then
			knifeFarm = false
			farmFunction = knifeFarmFunction
		end

		--Buy key
		local key = PLAYER.Backpack:FindFirstChild("[Key]") or PLAYER.Character:FindFirstChild("[Key]")
		while not key do
			PLAYER.Character.HumanoidRootPart.CFrame = CFrame.new(SHOP["[Key] - $133"].Head.Position + Vector3.new(0, 3, 0))
			fireclickdetector(SHOP["[Key] - $133"].ClickDetector)
			task.wait(1)
			key = PLAYER.Backpack:FindFirstChild("[Key]") or PLAYER.Character:FindFirstChild("[Key]")
		end

	--Use key until free
	while tonumber(JAIL.Value) > 0 do
    	task.wait(1)
    	if key and key.Parent then
        	key.Parent = PLAYER.Character
    	else
        	key = PLAYER.Backpack:FindFirstChild("[Key]") or PLAYER.Character:FindFirstChild("[Key]")
    	end
	end


		--Start farming again
		farmFunction()
	end
end)


--Character appearance loaded
local function characterAppearanceLoaded(character, player)
	if player ~= PLAYER then
		print("died")

		--Get farm function
		local farmFunction
		if gunFarm == true then
			gunFarm = false
			farmFunction = gunFarmFunction
		elseif knifeFarm == true then
			knifeFarm = false
			farmFunction = knifeFarmFunction
		end

		player.CharacterAdded:Wait()

		--Start farming again
		farmFunction()
	else
		character.Humanoid.Died:Connect(function()
			print("died")

			--Get farm function
			local farmFunction
			if gunFarm == true then
				gunFarm = false
				farmFunction = gunFarmFunction
			elseif knifeFarm == true then
				knifeFarm = false
				farmFunction = knifeFarmFunction
			end

			player.CharacterAdded:Wait()

			--Start farming again
			farmFunction()
		end)
	end
end



--Incase players joined before script ran
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(function()
		setupPlayer(player)
	end)
end


--Player added connection
Players.PlayerAdded:Connect(setupPlayer)
UserSettings().GameSettings.MasterVolume = 0
knifeFarmFunction()


