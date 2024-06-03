_G.state = "RN"
_G.boot_screen = gpu.getScreen()

local component = component
local computer = computer
local unicode = unicode
local uptime = computer.uptime
local pull = computer.pullSignal
local last_sleep = uptime()

do
  local addr, invoke = computer.getBootAddress(), component.invoke
  local w, h = gpu.getResolution()
  local screen = component.list("screen", true)()
  local gpu = screen and component.list("gpu", true)()
  if gpu then
    gpu = component.proxy(gpu)
    if not gpu.getScreen() then
      gpu.bind(screen)
    end
    w, h = gpu.maxResolution()
    gpu.setResolution()
    gpu.setBackground(0x171717)
    gpu.setForeground(0x66FF00)
  end
  local function loadfile(file)
    local handle = assert(invoke(addr, "open", file))
    local buffer = ""
    repeat
      local data = invoke(addr, "read", handle, math.maxinteger or math.huge)
      buffer = buffer .. (data or "")
    until not data
    invoke(addr, "close", handle)
    return load(buffer, "=" .. file, "bt", _G)
  end
  loadfile("/core/boot.lua")(loadfile)
end
