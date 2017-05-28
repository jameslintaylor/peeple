local exports = {}

function curry(func, num_args)
  num_args = num_args or debug.getinfo(func, "u").nparams
  if num_args < 2 then return func end
  local function helper(argtrace, n)
    if n < 1 then
      return func(unpack(flatten(argtrace)))
    else
      return function (...)
        return helper({argtrace, ...}, n - select("#", ...))
      end
    end
  end
  return helper({}, num_args)
end

function flatten(t)
  local ret = {}
  for _, v in ipairs(t) do
    if type(v) == 'table' then
      for _, fv in ipairs(flatten(v)) do
        ret[#ret + 1] = fv
      end
    else
      ret[#ret + 1] = v
    end
  end
  return ret
end

exports.curry = curry


csetmetatable = function(t)
  return function(mt)
    return setmetatable(t,mt)
  end
end

exports.csetmetatable = csetmetatable

function reverse(tbl)
  for i=1, math.floor(#tbl / 2) do
    tbl[i], tbl[#tbl - i + 1] = tbl[#tbl - i + 1], tbl[i]
  end
end

exports.reverse = reverse

function map(f, seq)
  mapped = {}
  for i, element in ipairs(seq) do
    mapped[i] = f(element)
  end
  return mapped
end

exports.map = map

function take(n, seq)
  taken = 0
  took = {}
  while taken < n do
    i = taken + 1
    took[i] = seq[i]
    taken = taken + 1
  end
  return took
end

exports.take = take

return exports
