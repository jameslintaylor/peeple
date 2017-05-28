helpers = require "helpers"

-- animations

function animation(keyframes, frame_duration)
  return {
    keyframes = keyframes,
    num_frames = #keyframes,
    frame_duration = frame_duration
  }
end

AnimationBox = {}

function AnimationBox:new(animation)
  self.__index = self
  return helpers.csetmetatable{
    animation = animation,
    t = 0,
    frame = 0
  }(self)
end

function AnimationBox:reverse()
  helpers.reverse(self.animation.keyframes)
end

function AnimationBox:pop_frame(dt)
  frame = self.animation.keyframes[self.frame + 1]
  if (self.t + dt) > self.animation.frame_duration then
    self.t = (self.t + dt) % self.animation.frame_duration
    self.frame = (self.frame + 1) % self.animation.num_frames
  else
    self.t = self.t + dt
  end
  return frame
end

function AnimationBox:recenter()
  self.frame = 0
end

-- haha like a box set you know 
function box_set()

  function load_resource(filename)
    return love.graphics.newImage("resources/" .. filename)
  end

  function c_prefix(prefix)
    return function(postfix)
      return prefix .. postfix
    end
  end

  function c_postfix(postfix)
    return function(prefix)
      return prefix .. postfix
    end
  end

  numbered = map(c_postfix(".png"), {"01","02","03","04","05","06","07","08","09","10"})

  walking_left = animation(map(load_resource, map(c_prefix("walking-left-"), take(8, numbered))), 0.1)
  walking_right = animation(map(load_resource, map(c_prefix("walking-right-"), take(8, numbered))), 0.1)
  running_left = animation(map(load_resource, map(c_prefix("running-left-"), take(8, numbered))), 0.1)
  running_right = animation(map(load_resource, map(c_prefix("running-right-"), take(8, numbered))), 0.1)

  return {
    ["chilling"] = AnimationBox:new(animation({love.graphics.newImage("resources/chilling.png")}, 1)),
    ["walking-left"] = AnimationBox:new(walking_left),
    ["walking-right"] = AnimationBox:new(walking_right),
    ["running-left"] = AnimationBox:new(running_left),
    ["running-right"] = AnimationBox:new(running_right)
  }
end

return {
  box_set = box_set
}
