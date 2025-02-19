local player = game.Players.LocalPlayer
local vrService = game:GetService("VRService")
local runService = game:GetService("RunService")

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local head = character:WaitForChild("Head")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Function to update the head position based on VR headset
local function updateHeadPosition()
    -- Check if in VR mode
    if vrService.VRDeviceType ~= Enum.VRDeviceType.None then
        -- Get the headset's CFrame (position and rotation)
        local headsetCFrame = vrService:GetUserCFrame(Enum.UserCFrame.Head)
        
        -- Set the dead character's head to the position of the headset
        if head and humanoid.Health == 0 then
            -- Apply the headset's CFrame to the character's head
            head.CFrame = humanoidRootPart.CFrame * headsetCFrame
        end
    end
end

-- Function to move body parts below the ground after death
local function moveBodyPartsBelowGround()
    -- Check if the humanoid is dead
    if humanoid.Health == 0 then
        -- Move the body parts below the ground by adjusting their Y position
        -- We assume a value below the ground, for example, Y = -50
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "Head" then
                -- Teleport each body part to be below the ground
                -- Change Y position to -50 (or any value lower than the ground)
                part.CFrame = part.CFrame * CFrame.new(0, -50, 0)
            end
        end
    end
end

-- Continuously update the head's position and move body parts below the ground
runService.RenderStepped:Connect(function()
    updateHeadPosition()
    moveBodyPartsBelowGround()
end)

-- Optionally, prevent respawn and movement after death
humanoid.Died:Connect(function()
    humanoid.Health = 0  -- Kill the character without respawning
    humanoid.PlatformStand = true  -- Prevent movement
end)
