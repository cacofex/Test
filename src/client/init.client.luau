local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local signal = require(ReplicatedStorage.Packages.signal)

local remote = ReplicatedStorage:WaitForChild("RemoteEvent") :: RemoteEvent
local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
local hrp = character:FindFirstChild("HumanoidRootPart")

local CameraModule = require(script.Camera)

local newCam = CameraModule.new(Players.LocalPlayer)
local mouse = Players.LocalPlayer:GetMouse()

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.Q then
        local direction = (mouse.Hit.Position - hrp.CFrame.Position).Unit
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {character}
        params.FilterType = Enum.RaycastFilterType.Exclude
        local ray: RaycastResult = workspace:Raycast(hrp.CFrame.Position, direction * 50, params)
        if not ray or not ray.Instance then return end

        local target = ray.Instance:FindFirstAncestorOfClass("Model")
        newCam:Change("Lock", target)
    elseif input.KeyCode == Enum.KeyCode.E then
        newCam:Change("Free")
    end
end)