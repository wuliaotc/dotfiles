" 基础设置
lua require('basic')
" 快捷键映射
lua require('keybindings')
" Packer插件管理
lua require('plugins')
" 插件配置
lua require('plugin-config/nvim-tree')
lua require('plugin-config/lualine')
lua require('plugin-config/nvim-treesitter')
lua require('plugin-config/telescope')
" lsp
lua require('lsp/setup')
" format
lua require("lsp/null-ls")

set background=dark
colorscheme nord 

" Or, you could use neovim's floating text feature.
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu
