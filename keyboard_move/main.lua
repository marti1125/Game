
--load our assets
function love.load()
   --load all assets here
   --- create a character table, our character is a rectangle, the initial position of
   --- the character object in the x and y coordinate is defined in the table as 300 and 400 respectively

   character = {}
   character.x = 300
   character.y = 400
   character.speed = 100

   love.graphics.setBackgroundColor(225, 153, 0)

   -- paint character blue
   love.graphics.setColor(0, 0, 225)

end

--update event
function love.update(dt)
--do the maths

   --- On pressing the 'd' key, move to the right
   if love.keyboard.isDown('a') then
      character.x = character.x - character.speed * dt
   elseif love.keyboard.isDown('d') then
      character.x = character.x + character.speed * dt
   end

   --- if we press the 'W' key, move to the up
   if love.keyboard.isDown('s') then
      character.y = character.y + character.speed * dt
   elseif love.keyboard.isDown('w') then
      character.y = character.y - character.speed * dt
   end

end

--draw a rectangle
function love.draw()
--describe how you want/what to draw.
   love.graphics.rectangle("fill", character.x, character.y, 100, 100)
end
