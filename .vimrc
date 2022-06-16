let g:polyglot_disabled = ['c', 'cpp', 'vim-lsp-cxx-highlight.plugin']
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go',   { 'for': 'go', 'do': ':GoUpdateBinaries'}
"" Plug 'rust-lang/rust.vim', {'for': 'rs'}
Plug 'preservim/tagbar' 
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jiangmiao/auto-pairs'
"" Plug 'SirVer/ultisnips'
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh', 'for': 'go'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'plasticboy/vim-markdown', {'for': 'md'}
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
"" Plug 'pangloss/vim-javascript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': ['c', 'cpp']}
"
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
"" color scheme
"" Plug 'morhetz/gruvbox' 
Plug 'joshdick/onedark.vim'
" Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'sheerun/vim-polyglot' 
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}




call plug#end() " required

" Put your non-Plugin stuff after this line
"常规配置
set nocompatible " 关闭 vi 兼容模式
syntax on " 自动语法高亮
" 一行80个字符
set nocompatible " 关闭 vi 兼容模式
set tw=80
set number " 显示行号
" set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s "设置C/C++语言的具体缩
set cursorline " 突出显示当前行
set cursorline cursorcolumn
set expandtab "将tab拓展为空格
set autoindent " 设置自动缩进
set cindent " c自动缩进
set shiftwidth=2 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=2 
filetype on
filetype indent on " 自适应不同语言的智能缩进
set tabstop=2 " 设定 tab 长度为 2
set iskeyword+=_,$,@,%,#,- " 设置有这些符号的单词不被换行
set nobackup " 覆盖文件时不备份
set autochdir " 自动切换当前目录为当前文件所在的目录
set autowrite
filetype plugin indent on " 开启插件
set backupcopy=yes " 设置备份时的行为为覆盖
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan " 禁止在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本
set nohls
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码
" set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
" set matchtime=1 " 短暂跳转到匹配括号的时间
set magic " 设置魔术
set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set ea " 设置split window时保持宽度相同

set guioptions-=m " 隐藏菜单栏
" set smartindent " 开启新行时使用智能自动缩进
set backspace=indent,eol,start
" 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1 " 设定命令行的行数为 1
set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
" 设置在状态行显示的信息
set foldmethod=manual
setlocal foldlevel=1 " 设置折叠层数为
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes


" 配置多语言环境
if has("multi_byte")
" UTF-8 编码
set encoding=utf-8
set history=50
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set termencoding=utf-8
set formatoptions+=mM
set fencs=utf-8,gbk
endif

if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
set ambiwidth=double
endif
"关于tab的快捷键
map tn :tabnext<cr>
map tp :tabprevious<cr>
map td :tabnew .<cr>
map te :tabedit
map tc :tabclose<cr>

"窗口分割时,进行切换的按键热键需要连接两次,比如从下方窗口移动
"光标到上方窗口,需要<c-w><c-w>k,非常麻烦,现在重映射为<c-k>,切换的
"时候会变得非常方便.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab


"-----------------------------------------------------------------
" plugin - vista

" let g:vista_default_executive  = 'ctags'
" let g:vista_icon_indent = ["╰─▸ ", "▸ "]
" let g:vista_fzf_preview = ["right:40%"]
" 
" let g:vista_sidebar_widthA = 40
" nmap <F8> :Vista!! <CR>


"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" :ERDtree 打开NERD_tree :NERDtreeClose 关闭NERD_tree
" o 打开关闭文件或者目录 t 在标签页中打开
" T 在后台标签页中打开 ! 执行此文件
" p 到上层目录 P 到根目录
" K 到第一个节点 J 到最后一个节点
" u 打开上层目录 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录 R 递归刷新当前根目录
"-----------------------------------------------------------------
" F4 NERDTree 切换
"
map <F4> :NERDTreeToggle<CR>
imap <F4> <ESC>:NERDTreeToggle<CR>

" Shell like behavior(not recommended).
" set completeopt-=preview

""""""""""""""""""
"Quickly Run
"
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
exec "!gcc -Wall -g % -o %<"
exec "!time ./%<"
elseif &filetype == 'cpp'
exec "!g++ -Wall -g % -o %<"
exec "!time ./%<"
elseif &filetype == 'java'
exec "!javac %"
exec "!time java %<"
elseif &filetype == 'go'
exec "!time go run %"
elseif &filetype == 'python'
exec "!time python3 %"
elseif &filetype == 'html'
exec "./%"
elseif &filetype == 'javascript'
exec "!time node %"
elseif &filetype == 'sh'
exec '!time ./%'
elseif &filetype == 'rust'
exec '!cargo run'
elseif &filetype == 'elixir'
exec '!time elixir ./% '
endif
endfunc
map<F6> :call CompileRunGcc()<CR>


"""""""""""""
" 设置支持JavaScript
""

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
set conceallevel=1
map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

"
" <leader> = '\'
" \ + n 跳转标签
noremap <silent><leader>1 :tabn 1<cr>
noremap <silent><leader>2 :tabn 2<cr>
noremap <silent><leader>3 :tabn 3<cr>
noremap <silent><Leader>4 :tabn 4<cr>
noremap <silent><leader>5 :tabn 5<cr>
noremap <silent><leader>6 :tabn 6<cr>
noremap <silent><leader>7 :tabn 7<cr>
noremap <silent><leader>8 :tabn 8<cr>
noremap <silent><leader>9 :tabn 9<cr>
noremap <silent><leader>0 :tabn 10<cr>
noremap <silent><s-tab> :tabnext<CR>
inoremap <silent><s-tab> <ESC>:tabnext<CR>


" YouCompleteMe 配置
" 自动补全配置
" set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" "回车即选中当前项
" "上下左右键的行为 会显示其他信息
" inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
" inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
" 
"youcompleteme 默认tab s-tab 和自动补全冲突
" ycm configuration
" let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.global_extra_conf.py'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_confirm_extra_conf = 1
" let g:EclimFileTypeValidate = 0
" let g:ycm_min_num_of_chars_for_completion = 1
" 
" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
" 
" let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
" let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
" let g:ycm_semantic_triggers =  {
"   \   'c': ['->', '.'],
"   \   'cpp,cuda,objcpp': ['->', '.', '::'],
"   \   'php': ['->', '::'],
"   \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
"   \   'java': ['::'],
"   \   'erlang': [':'],
"   \ }
" 
" "在注释输入中也能补全
" let g:ycm_complete_in_comments = 1
" "在字符串输入中也能补全
" let g:ycm_complete_in_strings = 1
" "注释和字符串中的文字也会被收入补全
" let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 
" " YCM 快捷键
" nnoremap <leader>jd :YcmCompleter GoTo<CR> 
" nnoremap <leader>jr :YcmCompleter GoToReferences<CR> 
" nnoremap <leader>ji :YcmCompleter GoToImplementation<CR> 
" nnoremap <leader>jt :YcmCompleter GoToType<CR> 
" nnoremap <leader>gt :YcmCompleter GetType<CR> 
" nnoremap <leader>gp :YcmCompleter GetParent<CR> 
" nnoremap <leader>gd :YcmCompleter GetDoc<CR> 
" nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
" nnoremap <leader>lo :lopen<CR> "open locationlist
" nnoremap <leader>lc :lclose<CR> "close locationlist
" inoremap <leader><leader> <C-x><C-o>


" vim-go setting
let g:go_highlight_extra_types = 1
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_debug=1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_def_reuse_buffer = 1

au FileType go nmap <leader>dt <Plug>(go-def-tab)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)


let g:go_test_timeout = '10s'
let g:go_term_enabled= 1
let g:go_test_show_name = 1

let g:go_decls_includes = "func"
let g:go_auto_type_info = 1
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 1
let g:go_fmt_command = "goimports"


let g:go_debug_mappings = {
    \ '(go-debug-continue)':   {'key': '<F5>'},
    \ '(go-debug-print)':      {'key': '<F6>'},
    \ '(go-debug-breakpoint)': {'key': '<F9>'},
    \ '(go-debug-next)':       {'key': '<F10>'},
    \ '(go-debug-step)':       {'key': '<F11>'},
    \ '(go-debug-halt)':       {'key': '<F12>'},
    \ }

nnoremap <leader>a :cclose<CR>

map <F7> :term <CR>

" tagbar config 
nmap <F8> :TagbarToggle<CR>

let g:airline#extensions#tagbar#enabled = 0

" airline
let g:airline_detect_spell=1

" coc.vim
" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" let g:coc_snippet_next = '<tab>'

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use <C-l> for trigger snippet expand.
imap <C-j> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-l> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-l>'
" Use <C-h> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-h>'
" Use <C-l> for both expand and jump (make expand higher priority.)
imap <C-l> <Plug>(coc-snippets-expand-jump)


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')


function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
  execute 'h '.expand('<cword>')
elseif (coc#rpc#ready())
  call CocActionAsync('doHover')
else
  execute '!' . &keywordprg . " " . expand('<cword>')
endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"multi-lines  select

nmap <expr> <silent> <C-z> <SID>select_current_word()
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

" Formatting selected code.
""
xmap <leader>m  <Plug>(coc-format-selected)
nmap <leader>m  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)



" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent> <space>l  :CocList<CR>

nnoremap <leader>cc :CocCommand 

" fzf.vim

" [Buffers] Jump to the existing window if possible
"
let g:fzf_buffers_jump = 1
" Want a preview window?
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

nnoremap <space>l :Lines <CR>
nnoremap <space>L :BLines <CR>
nnoremap <space>f :Files<CR>
nnoremap <space>F :GFiles<CR>
nnoremap <leader>s :GFiles?<CR>
nnoremap <space>t :Tags<CR>
nnoremap <space>T :BTags<CR>
nnoremap <space>h :History<CR>


" vim-surround
let b:surround_indent = 1

" vim-onedarck
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if &term == "alacritty"
  let &term = "xterm-256color"
endif
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
let g:airline_theme='onedark'
let g:onedark_terminal_italics=1
" colorscheme dracula
colorscheme onedark


" vim-lsp-cxx-highlight
let g:lsp_cxx_hl_ft_whitelist = ['c', 'cpp', 'h', 'cc', 'hh', 'hpp']

" auto-pairs
"
inoremap <buffer> <silent> <BS> <C-R>=AutoPairsDelete()<CR>
let g:AutoPairsShortcutFastWrap ='<leader>w'
let g:AutoPairsShortcutJump = '<leader>j'
let g:AutoPairsShortcutToggle = '<leader>p'
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", "do":"end//n"}
