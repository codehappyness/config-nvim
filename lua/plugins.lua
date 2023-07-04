local status, packer = pcall(require, "packer")
if (not status) then
	print("Packer is not installed")
	return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
		'svrana/neosolarized.nvim',
		requires = { 'tjdevries/colorbuddy.nvim' }
	}
	use { 'overcache/NeoSolarized' }
	use 'nvim-lualine/lualine.nvim' -- Statusline
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}

	use 'onsails/lspkind-nvim' -- vscode-like pictograms

	use 'hrsh7th/nvim-cmp'     -- Completion
	use 'hrsh7th/cmp-buffer'   -- nvim-cmp source for buffer words
	use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
	use 'hrsh7th/cmp-path'
	use 'saadparwaiz1/cmp_luasnip'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-cmdline'
	--use 'hrsh7th/vim-vsnip'
	--use 'hrsh7th/vim-vsnip-integ'

	use 'SirVer/Ultisnips'
	use 'L3MON4D3/LuaSnip'
	--use 'rafamadriz/friendly-snippets'
	--use 'RobertBrunhage/flutter-riverpod-snippets'
	--use 'Neevash/awesome-flutter-snippets'

	use 'quangnguyen30192/cmp-nvim-ultisnips'
	--use 'natebosch/dartlang-snippets'

	use 'neovim/nvim-lspconfig' -- LSP
	use 'kabouzeid/nvim-lspinstall'
	use 'mfussenegger/nvim-jdtls'
	use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
	use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use 'MunifTanjim/prettier.nvim'       -- Prettier plugin for Neovim's built-in LSP client
	--use 'dart-lang/dart-vim-plugin'
	use 'windwp/nvim-autopairs'
	use 'windwp/nvim-ts-autotag'
	--
	use 'norcalli/nvim-colorizer.lua'
	use { 'nvim-telescope/telescope-ui-select.nvim' }
	use 'nvim-telescope/telescope-file-browser.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use 'kyazdani42/nvim-web-devicons' -- File icons
	use 'akinsho/nvim-bufferline.lua'
	use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }
	use 'junegunn/goyo.vim'
	use 'junegunn/limelight.vim'
	use 'iamcco/markdown-preview.nvim'
	use 'preservim/tagbar'
	--use 'phpactor/phpactor'
	use 'jwalton512/vim-blade'
	use 'sunzhongwei/vim-laravel-snippets'
	use "williamboman/mason.nvim"
	use 'williamboman/mason-lspconfig.nvim'
	use 'AndrewRadev/tagalong.vim'
	--use 'stephpy/vim-php-cs-fixer'
	use {
		'lewis6991/gitsigns.nvim',
		tag = 'v0.5' -- To use the latest release
	}
	--
	--  use "EdenEast/nightfox.nvim"
	--
	use "tpope/vim-fugitive"
	use "tpope/vim-surround"
	use "tpope/vim-commentary"
	use 'mattn/emmet-vim'
	use "tpope/vim-repeat"
	--use {'neoclide/coc.nvim', branch = 'release'}
	use "vim-scripts/loremipsum"
	--use 'preservim/nerdtree'
	use 'MunifTanjim/eslint.nvim'
	use 'xiyaowong/telescope-emoji.nvim'
	use 'prisma/vim-prisma'
end)
