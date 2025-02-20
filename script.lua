local player = game.Players.LocalPlayer
-- loadstring(game:HttpGet(""))() 
-- loadstring commented so that we dont have to find it.

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminCommandGUI"
screenGui.ResetOnSpawn = false -- Keeps GUI after death
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.3, 0, 0.1, 0)
frame.Position = UDim2.new(0.35, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.3
frame.Parent = screenGui

-- Text Box
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0.5, 0)
textBox.Position = UDim2.new(0.1, 0, 0.1, 0)
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Enter command..."
textBox.TextScaled = true
textBox.Parent = frame
textBox.Text = "Enter command..."
-- Submit Button
local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.8, 0, 0.3, 0)
submitButton.Position = UDim2.new(0.1, 0, 0.7, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.Text = "Submit"
submitButton.TextScaled = true
submitButton.Parent = frame

-- Function to get player's humanoid safely
local function getHumanoid()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid", 3) -- Waits up to 3 seconds for Humanoid
end

-- Function to handle command execution
local function executeCommand(command)
    local humanoid = getHumanoid()
    if not humanoid then return end -- If no humanoid, stop execution

    if command == "kill" then
        humanoid.Health = 0
    elseif command == "jump" then
        humanoid.Jump = true
    elseif command == "unspeed" then
        humanoid.WalkSpeed = 16
    elseif command == "speed" then
        humanoid.WalkSpeed = 50
    elseif command == "reset" then
        player.Character:BreakJoints()
    elseif command == "spingui" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rotten2128/stickks-admin/refs/heads/main/Command%20Scripts/spin%20gui.lua"))()
    elseif command == "vr" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rotten2128/stickks-admin/refs/heads/main/Command%20Scripts/saucevr.lua"))
    elseif command == "chatbypass" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rotten2128/stickks-admin/refs/heads/main/Command%20Scripts/chatbypass.lua"))() 
    else
        -- Show unknown command in red
        textBox.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red text
        textBox.Text = "Unknown: " .. command
        task.wait(2) -- Wait 1 second

        -- Reset to default
        textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        textBox.Text = ""
        textBox.PlaceholderText = "Enter command..."
    end
end

-- Button click event
submitButton.MouseButton1Click:Connect(function()
    local command = textBox.Text
    executeCommand(command)
    textBox.Text = "" -- Clear input
end)
