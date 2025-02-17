local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local initialSpinSpeed = 0  -- Start from 0
local maxSpinSpeed = 0  -- Start with max spin at 0
local accelerationRate = 0.009
local spinning = false

-- Create a ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create a fixed frame in the center of the screen
local draggableFrame = Instance.new("Frame")
draggableFrame.Size = UDim2.new(0, 200, 0, 200)
draggableFrame.Position = UDim2.new(0.5, -100, 0.5, -100)  -- Position it in the center
draggableFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
draggableFrame.Parent = screenGui

-- Add a UIListLayout for buttons within the frame
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = draggableFrame

-- Create a button for starting the spin
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Text = "Start Spinning"
button.Parent = draggableFrame

-- Create an "Increase Speed" button
local increaseSpeedButton = Instance.new("TextButton")
increaseSpeedButton.Size = UDim2.new(0, 200, 0, 50)
increaseSpeedButton.Text = "Increase Speed"
increaseSpeedButton.Parent = draggableFrame

-- Create a close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 100, 0, 50)
closeButton.Text = "Close"
closeButton.Parent = draggableFrame

local function spinCharacter()
    local spinSpeed = initialSpinSpeed
    spinning = true
    
    while spinning do
        character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0))
        task.wait(0.001)
        
        spinSpeed = math.min(spinSpeed + accelerationRate, maxSpinSpeed)
    end
end

button.MouseButton1Click:Connect(function()
    if spinning then
        spinning = false
        button.Text = "Start Spinning"
    else
        button.Text = "Stop Spinning"
        spinCharacter()
    end
end)

-- Increase spin speed
increaseSpeedButton.MouseButton1Click:Connect(function()
    -- Increase the max speed by a fixed amount (you can change this increment)
    maxSpinSpeed = math.min(maxSpinSpeed + 100, 9999)  -- Adjust increment as desired
    initialSpinSpeed = maxSpinSpeed  -- Set initial speed to max speed to begin the spin
    increaseSpeedButton.Text = "Increase Speed (" .. maxSpinSpeed .. ")"
end)

closeButton.MouseButton1Click:Connect(function()
    spinning = false
    screenGui:Destroy()
end)
