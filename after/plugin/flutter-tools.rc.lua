local status, flutter_tools = pcall(require, "flutter-tools")
if (not status) then return end


local protocol = require('vim.lsp.protocol')

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
  buf_set_keymap('x', '<leader>a', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<Cmd>Telescope flutter commands<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>', opts)
  buf_set_keymap('n', '<C-u>', '<Cmd>FlutterReanalyze<CR>', opts)
  buf_set_keymap('n', 'mm', '<Cmd>FlutterRename<CR>', opts)
  buf_set_keymap('n', '<leader>8', '<Cmd>FlutterOutlineToggle<CR>', opts)
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
-- alternatively you can override the default configs
local capabilities = require('cmp_nvim_lsp').default_capabilities(
--protocol.make_client_capabilities()
)

flutter_tools.setup {
  ui = {
    -- the border type to use for all floating windows, the same options/formats
    -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
    border = "rounded",
    -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
    -- please note that this option is eventually going to be deprecated and users will need to
    -- depend on plugins like `nvim-notify` instead.
  },
  decorations = {
    statusline = {
      -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
      -- this will show the current version of the flutter app from the pubspec.yaml file
      app_version = false,
      -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
      -- this will show the currently running device if an application was started with a specific
      -- device
      device = false,
    }
  },
  fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  widget_guides = {
    enabled = false,
  },
  --closing_tags = {
  --  prefix = " // ", -- character to use for close tag e.g. > Widget
  --  enabled = false -- set to false to disable
  --},
  dev_log = {
    enabled = true,
    notify_errors = false,
    -- open_cmd = "tabedit", -- command to use to open the log buffer
    open_cmd = "botright 70vnew", -- command to use to open the outline buffer
  },
  dev_tools = {
    autostart = true,          -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
    auto_open = false    -- if true this will open the outline automatically when it is first populated
  },
  lsp = {
    color = {
      -- show the derived colours for dart variables
      enabled = false,        -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false,     -- highlight the background
      foreground = false,     -- highlight the foreground
      virtual_text = true,    -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    on_attach = on_attach,
    capabilities = capabilities, -- e.g. lsp_status capabilities
    -- see the link below for details on each option:
    -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      renameFilesWithClasses = "prompt", -- "always"
      enableSnippets = true,
    }
  }
}
