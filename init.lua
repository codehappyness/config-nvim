require('base')
require('highlights')
require('maps')
require('plugins')

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_linux = has "linux"

if is_linux then
  require('ubuntu')
end

vim.cmd [[
  autocmd BufRead,BufNewFile *.blade.php set filetype=blade
  autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
]]
vim.g.blade_custom_directives = { 'datetime', 'javascript' }
vim.g.blade_custom_directives_pairs = {
  markdown = 'endmarkdown',
  cache = 'endcache',
}

vim.g.php_cs_fixer_level = "symfony"
vim.g.php_cs_fixer_config = "default"
vim.g.php_cs_fixer_rules = "@PSR2"
vim.g.php_cs_fixer_allow_risky = "yes"

vim.g.php_cs_fixer_php_path = "php"
vim.g.php_cs_fixer_enable_default_mapping = 1
vim.g.php_cs_fixer_dry_run = 0
vim.g.php_cs_fixer_verbose = 0
vim.g.tagalong_verbose = 1
