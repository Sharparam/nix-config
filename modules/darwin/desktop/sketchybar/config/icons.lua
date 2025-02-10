local settings = require "settings"

local mt = {
  __tostring = function() return "Missing Icon" end,
  __index = function(t, k)
    return setmetatable({}, getmetatable(t))
  end
}

local function make_icons(icons)
  return setmetatable(icons, mt)
end

--[[
  # svim
  MODE_NORMAL=􀂯
  MODE_INSERT=􀂥
  MODE_VISUAL=􀂿
  MODE_CMD=􀂙
  MODE_PENDING=􀈏
]]

local sf_symbols = make_icons {
  plus = "􀅼",
  loading = "􀖇",
  apple = "􀣺",
  gear = "􀍟",
  cpu = "􀫥",
  clipboard = "􀉄",
  preferences = "􀺽",
  activity = "􀒓",
  lock = "􀒳",
  bell = "􀋚",
  bell_dot = "􀝗",

  switch = {
    on = "􁏮",
    off = "􁏯",
  },
  volume = {
    _100 = "􀊩",
    _66 = "􀊧",
    _33 = "􀊥",
    _10 = "􀊡",
    _0 = "􀊣",
  },
  battery = {
    _100 = "􀛨",
    _75 = "􀺸",
    _50 = "􀺶",
    _25 = "􀛩",
    _0 = "􀛪",
    charging = "􀢋"
  },
  wifi = {
    upload = "􀄨",
    download = "􀄩",
    connected = "􀙇",
    disconnected = "􀙈",
    router = "􁓤",
  },
  media = {
    back = "􀊊",
    forward = "􀊌",
    play_pause = "􀊈",
  },

  git = {
    issue = "􀍷",
    discussion = "􀒤",
    pull_request = "􀙡",
    commit = "􀡚",
    indicator = "􀂓",
  },

  spotify = {
    back = "􀊎",
    play_pause = "􀊈",
    next = "􀊐",
    shuffle = "􀊝",
    ["repeat"] = "􀊞",
  },

  yabai = {
    stack = "􀏭",
    fullscreen_zoom = "􀏜",
    parent_zoom = "􀥃",
    float = "􀢌",
    grid = "􀧍",
  }
}

-- Alternative NerdFont icons
local nerdfont = make_icons {
  plus = "",
  loading = "",
  apple = "",
  gear = "",
  cpu = "",
  clipboard = "Missing Icon",

  switch = {
    on = "󱨥",
    off = "󱨦",
  },
  volume = {
    _100 = "",
    _66 = "",
    _33 = "",
    _10 = "",
    _0 = "",
  },
  battery = {
    _100 = "",
    _75 = "",
    _50 = "",
    _25 = "",
    _0 = "",
    charging = ""
  },
  wifi = {
    upload = "",
    download = "",
    connected = "󰖩",
    disconnected = "󰖪",
    router = "Missing Icon"
  },
  media = {
    back = "",
    forward = "",
    play_pause = "",
  },
}

if settings.icon_type == "NerdFont" then
  return nerdfont
else
  return sf_symbols
end
