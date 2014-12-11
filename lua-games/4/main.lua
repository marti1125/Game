--variables
local angle = 0
local width = 100
local height = 100

--load our assets
function love.load()
   --load all assets here

end

--update event
function love.update(dt)
--do the maths

   --- On pressing the 'd' key, rotate to the right
   if love.keyboard.isDown('d') then
      angle = angle + math.pi * dt

   --- else if we press the 'a' key, rotate to the left
   elseif love.keyboard.isDown('a') then
      angle = angle - math.pi * dt
   end

end


--draw a rectangle
function love.draw()
--describe how you want/what to draw.

   -- rotate
   love.graphics.rotate(angle)

   -- draw a blue rectangle
   love.graphics.setColor(0,0,225)
   love.graphics.rectangle('fill', 300, 400, width, height)

end
