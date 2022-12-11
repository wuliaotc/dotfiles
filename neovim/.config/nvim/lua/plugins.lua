return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- UI
	--- gruvbox theme
	use({
		"ellisonleao/gruvbox.nvim",
		requires = { "rktjmp/lush.nvim" },
	})

	--- nord theme
	use("shaunsingh/nord.nvim")
	--- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- code
	--- highlight

	---- nvim-tree (新增)
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})

	---- nvim-treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = "kyazdani42/nvim-web-devicons",
		run = ":TSUpdate",
	})
	----- auto gen cpp code
	use({
		requires = { "nvim-treesitter/nvim-treesitter" },
		"Badhi/nvim-treesitter-cpp-tools",
	})

	-- language
	--- lua enhanced
	use("folke/neodev.nvim")
	--- json
	use("b0o/schemastore.nvim")
	-- lspconfig
	--use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'}
	use({ "neovim/nvim-lspconfig", "williamboman/mason.nvim" })
	--use 'glepnir/lspsaga.nvim'
	use("L3MON4D3/LuaSnip")
	use("simrat39/rust-tools.nvim")
	use("simrat39/symbols-outline.nvim")
	--- format
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
	--- nvim-cmp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("ray-x/cmp-treesitter")
	--- vsnip
	use("hrsh7th/cmp-vsnip") -- { name = 'vsnip' }
	use("hrsh7th/vim-vsnip")
	use("rafamadriz/friendly-snippets")
	-- UI 增强
	use("onsails/lspkind-nvim")
	use("kkharji/lspsaga.nvim")

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- tool
	-- git
	-- git
	use({ "lewis6991/gitsigns.nvim" })
	-- -- leap
	use({ "ggandor/leap.nvim", requires = { { "tpope/vim-repeat" } } })
end)
