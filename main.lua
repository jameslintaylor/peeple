animations = require "animations"

-- a world of objects
objects = {
  peeple = {
    is_running = false,
    state = "chilling"
  }
}

peeple = objects.peeple

function vector(x, y)
  return {
    x = x,
    y = y
  }
end

forcemap = {
  ["running-left"] = vector(-40, 0),
  ["walking-left"] = vector(-20, 0),
  ["running-right"] = vector(-40, 0),
  ["walking-right"] = vector(20, 0),
  jumping = vector(0, 0),
  chilling = vector(0, 0),
}

function love.load()
  abs = animations.box_set()

  -- world
  love.physics.setMeter(400)
  world = love.physics.newWorld(0, 5000, true)

  -- peeple
  objects.peeple.body = love.physics.newBody(world, 10, 100, "dynamic")
  objects.peeple.shape = love.physics.newRectangleShape(20, 100)
  objects.peeple.fixture = love.physics.newFixture(objects.peeple.body, objects.peeple.shape)
  
  -- floor
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2, "static")
  objects.ground.shape = love.physics.newRectangleShape(650, 50)
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

  -- left and right wall
  objects.left = {}
  objects.left.body = love.physics.newBody(world, 0, 650/2, "static")
  objects.left.shape = love.physics.newRectangleShape(1, 650)
  objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape)

  love.window.setMode(650, 650, {msaa = 16}) 
  love.graphics.setBackgroundColor(255, 255, 255)
end

function love.keypressed(key, scancode, isrepeat)
  if key == "lshift" then
    peeple.is_running = not peeple.is_running
  end

  if key == "space" then
    objects.peeple.body:applyForce(0, -1000)
    abs.jumping:recenter()
  end
end

function love.update(dt)
  world:update(dt)
  peeple.state = next_state(peeple, love.keyboard)
  peeple.frame = abs[peeple.state]:pop_frame(dt)

  f = forcemap[peeple.state]
  objects.peeple.body:applyForce(f.x, f.y)
end
 
function love.draw()
  love.graphics.draw(peeple.frame, peeple.body:getX(), peeple.body:getY(), 0, 0.1)
end

function next_state(peeple, kbd)
  if kbd.isDown("left") then
    return peeple.is_running and "running-left" or "walking-left"
  elseif kbd.isDown("right") then
    return peeple.is_running and "running-right" or "walking-right"
  else
    return "jumping"
  end
end
