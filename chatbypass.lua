local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Create MainFrame (UI Panel)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = screenGui

-- Create TextBox
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0.2, 0)
textBox.Position = UDim2.new(0.1, 0, 0.2, 0)
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox.Text = "Enter text here"
textBox.Parent = mainFrame

-- Create Submit Button
local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.8, 0, 0.2, 0)
submitButton.Position = UDim2.new(0.1, 0, 0.5, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitButton.Text = "Submit"
submitButton.Parent = mainFrame

-- Create Minimize Button (Placed at the bottom of the screen)
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 100, 0, 30) -- Wider for better accessibility
minimizeButton.Position = UDim2.new(0.5, -50, 1, -40) -- At the bottom center
minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minimizeButton.Text = "-"
minimizeButton.Parent = screenGui -- Parent it to ScreenGui so it stays visible

-- Function to handle text submission
local function onSubmit()
    local textValue = textBox.Text
    print("Submitted Text:", textValue) -- Replace with your function
end

-- Toggle UI visibility (Hide only MainFrame)
local isMinimized = false
local function toggleUI()
    isMinimized = not isMinimized
    mainFrame.Visible = not isMinimized
    minimizeButton.Text = isMinimized and "=" or "-" -- Change text when toggled
end

-- Connect button events
submitButton.MouseButton1Click:Connect(onSubmit)
minimizeButton.MouseButton1Click:Connect(toggleUI)
