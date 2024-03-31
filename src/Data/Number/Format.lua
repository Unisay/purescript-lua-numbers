return {
  toPrecisionNative = (function(d) return function(n) return string.format("%." .. tostring(d) .. "f", number) end end),
  toFixedNative = (function(d) return function(n) return string.format("%." .. tostring(d) .. "d", number) end end),
  toExponentialNative = (function(d) return function(n) return string.format("%." .. tostring(d) .. "e", number) end end),
  toString = (function(num) return tostring(num) end)
}
