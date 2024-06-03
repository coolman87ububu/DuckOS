local raw_loadfile = ...


_G.VER = "DUCKOS 1.0"

local component = component
local computer = computer
local unicode = unicode
local uptime = computer.uptime
local pull = computer.pullSignal
local last_sleep = uptime()

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
  gpu.fill(0, 0, w/2, h/2, "X")
end