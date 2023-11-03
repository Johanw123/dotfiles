---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    -- add vertical terminal
      ["<leader>h"] = "",
  }
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    ["go"] = {
     "<Cmd>ClangdSwitchSourceHeader<CR>",
     "Switch header/source"
    },

    -- Harpoon
    ["<leader>ha"] = {
      "<Cmd>lua require('harpoon.mark').add_file()<CR>", 
      "Add file to harpoon"
    },
    ["<leader>hr"] = {
      "<Cmd>lua require('harpoon.mark').rm_file()<CR>", 
      "Remove file to harpoon"
    },
    ["<leader>hl"] = {
      "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", 
      "Toggle quick menu"
    },
    ["<leader>hn"] = {
      "<Cmd>lua require('harpoon.ui').nav_next()<CR>", 
      "Navigate next file"
    },
    ["<leader>hp"] = {
      "<Cmd>lua require('harpoon.ui').nav_prev()<CR>", 
      "Navigate previous file"
    },
    ["1"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(1)<CR>", 
      "Jump to file 1"
    },
    ["2"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(2)<CR>", 
      "Jump to file 2"
    },
    ["3"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(3)<CR>", 
      "Jump to file 3"
    },
    ["4"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(4)<CR>", 
      "Jump to file 4"
    },
    ["5"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(5)<CR>", 
      "Jump to file 5"
    },

    ["<leader>mo"] = {
      "<Cmd>lua require('mini.map').open()<CR>", 
      "Open mini map"
    },
  

  }, -- n
} -- M.general

-- more keybinds!

return M
