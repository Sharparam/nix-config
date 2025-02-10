local settings = require "settings"
local colors = require "colors"

--[[
defaults=(
  updates=when_shown
  icon.color="$ICON_COLOR"
  icon.padding_left="$PADDING"
  icon.padding_right="$PADDING"
  label.color="$LABEL_COLOR"
  label.padding_left="$PADDING"
  label.padding_right="$PADDING"
  padding_left="$PADDING"
  padding_right="$PADDING"
  background.height=26
  background.corner_radius=9
  background.border_width=2
  popup.background.border_width=2
  popup.background.corner_radius=9
  popup.background.border_color="$POPUP_BORDER_COLOR"
  popup.background.color="$POPUP_BACKGROUND_COLOR"
  popup.background.shadow.drawing=on
  popup.blur_radius=20
  scroll_texts=on
)
]]

local default = {
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map.Bold,
      size = 14.0
    },
    color = colors.icon.foreground,
    padding_left = settings.padding,
    padding_right = settings.padding,
    background = { image = { corner_radius = 9 } },
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map.Semibold,
      size = 13.0
    },
    color = colors.label.foreground,
    padding_left = settings.padding,
    padding_right = settings.padding,
  },
  background = {
    height = 28,
    corner_radius = 9,
    border_width = 2,
    border_color = colors.background.border,
    image = {
      corner_radius = 9,
      border_color = colors.grey,
      border_width = 1
    }
  },
  popup = {
    background = {
      border_width = 2,
      corner_radius = 9,
      border_color = colors.popup.border,
      color = colors.popup.background,
      shadow = { drawing = true },
    },
    blur_radius = 50,
  },
  padding_left = 5,
  padding_right = 5,
  scroll_texts = true,
}

return default
