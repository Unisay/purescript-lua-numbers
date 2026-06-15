return {
  toPrecisionNative = (function(d)
    return function(n)
      -- JS toPrecision(d) keeps d SIGNIFICANT digits (switching to exponent
      -- form when needed); %f fixes d digits after the point, which is wrong
      -- for every input. %g is the significant-digit specifier.
      return string.format("%." .. tostring(d) .. "g", n)
    end
  end),
  toFixedNative = (function(d) return function(n) return string.format("%." .. tostring(d) .. "f", n) end end),
  toExponentialNative = (function(d)
    return function(n)
      -- C %e zero-pads the exponent to >=2 digits (e+03); JS toExponential
      -- uses the minimal number of exponent digits (e+3). Strip one leading
      -- zero from a single-digit exponent, leaving e+12 intact.
      local s = string.format("%." .. tostring(d) .. "e", n)
      return (s:gsub("([eE][%-+])0(%d)$", "%1%2"))
    end
  end),
  toString = (function(num)
    -- JS spells the non-finite values "Infinity"/"-Infinity"/"NaN"; Lua's
    -- tostring gives "inf"/"-inf"/"nan"/"-nan". (Finite values keep Lua's
    -- %.14g formatting, which is not the JS shortest-round-trip form.)
    if num ~= num then return "NaN" end
    if num == math.huge then return "Infinity" end
    if num == -math.huge then return "-Infinity" end
    return tostring(num)
  end)
}
