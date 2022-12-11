require("nvim-treesitter.configs").setup({
	-- 安装 language parser
	-- :TSInstallInfo 命令查看支持的语言
	ensure_installed = { "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "cpp" },
	-- 启用代码高亮功能
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	-- 启用增量选择
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<TAB>",
		},
	},
	-- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
	indent = {
		enable = true,
	},
	nt_cpp_tools = {
		enable = true,
		preview = {
			quit = "q", -- optional keymapping for quit preview
			accept = "<tab>", -- optional keymapping for accept preview
		},
		header_extension = "h", -- optional
		source_extension = "cpp", -- optional
		custom_define_class_function_commands = { -- optional
			TSCppImplWrite = {
				output_handle = require("nvim-treesitter.nt-cpp-tools.output_handlers").get_add_to_cpp(),
			},
		},
	},
})
-- 开启 Folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99
