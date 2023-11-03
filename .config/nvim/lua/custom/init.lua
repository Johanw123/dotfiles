-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })


vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')

-- Helper function for transparency formatting
local alpha = function()
	return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
	--vim.g.neovide_transparency = 0.9
	--vim.g.transparency = 0.9
	--vim.g.neovide_background_color = "#332C2A" .. alpha()

	--vim.g.neovide_background_color = "#332C2A"

	vim.o.guifont = "FiraCode NF"

	vim.g.neovide_floating_blur_amount_x = 15
	vim.g.neovide_floating_blur_amount_y = 5

	vim.g.neovide_refresh_rate = 60

	vim.g.neovide_cursor_animation_length = 0
end

if vim.fn.has('win32') then
	local powershell_options = {
		shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
		shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
		shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		shellquote = "",
		shellxquote = "",
	}

	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end
end