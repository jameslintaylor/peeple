fun = require "luafun/fun"
helpers = require "helpers"

-- 2d coordinates primitive
Coordinates = {}

Coordinates.new = function(x,y)
  return helpers.csetmetatable{x=x,y=y}(Coordinates)
end

Coordinates.__add = function(lhs, rhs)
  return helpers.csetmetatable{
    x = lhs.x + rhs.x,
    y = lhs.y + rhs.y,
  }(Coordinates)
end

-- Animations

Keyframe = {}

Keyframe.new = function(drawable,duration)
  return {
    drawable=drawable,
    duration=duration,
  }
end

KeyframeSequence = {}

-- frame_factory = framenumber -> keyframe?
KeyframeSequence.new = function(frame_factory)
  frames = fun.take_while(
    function(frame) return frame ~= nil end,
    fun.tabulate(function(n) return frame_factory(n) end)
  )
end

-- tests
a = Coordinates.new(4,2)
b = Coordinates.new(6,9)
c = a + b

print(c.x)

