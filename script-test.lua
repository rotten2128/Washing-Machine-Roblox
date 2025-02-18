local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local initialSpinSpeed = 0  -- Start from 0
local maxSpinSpeed = 0  -- Start with max spin at 0
local accelerationRate = 1
local spinning = false

-- Create a ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create a frame at the bottom of the screen with increased height and black background
local draggableFrame = Instance.new("Frame")
draggableFrame.Size = UDim2.new(0, 200, 0, 130)  -- Increased height by 30 pixels
draggableFrame.Position = UDim2.new(0.5, -100, 1, -150)  -- Positioned at the bottom of the screen
draggableFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Set background to black
draggableFrame.BackgroundTransparency = 0.2  -- Slight transparency to make it more subtle
draggableFrame.Parent = screenGui

-- Make the frame corners rounded
draggableFrame.UICorner = Instance.new("UICorner")
draggableFrame.UICorner.CornerRadius = UDim.new(0, 12)  -- Rounded corners

-- Add a UIListLayout for buttons within the frame
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = draggableFrame
listLayout.Padding = UDim.new(0, 5)  -- Adds some space between buttons

-- Create a button for starting the spin
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 30)
button.Text = "Start Spinning"
button.BackgroundColor3 = Color3.fromRGB(128, 128, 128)  -- Grey background for the button
button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
button.Parent = draggableFrame

-- Make the button corners rounded
button.UICorner = Instance.new("UICorner")
button.UICorner.CornerRadius = UDim.new(0, 8)  -- Rounded corners for the button

-- Create a button for increasing speed
local increaseSpeedButton = Instance.new("TextButton")
increaseSpeedButton.Size = UDim2.new(0, 50, 0, 30)
increaseSpeedButton.Text = "+"
increaseSpeedButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)  -- Grey background for the button
increaseSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
increaseSpeedButton.Parent = draggableFrame

-- Make the increase speed button corners rounded
increaseSpeedButton.UICorner = Instance.new("UICorner")
increaseSpeedButton.UICorner.CornerRadius = UDim.new(0, 8)  -- Rounded corners

-- Create a button for decreasing speed
local decreaseSpeedButton = Instance.new("TextButton")
decreaseSpeedButton.Size = UDim2.new(0, 50, 0, 30)
decreaseSpeedButton.Text = "-"
decreaseSpeedButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)  -- Grey background for the button
decreaseSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
decreaseSpeedButton.Parent = draggableFrame

-- Make the decrease speed button corners rounded
decreaseSpeedButton.UICorner = Instance.new("UICorner")
decreaseSpeedButton.UICorner.CornerRadius = UDim.new(0, 8)  -- Rounded corners

-- Create a close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 100, 0, 30)
closeButton.Text = "Close"
closeButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)  -- Grey background for the button
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
closeButton.Parent = draggableFrame

-- Make the close button corners rounded
closeButton.UICorner = Instance.new("UICorner")
closeButton.UICorner.CornerRadius = UDim.new(0, 8)  -- Rounded corners

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
end)

-- Decrease spin speed
decreaseSpeedButton.MouseButton1Click:Connect(function()
    -- Decrease the max speed by a fixed amount (you can change this decrement)
    maxSpinSpeed = math.max(maxSpinSpeed - 100, 0)  -- Adjust decrement as desired (ensure it doesn't go below 0)
    initialSpinSpeed = maxSpinSpeed  -- Set initial speed to max speed to begin the spin
end)

closeButton.MouseButton1Click:Connect(function()
    spinning = false
    screenGui:Destroy()
end)
