function love.load()
    --number = 0
    button = {}
    button.x = 200
    button.y = 200
    button.size = 50

    score = 0
    timer = 10

    myFont = love.graphics.newFont(40)

    gameState = 1

end

function love.update(dt)
    --number = number + 1
    if gameState == 2 then
        if timer > 0 then
            timer = timer - dt
        end
        if timer < 0 then
            timer = 0
            gameState = 1
        end   
    end
    
end

function love.draw()
    --love.graphics.print(number)
    --love.graphics.setColor(0, 0, 100)
    --love.graphics.rectangle("fill",200,400,200,100)
    if gameState == 2 then
        love.graphics.setColor(0, 100, 100)
        love.graphics.circle("fill", button.x, button.y, button.size)
    end
    
    
    love.graphics.setFont(myFont)
    love.graphics.setColor(255, 255, 255)   
    love.graphics.print("Score " .. score)
    love.graphics.print("Time " .. math.ceil(timer), 300, 0)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin!", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    end

end

function love.mousepressed(x, y, b, istouch)
    if b == 1 and gameState == 2 then
        if distanceBetween(button.x, button.y, love.mouse.getX(), love.mouse.getY()) < button.size then
            score = score + 1
            button.x = math.random(0, love.graphics.getWidth() - button.size)
            button.y = math.random(0, love.graphics.getHeight() - button.size)
        end
    end
    if gameState == 1 then
        gameState = 2
        timer = 10
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((y1 - y2)^2 + (x1 - x2)^2)
end