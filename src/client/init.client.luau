local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local signal = require(ReplicatedStorage.Packages.signal)

local remote = ReplicatedStorage:WaitForChild("RemoteEvent") :: RemoteEvent
local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        remote:FireServer(character)
    end
end)