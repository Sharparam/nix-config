local palette = require "colors.catppuccin.frappe"

local colors = {
  white = 0xffffffff,
  black = 0xff000000,
  transparent = 0x00000000,

  background = {
    background = palette.mantle,
    border = palette.surface1,
  },
  bar = {
    background = palette.base,
    border = palette.surface1
  },
  popup = {
    background = palette.base,
    border = palette.surface1,
  },
  icon = {
    foreground = palette.text
  },
  label = {
    foreground = palette.text
  },
  shadow = palette.crust,

  gray = 0xff7f8490,

  green = palette.green,
  red = palette.red,
  blue = palette.blue,
  yellow = palette.yellow,
  pink = palette.pink,
}

local color_keys = {
  "rosewater",
  "flamingo",
  "pink",
  "mauve",
  "red",
  "maroon",
  "peach",
  "yellow",
  "green",
  "teal",
  "sky",
  "sapphire",
  "blue",
  "lavender"
}

function colors.random()
  local key = color_keys[math.random(1, #color_keys)]
  return palette[key]
end

local function with_alpha_float(color, alpha)
  if alpha > 1.0 or alpha < 0.0 then return color end
  return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

function colors.with_alpha(color, alpha)
  if math.type(alpha) == "float" then
    return with_alpha_float(color, alpha)
  end

  if alpha > 0xff or alpha < 0x00 then return color end

  return (color & 0x00ffffff) | (alpha << 24)
end

return colors
