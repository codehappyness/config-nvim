local keymap = vim.keymap

vim.g.limelight_conceal_ctermfg = 245
vim.g.limelight_conceal_guifg = '#8a8a8a'
vim.g.limelight_default_coefficient = 0.7
vim.g.limelight_paragraph_span = 1
--vim.g.limelight_bop = '^\\s'
--vim.g.limelight_eop = '\\ze\\n^\\s'

keymap.set('n', '<leader>l', '<cmd>Limelight<CR>')
keymap.set('x', '<leader>l', '<cmd>Limelight<CR>')
