local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

-- if true then
--   return
-- end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  -- b.formatting.astyle,
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" }, disabled_filetypes = { "cs" }, }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.astyle.with {command = "_devtools\\ArtisticStyle\\astyle.exe", args = {"--options=_devtools\\ArtisticStyle\\.astylerc", "$FILENAME 2>&1", ">> log_formatted_files.txt"}},
}

null_ls.setup {
  debug = true,
  sources = sources,
}
