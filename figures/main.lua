--load our assets
function love.load()
   --load all assets here

   --- set color for our shapes RGB
   love.graphics.setColor(0, 0, 0, 225)

   --- set the background color RGB
   love.graphics.setBackgroundColor(225, 153, 0)

end

--update event
function love.update(dt)
--do the maths
end


--draw display
function love.draw()
--describe how you want/what to draw.

   ---draw circle with parameters(mode, x-pos, y-pos, radius, segments)
   love.graphics.circle("fill", 200, 300, 50, 50)

   ---draw rectangle with parameters(mode, x-pos, y-pos, width, height
   love.graphics.rectangle("fill", 300, 300, 100, 100)

   ---draw an arc with parameters(mode,x-pos,y-pos,radius,angle1,angle2)
   love.graphics.arc("fill", 450, 300, 100, math.pi/5, math.pi/2)

end
