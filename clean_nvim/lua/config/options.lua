local set = vim.o

vim.opt.backup = true
vim.opt.cmdheight = 0
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
vim.opt.mousescroll = "ver:2,hor:6"
--
-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	return keymap_set(mode, lhs, rhs, opts)
end

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

if vim.fn.has("win32") == 1 then
	LazyVim.terminal.setup("pwsh")
end

-- set.completeopt = "menuone,noselect,noinsert"
set.number = true
set.relativenumber = true
set.signcolumn = "auto"
set.cursorline = true
set.cursorline = true
set.cursorcolumn = true
set.expandtab = true
set.cindent = true
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
vim.opt.iskeyword:append({ "_", "$", "@", "#", "-" })

set.incsearch = true -- 输入搜索内容时就显示搜索结果
set.hlsearch = false -- 搜索时高亮显示被找到的文本
set.magic = true
set.hidden = true -- 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set.ea = true -- 设置split window时保持宽度相同

set.guicursor = "i:block" -- 设置指针形状
-- set.guioptions:remove('m') -- 隐藏菜单栏
set.foldmethod = "manual"

set.termguicolors = true
set.autochdir = true
set.shortmess = "sWIcF"
set.updatetime = 100
set.redrawtime = 1500
set.timeout = true
set.ttimeout = true
set.timeoutlen = 500
set.ttimeoutlen = 10
