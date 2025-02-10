local colors = require "colors"

--[[
bar=(
  height=45
  color="$BAR_COLOR"
  border_width=2
  border_color="$BAR_BORDER_COLOR"
  shadow=off
  position=top
  sticky=on
  padding_right=10
  padding_left=10
  y_offset=-5
  margin=-2
  topmost=window
)
]]

local bar = {
  height = 40,
  color = colors.bar.background,
  padding_right = 2,
  padding_left = 2,
}

return bar
