local colors = require "colors"
local icons = require "icons"
local settings = require "settings"

local MAX_ITEMS = 15

local function create_menu_item(i)
  return {
    padding_left = settings.padding,
    padding_right = settings.padding,
    drawing = false,
    icon = { drawing = false },
    label = {
      font = {
        style = settings.font.style_map[i == 1 and "Heavy" or "Semibold"],
      },
      padding_left = 6,
      padding_right = 6,
    },
    click_script = "sketchymenus -s " .. i,
  }
end

local function update_menus(sbar, menu_padding, menu_items)
  sbar.exec("sketchymenus -l", function(menus)
    sbar.set("/menu\\..*/", { drawing = false })
    menu_padding:set { drawing = true }
    local id = 1
    for menu in string.gmatch(menus, "[^\r\n]+") do
      if id < MAX_ITEMS then
        menu_items[id]:set { label = menu, drawing = true }
      else
        break
      end
      id = id + 1
    end
  end)
end

local function create(sbar)
  local menu_watcher = sbar.add("item", { drawing = false, updates = false })
  local space_menu_swap = sbar.add("item", { drawing = false, updates = true })
  sbar.add("event", "swap_menus_and_spaces")

  local menu_items = {}

  for i = 1, MAX_ITEMS do
    local menu_name = "menu." .. i
    local menu_data = create_menu_item(i)
    local menu_item = sbar.add("item", menu_name, menu_data)
    menu_items[i] = menu_item
  end

  sbar.add("bracket", { "/menu\\..*/" }, {
    background = { color = colors.background.background }
  })

  local menu_padding = sbar.add("item", "menu.padding", {
    drawing = false,
    width = 5
  })

  menu_watcher:subscribe("front_app_switched", function(env)
    update_menus(sbar, menu_padding, menu_items)
  end)

  space_menu_swap:subscribe("swap_menus_and_spaces", function(env)
    local drawing = menu_items[1]:query().geometry.drawing == "on"

    if drawing then
      menu_watcher:set { updates = false }
      sbar.set("/menu\\..*/", { drawing = false })
      sbar.set("/space\\..*/", { drawing = true })
      sbar.set("front_app", { drawing = true })
    else
      menu_watcher:set { updates = true }
      sbar.set("/space\\..*/", { drawing = false })
      sbar.set("front_app", { drawing = false })
      update_menus(sbar, menu_padding, menu_items)
    end
  end)
end

return {
  create = create
}
