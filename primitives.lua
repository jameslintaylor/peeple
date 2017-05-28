fun = require "luafun/fun"
helpers = require "helpers"

-- coordinates
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


