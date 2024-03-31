return {
  nan = (0 / 0),
  isNan = (function(x) return tostring(x) == tostring(0 / 0) end),
  infinity = (math.huge),
  isFinite = (function(x) return x == x and x ~= math.huge and x ~= -math.huge end),
  abs = (math.abs),
  acos = (math.acos),
  asin = (math.asin),
  atan = (math.atan),
  atan2 = (function(y) return function(x) return math.atan2(y, x) end end),
  ceil = (math.ceil),
  cos = (math.cos),
  exp = (math.exp),
  floor = (math.floor),
  log = (math.log),
  max = (function(n1) return function(n2) return math.max(n1, n2) end end),
  min = (function(n1) return function(n2) return math.min(n1, n2) end end),
  pow = (function(n) return function(p) return math.pow(n, p) end end),
  remainder = (function(n) return function(m) return math.fmod(n, m) end end),
  round = (function(x) return math.floor(x + 0.5) end),
  sign = (function(x) return x == 0 or x ~= x and x or (x < 0 and -1 or 1) end),
  sin = (math.sin),
  sqrt = (math.sqrt),
  tan = (math.tan),
  trunc = (function(x) return x < 0 and math.ceil(x) or math.floor(x) end),
  fromStringImpl = (function(str)
    return function(isFinite)
      return function(just)
        return function(nothing)
          local x = tonumber(str)
          if x ~= math.huge and x ~= -math.huge then
            return just(x)
          else
            return nothing
          end
        end
      end
    end
  end)
}
