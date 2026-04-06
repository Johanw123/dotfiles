local hl = vim.api.nvim_set_hl

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

--- C Sharp ---
vim.api.nvim_set_hl(0, 'PropertyName', { fg = "#9B59B6",  })
vim.api.nvim_set_hl(0, '@type.builtin.c_sharp', {  fg = "#6ab04c", })
vim.api.nvim_set_hl(0, '@keyword.c_sharp', {  fg = "#6ab04c", })
vim.api.nvim_set_hl(0, '@type.qualifier.c_sharp', {  fg = "#6ab04c", })
vim.api.nvim_set_hl(0, 'ParameterName', {  fg = "#C57626", })

--- C++ ----
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

vim.api.nvim_set_hl(0, '@lsp.type.class.cpp', {  fg = "#eccc68", })

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

vim.api.nvim_set_hl(0, 'FlashLabel', { bg ="#82ccdd", fg = "#000000", standout=true, bold=true, })


-- vim.api.nvim_get_hl(0, 'Folded', { bg = "#99272e", fg = "#dfe6e9"})
-- vim.api.nvim_get_hl(0, 'FoldColumn', { bg = "#99272e", fg = "#dfe6e9"})

