function love.load()
 
end
 
function love.update(dt)
 
end
 
function love.draw()
  love.graphics.print("Hello!",400,300)
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill", 300, 300, 50, 100) -- Draw white circle with 100 segments.
end

