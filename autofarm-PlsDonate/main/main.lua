--[[
	This property is protected.
	You are not allowed to claim this as your own.
	Removal of initial credits to the authors is prohibited.
]]

if hookmetamethod and typeof(hookmetamethod) == 'function' then
	local oldHook
	oldHook = hookmetamethod(game, "__namecall", function(self, ...)
		if getnamecallmethod() == "IsVoiceEnabledForUserIdAsync" then
			return true
		end
		return oldHook(self, ...)
	end)
end
repeat
	task.wait()
until game:IsLoaded()

  --Stops script if on a different game
if game.PlaceId ~= 8737602449 and game.PlaceId ~= 8943844393 then
	return
end

local xspin = 0

if getgenv().loadedRR then
	return
else
	getgenv().loadedRR = true
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/CF-Trail/random/main/hook/hookwscripts.lua"))()
task.wait()
  --Anti-AFK
local Players = game:GetService("Players")
Players.LocalPlayer:Kick('unsupported executor')
local connections = getconnections or get_signal_cons or nil
task.spawn(function()
	if connections then
		for a, b in next, connections(game:GetService('Players').LocalPlayer.Idled) do
			b:Disable()
		end
	else
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:Connect(function()
			vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			wait(1)
			vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		end)
	end
end)
  
  --Variables
local unclaimed = {}
local counter = 0
local donation, boothText, spamming, hopTimer, vcEnabled
local signPass = false
local errCount = 0
local booths = {
	["1"] = "72, 3, 36",
	["2"] = "83, 3, 161",
	["3"] = "11, 3, 36",
	["4"] = "100, 3, 59",
	["5"] = "72, 3, 166",
	["6"] = "2, 3, 42",
	["7"] = "-9, 3, 52",
	["8"] = "10, 3, 166",
	["9"] = "-17, 3, 60",
	["10"] = "35, 3, 173",
	["11"] = "24, 3, 170",
	["12"] = "48, 3, 29",
	["13"] = "24, 3, 33",
	["14"] = "101, 3, 142",
	["15"] = "-18, 3, 142",
	["16"] = "60, 3, 33",
	["17"] = "35, 3, 29",
	["18"] = "0, 3, 160",
	["19"] = "48, 3, 173",
	["20"] = "61, 3, 170",
	["21"] = "91, 3, 151",
	["22"] = "-24, 3, 72",
	["23"] = "-28, 3, 88",
	["24"] = "92, 3, 51",
	["25"] = "-28, 3, 112",
	["26"] = "-24, 3, 129",
	["27"] = "83, 3, 42",
	["28"] = "-8, 3, 151"
}
local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request
local httpservice = game:GetService('HttpService')
queueonteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/scowscripts/plsdonateautofarm/main/autofarm-PlsDonate/main/main.lua'))()")
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/CF-Trail/tzechco-PlsDonateAutofarmBackup/main/UI"))()
local function claimGifts()
	pcall(function()
		Players.LocalPlayer:WaitForChild("PlayerGui")
		local guipath = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")
		firesignal(guipath.GiftAlert.Buttons.Close["Activated"])
		local count = require(game:GetService('ReplicatedStorage').Remotes).Event("UnclaimedDonationCount"):InvokeServer()
		while count == nil do
			task.wait(5)
			count = require(game:GetService('ReplicatedStorage').Remotes).Event("UnclaimedDonationCount"):InvokeServer()
		end
		if count then
			local ud = {}
			for i = 1, count do
				table.insert(ud, i)
			end
			if #ud > 0 then
				firesignal(guipath.Gift.Buttons.Inbox["Activated"])
				Players.LocalPlayer.ClaimDonation:InvokeServer(ud)
				task.wait(.5)
				firesignal(guipath.GiftInbox.Buttons.Close["Activated"])
				task.wait(.5)
				firesignal(guipath.Gift.Buttons.Close["Activated"])
			end
		end
	end)
end
task.spawn(claimGifts)
getgenv().settings = {}
  --Load Settings
if isfile("plsdonateautofarm.txt") then
	local sl, er = pcall(function()
		getgenv().settings = httpservice:JSONDecode(readfile('plsdonateautofarm.txt'))
	end)
	if er ~= nil then
		task.spawn(function()
			errMsg = Instance.new("Hint")
			errMsg.Parent = game:GetService('CoreGui')
			errMsg.Text = tostring("Settings reset due to error: " .. er)
			task.wait(15)
			errMsg:Destroy()
		end)
		delfile("plsdonateautofarm.txt")
	end
end
local sNames = {
	"textUpdateToggle",
    "pingOnDonation",
    "MinimumRobuxForPing"
	"textUpdateDelay",
	"serverHopToggle",
	"serverHopDelay",
	"hexBox",
	"goalBox",
	"webhookToggle",
	"webhookBox",
	"danceChoice",
	"thanksMessage",
	"signToggle",
	"customBoothText",
	"signUpdateToggle",
	"signText",
	"signHexBox",
	"autoThanks",
	"autoBeg",
	"begMessage",
	"begDelay",
	"fpsLimit",
	"render",
	"thanksDelay",
	"vcServer",
	'donationJump',
	'AlternativeHop',
	'autoNearReply',
	'boothPosition',
	'standingPosition',
	'AnonymousMode',
	'boothSwitcher',
	'serverHopAfterDonation',
	'jumpsPerRobux',
	'staffHopA',
	'spinSet',
	'boothTop',
	'spinSpeedMultiplier',
	'webhookAfterSH',
	'minimumDonated'
}

local positionX = workspace:WaitForChild('Boomboxes'):WaitForChild('Spawn')

local sValues = {
	true,
    false,
    1,
	30,
	true,
	15,
	"#32CD32",
	5,
	false,
	"",
	"Disabled",
	{
		"Thank you",
		"Thanks!",
		"ty :)",
		"tysm!"
	},
	false,
	"✅ 1 ROBUX DONATED = $D JUMP ✅",
	false,
	"your text here",
	"#ffffff",
	true,
	true,
	{
		"1R$ = 1 JUMP",
		"Jumping for donations!"
	},
	300,
	60,
	false,
	3,
	true,
	true,
	false,
	false,
	3,
	'Front',
	false,
	false,
	false,
	1,
	true,
	false,
	false,
	1,
	false,
	0
}
if #getgenv().settings ~= sNames then
	for i, v in ipairs(sNames) do
		if getgenv().settings[v] == nil then
			getgenv().settings[v] = sValues[i]
		end
	end
	writefile('plsdonateautofarm.txt', httpservice:JSONEncode(getgenv().settings))
end

  --Save Settings
local settingsLock = true
local function saveSettings()
	if settingsLock == false then
		print('Settings saved.')
		writefile('plsdonateautofarm.txt', httpservice:JSONEncode(getgenv().settings))
	end
end
function serverHop()
	--local isVip = game:GetService('RobloxReplicatedStorage').GetServerType:InvokeServer()
	--if isVip == "VIPServer" then return end
	local gameId
	gameId = "8737602449"
	if vcEnabled and getgenv().settings.vcServer then
		gameId = "8943844393"
	end
	if getgenv().settings.AlternativeHop then
		math.randomseed(tick())
		local random = math.random(0, 1)
		if random == 1 then
			gameId = '8943844393'
		else
			gameId = '8737602449'
		end
	end
	local servers = {}
	local req = httprequest({
		Url = "https://games.roblox.com/v1/games/" .. gameId .. "/servers/Public?sortOrder=Desc&limit=100"
	})
	local body = httpservice:JSONDecode(req.Body)
	if body and body.data then
		for i, v in next, body.data do
			if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.playing > 19 then
				table.insert(servers, 1, v.id)
			end
		end
	end
	if #servers > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, servers[math.random(1, #servers)], Players.LocalPlayer)
	end
	game:GetService("TeleportService").TeleportInitFailed:Connect(function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, servers[math.random(1, #servers)], Players.LocalPlayer)
	end)
end
local function waitServerHop()
	task.wait(getgenv().settings.serverHopDelay * 60)
	serverHop()
end
local function hopSet()
	if hopTimer then
		task.cancel(hopTimer)
	end
	if getgenv().settings.serverHopToggle then
		hopTimer = task.spawn(waitServerHop)
	end
end

local function playerChecker(player)
	if not getgenv().settings.staffHopA then
		return
	end
	pcall(function()
		if player:GetRankInGroup(12121240) >= 254 then
			serverHop()
		end
	end)
end
  
  --Function to fix slider
local sliderInProgress = false;
local function slider(value, whichSlider)
	if sliderInProgress then
		return
	end
	sliderInProgress = true
	task.wait(5)
	if getgenv().settings[whichSlider] == value then
		saveSettings()
		sliderInProgress = false;
		if whichSlider == "serverHopDelay" then
			hopSet()
		end
	else
		sliderInProgress = false;
		return slider(getgenv().settings[whichSlider], whichSlider)
	end
end
  
  --Booth update function
local function update()
	local text
	local current = Players.LocalPlayer.leaderstats.Raised.Value
	local goal = current + tonumber(getgenv().settings.goalBox)
	if goal == 420 or goal == 425 then
		goal = goal + 10
	end
	if current == 420 or current == 425 then
		current = current + 10
	end
	if goal > 999 then
		if tonumber(getgenv().settings.goalBox) < 10 then
			goal = string.format("%.2fk", (current + 10) / 10 ^ 3)
		else
			goal = string.format("%.2fk", (goal) / 10 ^ 3)
		end
	end
	if current > 999 then
		current = string.format("%.2fk", current / 10 ^ 3)
	end
	if getgenv().settings.textUpdateToggle and getgenv().settings.customBoothText then
		text = string.gsub(getgenv().settings.customBoothText, "$C", current)
		text = string.gsub (text, "$G", goal)
		text = string.gsub(text, '$D', tostring(getgenv().settings.jumpsPerRobux))
		boothText = tostring('<font color="' .. getgenv().settings.hexBox .. '">' .. text .. '</font>')
		  --Updates the booth text
		local myBooth = Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI" .. unclaimed[1]))
		if myBooth.Sign.TextLabel.Text ~= boothText then
			if string.find(myBooth.Sign.TextLabel.Text, "# #") or string.find(myBooth.Sign.TextLabel.Text, "##") then
				require(game:GetService("ReplicatedStorage").Remotes).Event("SetBoothText"):FireServer("your text here", "booth")
				task.wait(3)
			end
			require(game:GetService('ReplicatedStorage').Remotes).Event("SetBoothText"):FireServer(boothText, "booth")
			task.wait(3)
		end
	end
	if getgenv().settings.signToggle and getgenv().settings.signUpdateToggle and getgenv().settings.signText and signPass then
		local currentSign = game:GetService('Players').LocalPlayer.Character.DonateSign.TextSign.SurfaceGui.TextLabel.Text
		text = string.gsub(getgenv().settings.signText, "$C", current)
		text = string.gsub (text, "$G", goal)
		signText = tostring('<font color="' .. getgenv().settings.signHexBox .. '">' .. text .. '</font>')
		if currentSign ~= signText then
			if string.find(currentSign, "# #") or string.find(currentSign, "##") then
				require(game:GetService('ReplicatedStorage').Remotes).Event("SetBoothText"):FireServer("your text here", "sign")
				task.wait(3)
			end
			require(game:GetService('ReplicatedStorage').Remotes).Event("SetBoothText"):FireServer(signText, "sign")
		end
	end
end
local function begging()
	while getgenv().settings.autoBeg do
		game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getgenv().settings.begMessage[math.random(#getgenv().settings.begMessage)], "All")
		task.wait(getgenv().settings.begDelay)
	end
end

local function webhook(msg)
	if getgenv().settings.webhookBox:gsub(' ', '') == '' then
		return
	end
	pcall(function()
		httprequest({
			Url = getgenv().settings.webhookBox,
			Body = httpservice:JSONEncode({
				["content"] = msg
			}),
			Method = "POST",
			Headers = {
				["content-type"] = "application/json"
			}
		})
	end)
end

  --GUI
local Window = library:AddWindow("pls donate autofarm",
  {
	main_color = Color3.fromRGB(80, 80, 80),
	min_size = Vector2.new(373, 433),
	toggle_key = Enum.KeyCode.RightShift,
})

local boothTab = Window:AddTab("Booth")
local signTab = Window:AddTab("Sign")
local chatTab = Window:AddTab("Chat")
local webhookTab = Window:AddTab("Webhook")
local serverHopTab = Window:AddTab("Server")
local otherTab = Window:AddTab("Other")
local bThemes = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("BoothSettings"):WaitForChild("ScrollingFrame"):WaitForChild("ChangeTheme"):WaitForChild("Themes")
  
  --Booth Settings
local textUpdateToggle = boothTab:AddSwitch("Text Update", function(bool)
	if settingsLock then
		return
	end
	getgenv().settings.textUpdateToggle = bool
	saveSettings()
	if bool then
		update()
	end
end)
textUpdateToggle:Set(getgenv().settings.textUpdateToggle)
local textUpdateDelay = boothTab:AddSlider("Text Update Delay (S)", function(x)
	if settingsLock then
		return
	end
	getgenv().settings.textUpdateDelay = x
	coroutine.wrap(slider)(getgenv().settings.textUpdateDelay, "textUpdateDelay")
end,
  {
	["min"] = 0,
	["max"] = 120
})
textUpdateDelay:Set((getgenv().settings.textUpdateDelay / 120) * 100)
boothTab:AddLabel("Text Color:")
local hexBox = boothTab:AddTextBox("Hex Codes Only", function(text)
	if settingsLock then
		return
	end
	local success = pcall(function()
		return Color3.fromHex(text)
	end)
	if success and string.find(text, "#") then
		getgenv().settings.hexBox = text
		saveSettings()
		update()
	end
end,
  {
	["clear"] = false
})
hexBox.Text = getgenv().settings.hexBox
boothTab:AddLabel("Goal Increase:")
local goalBox = boothTab:AddTextBox("Numbers Only", function(text)
	if tonumber(text) then
		getgenv().settings.goalBox = tonumber(text)
		saveSettings()
		update()
	end
end,
  {
	["clear"] = false
})
goalBox.Text = getgenv().settings.goalBox
boothTab:AddLabel("Custom Booth Text:")
local customBoothText = boothTab:AddConsole({
	["y"] = 50,
	["source"] = "",
})
boothTab:AddLabel("Standing Position:")
local standingPos = boothTab:AddDropdown("[ " .. getgenv().settings.standingPosition .. " ]", function(t)
	getgenv().settings.standingPosition = t
	saveSettings()
	if t == "Front" then
		getgenv().settings.boothPosition = 3
	elseif t == "Left" then
		getgenv().settings.boothPosition = -6
	elseif t == "Right" then
		getgenv().settings.boothPosition = 6
	else
		getgenv().settings.boothPosition = -5.5
	end
	saveSettings()
end)
standingPos:Add('Front')
standingPos:Add('Left')
standingPos:Add('Right')
standingPos:Add('Behind')
customBoothText:Set(getgenv().settings.customBoothText)
boothTab:AddButton("Save", function()
	if #customBoothText:Get() > 221 then
		return customBoothText:Set("221 Character Limit")
	end
	if settingsLock then
		return
	end
	if customBoothText:Get() then
		getgenv().settings.customBoothText = customBoothText:Get()
		saveSettings()
		update()
	end
end)
local helpLabel = boothTab:AddLabel("$C = Current, $G = Goal, $D = Robux per jump, 221 Character Limit")
helpLabel.TextSize = 9
  --Sign Settings
pcall(function()
	if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Players.LocalPlayer.UserId, 28460459) then
		signPass = true
	end
end)
if signPass then
	local signToggle = signTab:AddSwitch("Equip Sign", function(bool)
		getgenv().settings.signToggle = bool
		saveSettings()
		if bool then
			Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(Players.LocalPlayer.Backpack:FindFirstChild("DonateSign"))
		else
			Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools(Players.LocalPlayer.Backpack:FindFirstChild("DonateSign"))
		end
	end)
	signToggle:Set(getgenv().settings.signToggle)
	local signUpdateToggle = signTab:AddSwitch("Text Update", function(bool)
		if settingsLock then
			return
		end
		getgenv().settings.signUpdateToggle = bool
		saveSettings()
		if bool then
			update()
		end
	end)
	signUpdateToggle:Set(getgenv().settings.signUpdateToggle)
	signTab:AddLabel("Text Color:")
	local signHexBox = signTab:AddTextBox("Hex Codes Only", function(text)
		if settingsLock then
			return
		end
		local success = pcall(function()
			return Color3.fromHex(text)
		end)
		if success and string.find(text, "#") then
			getgenv().settings.signHexBox = text
			saveSettings()
			if getgenv().settings.signUpdateToggle and getgenv().settings.signText then
				update()
			end
		end
	end,
	  {
		["clear"] = false
	})
	signHexBox.Text = getgenv().settings.signHexBox
	signTab:AddLabel("Sign Text:")
	local signText = signTab:AddConsole({
		["y"] = 50,
		["source"] = "",
	})
	signText:Set(getgenv().settings.signText)
	signTab:AddButton("Save", function()
		if #signText:Get() > 221 then
			return signText:Set("221 Character Limit")
		end
		if settingsLock then
			return
		end
		if signText:Get() then
			getgenv().settings.signText = signText:Get()
			saveSettings()
			update()
		end
	end)
	local signHelpLabel = signTab:AddLabel("$C = Current, $G = Goal, 221 Character Limit")
	signHelpLabel.TextSize = 9
	signHelpLabel.TextXAlignment = Enum.TextXAlignment.Center
else
	signTab:AddLabel('Requires Sign Gamepass')
end
  
  --Chat Settings
local autoThanks = chatTab:AddSwitch("Auto Thank You", function(bool)
	getgenv().settings.autoThanks = bool
	saveSettings()
end)
autoThanks:Set(getgenv().settings.autoThanks)
local autoBeg = chatTab:AddSwitch("Auto Beg", function(bool)
	if settingsLock then
		return
	end
	getgenv().settings.autoBeg = bool
	saveSettings()
	if bool then
		spamming = task.spawn(begging)
	else
		task.cancel(spamming)
	end
end)
autoBeg:Set(getgenv().settings.autoBeg)
local thanksDelay = chatTab:AddSlider("Thanks Delay (S)", function(x)
	if settingsLock then
		return
	end
	getgenv().settings.thanksDelay = x
	coroutine.wrap(slider)(getgenv().settings.thanksDelay, "thanksDelay")
end,
  {
	["min"] = 1,
	["max"] = 120
})
thanksDelay:Set((getgenv().settings.thanksDelay / 120) * 100)
local begDelay = chatTab:AddSlider("Begging Delay (S)", function(x)
	if settingsLock then
		return
	end
	getgenv().settings.begDelay = x
	coroutine.wrap(slider)(getgenv().settings.begDelay, "begDelay")
end,
  {
	["min"] = 1,
	["max"] = 300
})
begDelay:Set((getgenv().settings.begDelay / 300) * 100)
local tym = chatTab:AddFolder("Thank You Messages:")
local thanksMessage = tym:AddConsole({
	["y"] = 170,
	["source"] = "",
})
local full = ''
for i, v in ipairs(getgenv().settings.thanksMessage) do
	full = full .. v .. "\n"
end
thanksMessage:Set(full)
tym:AddButton("Save", function()
	local split = {}
	for newline in string.gmatch(thanksMessage:Get(), "[^\n]+") do
		table.insert(split, newline)
	end
	getgenv().settings.thanksMessage = split
	saveSettings()
end)
local bm = chatTab:AddFolder("Begging Messages:")
local begMessage = bm:AddConsole({
	["y"] = 170,
	["source"] = "",
})
local bfull = ''
for i, v in ipairs(getgenv().settings.begMessage) do
	bfull = bfull .. v .. "\n"
end
begMessage:Set(bfull)
bm:AddButton("Save", function()
	local bsplit = {}
	for newline in string.gmatch(begMessage:Get(), "[^\n]+") do
		table.insert(bsplit, newline)
	end
	getgenv().settings.begMessage = bsplit
	saveSettings()
end)
  
  
  --Webhook Settings
local webhookToggle = webhookTab:AddSwitch("Discord Webhook Notifications", function(bool)
	getgenv().settings.webhookToggle = bool
	saveSettings()
end)
webhookToggle:Set(getgenv().settings.webhookToggle)

local serverHopDonation = webhookTab:AddSwitch("Notification after serverhop", function(bool)
	getgenv().settings.webhookAfterSH = bool
	saveSettings()
end)

serverHopDonation:Set(getgenv().settings.webhookAfterSH)

local serverHopDonation = webhookTab:AddSwitch("Ping @everyone on Donation", function(bool)
	getgenv().settings.pingOnDonation = bool
	saveSettings()
end)

serverHopDonation:Set(getgenv().settings.pingOnDonation)

local MinimumRobuxForPingSlider = webhookTab:AddSlider("Minimum Robux For Ping", function(x)
	if settingsLock then
		return
	end
	getgenv().settings.MinimumRobuxForPing = x
	coroutine.wrap(slider)(getgenv().settings.MinimumRobuxForPing, "MinimumRobuxForPing")
end,
  {
	["min"] = 1,
	["max"] = 1000
})

MinimumRobuxForPing:Set((getgenv().settings.begDelay / 300) * 100)

local webhookBox = webhookTab:AddTextBox("Webhook URL", function(text)
	if string.find(text, "api/") then
		getgenv().settings.webhookBox = text;
		saveSettings()
	end
end,
  {
	["clear"] = false
})
webhookBox.Text = getgenv().settings.webhookBox
webhookTab:AddLabel('Press Enter to Save')
webhookTab:AddButton("Test", function()
	if getgenv().settings.webhookBox then
		webhook("webhook works | dotgg")
	end
end)
  
  
  --Server Hop Settings
pcall(function()
	if game:GetService("VoiceChatService"):IsVoiceEnabledForUserIdAsync(Players.LocalPlayer.UserId) then
		vcEnabled = true
	end
end)
local serverHopToggle = serverHopTab:AddSwitch("Auto Server Hop", function(bool)
	if settingsLock then
		return
	end
	getgenv().settings.serverHopToggle = bool
	hopSet()
	saveSettings()
end)

serverHopToggle:Set(getgenv().settings.serverHopToggle)

if vcEnabled then
	local vcToggle = serverHopTab:AddSwitch("Voice Chat Servers", function(bool)
		if settingsLock then
			return
		end
		getgenv().settings.vcServer = bool
		saveSettings()
	end)
	vcToggle:Set(getgenv().settings.vcServer)
end
local alhop = serverHopTab:AddSwitch("Random Hop", function(bool)
	getgenv().settings.AlternativeHop = bool
	saveSettings()
end)

local sHopSwitch = serverHopTab:AddSwitch('ServerHop after donation', function(bool)
	getgenv().settings.serverHopAfterDonation = bool
	saveSettings()
end)

sHopSwitch:Set(getgenv().settings.serverHopAfterDonation)

local staffHopSwitch = serverHopTab:AddSwitch('ServerHop if Staff', function(bool)
	getgenv().settings.staffHopA = bool
	saveSettings()
end)

staffHopSwitch:Set(getgenv().settings.staffHopA)

alhop:Set(getgenv().settings.AlternativeHop)
serverHopTab:AddButton("Server Hop", function()
	serverHop()
end)

local serverHopMinAmount = serverHopTab:AddTextBox("Minimum donated amount", function(text)
	getgenv().settings.minimumDonated = tonumber(text) or 0
end,
  {
	["clear"] = false
})

local serverHopDelay = serverHopTab:AddSlider("Server Hop Delay (M)", function(x)
	if settingsLock then
		return
	end
	getgenv().settings.serverHopDelay = x
	coroutine.wrap(slider)(getgenv().settings.serverHopDelay, "serverHopDelay")
end,
  {
	["min"] = 1,
	["max"] = 120
})

serverHopTab:AddLabel("Server hop timer resets after donation")

serverHopDelay:Set((getgenv().settings.serverHopDelay / 120) * 100)
  --Other tab
otherTab:AddLabel('Dance:')
local danceDropdown = otherTab:AddDropdown("[ " .. getgenv().settings.danceChoice .. " ]", function(object)
	if settingsLock then
		return
	end
	getgenv().settings.danceChoice = object
	saveSettings()
	if object == "Disabled" then
		Players:Chat("/e wave")
	elseif object == "1" then
		Players:Chat("/e dance")
	else
		Players:Chat("/e dance" .. object)
	end
end)

danceDropdown:Add("Disabled")
danceDropdown:Add("1")
danceDropdown:Add("2")
danceDropdown:Add("3")
local render = otherTab:AddSwitch("Disable Rendering", function(bool)
	getgenv().settings.render = bool
	saveSettings()
	if bool then
		game:GetService("RunService"):Set3dRenderingEnabled(false)
	else
		game:GetService("RunService"):Set3dRenderingEnabled(true)
	end
end)
local jumpswitch = otherTab:AddSwitch("Donation Jump", function(bool)
	getgenv().settings.donationJump = bool
	saveSettings()
end)
jumpswitch:Set(getgenv().settings.donationJump)
local autoReply = otherTab:AddSwitch("Auto Reply [Experimental]", function(bool)
	getgenv().settings.autoNearReply = bool
	saveSettings()
end)
autoReply:Set(getgenv().settings.autoNearReply)
local anMode = otherTab:AddSwitch('Anonymous Mode', function(bool)
	getgenv().settings.AnonymousMode = bool
	if getgenv().settings.AnonymousMode then
		require(game:GetService('ReplicatedStorage').Remotes).Event('SetDonatedVisibility'):FireServer(false)
	else
		require(game:GetService('ReplicatedStorage').Remotes).Event('SetDonatedVisibility'):FireServer(true)
	end
	saveSettings()
end)
anMode:Set(getgenv().settings.AnonymousMode)

if getgenv().settings.AnonymousMode then
	require(game:GetService('ReplicatedStorage').Remotes).Event('SetDonatedVisibility'):FireServer(false)
end

task.spawn(function()
	while task.wait(1) do
		for i, v in next, Players:GetPlayers() do
			playerChecker(v)
			task.wait()
		end
	end
end)

local spinToggle = otherTab:AddSwitch('Spin [1R$ = +1 speed]', function(bool)
	getgenv().settings.spinSet = bool
	if getgenv().settings.spinSet then
		local root = Players.LocalPlayer.Character.Humanoid.RootPart
		local Spin = Instance.new("BodyAngularVelocity")
		Spin.Name = "Spin"
		Spin.Parent = root
		Spin.MaxTorque = Vector3.new(0, math.huge, 0)
		Spin.AngularVelocity = Vector3.new(0, 0.25 * settings.spinSpeedMultiplier, 0)
	elseif not getgenv().settings.spinSet and Players.LocalPlayer.Character.Humanoid.RootPart:FindFirstChild('Spin') then
		Players.LocalPlayer.Character.Humanoid.RootPart.Spin:Destroy()
	end
	saveSettings()
end)


local jumpsPerRB = otherTab:AddSlider("Jumps per robux", function(x)
	if settingsLock then
		return
	end
	getgenv().settings.jumpsPerRobux = x
	saveSettings()
	coroutine.wrap(slider)(getgenv().settings.jumpsPerRobux, "jumpsPerRobux")
end,
  {
	["min"] = 0,
	["max"] = 100
})

local spinMultiplier = otherTab:AddSlider("Spin speed multiplier", function(x)
	if settingsLock then
		return
	end
	getgenv().settings.spinSpeedMultiplier = x
	saveSettings()
	coroutine.wrap(slider)(getgenv().settings.spinSpeedMultiplier, "spinSpeedMultiplier")
end,
  {
	["min"] = 1,
	["max"] = 3
})

spinMultiplier:Set(getgenv().settings.spinSpeedMultiplier)
jumpsPerRB:Set(getgenv().settings.jumpsPerRobux)
spinToggle:Set(getgenv().settings.spinSet)

if setfpscap and type(setfpscap) == "function" then
	local fpsLimit = otherTab:AddSlider("FPS Limit", function(x)
		if settingsLock then
			return
		end
		getgenv().settings.fpsLimit = x
		setfpscap(x)
		coroutine.wrap(slider)(getgenv().settings.fpsLimit, "fpsLimit")
	end,
	  {
		["min"] = 1,
		["max"] = 60
	})
	fpsLimit:Set((getgenv().settings.fpsLimit / 60) * 100)
	setfpscap(getgenv().settings.fpsLimit)
end

render:Set(getgenv().settings.render)

boothTab:Show()
library:FormatWindows()
settingsLock = false
  
  --Finds unclaimed booths
local function findUnclaimed()
	for i, v in pairs(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:GetChildren()) do
		if (v.Details.Owner.Text == "unclaimed") then
			table.insert(unclaimed, tonumber(string.match(tostring(v), "%d+")))
		end
	end
end
if not pcall(findUnclaimed) then
	serverHop()
end
local claimCount = #unclaimed
  --Claim booth function
local function boothclaim()
	require(game:GetService('ReplicatedStorage').Remotes).Event("ClaimBooth"):InvokeServer(unclaimed[1])
	if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI" .. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
		task.wait(1)
		if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI" .. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
			error()
		end
	end
end
  --Checks if booth claim fails
while not pcall(boothclaim) do
	if errCount >= claimCount then
		serverHop()
	end
	table.remove(unclaimed, 1)
	errCount = errCount + 1
end
hopSet()
local function walkToBooth()
	local theCframe
	if string.find(tostring(getgenv().settings.boothPosition), "6") then
		theCframe = CFrame.new(getgenv().settings.boothPosition, 0, 0)
	else
		theCframe = CFrame.new(0, 0, getgenv().settings.boothPosition)
	end
	local boothPos, mainPosX
	for i, v in ipairs(game:GetService("Workspace").BoothInteractions:GetChildren()) do
		if v:GetAttribute("BoothSlot") == unclaimed[1] then
			mainPosX = v.CFrame
			boothPos = v.CFrame * theCframe
			break
		end
	end
	game:GetService('VirtualInputManager'):SendKeyEvent(true, "LeftControl", false, game)
	local Controls = require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
	Controls:Disable()
	local atBooth = false
	game:GetService("Workspace").Map.Main.Bench:Destroy()
	Players.LocalPlayer.Character.Humanoid:MoveTo(boothPos.Position)
	Players.LocalPlayer.Character.Humanoid.MoveToFinished:Connect(function(reached)
		atBooth = true
	end)
	repeat
		task.wait()
	until atBooth
	Players.LocalPlayer.Character.Humanoid.RootPart.CFrame = CFrame.new(boothPos.Position)
	Controls:Enable()
	game:GetService('VirtualInputManager'):SendKeyEvent(false, "LeftControl", false, game)
	Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(40, 14, 101)))
	task.wait(0.6)
	Players:Chat('/e dance' .. getgenv().settings.danceChoice)
end
walkToBooth()
if getgenv().settings.autoBeg then
	spamming = task.spawn(begging)
end
local RaisedC = Players.LocalPlayer.leaderstats.Raised.value
Players.LocalPlayer.leaderstats.Raised.Changed:Connect(function()
	hopSet()
	xspin = ((xspin + Players.LocalPlayer.leaderstats.Raised.Value - RaisedC) / 3) * getgenv().settings.spinSpeedMultiplier
	if getgenv().settings.webhookToggle and getgenv().settings.webhookBox then
		local LogService = Game:GetService("LogService")
		local logs = LogService:GetLogHistory()
		if string.find(logs[#logs].message, Players.LocalPlayer.DisplayName) then
            if Players.LocalPlayer.leaderstats.Raised.Value - RaisedC => getgenv().settings.MinimumRobuxForPing and getgenv().settings.pingOnDonation == true then
			    webhook("||@everyone|| 💰 Tip | Amount: " .. tostring(Players.LocalPlayer.leaderstats.Raised.Value - RaisedC) .. 'R$ (after tax: ' .. tostring(math.floor((Players.LocalPlayer.leaderstats.Raised.Value - RaisedC) * 0.6)) .. 'R$) | Total: ' .. tostring(Players.LocalPlayer.leaderstats.Raised.Value) .. 'R$ | Account: ' .. Players.LocalPlayer.DisplayName .. ' (' .. Players.LocalPlayer.Name .. ') | Server Message: ' .. logs[#logs].message:gsub('', ''))
            end
            webhook("💰 Tip | Amount: " .. tostring(Players.LocalPlayer.leaderstats.Raised.Value - RaisedC) .. 'R$ (after tax: ' .. tostring(math.floor((Players.LocalPlayer.leaderstats.Raised.Value - RaisedC) * 0.6)) .. 'R$) | Total: ' .. tostring(Players.LocalPlayer.leaderstats.Raised.Value) .. 'R$ | Account: ' .. Players.LocalPlayer.DisplayName .. ' (' .. Players.LocalPlayer.Name .. ') | Server Message: ' .. logs[#logs].message:gsub('', ''))
		else
			webhook("💰 Tip | Amount: " .. tostring(Players.LocalPlayer.leaderstats.Raised.Value - RaisedC) .. 'R$ (after tax: ' .. tostring(math.floor((Players.LocalPlayer.leaderstats.Raised.Value - RaisedC) * 0.6)) .. 'R$) | Total: ' .. tostring(Players.LocalPlayer.leaderstats.Raised.Value) .. 'R$ | Account: ' .. Players.LocalPlayer.DisplayName .. ' (' .. Players.LocalPlayer.Name .. ') | Couldnt fetch server message')
		end
		--webhook("💰 Tip | Amount: " .. tostring(Players.LocalPlayer.leaderstats.Raised.Value - RaisedC) .. 'R$ (after tax: ' .. tostring(math.floor((Players.LocalPlayer.leaderstats.Raised.Value - RaisedC) * 0.6)) .. 'R$) | Total: ' .. tostring(Players.LocalPlayer.leaderstats.Raised.Value) .. 'R$ | Account: ' .. Players.LocalPlayer.DisplayName .. ' (' .. Players.LocalPlayer.Name .. ')')
	end
	if getgenv().settings.serverHopAfterDonation then
		task.spawn(function()
			serverHop()
		end)
	end
	if Players.LocalPlayer.Character.Humanoid.RootPart:FindFirstChild('Spin') and getgenv().settings.spinSet then
		local spin = Players.LocalPlayer.Character.Humanoid.RootPart:FindFirstChild('Spin')
		spin.AngularVelocity = Vector3.new(0, xspin, 0)
	end
	if getgenv().settings.donationJump and not getgenv().settings.spinSet then
		task.spawn(function()
			if getgenv().settings.jumpsPerRobux == 1 then
				for i = 1, game:GetService('Players').LocalPlayer.leaderstats.Raised.value - RaisedC do
					game:GetService('Players').LocalPlayer.Character.Humanoid:ChangeState("Jumping")
					repeat
						task.wait()
					until game:GetService('Players').LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Running
				end
			else
				for i = 1, (game:GetService('Players').LocalPlayer.leaderstats.Raised.value - RaisedC) * getgenv().settings.jumpsPerRobux do
					game:GetService('Players').LocalPlayer.Character.Humanoid:ChangeState("Jumping")
					repeat
						task.wait()
					until game:GetService('Players').LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Running
				end
			end
		end)
	end
	RaisedC = Players.LocalPlayer.leaderstats.Raised.value
	if getgenv().settings.autoThanks then
		task.spawn(function()
			task.wait(getgenv().settings.thanksDelay)
			game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getgenv().settings.thanksMessage[math.random(#getgenv().settings.thanksMessage)], "All")
		end)
	end
	task.wait(getgenv().settings.textUpdateDelay)
	update()
end)
update()

task.spawn(function()
	raisedV = nil
	task.wait(5)
	Players.LocalPlayer.CharacterRemoving:Connect(function()
		if getgenv().settings.spinSet then
			serverHop()
		end
	end)
	for i,v in next, Players:GetPlayers() do
		if v:FindFirstChild('leaderstats') and v ~= Players.LocalPlayer then
			if raisedV ~= nil then
				if v.leaderstats.Raised.Value > raisedV then
					raisedV = v.leaderstats.Raised.Value
				end
			else
				raisedV = v.leaderstats.Raised.Value
			end
		end
	end
	if raisedV < getgenv().settings.minimumDonated then
		serverHop()
	end
end)

task.spawn(function()
	while task.wait(5) do
		if (Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').RootPart) then
			local root = Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').RootPart
			if (root.Position - positionX.Position).Magnitude > 1500 or (root.Position - positionX.Position).Magnitude < -1500 then
				serverHop()
			end
		end
	end
end)

if getgenv().settings.webhookAfterSH then
	webhook('hi hello ' .. Players.LocalPlayer.DisplayName .. ' (' .. Players.LocalPlayer.Name .. ') serverhopped')
end

local msgdone = game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.OnMessageDoneFiltering
local randommsgs = {
	'yes',
	'ok',
	'alr',
	'yeah'
}
local randombotmsgs = {
	'no im not a bot',
	'why yall think im a bot :(',
	'bro im not a bot',
	'bruh shut up im a real human'
}
local messageRequest = game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest
msgdone.OnClientEvent:Connect(function(msgdata)
	local speaker = tostring(msgdata.FromSpeaker)
	local message = string.lower(msgdata.Message)
	task.wait(2 + math.random(0.4,1))
	local plrChatted = game:GetService('Players')[speaker] or nil
	if (plrChatted and plrChatted == game:GetService('Players').LocalPlayer) or getgenv().settings.autoNearReply == false or not plrChatted then
		return
	end
	pcall(function()
		local chatChar = plrChatted.Character
		if (plrChatted.Character and plrChatted.Character.Humanoid.RootPart) then
			local root = chatChar.Humanoid.RootPart
			if (root.Position - game:GetService('Players').LocalPlayer.Character.Humanoid.RootPart.Position).Magnitude < 10 then
				if message == 'hello' or message == 'hi' or message == 'sup' then
					messageRequest:FireServer("hello", 'All')
				elseif string.find(message, 'jump') then
					messageRequest:FireServer('ok', 'All')
				elseif string.find(message, '?') and not string.find(message,'bot') then
					messageRequest:FireServer('yes', 'All')
				elseif string.find(message,'bot') then
					messageRequest:FireServer('no im not', 'All')
				else
					messageRequest:FireServer(randommsgs[math.random(1, #randommsgs)], 'All')
				end
			end
		end
	end)
end)
if game:GetService("CoreGui").imgui.Windows.Window.Title.Text == "Loading" then
	game:GetService("CoreGui").imgui.Windows.Window.Title.Text = "pls donate #1 autofarm"
end
while task.wait(getgenv().settings.serverHopDelay * 60) do
	if not hopTimer then
		hopSet()
	end
end
