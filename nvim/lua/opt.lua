local set = vim.o

set.nocompatible = true
set.completeopt="menu,menuone,noselect"


set.tw=80
set.number=true
set.cursorline=true
set.cursorline=true
set.cursorcolumn=true
set.expandtab=true
set.cindent= true
set.shiftwidth=2
set.softtabstop=2
set.tabstop=2
vim.opt.iskeyword:append({"_", "$", "@", "#", "-"})
set.autowrite=true
set.ignorecase=true
set.smartcase=true -- 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set.nowrapscan=true -- 禁止在搜索到文件两端时重新搜索
set.incsearch=true -- 输入搜索内容时就显示搜索结果
set.hlsearch=false -- 搜索时高亮显示被找到的文本
set.noerrorbells=true -- 关闭错误信息响铃
set.novisualbell=true -- 关闭使用可视响铃代替呼叫
set.t_vb=true -- 置空错误铃声的终端代码
set.magic=true
set.hidden=true -- 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set.ea=true -- 设置split window时保持宽度相同

set.guicursor="i:block"  -- 设置指针形状
-- set.guioptions:remove('m') -- 隐藏菜单栏
set.smartindent=true -- 开启新行时使用智能自动缩进
set.cmdheight=1 -- 设定命令行的行数为 1
set.laststatus=2 
set.statusline=""
set.foldmethod='manual'

set.nobackup=true
set.nowritebackup=true

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
set.updatetime=300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
set.signcolumn="yes"
set.termencoding="utf-8"
set.fencs="utf-8,gbk"
set.encoding="utf-8"

set.termguicolors = true
set.autochdir=true

vim.cmd('language en_US.UTF-8')

