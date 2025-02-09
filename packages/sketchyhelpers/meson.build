project(
  'sketchyhelpers',
  'c',
  version: '0.1.0',
  default_options: {
    c_std: 'c99',
    warning_level: 3
  })

libsketchybar_dep = dependency('libsketchybar', fallback: ['libsketchybar', 'libsketchybar_dep'])

carbon_dep = dependency('Carbon', method: 'extraframework')
skylight_dep = dependency('SkyLight', method: 'extraframework')

inc = include_directories('include')

helper_src = files('src/helper.c')
menus_src = files('src/menus.c')

helper_deps = [
  libsketchybar_dep,
]

menus_deps = [
  carbon_dep
  skylight_dep
]

helper = executable('sketchyhelper', helper_src,
  include_directories : inc,
  dependencies : helper_deps,
  install: true)

menus = executable('sketchymenus', menus_src,
  dependencies: menus_deps,
  install: true)
