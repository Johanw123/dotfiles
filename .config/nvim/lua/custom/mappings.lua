---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    -- add vertical terminal
      ["<leader>h"] = "",

    -- new buffer
    ["<leader>b"] = "",
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

    ["<leader><leader>x"] = {
      "<Plug>PlenaryTestFile",
      "TestFile"
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

        -- LSP

    ["<leader>lh"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },
      
    -- Dap

    ["-"] = {
    "<Cmd>lua require('oil').open(require('oil').get_current_dir())<CR>",
    "Open parent directory"
    },


  }, -- n

} -- M.general

M.nvim_dap = {
	n = {
		-- ["<leader>dl"] = { "<cmd>lua require'dap'.step_into()<CR>", "debugger step into" },
		-- ["<leader>dj"] = { "<cmd>lua require'dap'.step_over()<CR>", "debugger step over" },
		-- ["<leader>dk"] = { "<cmd>lua require'dap'.step_out()<CR>", "debugger step out" },
		-- ["<leader>d<space>"] = { "<cmd>lua require'dap'.continue()<CR>", "debugger continue" },
		-- ["<leader>dbp"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "debugger toggle breakpoint" },
		-- ["<leader>dd"] = {
		-- 	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
		-- 	"debugger set conditional breakpoint",
		-- },
		-- ["<leader>de"] = { "<cmd>lua require'dap'.terminate()<CR>", "debugger reset" },
		-- ["<leader>dr"] = { "<cmd>lua require'dap'.run_last()<CR>", "debugger reset" },
		-- map("n", "<leader>m", ":MaximizerToggle!<CR>", { noremap = true })

    ["<leader>b"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "debugger toggle breakpoint" },
    ["<leader>B"] = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "debugger set conditional breakpoint" },

    ["<leader>de"] = { "<cmd>lua require'dap'.terminate()<CR>", "debugger reset" },

    ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "debugger continue" },

    --step into
    ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "debugger continue" },
    --step out
    ["<S-F11>"] = { "<cmd>lua require'dap'.step_out()<CR>", "debugger continue" },
    --step over
    ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "debugger continue" },
	},
}

-- more keybinds!

return M
