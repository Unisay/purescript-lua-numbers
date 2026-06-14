-- Regression guard: Format.lua must use its bound argument n, not an
-- unbound `number` global (nil at runtime, which made every formatter error).
local M = assert(dofile("src/Data/Number/Format.lua"))

assert(type(M.toPrecisionNative(6)(1234.56789)) == "string",
  "toPrecisionNative must format its bound argument, not error on a nil global")

print("OK Format.lua uses the bound argument n")
