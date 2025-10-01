-- EXLiver_Studios Loader v2.0
-- Premium Authentication System with Advanced Animations

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

-- Анимационные системы
loader.animations = {
    particles = {},
    currentAlpha = 0,
    pulseDirection = 1,
    introProgress = 0,
    unloading = false,
    crackParticles = {}
}

-- ███████╗██╗  ██╗██╗     ██╗██╗   ██╗███████╗██████╗ 
-- ██╔════╝╚██╗██╔╝██║     ██║██║   ██║██╔════╝██╔══██╗
-- █████╗   ╚███╔╝ ██║     ██║██║   ██║█████╗  ██████╔╝
-- ██╔══╝   ██╔██╗ ██║     ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗
-- ███████╗██╔╝ ██╗███████╗██║ ╚████╔╝ ███████╗██║  ██║
-- ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝

function loader.showIntro()
    print("[EXLiver_Studios] Initializing premium system...")
    
    -- Создаем окно интро
    loader.introWindow = gui.Window("EXLiver_Intro", "", 600, 400)
    loader.introWindow.color = color(10, 0, 15, 255)
    loader.introWindow.border = false
    
    -- Логотип
    loader.logo = gui.Label(loader.introWindow, "EXLiver_Studios", 0, 120)
    loader.logo.color = color(180, 70, 255, 0)
    loader.logo.fontSize = 32
    loader.logo.bold = true
    loader.logo.align = "center"
    loader.logo.width = 600
    
    loader.slogan = gui.Label(loader.introWindow, loader.config.slogan, 0, 160)
    loader.slogan.color = color(200, 120, 255, 0)
    loader.slogan.fontSize = 14
    loader.slogan.align = "center"
    loader.slogan.width = 600
    
    -- Прогресс бар
    loader.progressBar = gui.Rectangle(loader.introWindow, 150, 250, 0, 20)
    loader.progressBar.color = color(120, 0, 200, 150)
    
    loader.progressText = gui.Label(loader.introWindow, "Loading... 0%", 0, 280)
    loader.progressText.color = color(255, 255, 255, 200)
    loader.progressText.align = "center"
    loader.progressText.width = 600
    
    -- Анимация появления
    local fadeInTime = 1.5
    local startTime = os.clock()
    
    while os.clock() - startTime < fadeInTime do
        local progress = (os.clock() - startTime) / fadeInTime
        local alpha = math.min(255 * progress, 255)
        
        loader.logo.color = color(180, 70, 255, alpha)
        loader.slogan.color = color(200, 120, 255, alpha * 0.8)
        
        sleep(16)
    end
    
    -- Анимация загрузки
    local loadSteps = {
        "Initializing core modules...",
        "Loading security protocols...",
        "Starting authentication system...",
        "Preparing user interface...",
        "Almost ready..."
    }
    
    for i, step in ipairs(loadSteps) do
        loader.progressText.text = step .. " " .. math.floor((i / #loadSteps) * 100) .. "%"
        loader.progressBar.width = 300 * (i / #loadSteps)
        
        -- Добавляем частицы загрузки
        for j = 1, 3 do
            loader.createParticle(
                150 + math.random(0, 300),
                250,
                math.random(-2, 2),
                math.random(-3, -1),
                color(180, 70, 255, 200),
                1.0
            )
        end
        
        sleep(500) -- Задержка между шагами
    end
    
    -- Завершение интро
    loader.progressText.text = "Ready! Starting main interface..."
    loader.progressBar.width = 300
    sleep(1000)
    
    -- Плавное исчезновение
    startTime = os.clock()
    while os.clock() - startTime < 1.0 do
        local progress = (os.clock() - startTime) / 1.0
        local alpha = 255 * (1 - progress)
        
        loader.logo.color = color(180, 70, 255, alpha)
        loader.slogan.color = color(200, 120, 255, alpha * 0.8)
        loader.progressText.color = color(255, 255, 255, alpha)
        loader.progressBar.color = color(120, 0, 200, alpha * 0.6)
        
        sleep(16)
    end
    
    loader.introWindow:destroy()
end

-- Создание частицы
function loader.createParticle(x, y, dx, dy, color, life)
    local particle = {
        x = x, y = y,
        dx = dx, dy = dy,
        color = color,
        life = life,
        maxLife = life
    }
    table.insert(loader.animations.particles, particle)
end

-- Анимация распадания GUI
function loader.unloadAnimation()
    if loader.animations.unloading then return end
    
    loader.animations.unloading = true
    loader.status.text = "🔒 Статус: Unloading system..."
    loader.status.color = color(255, 100, 100, 255)
    
    -- Создаем трещины
    for i = 1, 20 do
        table.insert(loader.animations.crackParticles, {
            x = math.random(0, 400),
            y = math.random(0, 300),
            size = math.random(10, 30),
            life = 1.0
        })
    end
    
    -- Анимация трескания
    local crackTime = 2.0
    local startTime = os.clock()
    
    while os.clock() - startTime < crackTime do
        local progress = (os.clock() - startTime) / crackTime
        
        -- Дрожание элементов
        local shake = (1 - progress) * 5
        loader.title.x = 10 + math.random(-shake, shake)
        loader.keyInput.x = 10 + math.random(-shake, shake)
        
        -- Затемнение
        local alpha = 255 * (1 - progress)
        loader.window.color = color(25, 0, 40, alpha)
        
        -- Обновление частиц трещин
        for i, crack in ipairs(loader.animations.crackParticles) do
            crack.life = crack.life - 0.02
            crack.size = crack.size * 0.95
        end
        
        -- Удаление мертвых частиц
        for i = #loader.animations.crackParticles, 1, -1 do
            if loader.animations.crackParticles[i].life <= 0 then
                table.remove(loader.animations.crackParticles, i)
            end
        end
        
        sleep(16)
    end
    
    -- Финальное исчезновение
    loader.window:destroy()
    print("[EXLiver_Studios] System unloaded successfully!")
end

-- Основной GUI
function loader.createGUI()
    loader.window = gui.Window("EXLiver_Studios_Loader", loader.config.title .. " | " .. loader.config.version, 400, 400)
    loader.window.color = color(25, 0, 40, 255)
    
    -- Заголовок
    loader.title = gui.Label(loader.window, "🎮 " .. loader.config.title, 10, 20)
    loader.title.color = color(180, 70, 255, 255)
    loader.title.fontSize = 18
    loader.title.bold = true
    
    loader.subtitle = gui.Label(loader.window, loader.config.slogan, 10, 45)
    loader.subtitle.color = color(200, 120, 255, 200)
    loader.subtitle.fontSize = 12
    
    -- Разделитель
    loader.separator = gui.Rectangle(loader.window, 10, 70, 380, 1)
    loader.separator.color = color(120, 0, 200, 100)
    
    -- Поле ввода ключа
    loader.keyLabel = gui.Label(loader.window, "🔑 Введите лицензионный ключ:", 10, 90)
    loader.keyLabel.color = color(255, 255, 255, 220)
    
    loader.keyInput = gui.Textbox(loader.window, "key_input", "EXL-PREM-2024-XXX", 10, 115, 250, 25)
    loader.keyInput.color = color(40, 10, 60, 255)
    loader.keyInput.textColor = color(220, 180, 255, 255)
    
    -- Кнопка активации
    loader.activateBtn = gui.Button(loader.window, "⚡ АКТИВИРОВАТЬ", 270, 115, 120, 25)
    loader.activateBtn.color = color(120, 0, 200, 255)
    loader.activateBtn.hoverColor = color(160, 40, 255, 255)
    loader.activateBtn.textColor = color(255, 255, 255, 255)
    
    -- Список ключей
    loader.keysLabel = gui.Label(loader.window, "📋 Доступные ключи:", 10, 160)
    loader.keysLabel.color = color(255, 255, 255, 220)
    
    loader.keysList = gui.Listbox(loader.window, "keys_list", 10, 185, 380, 80)
    loader.keysList.color = color(30, 5, 50, 255)
    loader.keysList.textColor = color(200, 150, 255, 255)
    
    for i, key in ipairs(loader.config.validKeys) do
        loader.keysList:addItem("🔓 " .. key .. " - СВОБОДЕН")
    end
    
    -- Кнопки действий
    loader.buyBtn = gui.Button(loader.window, "🛒 КУПИТЬ КЛЮЧ - " .. loader.config.price .. "₽", 10, 275, 185, 25)
    loader.buyBtn.color = color(200, 60, 100, 255)
    loader.buyBtn.hoverColor = color(255, 80, 120, 255)
    loader.buyBtn.textColor = color(255, 255, 255, 255)
    
    loader.discordBtn = gui.Button(loader.window, "💬 DISCORD", 205, 275, 185, 25)
    loader.discordBtn.color = color(90, 100, 220, 255)
    loader.discordBtn.hoverColor = color(120, 130, 255, 255)
    loader.discordBtn.textColor = color(255, 255, 255, 255)
    
    loader.unloadBtn = gui.Button(loader.window, "❌ UNLOAD", 10, 310, 380, 25)
    loader.unloadBtn.color = color(150, 30, 30, 255)
    loader.unloadBtn.hoverColor = color(200, 50, 50, 255)
    loader.unloadBtn.textColor = color(255, 255, 255, 255)
    
    -- Статус
    loader.status = gui.Label(loader.window, "⏳ Статус: Ожидание ключа...", 10, 345)
    loader.status.color = color(255, 200, 50, 255)
end

-- Основные функции (остаются без изменений из предыдущей версии)
function loader.validateKey(key)
    for i, validKey in ipairs(loader.config.validKeys) do
        if key == validKey then
            return true, i
        end
    end
    return false, 0
end

function loader.activateSuccess(keyIndex)
    loader.status.text = "✅ Статус: Premium активирован! Добро пожаловать!"
    loader.status.color = color(50, 255, 100, 255)
    loader.keysList:setItem(keyIndex - 1, "🔒 " .. loader.config.validKeys[keyIndex] .. " - АКТИВИРОВАН")
    loader.activateBtn.active = false
    loader.keyInput.active = false
    loader.successAnimation()
end

function loader.mainLoop()
    loader.showIntro() -- Сначала показываем интро
    loader.createGUI()
    
    loader.activateBtn:setCallback(function()
        local key = loader.keyInput.text
        if key == "" then
            loader.status.text = "❌ Статус: Введите ключ!"
            loader.status.color = color(255, 100, 100, 255)
            return
        end
        
        local isValid, keyIndex = loader.validateKey(key)
        if isValid then
            loader.activateSuccess(keyIndex)
        else
            loader.status.text = "❌ Статус: Неверный ключ!"
            loader.status.color = color(255, 100, 100, 255)
        end
    end)
    
    loader.buyBtn:setCallback(function()
        loader.status.text = "🌐 Статус: Открытие сайта..."
        loader.status.color = color(100, 180, 255, 255)
        print("[EXLiver_Studios] Redirecting to: " .. loader.config.website)
        sleep(2000)
        loader.status.text = "📧 Свяжитесь с продавцом для покупки"
    end)
    
    loader.discordBtn:setCallback(function()
        loader.status.text = "💬 Статус: Открытие Discord..."
        loader.status.color = color(120, 140, 255, 255)
        print("[EXLiver_Studios] Discord: " .. loader.config.discord)
        sleep(2000)
        loader.status.text = "📱 Присоединяйтесь к нашему Discord!"
    end)
    
    loader.unloadBtn:setCallback(loader.unloadAnimation)
    
    print("[EXLiver_Studios] Main interface loaded successfully!")
    
    while loader.window:isActive() and not loader.animations.unloading do
        loader.pulseAnimation()
        sleep(16)
    end
end

-- Запуск системы
function loader.run()
    local success, err = pcall(loader.mainLoop)
    if not success then
        print("[EXLiver_Studios] Critical Error: " .. err)
    end
end

-- Автозапуск
if not _G.EXLIVER_STUDIOS_LOADED then
    _G.EXLIVER_STUDIOS_LOADED = true
    loader.run()
end

return loader