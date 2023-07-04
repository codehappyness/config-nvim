local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


keymap('n', 'x', '"_x', opts)

-- Increment/decrement
keymap('n', '+', '<C-a>', opts)
keymap('n', '-', '<C-x>', opts)

-- Delete a word backwards
--keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G', opts)

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap('n', 'te', ':tabedit ', {})
keymap('n', 'tn', ':tabedit %:h/', {})
keymap('n', 'to', ':tabedit .<CR>', {})
-- Split window
-- Split window
keymap('n', 'ss', ':split<Return><C-w>w', opts)
keymap('n', 'sv', ':vsplit<Return><C-w>w', opts)
-- Move window
keymap('n', '<Space>', '<C-w>w', opts)
keymap('', 'sh', '<C-w>h', opts)
keymap('', 'sk', '<C-w>k', opts)
keymap('', 'sj', '<C-w>j', opts)
keymap('', 'sl', '<C-w>l', opts)

keymap('n', 'gk', 'ddkP', opts)
keymap('n', 'gj', 'ddp', opts)
--keymap('', '<C-a>', '<Esc>^', opts)
--keymap('i', '<C-a>', '<Esc>I', opts)
--keymap('', '<C-e>', '<Esc>$', opts)
--keymap('i', '<C-e>', '<Esc>A', opts)
--keymap('i', 'jk', '<Esc>', opts)
-- Resize window
-- Resize window
keymap('n', '<C-w><left>', '<C-w><', opts)
keymap('n', '<C-w><right>', '<C-w>>', opts)
keymap('n', '<C-w><up>', '<C-w>+', opts)
keymap('n', '<C-w><down>', '<C-w>-', opts)
keymap('n', '<F8>', ':TagbarToggle<CR>', opts)

keymap('n', '<leader>n', ':NERDTreeFocus<CR>', opts)
--keymap.set('n', 'dw', 'vb"_d')
keymap('n', '<C-s>', ':MarkdownPreview<CR>', opts)
keymap('n', '<leader>s', ':MarkdownPreviewStop<CR>', opts)
keymap('n', '<C-p>', ':MarkdownPreviewToggle<CR>', opts)
keymap('n', '<C-e>', ':Telescope emoji<CR>', opts)
