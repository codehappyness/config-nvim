--vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.format({ async=true })<CR>', opts)
	buf_set_keymap('n', '<leader>a', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	-- formatting
	-- nevim 0.7
	--  if client.resolved_capabilities.document_formatting then
	--    vim.api.nvim_command [[augroup Format]]
	--    vim.api.nvim_command [[autocmd! * <buffer>]]
	--    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
	--    vim.api.nvim_command [[augroup END]]
	--  end

	--  if client.server_capabilities.documentFormattingProvider then
	--    vim.api.nvim_command [[augroup Format]]
	--    vim.api.nvim_command [[autocmd! * <buffer>]]
	--    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async=true })]]
	--    vim.api.nvim_command [[augroup END]]
	--  end
	--
	--require'completion'.on_attach(client, bufnr)

	--protocol.SymbolKind = { }
	protocol.CompletionItemKind = {
		'', -- Text
		'', -- Method
		'', -- Function
		'', -- Constructor
		'', -- Field
		'', -- Variable
		'', -- Class
		'ﰮ', -- Interface
		'', -- Module
		'', -- Property
		'', -- Unit
		'', -- Value
		'', -- Enum
		'', -- Keyword
		'﬌', -- Snippet
		'', -- Color
		'', -- File
		'', -- Reference
		'', -- Folder
		'', -- EnumMember
		'', -- Constant
		'', -- Struct
		'', -- Event
		'ﬦ', -- Operator
		'', -- TypeParameter
	}
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
	protocol.make_client_capabilities()
)

-- Determine OS
local home = os.getenv "HOME"
if vim.fn.has "mac" == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
	CONFIG = "mac"
elseif vim.fn.has "unix" == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
	CONFIG = "linux"
else
	print "Unsupported system"
end


nvim_lsp.tsserver.setup {
	on_attach = on_attach,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities
}

nvim_lsp.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

-- java
--nvim_lsp.jdtls.setup {
--  on_attach = on_attach,
--  cmd = {
--    "java", -- or '/path/to/java11_or_newer/bin/java'
--    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--    "-Dosgi.bundles.defaultStartLevel=4",
--    "-Declipse.product=org.eclipse.jdt.ls.core.product",
--    "-Dlog.protocol=true",
--    "-Dlog.level=ALL",
--    "-Xms1g",
--    "--add-modules=ALL-SYSTEM",
--    "--add-opens",
--    "java.base/java.util=ALL-UNNAMED",
--    "--add-opens",
--    "java.base/java.lang=ALL-UNNAMED",
--    "-jar", vim.fn.glob(home .. "/jdt/plugins/org.eclipse.equinox.launcher_*.jar"),
--    "-configuration",
--    home .. "/jdt/config_" .. CONFIG,
--    "-data", workspace_dir,
--  },
--}
--nvim_lsp.phpactor.setup{
--  on_attach = on_attach,
--  init_options = {
--      ["language_server_phpstan.enabled"] = false,
--      ["language_server_psalm.enabled"] = false,
--  }
--}
nvim_lsp.intelephense.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	--  settings = {
	--    intelephense = {
	--      files = {
	--        maxSize = 1000000,
	--      },
	--      environment = {
	--        includePaths = {
	--          "/home/serii/Sites/wordpress",
	--          "/home/serii/Sites/advanced-custom-fields-pro",
	--          "/home/serii/Sites/woocommerce"
	--        }
	--      }
	--    }
	--  }
}


nvim_lsp.tailwindcss.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

nvim_lsp.cssls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
nvim_lsp.html.setup {
	on_attach = on_attach,
	filetypes = {
		"html",
		"blade",
	},
	capabilities = capabilities
}


--nvim_lsp.eslint.setup({
--  on_attach = on_attach,
--  capabilities = capabilities,
--  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx",
--    "vue", "svelte", "astro" },
--})
--nvim_lsp.eslint.setup({
--  on_attach = function(client, bufnr)
--    vim.api.nvim_create_autocmd("BufWritePre", {
--      buffer = bufnr,
--      command = "prettired",
--    })
--  end,
--})

--nvim_lsp.flow.setup({
--  on_attach = on_attach,
--  capabilities = capabilities,
--  filetypes = { "javascript", "javascriptreact", "javascript.jsx" }
--})

--local project_library_path = "/usr/lib/node_modules/node_modules"
--local cmd = { "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations",
--  project_library_path }
--
--nvim_lsp.angularls.setup {
--  cmd = cmd,
--  on_new_config = function(new_config, new_root_dir)
--    new_config.cmd = cmd
--  end,
--}

nvim_lsp.ccls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

nvim_lsp.solidity.setup {
	--cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
	on_attach = on_attach,
	capabilities = capabilities

}
require'lspconfig'.gopls.setup{
	on_attach = on_attach,
	capabilities = capabilities
}

require'lspconfig'.prismals.setup{
	on_attach = on_attach,
	capabilities = capabilities
}
--nvim_lsp.solc.setup {
--	on_attach = on_attach,
--	capabilities = capabilities
--}
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		update_in_insert = false,
		virtual_text = { spacing = 4, prefix = "●" },
		severity_sort = true,
	}
)
-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = '●'
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
--
--
--
--vim.diagnostic.config({
--  virtual_text = false,
--})
--vim.o.updatetime = 250
--vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
