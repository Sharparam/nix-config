local colors = require "colors"
local icons = require "icons"
local settings = require "settings"

local item = {
  icon = {
    font = { size = 16.0 },
    string = icons.apple,
    padding_left = 8,
    padding_right = 8
  },
  label = { drawing = false },
  background = {
    color = colors.background.background,
    border_color = colors.black,
    border_width = 1,
  },
  padding_left = 1,
  padding_right = 1,
  click_script = "sketchymenus -s 0",
}

local function create(sbar)
  sbar.add("item", { width = 5 })
  local apple = sbar.add("item", item)
  sbar.add("bracket", { apple.name }, {
    background = {
      color = colors.transparent,
      height = 30,
      border_color = colors.background.border,
    }
  })
  sbar.add("item", { width = 7 })
end

return {
  create = create
}
