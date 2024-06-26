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
    "csv",
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

-- local z_utils = require("telescope._extensions.zoxide.utils")
--
-- M.telescope = {
--   -- extensions = {
--       zoxide = {
--         prompt_title = "[ Walking on the shoulders of TJ ]",
--         mappings = {
--           default = {
--             after_action = function(selection)
--               print("Update to (" .. selection.z_score .. ") " .. selection.path)
--             end
--           },
--           ["<C-s>"] = {
--             before_action = function(selection) print("before C-s") end,
--             action = function(selection)
--               vim.cmd.edit(selection.path)
--             end
--           },
--           -- Opens the selected entry in a new split
--           ["<C-q>"] = { action = z_utils.create_basic_command("split") },
--         },
--       }
--     -- }
-- }

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

local cmp = require("cmp")

M.cmp = {
  view = {
  },
  -- sources = {
  --   { name = 'cmp_ai' },
  -- },
  mapping = {
    ['<C-a>'] = cmp.mapping(
      cmp.mapping.complete({
        config = {
          sources = cmp.config.sources({
            { name = 'cmp_ai' },
          }),
        },
      }),
      { 'i' }
    ),
  },
	formatting = {
    fields = {"kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local icons = require("nvchad.icons.lspkind")
      local item = entry:get_completion_item()

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
        cmp_ai = '[AI]',
				path = "[PTH]",
			})[entry.source.name], from)


      if entry.source.name == 'cmp_ai' then
        local detail = (entry.completion_item.labelDetails or {}).detail
        vim_item.kind = ''
        if detail and detail:find('.*%%.*') then
          vim_item.kind = vim_item.kind .. ' ' .. detail
        end

        if (entry.completion_item.data or {}).multiline then
          vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
        end
      end

			return vim_item
		end,
	},
}




return M
