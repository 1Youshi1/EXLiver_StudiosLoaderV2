-- EXLiver_Studios Premium Loader v2.0
-- Luau Version for Roblox

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local loader = {}

-- Конфигурация
loader.config = {
	title = "EXLiver_Studios",
	version = "v2.0 Premium",
	slogan = "Quality Beyond Limits",
	validKeys = {
		"EXL-PREM-2024-001",
		"EXL-PREM-2024-002", 
		"EXL-PREM-2024-003",
		"EXL-PREM-2024-004",
		"EXL-PREM-2024-005",
		"EXL-PREM-2024-006",
		"EXL-PREM-2024-007",
		"EXL-PREM-2024-008",
		"EXL-PREM-2024-009",
		"EXL-PREM-2024-010"
	},
	price = 1499,
	website = "https://exliver-studios.ru/premium",
	discord = "https://discord.gg/exliver"
}

-- GUI элементы
loader.gui = nil
loader.connections = {}
loader.tweens = {}
loader.particles = {}
loader.crackParticles = {}

-- Состояния
loader.states = {
	introComplete = false,
	unloading = false,
	activated = false,
	currentKey = ""
}

-- Создание основного GUI
function loader.createMainGUI()
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	
	-- Удаляем старый GUI если существует
	if loader.gui then
		loader.gui:Destroy()
	end
	
	-- Создаем ScreenGui
	loader.gui = Instance.new("ScreenGui")
	loader.gui.Name = "EXLiverStudiosLoader"
	loader.gui.ResetOnSpawn = false
	loader.gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	loader.gui.Parent = playerGui
	
	-- Основной фрейм
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(0, 450, 0, 500)
	mainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
	mainFrame.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
	mainFrame.BackgroundTransparency = 1
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = loader.gui
	
	-- Скругление углов
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = mainFrame
	
	-- Тень
	local shadow = Instance.new("UIStroke")
	shadow.Color = Color3.fromRGB(120, 0, 200)
	shadow.Thickness = 2
	shadow.Transparency = 0.8
	shadow.Parent = mainFrame
	
	-- Заголовок
	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Size = UDim2.new(1, -20, 0, 40)
	title.Position = UDim2.new(0, 10, 0, 20)
	title.BackgroundTransparency = 1
	title.Text = "🎮 EXLiver_Studios"
	title.TextColor3 = Color3.fromRGB(180, 70, 255)
	title.TextSize = 24
	title.Font = Enum.Font.GothamBold
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = mainFrame
	
	local subtitle = Instance.new("TextLabel")
	subtitle.Name = "Subtitle"
	subtitle.Size = UDim2.new(1, -20, 0, 20)
	subtitle.Position = UDim2.new(0, 10, 0, 55)
	subtitle.BackgroundTransparency = 1
	subtitle.Text = loader.config.slogan
	subtitle.TextColor3 = Color3.fromRGB(200, 120, 255)
	subtitle.TextSize = 14
	subtitle.Font = Enum.Font.Gotham
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.Parent = mainFrame
	
	-- Разделитель
	local separator = Instance.new("Frame")
	separator.Name = "Separator"
	separator.Size = UDim2.new(1, -20, 0, 1)
	separator.Position = UDim2.new(0, 10, 0, 85)
	separator.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
	separator.BorderSizePixel = 0
	separator.Parent = mainFrame
	
	-- Поле ввода ключа
	local keyLabel = Instance.new("TextLabel")
	keyLabel.Name = "KeyLabel"
	keyLabel.Size = UDim2.new(1, -20, 0, 20)
	keyLabel.Position = UDim2.new(0, 10, 0, 100)
	keyLabel.BackgroundTransparency = 1
	keyLabel.Text = "🔑 Введите лицензионный ключ:"
	keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyLabel.TextSize = 14
	keyLabel.Font = Enum.Font.Gotham
	keyLabel.TextXAlignment = Enum.TextXAlignment.Left
	keyLabel.Parent = mainFrame
	
	local keyInput = Instance.new("TextBox")
	keyInput.Name = "KeyInput"
	keyInput.Size = UDim2.new(0, 270, 0, 35)
	keyInput.Position = UDim2.new(0, 10, 0, 125)
	keyInput.BackgroundColor3 = Color3.fromRGB(40, 10, 60)
	keyInput.TextColor3 = Color3.fromRGB(220, 180, 255)
	keyInput.PlaceholderText = "EXL-PREM-2024-XXX"
	keyInput.Text = ""
	keyInput.TextSize = 14
	keyInput.Font = Enum.Font.Gotham
	keyInput.ClearTextOnFocus = false
	keyInput.Parent = mainFrame
	
	local inputCorner = Instance.new("UICorner")
	inputCorner.CornerRadius = UDim.new(0, 6)
	inputCorner.Parent = keyInput
	
	-- Кнопка активации
	local activateBtn = Instance.new("TextButton")
	activateBtn.Name = "ActivateBtn"
	activateBtn.Size = UDim2.new(0, 140, 0, 35)
	activateBtn.Position = UDim2.new(1, -150, 0, 125)
	activateBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
	activateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	activateBtn.Text = "⚡ АКТИВИРОВАТЬ"
	activateBtn.TextSize = 14
	activateBtn.Font = Enum.Font.GothamBold
	activateBtn.Parent = mainFrame
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = activateBtn
	
	-- Список ключей
	local keysLabel = Instance.new("TextLabel")
	keysLabel.Name = "KeysLabel"
	keysLabel.Size = UDim2.new(1, -20, 0, 20)
	keysLabel.Position = UDim2.new(0, 10, 0, 180)
	keysLabel.BackgroundTransparency = 1
	keysLabel.Text = "📋 Доступные ключи:"
	keysLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	keysLabel.TextSize = 14
	keysLabel.Font = Enum.Font.Gotham
	keysLabel.TextXAlignment = Enum.TextXAlignment.Left
	keysLabel.Parent = mainFrame
	
	local keysFrame = Instance.new("ScrollingFrame")
	keysFrame.Name = "KeysFrame"
	keysFrame.Size = UDim2.new(1, -20, 0, 100)
	keysFrame.Position = UDim2.new(0, 10, 0, 205)
	keysFrame.BackgroundColor3 = Color3.fromRGB(30, 5, 50)
	keysFrame.BorderSizePixel = 0
	keysFrame.ScrollBarThickness = 6
	keysFrame.Parent = mainFrame
	
	local keysLayout = Instance.new("UIListLayout")
	keysLayout.Parent = keysFrame
	
	local keysCorner = Instance.new("UICorner")
	keysCorner.CornerRadius = UDim.new(0, 6)
	keysCorner.Parent = keysFrame
	
	-- Заполняем список ключей
	for i, key in loader.config.validKeys do
		local keyItem = Instance.new("TextLabel")
		keyItem.Name = "KeyItem_" .. i
		keyItem.Size = UDim2.new(1, -10, 0, 25)
		keyItem.Position = UDim2.new(0, 5, 0, (i-1)*25)
		keyItem.BackgroundTransparency = 1
		keyItem.Text = "🔓 " .. key .. " - СВОБОДЕН"
		keyItem.TextColor3 = Color3.fromRGB(200, 150, 255)
		keyItem.TextSize = 12
		keyItem.Font = Enum.Font.Gotham
		keyItem.TextXAlignment = Enum.TextXAlignment.Left
		keyItem.Parent = keysFrame
	end
	
	-- Кнопки действий
	local buyBtn = Instance.new("TextButton")
	buyBtn.Name = "BuyBtn"
	buyBtn.Size = UDim2.new(0, 200, 0, 35)
	buyBtn.Position = UDim2.new(0, 10, 1, -135)
	buyBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 100)
	buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	buyBtn.Text = "🛒 КУПИТЬ КЛЮЧ - " .. loader.config.price .. "₽"
	buyBtn.TextSize = 14
	buyBtn.Font = Enum.Font.GothamBold
	buyBtn.Parent = mainFrame
	
	local discordBtn = Instance.new("TextButton")
	discordBtn.Name = "DiscordBtn"
	discordBtn.Size = UDim2.new(0, 200, 0, 35)
	discordBtn.Position = UDim2.new(1, -210, 1, -135)
	discordBtn.BackgroundColor3 = Color3.fromRGB(90, 100, 220)
	discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	discordBtn.Text = "💬 DISCORD"
	discordBtn.TextSize = 14
	discordBtn.Font = Enum.Font.GothamBold
	discordBtn.Parent = mainFrame
	
	local unloadBtn = Instance.new("TextButton")
	unloadBtn.Name = "UnloadBtn"
	unloadBtn.Size = UDim2.new(1, -20, 0, 35)
	unloadBtn.Position = UDim2.new(0, 10, 1, -85)
	unloadBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
	unloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	unloadBtn.Text = "❌ UNLOAD"
	unloadBtn.TextSize = 14
	unloadBtn.Font = Enum.Font.GothamBold
	unloadBtn.Parent = mainFrame
	
	-- Статус
	local status = Instance.new("TextLabel")
	status.Name = "Status"
	status.Size = UDim2.new(1, -20, 0, 20)
	status.Position = UDim2.new(0, 10, 1, -50)
	status.BackgroundTransparency = 1
	status.Text = "⏳ Статус: Ожидание ключа..."
	status.TextColor3 = Color3.fromRGB(255, 200, 50)
	status.TextSize = 14
	status.Font = Enum.Font.Gotham
	status.TextXAlignment = Enum.TextXAlignment.Left
	status.Parent = mainFrame
	
	-- Применяем скругления ко всем кнопкам
	for _, btn in {activateBtn, buyBtn, discordBtn, unloadBtn} do
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 6)
		corner.Parent = btn
	end
	
	-- Сохраняем ссылки на элементы
	loader.elements = {
		mainFrame = mainFrame,
		title = title,
		subtitle = subtitle,
		keyInput = keyInput,
		activateBtn = activateBtn,
		keysFrame = keysFrame,
		buyBtn = buyBtn,
		discordBtn = discordBtn,
		unloadBtn = unloadBtn,
		status = status
	}
	
	-- Анимация появления
	loader.fadeInGUI()
end

-- Анимация появления GUI
function loader.fadeInGUI()
	local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	local tween = TweenService:Create(loader.elements.mainFrame, tweenInfo, {
		BackgroundTransparency = 0
	})
	
	tween:Play()
	tween.Completed:Wait()
	
	-- Запускаем пульсацию кнопки активации
	loader.startPulseAnimation()
end

-- Анимация пульсации кнопки
function loader.startPulseAnimation()
	if loader.connections.pulse then
		loader.connections.pulse:Disconnect()
	end
	
	loader.connections.pulse = RunService.Heartbeat:Connect(function(deltaTime)
		if loader.states.unloading or loader.states.activated then
			return
		end
		
		local time = tick()
		local pulse = math.sin(time * 3) * 0.2 + 0.8
		
		loader.elements.activateBtn.BackgroundColor3 = Color3.fromRGB(
			120 + math.sin(time * 2) * 20,
			0,
			200 + math.cos(time * 1.5) * 20
		)
	end)
end

-- Валидация ключа
function loader.validateKey(key)
	for i, validKey in loader.config.validKeys do
		if key == validKey then
			return true, i
		end
	end
	return false, 0
end

-- Успешная активация
function loader.activateSuccess(keyIndex)
	loader.states.activated = true
	loader.states.currentKey = loader.config.validKeys[keyIndex]
	
	-- Обновляем статус
	loader.elements.status.Text = "✅ Статус: Premium активирован! Добро пожаловать!"
	loader.elements.status.TextColor3 = Color3.fromRGB(50, 255, 100)
	
	-- Обновляем список ключей
	local keyItem = loader.elements.keysFrame:FindFirstChild("KeyItem_" .. keyIndex)
	if keyItem then
		keyItem.Text = "🔒 " .. loader.config.validKeys[keyIndex] .. " - АКТИВИРОВАН"
		keyItem.TextColor3 = Color3.fromRGB(50, 255, 100)
	end
	
	-- Отключаем элементы ввода
	loader.elements.activateBtn.Active = false
	loader.elements.activateBtn.Text = "✅ АКТИВИРОВАН"
	loader.elements.activateBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
	loader.elements.keyInput.Text = loader.config.validKeys[keyIndex]
	loader.elements.keyInput.TextEditable = false
	
	-- Запускаем анимацию успеха
	loader.successAnimation()
end

-- Анимация успеха
function loader.successAnimation()
	-- Радужная анимация заголовка
	local startTime = tick()
	
	if loader.connections.success then
		loader.connections.success:Disconnect()
	end
	
	loader.connections.success = RunService.Heartbeat:Connect(function()
		if tick() - startTime > 3 then
			loader.connections.success:Disconnect()
			return
		end
		
		local progress = (tick() - startTime) / 3
		local r = math.sin(progress * 6.28 + 0) * 127 + 128
		local g = math.sin(progress * 6.28 + 2) * 127 + 128
		local b = math.sin(progress * 6.28 + 4) * 127 + 128
		
		loader.elements.title.TextColor3 = Color3.fromRGB(r, g, b)
		loader.elements.subtitle.TextColor3 = Color3.fromRGB(r, g, b)
	end)
	
	-- Возвращаем цвета через 3 секунды
	delay(3, function()
		loader.elements.title.TextColor3 = Color3.fromRGB(180, 70, 255)
		loader.elements.subtitle.TextColor3 = Color3.fromRGB(200, 120, 255)
	end)
end

-- Анимация распадания
function loader.unloadAnimation()
	if loader.states.unloading then return end
	
	loader.states.unloading = true
	loader.elements.status.Text = "🔒 Статус: Unloading system..."
	loader.elements.status.TextColor3 = Color3.fromRGB(255, 100, 100)
	
	-- Отключаем все соединения
	for _, connection in loader.connections do
		connection:Disconnect()
	end
	
	-- Создаем частицы трещин
	loader.createCrackParticles()
	
	-- Анимация дрожания и распадания
	local startTime = tick()
	local originalPos = loader.elements.mainFrame.Position
	
	if loader.connections.unload then
		loader.connections.unload:Disconnect()
	end
	
	loader.connections.unload = RunService.Heartbeat:Connect(function()
		local progress = (tick() - startTime) / 2
		
		if progress >= 1 then
			loader.connections.unload:Disconnect()
			loader.destroyGUI()
			return
		end
		
		-- Дрожание
		local shake = (1 - progress) * 8
		loader.elements.mainFrame.Position = UDim2.new(
			originalPos.X.Scale, 
			originalPos.X.Offset + math.random(-shake, shake),
			originalPos.Y.Scale,
			originalPos.Y.Offset + math.random(-shake, shake)
		)
		
		-- Затемнение
		loader.elements.mainFrame.BackgroundTransparency = progress * 0.7
		
		-- Обновление частиц трещин
		loader.updateCrackParticles(progress)
	end)
end

-- Создание частиц трещин
function loader.createCrackParticles()
	for i = 1, 15 do
		table.insert(loader.crackParticles, {
			position = UDim2.new(
				math.random() * 0.8 + 0.1,
				math.random(-10, 10),
				math.random() * 0.8 + 0.1,
				math.random(-10, 10)
			),
			size = math.random(20, 50),
			life = 1.0
		})
	end
end

-- Обновление частиц трещин
function loader.updateCrackParticles(progress)
	-- В реальной реализации здесь была бы отрисовка частиц
	-- Для демонстрации просто выводим в консоль
	if progress > 0.5 and progress < 0.6 then
		print("💥 GUI cracking...")
	end
end

-- Уничтожение GUI
function loader.destroyGUI()
	if loader.gui then
		loader.gui:Destroy()
		loader.gui = nil
	end
	
	print("[EXLiver_Studios] System unloaded successfully!")
end

-- Показ интро
function loader.showIntro()
	print("[EXLiver_Studios] Initializing premium system...")
	
	-- В Roblox сложно создать отдельное окно интро, 
	-- поэтому интегрируем его в основной GUI
	loader.createMainGUI()
	
	-- Симулируем загрузку
	local loadSteps = {
		"Initializing core modules...",
		"Loading security protocols...", 
		"Starting authentication system...",
		"Preparing user interface...",
		"Almost ready..."
	}
	
	for i, step in loadSteps do
		loader.elements.status.Text = "⏳ " .. step .. " " .. math.floor((i / #loadSteps) * 100) .. "%"
		wait(0.5)
	end
	
	loader.elements.status.Text = "⏳ Статус: Ожидание ключа..."
	loader.states.introComplete = true
end

-- Подключение обработчиков событий
function loader.connectEvents()
	-- Активация по кнопке
	loader.connections.activate = loader.elements.activateBtn.MouseButton1Click:Connect(function()
		local key = loader.elements.keyInput.Text
		
		if key == "" then
			loader.elements.status.Text = "❌ Статус: Введите ключ!"
			loader.elements.status.TextColor3 = Color3.fromRGB(255, 100, 100)
			return
		end
		
		local isValid, keyIndex = loader.validateKey(key)
		if isValid then
			loader.activateSuccess(keyIndex)
		else
			loader.elements.status.Text = "❌ Статус: Неверный ключ!"
			loader.elements.status.TextColor3 = Color3.fromRGB(255, 100, 100)
		end
	end)
	
	-- Кнопка покупки
	loader.connections.buy = loader.elements.buyBtn.MouseButton1Click:Connect(function()
		loader.elements.status.Text = "🌐 Статус: Открытие сайта..."
		loader.elements.status.TextColor3 = Color3.fromRGB(100, 180, 255)
		
		-- В Roblox нельзя открыть внешние ссылки напрямую
		print("[EXLiver_Studios] Website: " .. loader.config.website)
		
		delay(2, function()
			loader.elements.status.Text = "📧 Свяжитесь с продавцом для покупки"
		end)
	end)
	
	-- Кнопка Discord
	loader.connections.discord = loader.elements.discordBtn.MouseButton1Click:Connect(function()
		loader.elements.status.Text = "💬 Статус: Открытие Discord..."
		loader.elements.status.TextColor3 = Color3.fromRGB(120, 140, 255)
		
		print("[EXLiver_Studios] Discord: " .. loader.config.discord)
		
		delay(2, function()
			loader.elements.status.Text = "📱 Присоединяйтесь к нашему Discord!"
		end)
	end)
	
	-- Кнопка выгрузки
	loader.connections.unloadBtn = loader.elements.unloadBtn.MouseButton1Click:Connect(function()
		loader.unloadAnimation()
	end)
	
	-- Анимация при наведении на кнопки
	loader.setupHoverEffects()
end

-- Эффекты при наведении
function loader.setupHoverEffects()
	local buttons = {
		{btn = loader.elements.activateBtn, normal = Color3.fromRGB(120, 0, 200), hover = Color3.fromRGB(160, 40, 255)},
		{btn = loader.elements.buyBtn, normal = Color3.fromRGB(200, 60, 100), hover = Color3.fromRGB(255, 80, 120)},
		{btn = loader.elements.discordBtn, normal = Color3.fromRGB(90, 100, 220), hover = Color3.fromRGB(120, 130, 255)},
		{btn = loader.elements.unloadBtn, normal = Color3.fromRGB(150, 30, 30), hover = Color3.fromRGB(200, 50, 50)}
	}
	
	for _, buttonData in buttons do
		local btn = buttonData.btn
		
		btn.MouseEnter:Connect(function()
			if not loader.states.unloading and not (btn == loader.elements.activateBtn and loader.states.activated) then
				local tween = TweenService:Create(btn, TweenInfo.new(0.2), {
					BackgroundColor3 = buttonData.hover
				})
				tween:Play()
			end
		end)
		
		btn.MouseLeave:Connect(function()
			if not loader.states.unloading and not (btn == loader.elements.activateBtn and loader.states.activated) then
				local tween = TweenService:Create(btn, TweenInfo.new(0.2), {
					BackgroundColor3 = buttonData.normal
				})
				tween:Play()
			end
		end)
	end
end

-- Основная функция запуска
function loader.run()
	local success, err = pcall(function()
		loader.showIntro()
		loader.connectEvents()
	end)
	
	if not success then
		warn("[EXLiver_Studios] Loader error: " .. err)
	end
end

-- Автозапуск
if not _G.EXLIVER_STUDIOS_LOADED then
	_G.EXLIVER_STUDIOS_LOADED = true
	loader.run()
else
	print("[EXLiver_Studios] Loader already running!")
end

return loader