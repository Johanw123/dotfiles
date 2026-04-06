local M = {}
local theme = require('custom.onedark.theme')

M.setup = function()
  vim.cmd('hi clear')

  vim.o.background = 'dark'
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'onedark'

  theme.set_highlights()
  require('custom.onedark.custom')
end

return M