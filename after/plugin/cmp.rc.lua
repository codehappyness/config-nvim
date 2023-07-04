local status, cmp = pcall(require, "cmp")
if (not status) then return end
--
local status1, lspkind = pcall(require, "lspkind")
if (not status1) then return end
--
--
local status2, luasnip = pcall(require, "luasnip")
if (not status2) then return end

--if (true) then return end

local function formatForTailwindCSS(entry, vim_item)
	if vim_item.kind == 'Color' and entry.completion_item.documentation then
		local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
		if r then
			local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
			local group = 'Tw_' .. color
			if vim.fn.hlID(group) < 1 then
				vim.api.nvim_set_hl(0, group, { fg = '#' .. color })
			end
			vim_item.kind = "●"
			vim_item.kind_hl_group = group
			return vim_item
		end
	end
	vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
	return vim_item
end

local function formatForPath(entry, vim_item)
	if vim_item.kind == 'path' and entry.completion_item.documentation then
		local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
		if r then
			local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
			local group = 'Tw_' .. color
			if vim.fn.hlID(group) < 1 then
				vim.api.nvim_set_hl(0, group, { fg = '#' .. color })
			end
			vim_item.kind = "●"
			vim_item.kind_hl_group = group
			return vim_item
		end
	end
	vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
	return vim_item
end

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = ""
}

cmp.setup({
	snippet = {
		expand = function(args)
			--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
			--require('snippy').expand_snippet(args.body) -- For `snippy` users.
			--vim.fn["UltiSnips"](args.body)    -- For `ultisnips` users.
			--vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		}),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		--{ name = 'luasnip' }, -- For luasnip users.
		{ name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
		--{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
		{
			name = 'path',
			option = {
				-- Options go into this table
				trailing_slash = false,
				label_trailing_slash = false,
				get_cwd = function(params)
					--print(vim.fn.expand(('#%d:p:h'):format(params.context.bufnr)))
					return vim.fn.getcwd()
				end
			},
		},
	}),
	formatting = {
		--format = function(entry, vim_item)
		--	-- Kind icons
		--	vim_item.kind = string.format('%s', kind_icons[vim_item.kind]) -- This concatonates the icons with the name of the item kind
		--	-- Source
		--	vim_item.menu = ({
		--		buffer = "[Buffer]",
		--		nvim_lsp = "[LSP]",
		--		luasnip = "[LuaSnip]",
		--		nvim_lua = "[Lua]",
		--		ultisnips = "[UltiSnips]",
		--		latex_symbols = "[LaTeX]",
		--		path = "[Path]"
		--	})[entry.source.name]
		--  before = function (entry, vim_item)
		--    return vim_item
		--  end
		--	return vim_item
		--end
		format = lspkind.cmp_format({
			--mode = 'symbol', -- show only symbol annotations
			--maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			--ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				vim_item.kind = string.format('%s', kind_icons[vim_item.kind]) -- This concatonates the icons with the name of the item kind
				-- Source
				vim_item.menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					ultisnips = "[UltiSnips]",
					latex_symbols = "[LaTeX]",
					path = "[Path]"
				})[entry.source.name]
				--vim_item = formatForTailwindCSS(entry, vim_item)
				return vim_item
			end
		})
	}
})
--formatting = {
--  format = lspkind.cmp_format({
--    mode = 'symbol',
--    with_text = false,
--    maxwidth = 50,
--    before = function(entry, vim_item)
--      vim_item = formatForTailwindCSS(entry, vim_item)
--      return vim_item
--    end
--  })
--}
--

--print('cmp')
--print(vim.fn.expand(('%:p:h')))
vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]
