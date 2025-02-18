local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local initialSpinSpeed = 0  -- Start from 0
local maxSpinSpeed = 0  -- Start with max spin at 0
local accelerationRate = 1  -- Acceleration set to 1
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

-- Add a UIListLayout for buttons within the frame
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = draggableFrame
listLayout.Padding = UDim.new(0, 5)  -- Adds some space between buttons

-- Create a title label at the top of the frame
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Spin GUI v1"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
titleLabel.BackgroundTransparency = 1  -- Transparent background
titleLabel.Font = "SourceSans"  -- Comic Sans font
titleLabel.TextSize = 18
titleLabel.TextAlign = "Center"  -- Center alignment for text
titleLabel.Parent = draggableFrame

-- Create a button for starting the spin
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 30)
button.Text = "Start Spinning"
button.BackgroundColor3 = Color3.fromRGB(128, 128, 128)  -- Grey background for the button
button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
button.Font = "SourceSans"  -- Comic Sans font
button.TextSize = 14
button.Parent = draggableFrame

-- Create a button for increasing speed
local increaseSpeedButton = Instance.new("TextButton")
increaseSpeedButton.Size = UDim2.new(0, 50, 0, 30)
increaseSpeedButton.Text = "+"
increaseSpeedButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)  -- Grey background for the button
increaseSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
increaseSpeedButton.Font = "SourceSans"  -- Comic Sans font
increaseSpeedButton.TextSize = 14
increaseSpeedButton.Parent = draggableFrame

-- Create a button for decreasing speed
local decreaseSpeedButton = Instance.new("TextButton")
decreaseSpeedButton.Size = UDim2.new(0, 50, 0, 30)
decreaseSpeedButton.Text = "-"
decreaseSpeedButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)  -- Grey background for the button
decreaseSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
decreaseSpeedButton.Font = "SourceSans"  -- Comic Sans font
decreaseSpeedButton.TextSize = 14
decreaseSpeedButton.Parent = draggableFrame

-- Create a close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 100, 0, 30)
closeButton.Text = "Close"
closeButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)  -- Grey background for the button
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
closeButton.Font = "SourceSans"  -- Comic Sans font
closeButton.TextSize = 14
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

-- Increase spin speed by 10
increaseSpeedButton.MouseButton1Click:Connect(function()
    -- Increase the max speed by 10
    maxSpinSpeed = math.min(maxSpinSpeed + 10, 9999)  -- Adjust increment to 10
    initialSpinSpeed = maxSpinSpeed  -- Set initial speed to max speed to begin the spin
end)

-- Decrease spin speed by 10
decreaseSpeedButton.MouseButton1Click:Connect(function()
    -- Decrease the max speed by 10
    maxSpinSpeed = math.max(maxSpinSpeed - 10, 0)  -- Adjust decrement to 10 (ensure it doesn't go below 0)
    initialSpinSpeed = maxSpinSpeed  -- Set initial speed to max speed to begin the spin
end)

closeButton.MouseButton1Click:Connect(function()
    spinning = false
    screenGui:Destroy()
end)
