local M = {}

M.base46 = {
  theme = 'onedark',
  changed_themes = {
    onedark = {
      base_16 = {
        base0F = '#CFECF7',
        base08 = '#C57626',
      },
    },
  },
  hl_add = {},
  hl_override = {},
  integrations = {},
  transparency = false,
  theme_toggle = { 'onedark', 'one_light' },
}

M.ui = {
  telescope = { style = 'bordered' }, -- borderless / bordered
}

return M
