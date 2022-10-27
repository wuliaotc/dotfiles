--- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- 保存本地变量 -- map('模式','按键','映射为XX',opt)
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }
--- visual 模式下可以连续 > 缩进代码
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)

--- 分屏
--- sv 水平分屏
--- sh 垂直分屏
--- sc 关闭当前分屏 (s = close)
--- so 关闭其他分屏 (o = other)
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
map("n", "sc", "<C-w>c", opt)
map("n", "so", "<C-w>o", opt) -- close others

--- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


