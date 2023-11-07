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
    ["<leader>h"] = {
      "null",
      "+harpoon"
    },
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
    ["<leader>1"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(1)<CR>", 
      "Jump to file 1"
    },
    ["<leader>2"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(2)<CR>", 
      "Jump to file 2"
    },
    ["<leader>3"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(3)<CR>", 
      "Jump to file 3"
    },
    ["<leader>4"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(4)<CR>", 
      "Jump to file 4"
    },
    ["<leader>5"] = {
      "<Cmd>lua require('harpoon.ui').nav_file(5)<CR>", 
      "Jump to file 5"
    },

    -- flash

    ["<leader>l"] = {
      "null",
      "+flash"
    },
    ["<leader>ls"] = {
      function() require("flash").jump() end,
      "Flash Jump"
    },
    ["<leader>lt"] = {
      function() require("flash").treesitter() end,
      "Flash Treesitter"
    },
    ["<leader>lr"] = {
      function() require("flash").treesitter_search() end,
      "Flash Treesitter Search"
    },

    ["<F2>"] = {
      "<Cmd>lua vim.lsp.buf.rename()<CR>", 
      "LSP Rename"
    },

    ["<F5>"] = {
      function() 
        --require("nvterm.terminal").send("ping 127.0.0.1", "vertical", "i")
        --vim.fn.feedkeys("<CR>")
        --require("harpoon.term").gotoTerminal(1)   
        --require("harpoon.term").sendCommand(1, "ping 127.0.0.1")  
        --require("harpoon.term").sendCommand(1, "dotnet run")  

        require("nvterm.terminal").send("ping 127.0.0.1", "vertical", "i")

        vim.cmd('startinsert')
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>',true,false,true),'m',true)
        -- vim.api.nvim_feedkeys("<Enter>", "i", true)
        ---vim.api.nvim_feedkeys("<CR>")

      end,
      "LSP Rename"
    },

    -- LSP

    ["<leader>lh"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },


  }, -- n
} -- M.general

-- more keybinds!

return M
