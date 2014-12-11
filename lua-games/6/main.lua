--local Quad = {} --love.graphics.newQuad

function Quad:flip( sx, sy ) -- sx, sy = new scale for Quad.
   self.sx, self.sy = nx, ny
end

--load our assets
function love.load()
--load all assets here
   character= {}
   character.player = love.graphics.newImage("sprite.png")
   character.x = 50
   character.y = 50
   direction = "right"
   iteration = 1

   max = 8

   idle = true
   timer = 0.1
   quads = {}
   quads['right'] ={}
   quads['left'] = {}

   for j=1,8 do
       quads['right'][j] = Quad((j-1)*32, 0, 32, 32, 256, 32);
       quads['left'][j] = Quad((j-1)*32, 0, 32, 32, 256, 32);
       -- for the character to face the opposite direction, the quad need to be flipped by using the Quad:flip(x, y) method, where x and why are Boolean. 
      quads.left[j]:flip(true, false) --flip horizontally x = true, y = false
   end

end
 
--update event
function love.update(dt)
--do the maths
   if idle == false then
      timer = timer + dt
      if timer > 0.2 then
         timer = 0.1
         -- The animation will play as the iteration increases, so we just write iteration = iteration + 1, also we'll stop reset our iteration at the maximum of 8 with a timer update to keep the animation smooth.
         iteration = iteration + 1
         if love.keyboard.isDown('right') then
            character.x = character.x + 5
         end
         if love.keyboard.isDown('left') then
            character.x = character.x - 5
         end
         if iteration > max then
             iteration = 1
         end
      end
   end
end

function love.keypressed(key)
   if quads[key] then
      direction = key
      idle = false
   end
end

function love.keyreleased(key)
   if quads[key] and direction == key then
      idle = true
      iteration = 1
      direction = "right"
   end 
end

--draw display
function love.draw()
--describe how you want/what to draw.
   love.graphics.drawq(character.player, quads[direction][iteration], character.x, character.y)
end
