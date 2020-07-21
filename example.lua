local function a()
  error("example error") --# line 2
end

local function b()
  a() --# line 6
end

local function c()
  b() --# line 10
end

c() --# line 13
