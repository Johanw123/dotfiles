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

  -- Neovide settings
if vim.g.neovide then
	--vim.g.neovide_transparency = 0.9
	--vim.g.transparency = 0.9
	--vim.g.neovide_background_color = "#332C2A" .. alpha()
	--vim.g.neovide_background_color = "#332C2A"

	vim.o.guifont = "FiraCode NF"

	vim.g.neovide_floating_blur_amount_x = 2
	vim.g.neovide_floating_blur_amount_y = 2

	vim.g.neovide_refresh_rate = 165

	vim.g.neovide_cursor_animation_length = 0
end

-- Omnisharp settings
vim.g.OmniSharp_highlighting = 0
vim.g.OmniSharp_server_use_net6 = 1
vim.g.OmniSharp_selector_ui = 'fzf' 

-- https://github.com/OmniSharp/omnisharp-vim/wiki/Highlighting-configuration
-- https://github.com/dotnet/roslyn/blob/main/src/Workspaces/Core/Portable/Classification/ClassificationTypeNames.cs

vim.g.OmniSharp_highlight_groups = {
	PropertyName = "PropertyName",
	TypeParameterName = "TypeParameterName",
	Structure = "Structure",
	StaticSymbol = "PropertyName",
}
-- Structure is pink, change

--vim.api.nvim_set_hl(0, 'Structure', { bg ="#82ccdd", fg = "#000000", standout=true, bold=true, })

vim.api.nvim_set_hl(0, 'PropertyName', { fg = "#dfe6e9",  })

vim.api.nvim_set_hl(0, '@type.builtin.c_sharp', {  fg = "#6ab04c", })
vim.api.nvim_set_hl(0, '@keyword.c_sharp', {  fg = "#6ab04c", })
vim.api.nvim_set_hl(0, '@type.qualifier.c_sharp', {  fg = "#6ab04c", })

vim.api.nvim_set_hl(0, '@type.builtin.cpp', {  fg = "#6ab04c", })
vim.api.nvim_set_hl(0, '@type.qualifier.cpp', {  fg = "#6ab04c", })
vim.api.nvim_set_hl(0, '@conditional.cpp', {  fg = "#6ab04c", })




--vim.api.nvim_set_hl(0, 'Include', { bg ="#82ccdd", fg = "#000000",  })
--vim.api.nvim_set_hl(0, 'Function', { bg ="#82ccdd", fg = "#000000",  })


--Include
--Function

--vim.api.nvim_set_hl(0, 'Typedef', { bg ="#82ccdd", fg = "#000000", standout=true, bold=true, })


--@type.builtin - yellow
--@keyword.operator - pink

-- flash settings
vim.api.nvim_set_hl(0, 'FlashLabel', { bg ="#82ccdd", fg = "#000000", standout=true, bold=true, })



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