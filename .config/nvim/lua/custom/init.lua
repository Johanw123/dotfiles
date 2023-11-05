-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

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

	vim.g.neovide_refresh_rate = 165

	vim.g.neovide_cursor_animation_length = 0
end

-- let g:OmniSharp_highlighting = 0

vim.g.OmniSharp_highlighting = 3
vim.g.OmniSharp_server_use_net6 = 1
vim.g.OmniSharp_selector_ui = 'fzf' 

--let g:OmniSharp_highlight_groups = {
--	\ 'Comment': 'NonText',
--	\ 'XmlDocCommentName': 'Identifier',
--	\ 'XmlDocCommentText': 'NonText'
--	\}

-- https://github.com/OmniSharp/omnisharp-vim/wiki/Highlighting-configuration
-- https://github.com/dotnet/roslyn/blob/main/src/Workspaces/Core/Portable/Classification/ClassificationTypeNames.cs

vim.g.OmniSharp_highlight_groups = {
	PropertyName = "PropertyName",
}

-- Setup powershell as shell on windows
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