local set = vim.o

set.completeopt = "menu,menuone,noselect"

-- set.tw = 120
set.number = true
set.relativenumber = true
set.cursorline = true
set.cursorline = true
set.cursorcolumn = true
set.expandtab = true
set.cindent = true
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
vim.opt.iskeyword:append({ "_", "$", "@", "#", "-" })
set.autowrite = true
set.ignorecase = true
set.smartcase = true    -- 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set.incsearch = true    -- 输入搜索内容时就显示搜索结果
set.hlsearch = false    -- 搜索时高亮显示被找到的文本
set.magic = true
set.hidden = true       -- 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set.ea = true           -- 设置split window时保持宽度相同

set.guicursor = "i:block" -- 设置指针形状
-- set.guioptions:remove('m') -- 隐藏菜单栏
set.smartindent = true  -- 开启新行时使用智能自动缩进
set.cmdheight = 1       -- 设定命令行的行数为 1
set.laststatus = 2
set.statusline = ""
set.foldmethod = 'manual'

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
set.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
set.signcolumn = "yes"
set.fencs = "utf-8,gbk"
set.encoding = "utf-8"

set.termguicolors = true
set.autochdir = true
set.shortmess = "sWIcF"
set.updatetime = 100
set.redrawtime = 1500
set.timeout = true
set.ttimeout = true
set.timeoutlen = 500
set.ttimeoutlen = 10

-- vim.cmd('language en_US.UTF-8')


-- nvim-parinfer
vim.g.parinfer_mode = "indent"
vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' }) -- line to fix de background color border
