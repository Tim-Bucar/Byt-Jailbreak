print("v1.0.0")+
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Unload = false
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Tim-Bucar/UiLib/refs/heads/main/UiLib.lua"))()
local VehicleUtils = require(game:GetService("ReplicatedStorage").Vehicle.VehicleUtils)
local function Load() 
	local Window = Library:CreateWindow({
		Accent = Color3.fromRGB(100, 170, 255),  -- recolor the whole UI from here
		Size   = UDim2.fromOffset(560, 360),
	})
	Window:AddTitle("BytHub | Free")
	local main = Window:AddTab("rbxassetid://", "Vehicle Modifications")
	local Config = Window:AddTab("rbxassetid://", "Configuration")
    local General = Config:AddSection("rbxassetid://", "General")
	local VehicleMod = main:AddSection("Vehicle Modifications")
--———————————————————————————————————————— Heli Ui —————————————————————————————————————————————--
local HeliMod = false
local HeliSpeed = 1.5
local HeliMaxSpeed = 3
local HeliMod =	VehicleMod:AddToggle({
	Title = "Modify Helicopters",
	Content = "Apply the custom values",
	Default = false,
	Callback = function(value)
		HeliMod = value
	end
})
	HeliMod:AddSlider({
	Title = "Heli Speed",
	Min = 10,
	Max = HeliMaxSpeed*10,
	Deafult = 15,
	Callback = function(value)
		HeliSpeed =  value/10
	end
})
--———————————————————————————————————————— Car Ui —————————————————————————————————————————————--
local CarMod = false
local CarSpeed = 10
local CarHeight = 33
local TurnSpeed = 14
	local CarMod =	VehicleMod:AddToggle({
	Title = "Modify Vehicle",
	Content = "Apply the custom values",
	Default = false,
	Callback = function(value)
		CarMod = value
	end
})
	CarMod:AddSlider({
	Title = "Vehicle Speed",
	Min = 10,
	Max = 30,
	Deafult = 15,
	Callback = function(value)
		CarSpeed =  value
	end
})

	CarMod:AddSlider({
	Title = "Vehicle Height",
	Min = 3,
	Max = 200,
	Deafult = 10,
	Callback = function(value)
		CarHeight =  value
	end
})
	CarMod:AddSlider({
	Title = "Vehicle Turn Speed",
	Min = 14,
	Max = 20,
	Deafult = 10,
	Callback = function(value)
		TurnSpeed =  value
	end
})
	General:AddButton({
	Title = "Unload",
	Content = "Unloads the script",
	Callback = function ()
		Unload = true
			game:GetService("CoreGui").UiLib:Destroy()
	end
})
local function GetVehicle()
	for i,Vehicle in workspace.Vehicles:GetChildren() do
		local seat = Vehicle:FindFirstChild("Seat")
		if not seat then continue end
		local PlayerName = seat.PlayerName
		local Plr = seat.Player
		if not PlayerName or  PlayerName.Value ~= Player.Name then continue end
		if Plr.Value == false then continue end
		return Vehicle
	end
end
local RenderStepped = nil
RenderStepped = RunService.RenderStepped:connect(function ()
	if Unload then RenderStepped:Disconnect() return end
	if HeliMod then
		local Vehicle = GetVehicle()
		if not Vehicle then return end
		local Engine = Vehicle:WaitForChild("Engine")
		local BodyVelocity = Engine:WaitForChild("BodyVelocity")
		if not BodyVelocity then return end
		BodyVelocity.Velocity *= HeliSpeed
	end

	if CarMod then
		local packet = VehicleUtils.GetLocalVehiclePacket()
		packet.GarageEngineSpeed = CarSpeed
		packet.Height = CarHeight
		packet.TurnSpeed = TurnSpeed/10
	end
end)

end

Library:CreateKeySystem({
	Title = "My Powerplant",
	Subtitle = "Enter your key to continue",
	Placeholder = "Paste key here...",
	Validate = function(key)
		return key == "BytHub"
	end,
	OnGetKey = function()
		print("send the player to your key link / copy it here")
	end,
	OnSuccess = function()
		Load()   -- only runs once the key passed; gate is already destroyed
	end,
	OnFail = function(key)
	end,
})
