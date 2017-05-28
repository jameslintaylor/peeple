animations = require "animations"

abs = nil

peeple = {
  frame = nil,
  x = 400,
  y = 200,
  is_running = false,
  state = "walking-left"
}

function love.load()
  abs = animations.box_set()
end

function love.keypressed(key, scancode, isrepeat)
  if key == "lshift" then
    peeple.is_running = not peeple.is_running
  end
end

function love.update(dt)
  
  -- ;_;
  speed = peeple.is_running and 5 or 2
  
  if love.keyboard.isDown("left") then
    peeple.x = peeple.x - speed
    peeple.state = peeple.is_running and "running-left" or "walking-left"
  elseif love.keyboard.isDown("right") then
    peeple.x = peeple.x + speed
    peeple.state = peeple.is_running and "running-right" or "walking-right"
  else
    peeple.state = "chilling"
  end
  peeple.frame = abs[peeple.state]:pop_frame(dt)
end
 
function love.draw()
  love.graphics.setBackgroundColor(255,255,255)
  love.graphics.draw(peeple.frame, peeple.x, peeple.y, 0, 0.05)
end
