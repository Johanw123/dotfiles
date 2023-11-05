---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  changed_themes = {
    onedark = {
       base_16 = {
         -- base00 = "#1AF80E",
          base0F = "#CFECF7",
          base08 = "#C57626",
       },
      --  base_30 = {
      --     red = "#1AF80E",
      --     white = "#1AF80E",
      --     baby_pink = "#1AF80E",
      --     pink = "#1AF80E",
      --     orange = "#1AF80E",
      --  },
    },
 },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
