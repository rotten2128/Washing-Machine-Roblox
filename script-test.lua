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

-- Function to follow the mouse position when clicked inside the frame
local function followMouse(input)
    local mousePos = input.Position
    draggableFrame.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)
end

-- Connect the MouseButton1Click event to follow the mouse
draggableFrame.MouseButton1Click:Connect(function()
    local mouse = player:GetMouse()
    mouse.Move:Connect(followMouse)
end)

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
