-- GUI de personalização de flashback
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar GUI
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "FlashbackSettings"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 8)

-- Função utilitária
local function createSetting(name, defaultValue, posY)
	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(0, 280, 0, 20)
	label.Position = UDim2.new(0, 10, 0, posY)
	label.Text = name
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left

	local box = Instance.new("TextBox", frame)
	box.Size = UDim2.new(0, 280, 0, 25)
	box.Position = UDim2.new(0, 10, 0, posY + 20)
	box.Text = tostring(defaultValue)
	box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	box.TextColor3 = Color3.new(1, 1, 1)
	box.ClearTextOnFocus = false

	local corner = Instance.new("UICorner", box)
	corner.CornerRadius = UDim.new(0, 6)

	return box
end

local keyInput = createSetting("Tecla de ativação (ex: V)", "V", 10)
local lengthInput = createSetting("Duração do flashback (segundos)", "60", 60)
local speedInput = createSetting("Velocidade do flashback (0 = desativado)", "1", 110)

local applyButton = Instance.new("TextButton", frame)
applyButton.Size = UDim2.new(0, 280, 0, 30)
applyButton.Position = UDim2.new(0, 10, 0, 150)
applyButton.Text = "Aplicar Configurações"
applyButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
applyButton.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", applyButton)

-- Ação ao clicar
applyButton.MouseButton1Click:Connect(function()
	local key = keyInput.Text:upper()
	local length = tonumber(lengthInput.Text)
	local speed = tonumber(speedInput.Text)

	if not key or not length or not speed then
		warn("Valores inválidos.")
		return
	end

	loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPOSITORIO/main/script.lua"))()(key, length, speed)
end)
