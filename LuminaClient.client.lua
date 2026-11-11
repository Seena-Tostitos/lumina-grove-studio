local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local remotes = ReplicatedStorage:WaitForChild("LuminaRemotes")
local stateEvent = remotes:WaitForChild("State")
local openEvent = remotes:WaitForChild("Open")
local actionEvent = remotes:WaitForChild("Action")

local gui = Instance.new("ScreenGui")
gui.Name = "LuminaHud"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = parent
end

local top = Instance.new("Frame")
top.Name = "Top"
top.BackgroundColor3 = Color3.fromRGB(26, 33, 28)
top.BorderSizePixel = 0
top.Position = UDim2.fromOffset(16, 16)
top.Size = UDim2.new(1, -32, 0, 92)
top.Parent = gui
corner(top, 16)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(232, 239, 233)
title.Position = UDim2.fromOffset(16, 10)
title.Size = UDim2.new(0.55, 0, 0, 28)
title.Text = "Lumina Grove"
title.Parent = top

local purse = Instance.new("TextLabel")
purse.BackgroundTransparency = 1
purse.Font = Enum.Font.GothamMedium
purse.TextSize = 16
purse.TextXAlignment = Enum.TextXAlignment.Right
purse.TextColor3 = Color3.fromRGB(215, 227, 216)
purse.Position = UDim2.new(0.45, 0, 0, 12)
purse.Size = UDim2.new(0.55, -16, 0, 24)
purse.Text = "0 embers"
purse.Parent = top

local quest = Instance.new("TextButton")
quest.Name = "Quest"
quest.BackgroundColor3 = Color3.fromRGB(16, 20, 18)
quest.AutoButtonColor = true
quest.Font = Enum.Font.GothamMedium
quest.TextSize = 16
quest.TextXAlignment = Enum.TextXAlignment.Left
quest.TextColor3 = Color3.fromRGB(232, 239, 233)
quest.Position = UDim2.fromOffset(16, 46)
quest.Size = UDim2.new(1, -32, 0, 34)
quest.Text = "  Loading the deed"
quest.Parent = top
corner(quest, 8)
quest.MouseButton1Click:Connect(function()
	actionEvent:FireServer("turnin")
end)

local notice = Instance.new("TextLabel")
notice.BackgroundColor3 = Color3.fromRGB(215, 227, 216)
notice.TextColor3 = Color3.fromRGB(18, 24, 22)
notice.Font = Enum.Font.GothamMedium
notice.TextSize = 16
notice.BackgroundTransparency = 1
notice.TextTransparency = 1
notice.AnchorPoint = Vector2.new(0.5, 1)
notice.Position = UDim2.new(0.5, 0, 1, -24)
notice.Size = UDim2.new(0.8, 0, 0, 36)
notice.Text = ""
notice.Parent = gui
corner(notice, 8)

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Visible = false
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.fromScale(0.5, 0.55)
panel.Size = UDim2.fromOffset(420, 460)
panel.BackgroundColor3 = Color3.fromRGB(26, 33, 28)
panel.BorderSizePixel = 0
panel.Parent = gui
corner(panel, 18)

local panelTitle = Instance.new("TextLabel")
panelTitle.BackgroundTransparency = 1
panelTitle.Font = Enum.Font.GothamBold
panelTitle.TextSize = 20
panelTitle.TextXAlignment = Enum.TextXAlignment.Left
panelTitle.TextColor3 = Color3.fromRGB(232, 239, 233)
panelTitle.Position = UDim2.fromOffset(16, 12)
panelTitle.Size = UDim2.new(1, -120, 0, 28)
panelTitle.Text = "Shop"
panelTitle.Parent = panel

local close = Instance.new("TextButton")
close.Text = "Close"
close.Font = Enum.Font.GothamMedium
close.TextSize = 16
close.BackgroundColor3 = Color3.fromRGB(36, 48, 42)
close.TextColor3 = Color3.fromRGB(232, 239, 233)
close.Size = UDim2.fromOffset(80, 32)
close.Position = UDim2.new(1, -96, 0, 12)
close.Parent = panel
corner(close, 8)
close.MouseButton1Click:Connect(function()
	panel.Visible = false
end)

local list = Instance.new("ScrollingFrame")
list.BackgroundTransparency = 1
list.Position = UDim2.fromOffset(12, 56)
list.Size = UDim2.new(1, -24, 1, -68)
list.CanvasSize = UDim2.fromOffset(0, 0)
list.ScrollBarThickness = 6
list.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.Parent = list
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	list.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 8)
end)

local openPayload

local function drawOptions(payload)
	openPayload = payload
	panelTitle.Text = payload.title or "Lumina"
	for _, child in ipairs(list:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	for _, option in ipairs(payload.options or {}) do
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, -8, 0, 52)
		button.BackgroundColor3 = Color3.fromRGB(16, 20, 18)
		button.TextColor3 = Color3.fromRGB(232, 239, 233)
		button.Font = Enum.Font.GothamMedium
		button.TextSize = 16
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.Text = "  " .. option.label .. "    " .. (option.detail or "")
		button.AutoButtonColor = option.enabled ~= false
		button.Active = option.enabled ~= false
		if option.enabled == false then
			button.TextColor3 = Color3.fromRGB(122, 138, 128)
		end
		button.Parent = list
		corner(button, 8)
		button.MouseButton1Click:Connect(function()
			if option.enabled == false then
				return
			end
			if payload.mode == "seeds" then
				actionEvent:FireServer("seed", payload.plot, option.id)
			else
				actionEvent:FireServer("buy", option.id)
			end
			panel.Visible = false
		end)
	end
	if #(payload.options or {}) == 0 then
		local empty = Instance.new("TextButton")
		empty.Size = UDim2.new(1, -8, 0, 52)
		empty.BackgroundTransparency = 1
		empty.Text = "Nothing here yet. Forage the thicket."
		empty.TextColor3 = Color3.fromRGB(154, 171, 160)
		empty.Font = Enum.Font.GothamMedium
		empty.TextSize = 16
		empty.Parent = list
	end
	panel.Visible = true
end

local lastNotice = ""
stateEvent.OnClientEvent:Connect(function(payload)
	if type(payload) ~= "table" then
		return
	end
	title.Text = "Lumina Grove  ·  " .. (payload.titleName or "Deed holder")
	local surge = payload.surge and "   SURGE" or ""
	purse.Text = tostring(payload.embers or 0) .. " embers    " .. tostring(payload.shards or 0) .. " shards" .. surge
	local ready = payload.met and "Turn in  ·  " or ""
	quest.Text = "  " .. ready .. (payload.giver or "") .. "  ·  " .. (payload.quest or "") .. "  " .. tostring(payload.current or 0) .. "/" .. tostring(payload.need or 0)
	if payload.notice and payload.notice ~= lastNotice then
		lastNotice = payload.notice
		notice.Text = payload.notice
		notice.BackgroundTransparency = 0
		notice.TextTransparency = 0
		task.delay(2.6, function()
			if notice.Text == payload.notice then
				notice.BackgroundTransparency = 1
				notice.TextTransparency = 1
			end
		end)
	end
end)

openEvent.OnClientEvent:Connect(drawOptions)
