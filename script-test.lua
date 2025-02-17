local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local initialSpinSpeed = 1
local maxSpinSpeed = 9999
local accelerationRate = 0.009
local spinning = false

-- Create a ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create a draggable frame
local draggableFrame = Instance.new("Frame")
draggableFrame.Size = UDim2.new(0, 200, 0, 150)
draggableFrame.Position = UDim2.new(0.5, -100, 0.8, -75)
draggableFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
draggableFrame.Parent = screenGui

-- Add a UIListLayout for buttons within the frame
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = draggableFrame

-- Create a button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Text = "Start Spinning"
button.Parent = draggableFrame

-- Create a close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 100, 0, 50)
closeButton.Text = "Close"
closeButton.Parent = draggableFrame

-- Variables for dragging the frame
local dragInput, dragStart, startPos
local dragging = false

-- Function to update the frame's position
local function update(input)
    if dragging then
        local delta = input.Position - dragStart
        draggableFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

-- Function to handle the beginning of the drag
local function onInputBegan(input)
    -- Only allow dragging if the user clicks on the frame itself (not the buttons)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and input.Target == draggableFrame then
        dragging = true
        dragStart = input.Position
        startPos = draggableFrame.Position
        input.Changed:Connect(function()
            update(input)
        end)
    end
end

-- Function to stop dragging when the mouse is released
local function onInputEnded(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end

-- Connecting the input to allow dragging the frame
draggableFrame.InputBegan:Connect(onInputBegan)
draggableFrame.InputEnded:Connect(onInputEnded)

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

closeButton.MouseButton1Click:Connect(function()
    spinning = false
    screenGui:Destroy()
end)
