local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  {
    "3rd/image.nvim",
  },

  {
    "libvips/lua-vips",
  },
  {
    "edluffy/hologram.nvim",
    config = function()
        require("hologram").setup()
    end,

    rocks = { "magick" },
  },


  {
  "simrat39/rust-tools.nvim"
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    opts = overrides.treesitter,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    --lazy = false,
    config = function()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
              ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
              ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
  
              ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },
  
              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
  
              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
  
              ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
              ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },
  
              ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
              ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },
  
              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]i"] = "@indent.begin",
            },
            goto_next_end = {
              ["]I"] = "@indent.begin",
            },
            goto_previous_start = {
              ["[i"] = "@indent.begin",
            },
            goto_previous_end = {
              ["[I"] = "@indent.begin",
            },
          }
        },
        incremental_selection = {
          enable = false,
          -- keymaps = {
          --   init_selection = "<C-space>",
          --   node_incremental = "<C-space>",
          --   scope_incremental = false,
          --   node_decremental = "<bs>",
          -- },
        },
        additional_vim_regex_highlighting = false,
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    'MeanderingProgrammer/dashboard.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        { 'MaximilianLloyd/ascii.nvim', dependencies = { 'MunifTanjim/nui.nvim' } },
    },
    config = function()
        require('dashboard').setup({
            header = require('custom/ascii2').pikachu,
            directories = {
                'G:\\dev\\susrepo1_2',
                 '~/dotfiles',

                -- Home PC
                 'D:\\Dev\\DungeonRun',
                 'D:\\Dev\\SurgicalScience\\susrepo1_2',
                 'D:\\Dev\\SurgicalScience\\experimental\\SusrepoHelper\\BuildCLI\\BuildCLI',
                 'D:\\Dev\\Projects\\RustStuff\\AoC2022',
                 'D:\\Dev\\avalonia.nvim',
                 'C:\\Users\\Johan\\source\\repos\\AvaloniaApplication3'
                -- '~/dev/repos/advent-of-code',
            },
        })
    end,
},

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "p00f/clangd_extensions.nvim",
  },

  {
    "vijaymarupudi/nvim-fzf"
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },


  -- C# stuff:

  {
    "OmniSharp/omnisharp-roslyn",
    lazy = false
  },
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = false,
  },
  -- {
  --   "Decodetalkers/csharpls-extended-lsp.nvim",
  -- },
  -- {
  --   "OmniSharp/omnisharp-vim",
  --   lazy = false
  -- },
  {
    "jmederosalvarado/roslyn.nvim",
  },
  -- {
  --   "razzmatazz/csharp-language-server"
  -- },
  -- C#

  {
    "ThePrimeagen/harpoon"
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    --lazy = false,
    config = function()
     -- This module contains a number of default definitions
        local rainbow_delimiters = require 'rainbow-delimiters'

        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = rainbow_delimiters.strategy['global'],
                vim = rainbow_delimiters.strategy['local'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        }
    end,
  },

  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = 'quintic', -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end,
  },

	{
		"hrsh7th/nvim-cmp",
		opts = overrides.cmp,
	},
  {
    "folke/flash.nvim",
  },

  {
    "tjdevries/vlog.nvim"
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      -- options
    },
  },

  {
    'petertriho/nvim-scrollbar', 
    lazy = false,
    config = function()
      require("scrollbar").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    config = function()
      return {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
         -- your configuration comes here
         -- or leave it empty to use the default settings
         -- refer to the configuration section below
        },
       }
    end,
  },


  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = { mode = "background", rgb_fn = true, css  = true,css_fn =true  },
    }
  },


  {
    "nolanderc/glsl_analyzer",
    dependencies = { "tikhomirov/vim-glsl", lazy=false },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
    end,
  },


  -- Dap
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("custom.configs.dap")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()
		end,
		requires = { "mfussenegger/nvim-dap" },
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
		requires = { "mfussenegger/nvim-dap" },
	},

  {
    dir= "D:\\Dev\\avalonia.nvim",
    config = function()
      require("avalonia.nvim").setup()
    end,
    enabled = function() return jit.os ~= "Linux" end
  },
  {
    dir= "/mnt/d/Dev/avalonia.nvim",
    config = function()
      require("avalonia.nvim").setup()
    end,
    enabled = function() return jit.os == "Linux" end
  },

  {
    "David-Kunz/gen.nvim",
    opts = {
        model = "codellama", -- The default model to use.
        display_mode = "float", -- The display mode. Can be "float" or "split".
        show_prompt = false, -- Shows the Prompt submitted to Ollama.
        show_model = false, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = false, -- Never closes the window automatically.
        init =
        function(options)
          pcall(io.popen, "wsl ollama serve > /dev/null 2>&1 &")  
        end,
        -- Function to initialize Ollama
        command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a lua function returning a command string, with options as the input parameter.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        list_models = '<function>', -- Retrieves a list of model names
        debug = false -- Prints errors and the command which is run.
    }
  },

  {
    "tzachar/cmp-ai",
    dependencies = 'nvim-lua/plenary.nvim'
  },

  {
    "rcarriga/nvim-notify"
  },

  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

}



return plugins
