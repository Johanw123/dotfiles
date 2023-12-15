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
    "xml",
    "glsl",
    "rust",
    "python"
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
    
    "lemminx",
    "marksman",

    "rust-analyzer",
    "python-lsp-server",
    -- "pylsp",
    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
		"clangd",
		"clang-format",
		"cmake-language-server",
		"cpplint",
		"cpptools",

    -- shell
		"shellcheck",
		"shellharden",
		"bash-language-server",
		"bash-debug-adapter",
		"awk-language-server",

    --c#
    "omnisharp",
    -- "csharp-language-server",
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

T = true

-- vim.opt.cmdheight = 0

-- local log = require("plenary.log").new({
--   plugin = "test",
--   level = "debug"
-- })


-- vim.cmd('highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080')
-- vim.cmd('highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6')
-- vim.cmd('highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6')
-- vim.cmd('highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE')
-- vim.cmd('highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE')
-- vim.cmd('highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE')
-- vim.cmd('highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0')
-- vim.cmd('highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0')
-- vim.cmd('highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4')
--
-- vim.api.nvim_set_hl(0, "CmpItemKindText", {bg = "white", fg = "black"})

M.cmp = {
  view = {

  },
	formatting = {
    fields = {"kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local icons = require("nvchad.icons.lspkind")
      -- vim.print(entry:get_completion_item())
      -- log.debug(entry:get_completion_item())
      -- log.debug(vim_item)
      --


      local item = entry:get_completion_item()
      -- local doc = entry:get_documentation()

        -- if T then
        --
      --  T = false
      --
      --   local fp = io.open("C:\\Users\\Johan\\dotfiles\\.config\\nvim\\lua\\custom\\test.log", "a")
      --  fp:write(vim.inspect(entry))
      --   fp:write("----------------------------------------------")
      --   -- fp:write(vim.inspect(entry.context))
      --  fp:write(vim.inspect(vim_item))
      --   fp:write("----------------------------------------------")
      --   fp:write(vim.inspect(item))
      --   fp:write("----------------------------------------------")
      --   fp:write(vim.inspect(doc))
      --   -- fp:write(vim.inspect(icons))
      --   fp:close()
      -- end

      -- vim.print(doc)
      function trim(text, len)
        local max = len
        if text and text:len() > max then
          text = text:sub(1, max-3) .. "..."
        end
        return text
      end

      local from = ""
      if item.documentation and entry.source.name == "nvim_lsp" then
          if entry.source.source.client.name == "clangd" then
          from = item.documentation.value
          from = string.match(from, "%w*%.%w*");
          from = string.format(" (%s)", from)
          from = trim(from, 20)
        end
      end

      local type = ""
      if item.detail and entry.source.name == "nvim_lsp" then
        if entry.source.source.client.name == "clangd" then

          type = item.detail

          type = type:gsub("(%w*::)", "")
          type = type:gsub("unique_ptr", "u*")

          if type:len() > 20 then
            type = type:sub(1, 20)
          end


          type = string.format(" (%s)", type)
        end
      end

      vim_item.abbr = trim(vim_item.abbr, 60)

			vim_item.kind = string.format("%s%s", icons[vim_item.kind], type)
			vim_item.menu = string.format("%s%s", ({
				luasnip = "[SNP]",
				nvim_lsp = "[LSP]",
				buffer = "[BUF]",
				nvim_lua = "[Lua]",
				path = "[PTH]",
			})[entry.source.name], from)

			return vim_item
		end,
	},
}




return M
