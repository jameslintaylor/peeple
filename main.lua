evil_img = nil
normal_img = nil
peeple = {x = 0, y = 0, is_evil = false}

function love.load()

  evil_img = love.graphics.newImage('pp-06.png')
  normal_img = love.graphics.newImage('pp-08.png')
end

function love.keypressed(key, scancode, isrepeat)
  if key == "space" then
    peeple.is_evil = not peeple.is_evil
  end
end

function love.update(dt)
  speed = peeple.is_evil and 20 or 2
  if love.keyboard.isDown("left") then
    peeple.x = peeple.x - speed
  elseif love.keyboard.isDown("up") then
    peeple.y = peeple.y - speed
  elseif love.keyboard.isDown("right") then
    peeple.x = peeple.x + speed
  elseif love.keyboard.isDown("down") then
    peeple.y = peeple.y + speed
  end 
end
 
function love.draw()
  love.graphics.setBackgroundColor(255,255,255)
  if peeple.is_evil then
    love.graphics.draw(evil_img, peeple.x, peeple.y, 0, 0.02)
  else
    love.graphics.draw(normal_img, peeple.x, peeple.y, 0, 0.02)
  end
end
