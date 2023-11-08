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
vim.g.OmniSharp_highlighting = 1
vim.g.OmniSharp_server_use_net6 = 1
vim.g.OmniSharp_selector_ui = 'fzf' 

-- https://github.com/OmniSharp/omnisharp-vim/wiki/Highlighting-configuration
-- https://github.com/dotnet/roslyn/blob/main/src/Workspaces/Core/Portable/Classification/ClassificationTypeNames.cs

vim.g.OmniSharp_highlight_groups = {
	PropertyName = "PropertyName",
	TypeParameterName = "TypeParameterName",
	Structure = "Structure",
	StaticSymbol = "PropertyName",
	ParameterName = "ParameterName",
	FieldName = "FieldName",
	ClassName = "ClassName",
	LocalName = "LocalName",

}
-- Structure is pink, change

--vim.api.nvim_set_hl(0, 'Structure', { bg ="#82ccdd", fg = "#000000", standout=true, bold=true, })


local links = {
	['@lsp.type.namespace'] = '@namespace',
	['@lsp.type.type'] = '@type',
	['@lsp.type.class'] = '@type',
	['@lsp.type.enum'] = '@type',
	['@lsp.type.interface'] = '@type',
	['@lsp.type.struct'] = '@structure',
	['@lsp.type.parameter'] = '@parameter',
	['@lsp.type.variable'] = '@variable',
	['@lsp.type.property'] = '@property',
	['@lsp.type.enumMember'] = '@constant',
	['@lsp.type.function'] = '@function',
	['@lsp.type.method'] = '@method',
	['@lsp.type.macro'] = '@macro',
	['@lsp.type.decorator'] = '@function',
  }
  for newgroup, oldgroup in pairs(links) do
	vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
  end


vim.api.nvim_set_hl(0, 'PropertyName', { fg = "#dfe6e9",  })

vim.api.nvim_set_hl(0, '@type.builtin.c_sharp', {  fg = "#6ab04c", })
vim.api.nvim_set_hl(0, '@keyword.c_sharp', {  fg = "#6ab04c", })
vim.api.nvim_set_hl(0, '@type.qualifier.c_sharp', {  fg = "#6ab04c", })

local keywords = "#6ab04c"

vim.api.nvim_set_hl(0, '@type.builtin.cpp', {  fg = keywords, })
vim.api.nvim_set_hl(0, '@type.qualifier.cpp', {  fg = keywords, })
vim.api.nvim_set_hl(0, '@conditional.cpp', {  fg = keywords, })
vim.api.nvim_set_hl(0, '@repeat.cpp', {  fg = keywords, })
vim.api.nvim_set_hl(0, '@boolean.cpp', {  fg = keywords, })
vim.api.nvim_set_hl(0, '@constant.builtin.cpp', {  fg = keywords, })
vim.api.nvim_set_hl(0, '@keyword.return.cpp', {  fg = keywords, })


vim.api.nvim_set_hl(0, '@keyword.return.cpp', {  fg = keywords, })



vim.api.nvim_set_hl(0, '@conditional.ternary.cpp', {  fg = "#dfe6e9", })



vim.api.nvim_set_hl(0, '@lsp.type.property.cpp', {  fg = "#9B59B6", })


vim.api.nvim_set_hl(0, '@lsp.type.macro.cpp', {  fg = "#7ed6df", })


--local functionColor = "#eccc68"
--
--vim.api.nvim_set_hl(0, '@lsp.type.method.cpp', {  fg = functionColor, })
--vim.api.nvim_set_hl(0, '@function', {  fg = functionColor, })
--vim.api.nvim_set_hl(0, '@method', {  fg = functionColor, })

-- function tprint (tbl, indent)
-- 	if not indent then indent = 0 end
-- 	local toprint = string.rep(" ", indent) .. "{\r\n"
-- 	indent = indent + 2 
-- 	for k, v in pairs(tbl) do
-- 	  toprint = toprint .. string.rep(" ", indent)
-- 	  if (type(k) == "number") then
-- 		toprint = toprint .. "[" .. k .. "] = "
-- 	  elseif (type(k) == "string") then
-- 		toprint = toprint  .. k ..  "= "   
-- 	  end
-- 	  if (type(v) == "number") then
-- 		toprint = toprint .. v .. ",\r\n"
-- 	  elseif (type(v) == "string") then
-- 		toprint = toprint .. "\"" .. v .. "\",\r\n"
-- 	  elseif (type(v) == "table") then
-- 		toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
-- 	  else
-- 		toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
-- 	  end
-- 	end
-- 	toprint = toprint .. string.rep(" ", indent-2) .. "}"
-- 	return toprint
--   end

vim.api.nvim_create_autocmd("LspTokenUpdate", {
	callback = function(args)
	  local token = args.data.token
	  if
		token.type == "class"
		--token.type == "variable"
		and token.modifiers.deduced
		--and not token.modifiers.readonly
	  then
		--print(tprint(args.data))
		vim.lsp.semantic_tokens.highlight_token(
		  token, args.buf, args.data.client_id, "MyMutableGlobalHL")
	  end

		if
		token.type == "class"
		--token.type == "variable"
		and token.modifiers.defaultLibrary
		--and not token.modifiers.readonly
		then
		--print(tprint(args.data))
		vim.lsp.semantic_tokens.highlight_token(
			token, args.buf, args.data.client_id, "DefaultClassType")
		end

	  if
		token.type == "type"
		--token.type == "variable"
		and token.modifiers.deduced
		--and not token.modifiers.readonly
	  then
		--print(tprint(args.data))
		vim.lsp.semantic_tokens.highlight_token(
		  token, args.buf, args.data.client_id, "MyMutableGlobalHL")
	  end

		if
		token.type == "type"
		--token.type == "variable"
		and token.modifiers.defaultLibrary
		--and not token.modifiers.readonly
		then
		--print(tprint(args.data))
		vim.lsp.semantic_tokens.highlight_token(
			token, args.buf, args.data.client_id, "MyMutableGlobalHL")
		end

		if
		token.type == "class"
		--token.type == "variable"
		and token.modifiers.constructorOrDestructor
		--and not token.modifiers.readonly
		then
		--print(tprint(args.data))
		vim.lsp.semantic_tokens.highlight_token(
			token, args.buf, args.data.client_id, "function")
		end

	end,
  })

  vim.api.nvim_set_hl(0, 'MyMutableGlobalHL', {  fg = "#6ab04c", })
  vim.api.nvim_set_hl(0, 'DefaultClassType', {  fg = "#009432", })
  vim.api.nvim_set_hl(0, 'DefaultClassType', {  fg = "#009432", })

--vim.api.nvim_set_hl(0, 'Include', { bg ="#82ccdd", fg = "#000000",  })
--vim.api.nvim_set_hl(0, 'Function', { bg ="#82ccdd", fg = "#000000",  })


--Include
--Function

--vim.api.nvim_set_hl(0, 'Typedef', { bg ="#82ccdd", fg = "#000000", standout=true, bold=true, })


--@type.builtin - yellow
--@keyword.operator - pink

-- flash settings
vim.api.nvim_set_hl(0, 'FlashLabel', { bg ="#82ccdd", fg = "#000000", standout=true, bold=true, })

--vim.filetype.add({ extension = { frag = "frag" } })

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