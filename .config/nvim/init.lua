vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.cindent = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cmdheight = 0
vim.g.have_nerd_font = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.linespace = 5
vim.opt.foldminlines = 0 -- Allow folding/hiding single lines
vim.opt.fillchars = "fold: " -- Remove the trailing dots
vim.opt.shell = 'fish'

-- vim.g.OmniSharp_highlighting = 1
-- vim.g.OmniSharp_server_use_net6 = 1
-- vim.g.OmniSharp_selector_ui = 'fzf'
vim.g.editorconfig = false

-- nv base46 color theme
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
dofile(vim.g.base46_cache .. v)
end

vim.opt.diffopt = 'internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram'
vim.o.completeopt = 'menu,noinsert,popup,fuzzy,preview'


vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })




vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end, { desc = 'Search File' })
vim.keymap.set('n', '<C-n>', function() Snacks.picker.explorer() end, { desc = 'Explorer' })

vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Grep Word' })

local lsp_keybinds = function(opts)

	vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)
	vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, opts)
	vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, opts)
	vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, opts)

	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)

end

vim.keymap.set('n', 'go', '<Cmd>ClangdSwitchSourceHeader<CR>', { desc = 'Switch header/source (C++)' })

-- Harpoon
vim.keymap.set('n', '<leader>ha', "<Cmd>lua require('harpoon.mark').add_file()<CR>", { desc = 'Add file' })
vim.keymap.set('n', '<leader>hr', "<Cmd>lua require('harpoon.mark').rm_file()<CR>", { desc = 'Remove file' })
vim.keymap.set('n', '<leader>hl', "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = 'Toggle quick menu' })
vim.keymap.set('n', '<leader>hn', "<Cmd>lua require('harpoon.ui').nav_next()<CR>", { desc = 'Navigate next file' })
vim.keymap.set('n', '<leader>hp', "<Cmd>lua require('harpoon.ui').nav_prev()<CR>", { desc = 'Navigate previous file' })

vim.keymap.set('n', '<leader>1', "<Cmd>lua require('harpoon.ui').nav_file(1)<CR>", { desc = 'Harpoon to file 1' })
vim.keymap.set('n', '<leader>2', "<Cmd>lua require('harpoon.ui').nav_file(2)<CR>", { desc = 'Harpoon to file 2' })
vim.keymap.set('n', '<leader>3', "<Cmd>lua require('harpoon.ui').nav_file(3)<CR>", { desc = 'Harpoon to file 3' })
vim.keymap.set('n', '<leader>4', "<Cmd>lua require('harpoon.ui').nav_file(4)<CR>", { desc = 'Harpoon to file 4' })
vim.keymap.set('n', '<leader>5', "<Cmd>lua require('harpoon.ui').nav_file(5)<CR>", { desc = 'Harpoon to file 5' })

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

vim.keymap.set('n', '<leader>bf', function() require('conform').format { async = true, lsp_fallback = true } end, { desc = '[F]ormat buffer' })
vim.keymap.set('n', '<Leader>pf', 'i<C-r><C-o>+<ESC>l=`[`]$', { desc = 'Paste block and indent' })

-- vim.keymap.set({ 'n', 't' }, '<F4>', function()
--   require("nvchad.term").runner {
--     pos = "float",
--     cmd = "dotnet run",
--     id = "floatTerm",
--     clear_cmd = false
--   } 
-- end)
          

-- keys = {
--       {
--         '<leader>un',
--         function()
--           Snacks.notifier.hide()
--         end,
--         desc = 'Dismiss All Notifications',
--       },
--       {
--         '<leader>bd',
--         function()
--           Snacks.bufdelete()
--         end,
--         desc = 'Delete Buffer',
--       },

--       {
--         '<leader>cR',
--         function()
--           Snacks.rename()
--         end,
--         desc = 'Rename File',
--       },
--       {
--         ']]',
--         function()
--           Snacks.words.jump(vim.v.count1)
--         end,
--         desc = 'Next Reference',
--       },
--       {
--         '[[',
--         function()
--           Snacks.words.jump(-vim.v.count1)
--         end,
--         desc = 'Prev Reference',
--       },

--       {
--         '<leader>sb',
--         function()
--           Snacks.picker.buffers()
--         end,
--         desc = 'Buffers',
--       },

--       -- {
--       --   '<leader>sg',
--       --   function()
--       --     Snacks.picker.git_files()
--       --   end,
--       --   desc = 'Git Files',
--       -- },

--       {
--         '<leader>sl',
--         function()
--           Snacks.picker.lines()
--         end,
--         desc = 'Lines',
--       },
--       {
--         '<leader><leader>',
--         function()
--           Snacks.picker.pick { finder = 'smart', finders = { 'buffers', 'recent', 'files' } }
--         end,
--       },


--       {
--         '<leader>:',
--         function()
--           Snacks.picker.command_history()
--         end,
--         desc = 'Command History',
--       },
--       {
--         '<leader>ss',
--         function()
--           Snacks.picker.smart()
--         end,
--         desc = 'Smart',
--       },
--       {
--         '<leader>sp',
--         function()
--           Snacks.picker.lsp_symbols()
--         end,
--         desc = 'LSP Symbols',
--       },
    


---* Auto commands

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local value = ev.data.params.value
    vim.api.nvim_echo({ { value.message or 'done' } }, false, {
      id = 'lsp.' .. ev.data.client_id,
      kind = 'progress',
      source = 'vim.lsp',
      title = value.title,
      status = value.kind ~= 'end' and 'running' or 'success',
      percent = value.percentage,
    })
  end,
})

-- wrap, linebreak and spellcheck on markdown and text files
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = augroup,
-- 	pattern = { "markdown", "text", "gitcommit" },
-- 	callback = function()
-- 		vim.opt_local.wrap = true
-- 		vim.opt_local.linebreak = true
-- 		vim.opt_local.spell = true
-- 	end,
-- })

---*

---* Packages

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/seblyng/roslyn.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
	{ src = "https://github.com/NvChad/ui" },
	{ src = "https://github.com/NvChad/base46" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua" },
	{ src = "https://github.com/xzbdmw/colorful-menu.nvim" },
	{ src = "https://github.com/aznhe21/actions-preview.nvim" },
	{ src = "https://github.com/ray-x/lsp_signature.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	
	
		-- { src = "https://github.com/sschleemilch/slimline.nvim" },
	-- { src = "https://github.com/folke/trouble.nvim" },
	-- https://github.com/tpope/vim-sleuth
	-- https://github.com/ibhagwan/fzf-lua
	
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },

	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

	{ src = "https://github.com/MagicDuck/grug-far.nvim" },
	{ src = "https://github.com/lewis6991/satellite.nvim" },
	{ src = "https://github.com/typicode/bg.nvim" },
	{ src = "https://github.com/ThePrimeagen/harpoon" },
	{ src = "https://github.com/max397574/better-escape.nvim" }, 
	{ src = "https://github.com/p00f/clangd_extensions.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end

packadd("nvim.difftool")
packadd("nvim.undotree")

--   {
--     'nvchad/ui',
--     config = function()
--       require 'nvchad'
--     end,
--   },
--   {
--     'nvchad/base46',
--     lazy = true,
--     build = function()
--       require('base46').load_all_highlights()
--     end,
--   },


---*



--: treesitter



local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
		"vim",
		"vimdoc",
		"rust",
		"c",
		"cpp",
		"c_sharp",
		"go",
		"html",
		"css",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"typescript",
		"vue",
		"svelte",
		"bash",
		"hlsl",
	}

	local config = require("nvim-treesitter.config")

	local already_installed = config.get_installed()
	local parsers_to_install = {}

	for _, parser in ipairs(ensure_installed) do
		if not vim.tbl_contains(already_installed, parser) then
			table.insert(parsers_to_install, parser)
		end
	end

	if #parsers_to_install > 0 then
		treesitter.install(parsers_to_install)
	end

	local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

setup_treesitter()

--:

--: lsp and mason


require('mason').setup {
  registries = {
    'github:mason-org/mason-registry',
    -- 'github:syndim/mason-registry',
    'github:Crashdummyy/mason-registry',
  },
}
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "clangd", "basedpyright", "rust_analyzer" },
})

vim.lsp.enable({ "lua_ls", "basedpyright", "rust_analyzer", "clangd", "gdscript", "roslyn" })

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action({
			filter = function(action)
				return not action.disabled
			end,
		})
	end, opts)
	

	lsp_keybinds(opts)

	require "lsp_signature".on_attach({
      bind = true,
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
end

-- vim.lsp.config("basedpyright", {
-- 	on_attach = on_attach,
-- 	root_dir = require("lspconfig.util").root_pattern(".git", "setup.py", "pyproject.toml", "requirements.txt"),
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				autoSearchPaths = true,
-- 				useLibraryCodeForTypes = true,
-- 				typeCheckingMode = 'basic'
-- 			},
-- 		},
-- 	},
-- })


vim.lsp.config("lua_ls", { on_attach = on_attach })
vim.lsp.config("rust_analyzer", { on_attach = on_attach })
vim.lsp.config("roslyn", { on_attach = on_attach })
vim.lsp.config("clangd", { on_attach = on_attach })
--:

--: blink.cmp

require("blink.cmp").setup({
	keymap = { preset = 'enter' },
	appearance = {
		nerd_font_variant = 'mono'
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	fuzzy = { implementation = "prefer_rust" }
})
--:

-- require('trouble').setup({
--       opts = function(_, opts)
--         return vim.tbl_deep_extend('force', opts or {}, {
--           picker = {
--             actions = require('trouble.sources.snacks').actions,
--             win = {
--               input = {
--                 keys = {
--                   ['<c-t>'] = {
--                     'trouble_open',
--                     mode = { 'n', 'i' },
--                   },
--                 },
--               },
--             },
--           },
--         })
--       end
-- })

require('snacks').setup({
	  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  }
})

--: tiny-inline-diagnostic
vim.pack.add({
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
})
-- require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({
	virtual_text = false,
})

require("tiny-inline-diagnostic").setup({
    -- Choose a preset style for diagnostic appearance
    -- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
    preset = "modern",

    -- Make diagnostic background transparent
    transparent_bg = true, -- default false

    -- Make cursorline background transparent for diagnostics
    transparent_cursorline = true,

    -- Customize highlight groups for colors
    -- Use Neovim highlight group names or hex colors like "#RRGGBB"
    hi = {
        error = "DiagnosticError",     -- Highlight for error diagnostics
        warn = "DiagnosticWarn",       -- Highlight for warning diagnostics
        info = "DiagnosticInfo",       -- Highlight for info diagnostics
        hint = "DiagnosticHint",       -- Highlight for hint diagnostics
        arrow = "NonText",             -- Highlight for the arrow pointing to diagnostic
        background = "CursorLine",     -- Background highlight for diagnostics
        mixing_color = "Normal",       -- Color to blend background with (or "None")
    },

    -- List of filetypes to disable the plugin for
    disabled_ft = {},

    options = {
        -- Display the source of diagnostics (e.g., "lua_ls", "pyright")
        show_source = {
            enabled = false,           -- Enable showing source names
            if_many = false,           -- Only show source if multiple sources exist for the same diagnostic
        },

        -- Display the diagnostic code of diagnostics (e.g., "F401", "no-dupe-args")
        show_code = true,

        -- Use icons from vim.diagnostic.config instead of preset icons
        use_icons_from_diagnostic = false,

        -- Color the arrow to match the severity of the first diagnostic
        set_arrow_to_diag_color = false,


        -- Throttle update frequency in milliseconds to improve performance
        -- Higher values reduce CPU usage but may feel less responsive
        -- Set to 0 for immediate updates (may cause lag on slow systems)
        throttle = 20,

        -- Minimum number of characters before wrapping long messages
        softwrap = 30,

        -- Control how diagnostic messages are displayed
        -- NOTE: When using display_count = true, you need to enable multiline diagnostics with multilines.enabled = true
        --       If you want them to always be displayed, you can also set multilines.always_show = true.
        add_messages = {
            messages = true,           -- Show full diagnostic messages
            display_count = false,     -- Show diagnostic count instead of messages when cursor not on line
            use_max_severity = false,  -- When counting, only show the most severe diagnostic
            show_multiple_glyphs = true, -- Show multiple icons for multiple diagnostics of same severity
        },

        -- Settings for multiline diagnostics
        multilines = {
            enabled = true,           -- Enable support for multiline diagnostic messages
            always_show = false,       -- Always show messages on all lines of multiline diagnostics
            trim_whitespaces = false,  -- Remove leading/trailing whitespace from each line
            tabstop = 4,               -- Number of spaces per tab when expanding tabs
            severity = nil,            -- Filter multiline diagnostics by severity (e.g., { vim.diagnostic.severity.ERROR })
          },

        -- Show all diagnostics on the current cursor line, not just those under the cursor
        show_all_diags_on_cursorline = false,

        -- Only show diagnostics when the cursor is directly over them, no fallback to line diagnostics
        show_diags_only_under_cursor = false,

        -- Display related diagnostics from LSP relatedInformation
        show_related = {
            enabled = true,           -- Enable displaying related diagnostics
            max_count = 3,             -- Maximum number of related diagnostics to show per diagnostic
        },

        -- Enable diagnostics display in insert mode
        -- May cause visual artifacts; consider setting throttle to 0 if enabled
        enable_on_insert = false,

        -- Enable diagnostics display in select mode (e.g., during auto-completion)
        enable_on_select = false,

        -- Handle messages that exceed the window width
        overflow = {
            mode = "wrap",             -- "wrap": split into lines, "none": no truncation, "oneline": keep single line
            padding = 0,               -- Extra characters to trigger wrapping earlier
        },

        -- Break long messages into separate lines
        break_line = {
            enabled = false,           -- Enable automatic line breaking
            after = 30,                -- Number of characters before inserting a line break
        },

        -- Custom function to format diagnostic messages
        -- Receives diagnostic object, returns formatted string
        -- Example: function(diag) return diag.message .. " [" .. diag.source .. "]" end
        format = nil,

        -- Virtual text display priority
        -- Higher values appear above other plugins (e.g., GitBlame)
        virt_texts = {
            priority = 2048,
        },

        -- Filter diagnostics by severity levels
        -- Remove severities you don't want to display
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },

        -- Events that trigger attaching diagnostics to buffers
        -- Default is {"LspAttach"}; change only if plugin doesn't work with your LSP setup
        overwrite_events = nil,

        -- Automatically disable diagnostics when opening diagnostic float windows
        override_open_float = false,

        -- Experimental options, subject to misbehave in future NeoVim releases
        experimental = {
          -- Make diagnostics not mirror across windows containing the same buffer
          -- See: https://github.com/rachartier/tiny-inline-diagnostic.nvim/issues/127
          use_window_local_extmarks = false,
        },
    },
})

require('nvim-autopairs').setup()
require("bufferline").setup()
require('lualine').setup {
  options = {
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      { 'filename', file_status = true, path = 0 }, -- Set path to 0 since we have CWD now
    },
    lualine_c = {
      {
        -- Custom function for the working directory folder
        function()
          return '󰉖 ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        end,
        color = { gui = 'italic' }, -- Makes the folder stand out subtly
      },
      '%=', -- Spacer to push diagnostics to the center
      {
        'diagnostics',
        symbols = { error = ' ', warn = ' ', info = ' ' },
      },
    },
    lualine_x = {
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
      },
      'branch',
    },
    lualine_y = { 'lsp_status', 'filetype', 'progress' },
    lualine_z = {
      { separator = { right = '' }, left_padding = 2 },
    },
  },
}
-- require('lualine').setup {
--   options = {
--     theme = 'auto',
--     component_separators = '',
--     section_separators = { left = '', right = '' },
--     globalstatus = true,
--   },
--   sections = {
--     lualine_a = {
--       { 'mode', separator = { left = '' }, right_padding = 2 },
--     },
--     lualine_b = {
--       { 'filename', file_status = true, path = 1 }, -- Filename now on the left
--     },
--     lualine_c = {
--       '%=', -- Spacer to center diagnostics
--       {
--         'diagnostics',
--         symbols = { error = ' ', warn = ' ', info = ' ' },
--       },
--     },
--     lualine_x = {
--       {
--         'diff',
--         symbols = { added = ' ', modified = ' ', removed = ' ' },
--       },
--       'branch', -- Git status and branch now on the right
--     },
--     lualine_y = { 'filetype', 'progress' },
--     lualine_z = {
--       { 'location', separator = { right = '' }, left_padding = 2 },
--     },
--   },
-- }
require('oil').setup {
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
	},
}

-- require('ibl').setup({ -- Add indentation guides even on blank lines
--     main = 'ibl',
--     opts = {},
--     indent = {
--       char = '│', -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
--     },
--     exclude = {
--       filetypes = {
--         'help',
--         'startify',
--         'aerial',
--         'alpha',
--         'dashboard',
--         'packer',
--         'neogitstatus',
--         'NvimTree',
--         'neo-tree',
--         'Trouble',
--       },
--       buftypes = {
--         'nofile',
--         'terminal',
--       },
--     },
--   })

local highlight = {
  'IndentLineColor',
}

local hooks = require 'ibl.hooks'
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'IndentLineColor', { fg = '#2b303c' })
end)

require("ibl").setup { 
	indent = { 
		char =  '│',
		highlight = highlight
	},
	exclude = {
      filetypes = {
        'help',
        'startify',
        'aerial',
        'alpha',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'neo-tree',
        'Trouble',
      },
      buftypes = {
        'nofile',
        'terminal',
      }
	}
}

require('which-key').add {
	{ '<leader>c', group = '[C]ode' },
	{ '<leader>c_', hidden = true },
	{ '<leader>d', group = '[D]ocument' },
	{ '<leader>d_', hidden = true },
	{ '<leader>r', group = '[R]ename' },
	{ '<leader>r_', hidden = true },
	{ '<leader>s', group = '[S]earch' },
	{ '<leader>s_', hidden = true },
	{ '<leader>t', group = '[T]erminal' },
	{ '<leader>t_', hidden = true },
	{ '<leader>w', group = '[W]orkspace' },
	{ '<leader>w_', hidden = true },
	{ '<leader>b', group = '[B]uffer' },
	{ '<leader>b_', hidden = true },
	{ '<leader>f', group = '[F]lash' },
	{ '<leader>f_', hidden = true },
	{ '<leader>h', group = '[H]arpoon' },
	{ '<leader>h_', hidden = true },
	{ '<leader>l', group = '[L]sp' },
	{ '<leader>l_', hidden = true },
}

vim.filetype.add({
  extension = {
    fx = 'hlsl',
	mgfx = 'hlsl',
	mgfxc = 'hlsl'
  }
})

--require 'custom.keybindings'
require 'highlights'

require"vim._core.ui2".enable{}
require('base46').load_all_highlights()


