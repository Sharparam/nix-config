local sbar = require("sketchybar")

-- _G.sbar = sbar

sbar.begin_config()

local bar = require "bar"
sbar.bar(bar)

local default = require "default"
sbar.default(default)

local items = require "items"
for _, item in ipairs(items) do
  item.create(sbar)
end

sbar.end_config()

sbar.event_loop()
