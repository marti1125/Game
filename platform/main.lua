function love.load()

    love.window.setMode(900, 700)

    myWorld = love.physics.newWorld(0, 500, false)
    myWorld:setCallbacks(beginContact, endContact, preSolve, postSolve)

    sprites = {}
    sprites.background = love.graphics.newImage("sprites/background.png")
    sprites.coin_sheet = love.graphics.newImage("sprites/coin_sheet.png")
    sprites.player_jump = love.graphics.newImage("sprites/player_jump.png")
    sprites.player_stand = love.graphics.newImage("sprites/player_stand.png")

    sounds = {}
    sounds.blip = love.audio.newSource("sound/blip.wav", "static")
    sounds.nature = love.audio.newSource("sound/nature.ogg", "static")

    require("player")
    require("coin")
    anim8 = require("anim8/anim8")
    sti = require("sti")
    cameraFile = require("hump/camera")
    show = require("show")

    cam = cameraFile()

    platforms = {}

    --spawnPlatform(50, 400, 300, 30)
    --spawnCoin(300,400)

    gameMap = sti("maps/map.lua")

    for i, m in ipairs(gameMap.layers["platform"].objects) do
        spawnPlatform(m.x, m.y, m.width, m.height)
    end

    for i, c in ipairs(gameMap.layers["coins"].objects) do
        spawnCoin(c.x, c.y)
    end

    gameState = 1

    myFont = love.graphics.newFont(40)

    timer = 0

    saveData = {}
    saveData.bestTime = 999

    if love.filesystem.getInfo("data.lua") then
        local data = love.filesystem.load("data.lua")
        data()
    end

end

function love.update(dt)
    
    myWorld:update(dt)
    playerUpdate(dt)
    gameMap:update(dt)
    coinUpdate(dt)

    cam:lookAt(player.body:getX(), love.graphics.getHeight()/2) -- player.body:getY()
    
    for i, c in ipairs(coins) do
        c.animation:update(dt)
    end

    if gameState == 2 then
        timer = timer + dt
    end

    if #coins == 0 and gameState == 2 then
        
        gameState = 1
        player.body:setPosition(198, 443)
        
        if #coins == 0 then
            for i, c in ipairs(gameMap.layers["coins"].objects) do
                spawnCoin(c.x, c.y)
            end
        end

        if timer < saveData.bestTime then
            saveData.bestTime = math.floor(timer)
            love.filesystem.write("data.lua", table.show(saveData, "saveData"))
        end

    end

end

function love.draw()

    sounds.nature:play()

    love.graphics.draw(sprites.background, 0, 0)

    cam:attach()

    gameMap:drawLayer(gameMap.layers["first_layer"])
    
    love.graphics.draw(player.sprite, player.body:getX(), player.body:getY(), nil, player.direction, 1, sprites.player_stand:getWidth()/2, sprites.player_stand:getHeight()/2)

    --for i, p in ipairs(platforms) do
        --love.graphics.rectangle("fill", p.body:getX(), p.body:getY(), p.width, p.height)
    --end

    for i, c in ipairs(coins) do
        c.animation:draw(sprites.coin_sheet, c.x, c.y, nil, nil, nil, 20.5, 21)
    end

    cam:detach()

    if gameState == 1 then
        love.graphics.setFont(myFont)
        love.graphics.printf("Click anywhere to begin!", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
        love.graphics.printf("Best time " .. saveData.bestTime, 0, 150, love.graphics.getWidth(), "center")
    end

    love.graphics.print("Time " .. math.floor(timer), 10, 660)

end

function love.keypressed(key, scancode, isrepeat)
    if key == "up" and player.grounded == true then
        player.body:applyLinearImpulse(0, -2500)
    end
    if gameState == 1 then
        gameState = 2
        timer = 0
    end
end

function spawnPlatform(x, y, width, height)
    
    local platform = {}
    platform.body = love.physics.newBody(myWorld, x, y, "static")
    platform.shape = love.physics.newRectangleShape(width/2, height/2, width, height)
    platform.fixture = love.physics.newFixture(platform.body, platform.shape)
    platform.width = width
    platform.height = height

    table.insert(platforms, platform)

end

function beginContact(a, b, coll)
    player.grounded = true
end

function endContact(a, b, coll)
    player.grounded = false
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((y1 - y2)^2 + (x1 - x2)^2)
end