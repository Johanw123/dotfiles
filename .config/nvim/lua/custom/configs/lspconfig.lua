local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"


-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "lua_ls", "tsserver", "glsl_analyzer", "rust_analyzer", "lemminx" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end




-- local testCap = require('cmp_nvim_lsp').default_capabilities()
local testCap = require('cmp_nvim_lsp').default_capabilities(capabilities)

lspconfig["clangd"].setup{
  on_attach = function(client, buffer)
    on_attach(client, buffer)
    require("clangd_extensions").setup()
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
  end,
  capabilities = testCap,
}



 -- local pid = vim.fn.getpid()
 --
 -- local config = {
 --     on_attach  = function (client, bufnr)
 --         local wk = require("which-key")
 --         wk.register({
 --             g = {
 --                 name = "lsp/go", -- optional group name
 --                 d = { "<cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<cr>", "Go definition" }, -- create a binding with label
 --             },
 --         })
 --
 --         --vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<cr>", {noremap=false})
 --
 --         on_attach(client, bufnr)
 --     end,
 --   handlers = {
 --     ["textDocument/definition"] = require('omnisharp_extended').handler,
 --   },
 --   cmd = { "omnisharp", '--languageserver' , '--hostPID', tostring(pid) },
 --   -- rest of your settings
 --     -- Enables support for reading code style, naming convention and analyzer
 --   -- settings from .editorconfig.
 --   enable_editorconfig_support = true,
 --
 --   -- If true, MSBuild project system will only load projects for files that
 --   -- were opened in the editor. This setting is useful for big C# codebases
 --   -- and allows for faster initialization of code navigation features only
 --   -- for projects that are relevant to code that is being edited. With this
 --   -- setting enabled OmniSharp may load fewer projects and may thus display
 --   -- incomplete reference lists for symbols.
 --   enable_ms_build_load_projects_on_demand = false,
 --
 --   -- Enables support for roslyn analyz:ers, code fixes and rulesets.
 --   enable_roslyn_analyzers = true,
 --
 --   -- Specifies whether 'using' directives should be grouped and sorted during
 --   -- document formatting.
 --   organize_imports_on_format = false,
 --
 --   -- Enables support for showing unimported types and unimported extension
 --   -- methods in completion lists. When committed, the appropriate using
 --   -- directive will be added at the top of the current file. This option can
 --   -- have a negative impact on initial completion responsiveness,
 --   -- particularly for the first few completion sessions after opening a
 --   -- solution.
 --   enable_import_completion = false,
 --
 --   -- Specifies whether to include preview versions of the .NET SDK when
 --   -- determining which version to use for project loading.
 --   sdk_include_prereleases = true,
 --
 --   -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
 --   -- true
 --   analyze_open_documents_only = false,
 -- }
 --
 -- require'lspconfig'.omnisharp.setup(config)


--require'lspconfig'.roslyn.setup()
-- local cap = capabilities
-- cap.completion = {
--   completionItem = {
--     commitCharactersSupport = true,
--     deprecatedSupport = true,
--     documentationFormat = { "markdown", "plaintext" },
--     insertReplaceSupport = true,
--     insertTextModeSupport = {
--       valueSet = { 1, 2 }
--     },
--     labelDetailsSupport = true,
--     preselectSupport = true,
--     resolveSupport = {
--       properties = { "documentation", "detail", "additionalTextEdits", "sortText", "filterText", "insertText", "textEdit", "insertTextFormat", "insertTextMode" },
--     },
--     snippetSupport = true,
--     tagSupport = {
--       valueSet = { 1 }
--     }
--   },
--   completionItemKind = {
--     valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
--   },
--   completionList = {
--     itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" }
--   },
--   contextSupport = true,
--   dynamicRegistration = false,
--   insertTextMode = 1
-- };

-- local capa = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("roslyn").setup({
    on_attach = on_attach, -- required
    capabilities = capabilities, -- required
    handlers = {
     ["textdocument/definition"] = require('omnisharp_extended').handler,
  }
})

-- lspconfig["csharp_ls"].setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   handlers = {
--      ["textdocument/definition"] = require('csharpls_extended').handler,
--   }
-- })
--
-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

-- vim.lsp.handlers['textDocument/definition'] = require('omnisharp_extended').handler

--
--
-- https://github.com/Hoffs/omnisharp-extended-lsp.nvim
