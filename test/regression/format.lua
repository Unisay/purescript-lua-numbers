-- Regression guard for the Lua 5.1 FFI of Data.Number.Format.
-- Expected values come from the module docstring (Format.purs) = the JS
-- toPrecision/toFixed/toExponential/toString contract.
--
--   #92 toPrecisionNative: %g (d significant digits), not %f (d decimals).
--   #95 toExponentialNative: minimal exponent digits (e+3), not zero-padded (e+03).
--   #96 toString: "Infinity"/"-Infinity"/"NaN" for specials, not Lua "inf"/"nan".
-- Accepted divergences (per the number-format calibration): %g strips trailing
-- zeros toPrecision would keep; finite toString keeps Lua's %.14g precision;
-- toFixed uses banker's rounding at exact halves (#99).
--
-- Run from the repo root: `lua test/regression/format.lua`.
local M = assert(dofile("src/Data/Number/Format.lua"))

local failures = 0
local function check(name, got, want)
  if got == want then
    print("ok   - " .. name)
  else
    failures = failures + 1
    print("FAIL - " .. name .. ": got " .. tostring(got) .. ", want " .. tostring(want))
  end
end

-- #92 toPrecision: significant digits
check("toPrecision 6 of 1234.56789", M.toPrecisionNative(6)(1234.56789), "1234.57")
check("toPrecision 3 of 0.000123456", M.toPrecisionNative(3)(0.000123456), "0.000123")

-- #95 toExponential: minimal exponent digits
check("toExponential 2 of 1234.56789", M.toExponentialNative(2)(1234.56789), "1.23e+3")
check("toExponential 3 of 0.000123", M.toExponentialNative(3)(0.000123), "1.230e-4")
check("toExponential 0 of 5.0", M.toExponentialNative(0)(5.0), "5e+0")
-- two-digit exponents must stay intact (no over-stripping)
check("toExponential 2 of 1e12 keeps e+12", M.toExponentialNative(2)(1e12), "1.00e+12")

-- toFixed still uses %f (the prior %d->%f fix); semantics check, not rounding edge
check("toFixed 3 of 1234.56789", M.toFixedNative(3)(1234.56789), "1234.568")

-- #96 toString: special values
check("toString NaN", M.toString(0 / 0), "NaN")
check("toString +Infinity", M.toString(math.huge), "Infinity")
check("toString -Infinity", M.toString(-math.huge), "-Infinity")
-- finite values still produce a string (precision divergence accepted)
do
  local s = M.toString(42.0)
  check("toString finite is a string", type(s), "string")
end

if failures > 0 then error(failures .. " regression check(s) failed") end
print("purescript-lua-numbers (Format): all FFI regression checks passed")
