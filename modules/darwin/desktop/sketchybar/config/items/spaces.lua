local colors = require "colors"
local icons = require "icons"
local settings = require "settings"
local app_icons = require "utils.app_icons"

local APP_FONT = "sketchybar-app-font:Regular:16.0"
local NERD_FONT = "Symbols Nerd Font:Regular:16.0"

local MAX_SPACES = 9

--[[
  1: main
  2: code
  3: web
  4: comms
  5: media
  6: misc
  7: scratch
--]]
local ICON_OVERRIDES = {
  [2] = {
    font = NERD_FONT,
    string = " ",
  },
  [3] = {
    font = NERD_FONT,
    string = " ",
  },
  [4] = {
    font = NERD_FONT,
    string = " ",
  },
  [5] = {
    font = NERD_FONT,
    string = " ",
  },
}

local function override(target, source)
  for k, v in pairs(source) do
    if type(v) == "table" and type(target[k]) == "table" then
      override(target[k], v)
    else
      target[k] = v
    end
  end
end

local function create_space_item(i)
  local overrides = ICON_OVERRIDES[i]
  local icon = {
    font = { family = settings.font.numbers },
    string = i,
    padding_left = 15,
    padding_right = 8,
    color = colors.white,
    highlight_color = colors.red,
  }

  if overrides then
    override(icon, overrides)
  end

  return {
    space = i,
    icon = icon,
    label = {
      padding_right = 20,
      color = colors.label.foreground,
      highlight_color = colors.white,
      font = APP_FONT,
      y_offset = -1,
    },
    padding_left = 1,
    padding_right = 1,
    background = {
      color = colors.background.background,
      border_width = 1,
      height = 26,
      border_color = colors.black,
    },
    popup = {
      background = {
        border_width = 5,
        border_color = colors.black,
      },
    },
  }
end

local function create(sbar)
  local spaces = {}
  for i = 1, MAX_SPACES do
    local space_data = create_space_item(i)
    local space = sbar.add("space", "space." .. i, space_data)
    spaces[i] = space

    local space_bracket = sbar.add("bracket", { space.name }, {
      background = {
        color = colors.transparent,
        border_color = colors.background.border,
        height = 28,
        border_width = 2,
      },
    })

    sbar.add("space", "space.padding." .. i, {
      space = i,
      script = "",
      width = settings.group_padding,
    })

    local space_popup = sbar.add("item", {
      position = "popup." .. space.name,
      padding_left = 5,
      padding_right = 0,
      background = {
        drawing = true,
        image = {
          corner_radius = 9,
          scale = 0.2,
        },
      },
    })

    space:subscribe("space_change", function(env)
      local selected = env.SELECTED == "true"
      local color = selected and colors.gray or colors.background.background
      space:set {
        icon = { highlight = selected },
        label = { highlight = selected },
        background = { border_color = selected and colors.black or colors.background.background },
      }
      space_bracket:set {
        background = { border_color = selected and colors.gray or colors.background.background },
      }
    end)

    space:subscribe("mouse.clicked", function(env)
      if env.BUTTON == "other" then
        space_popup:set { background = { image = "space." .. env.SID } }
        space:set { popup = { drawing = "toggle" } }
      else
        local op = (env.BUTTON == "right") and "--destroy" or "--focus"
        sbar.exec("yabai -m space " .. op .. " " .. env.SID)
      end
    end)

    space:subscribe("mouse.exited", function(_)
      space:set { popup = { drawing = false } }
    end)
  end

  local space_window_observer = sbar.add("item", { drawing = false, updates = true })

  local spaces_indicator = sbar.add("item", {
    padding_left = -3,
    padding_right = 0,
    icon = {
      padding_left = 8,
      padding_right = 9,
      color = colors.gray,
      string = icons.switch.on,
    },
    label = {
      width = 0,
      padding_left = 0,
      padding_right = 8,
      string = "Spaces",
      color = colors.background.background,
    },
    background = {
      color = colors.with_alpha(colors.gray, 0),
      border_color = colors.with_alpha(colors.background.background, 0),
    },
  })

  space_window_observer:subscribe("space_windows_change", function(env)
    local icon_line = ""
    local no_app = true
    for app, count in pairs(env.INFO.apps) do
      no_app = false
      local lookup = app_icons[app]
      local icon = lookup == nil and app_icons.Default or lookup
      icon_line = icon_line .. icon
    end

    if no_app then
      icon_line = " —"
    end

    sbar.animate("tanh", 10, function()
      spaces[env.INFO.space]:set { label = icon_line }
    end)
  end)

  spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
    local currently_on = spaces_indicator:query().icon.value == icons.switch.on
    spaces_indicator:set {
      icon = currently_on and icons.switch.off or icons.switch.on,
    }
  end)

  spaces_indicator:subscribe("mouse.entered", function(env)
    sbar.animate("tanh", 30, function()
      spaces_indicator:set {
        background = {
          color = { alpha = 1.0 },
          border_color = { alpha = 1.0 },
        },
        icon = { color = colors.background.background },
        label = { width = "dynamic" },
      }
    end)
  end)

  spaces_indicator:subscribe("mouse.exited", function(env)
    sbar.animate("tanh", 30, function()
      spaces_indicator:set {
        background = {
          color = { alpha = 0 },
          border_color = { alpha = 0 },
        },
        icon = { color = colors.gray },
        label = { width = 0 },
      }
    end)
  end)

  spaces_indicator:subscribe("mouse.clicked", function(env)
    sbar.trigger "swap_menus_and_spaces"
  end)
end

return {
  create = create,
}
