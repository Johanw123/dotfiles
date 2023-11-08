local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "cpp",
    "c_sharp",
    "markdown",
    "markdown_inline",
    "glsl"
  },
  indent = {
    enable = true,
  },
  build = { ":TSUpdate" },
  event = { "BufReadPred", "BufNewFile" },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    --c#
    "omnisharp",
  },
}

-- M.telescope = 
-- {
--   defaults = { 
--     file_ignore_patterns = { 
--       "*.obj" 
--     }
--   },
-- }

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}



return M
