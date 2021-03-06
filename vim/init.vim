let g:polyglot_disabled = ['c', 'cpp', 'vim-lsp-cxx-highlight.plugin']
set nocompatible
call plug#begin('~/.vim/plugged')
" Plug 'fatih/vim-go',   { 'for': 'go'}
" Plug 'rust-lang/rust.vim', {'for': 'rs'}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh', 'for': 'go'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'plasticboy/vim-markdown', {'for': 'md'}
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'

"" Plug 'pangloss/vim-javascript'
" Plug 'jackguo380/vim-lsp-cxx-highlight', {'for': ['c', 'cpp']}
"
" Plug 'honza/vim-snippets'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'preservim/tagbar'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
" Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'cespare/vim-toml', { 'branch': 'main' }


"" color scheme
Plug 'morhetz/gruvbox' 
Plug 'joshdick/onedark.vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'olimorris/onedarkpro.nvim'

Plug 'sheerun/vim-polyglot' 
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'rafamadriz/friendly-snippets'
" Plug 'SirVer/ultisnips'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}


" coc.vim
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'fannheyward/telescope-coc.nvim'


" nvim plugins
Plug 'ray-x/lsp_signature.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'matveyt/neoclip'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'tom-anders/telescope-vim-bookmarks.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'folke/twilight.nvim'

" git 
" Plug 'tanvirtin/vgit.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'


" nvim_lsp
Plug 'neovim/nvim-lspconfig'
" Plug 'kabouzeid/nvim-lspinstall'
Plug 'williamboman/nvim-lsp-installer'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'quangnguyen30192/cmp-nvim-tags'
" Plug 'glepnir/lspsaga.nvim'
" Plug 'tami5/lspsaga.nvim', {'branch' : 'nvim51'}


Plug 'kyazdani42/nvim-tree.lua'
Plug 'lewis6991/gitsigns.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'} 
Plug 'romgrk/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'p00f/nvim-ts-rainbow'

Plug 'voldikss/vim-translator'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
" Plug 'ray-x/guihua.lua' " --float term, gui support
Plug 'ray-x/go.nvim'

Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'simrat39/symbols-outline.nvim'
Plug 'romgrk/barbar.nvim'
" Plug 'akinsho/bufferline.nvim'

call plug#end() " required

set completeopt=menu,menuone,noselect

" Put your non-Plugin stuff after this line
"????????????
set nocompatible " ?????? vi ????????????
syntax on " ??????????????????
" ??????80?????????
set nocompatible " ?????? vi ????????????
set tw=80
set number " ????????????
" set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s "??????C/C++??????????????????
set cursorline " ?????????????????????
set cursorline cursorcolumn
set expandtab "???tab???????????????
set autoindent " ??????????????????
set cindent " c????????????
set shiftwidth=2 " ?????? << ??? >> ??????????????????????????? 4
set softtabstop=2 
filetype on
filetype indent on " ????????????????????????????????????
set tabstop=2 " ?????? tab ????????? 2
set iskeyword+=_,$,@,%,#,- " ??????????????????????????????????????????
set nobackup " ????????????????????????
set autochdir " ??????????????????????????????????????????????????????
set autowrite
filetype plugin indent on " ????????????
set backupcopy=yes " ?????????????????????????????????
set ignorecase smartcase " ?????????????????????????????????????????????????????????????????????????????????????????????
set nowrapscan " ?????????????????????????????????????????????
set incsearch " ??????????????????????????????????????????
set hlsearch " ???????????????????????????????????????
set nohls
set noerrorbells " ????????????????????????
set novisualbell " ????????????????????????????????????
set t_vb= " ?????????????????????????????????
" set showmatch " ?????????????????????????????????????????????????????????
" set matchtime=1 " ????????????????????????????????????
set magic " ????????????
set hidden " ????????????????????????????????????????????????????????????????????? vim ????????????
set ea " ??????split window?????????????????????

set guicursor=i:block " ??????????????????
set guioptions-=m " ???????????????
" set smartindent " ???????????????????????????????????????
set backspace=indent,eol,start
" ????????????????????????????????????????????? Delete ??????????????????
set cmdheight=1 " ??????????????????????????? 1
set laststatus=2 " ??????????????? (???????????? 1, ?????????????????????)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
" ?????????????????????????????????
set foldmethod=manual
setlocal foldlevel=1 " ?????????????????????
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


set sessionoptions+=globals

" ?????????????????????
if has("multi_byte")
" UTF-8 ??????
set encoding=utf-8
set history=50
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set termencoding=utf-8
set formatoptions+=mM
set fencs=utf-8,gbk
endif

" unmap the evil F1
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

" tab
map tn :tabnext<cr>
map tp :tabprevious<cr>
map td :tabnew .<cr>
map te :tabedit
map tc :tabclose<cr>

" buffer
map <leader>b :badd
map vs :vs
map hs :split

"???????????????,?????????????????????????????????????????????,???????????????????????????
"?????????????????????,??????<c-w><c-w>k,????????????,??????????????????<c-k>,?????????
"???????????????????????????.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Python ???????????????????????????????????? tab ???
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab


"-----------------------------------------------------------------
" plugin - NERD_tree.vim ????????????????????????????????????????????????
" :ERDtree ??????NERD_tree :NERDtreeClose ??????NERD_tree
" o ?????????????????????????????? t ?????????????????????
" T ??????????????????????????? ! ???????????????
" p ??????????????? P ????????????
" K ?????????????????? J ?????????????????????
" u ?????????????????? m ????????????????????????????????????????????????????????????
" r ???????????????????????? R ???????????????????????????
"-----------------------------------------------------------------
" F4 NERDTree ??????
"
" map <F4> :NERDTreeToggle<CR>
" imap <F4> <ESC>:NERDTreeToggle<CR>


"-----------------------------------------------------------------
" plugin - NERD_commenter.vim ?????????????????????
" [count],cc ????????????count?????????????????????(7,cc)
" [count],cu ????????????count?????????????????????(7,cu)
" [count],cm ????????????count????????????????????????(7,cm)
" ,cA ??????????????? /* */,??????????????????????????? ??????????????????????????????
" ??????count???????????????????????????????????????????????????
"-----------------------------------------------------------------
let NERDSpaceDelims=1 " ??????????????????????????????????????????
let NERDCompactSexyComs=1 " ??????????????????????????????

"-----------------------------------------------------------------
" plugin - NeoComplCache.vim ??????????????????
"-----------------------------------------------------------------

" Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" 
" " Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
" \ 'vimshell' : $HOME.'/.vimshell_hist',
" \ 'scheme' : $HOME.'/.gosh_completions'
" \ }

" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
" let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" 
" " Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()

" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).

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
" ????????????JavaScript
""

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
set conceallevel=1
map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

"
" <leader> = '\'
" \ + n ????????????
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


" map <F7> :term <CR>
" set shell=/usr/bin/zsh


let g:airline#extensions#tagbar#enabled = 0
" airline
let g:airline_detect_spell=1

" coc.vim
" source ~/.config/vim/coc.vim

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
"let g:airline_theme='onedark'
let g:onedark_terminal_italics=1
" colorscheme dracula
" colorscheme onedark
" colorscheme gruvbox

" Yggdroot/indentLine
let g:indentLine_char = '???'
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_setConceal = 0


" vim-lsp-cxx-highlight
let g:lsp_cxx_hl_ft_whitelist = ['c', 'cpp', 'h', 'cc', 'hh', 'hpp']

" auto-pairs
"
inoremap <buffer> <silent> <BS> <C-R>=AutoPairsDelete()<CR>
let g:AutoPairsShortcutFastWrap ='<C-e>'
let g:AutoPairsShortcutJump = '<leader>j'
let g:AutoPairsShortcutToggle = '<leader>p'
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

source ~/.config/vim/nvim_lsp.vim
:luafile ~/.config/vim/nvim_term.lua
:luafile ~/.config/vim/nvim_cmp.lua
:luafile ~/.config/vim/luasnip.lua
:luafile ~/.config/vim/nvim_lsp_server.lua
source ~/.config/vim/telescope.vim
" source ~/.config/vim/lsp_saga.vim
" :luafile ~/.config/vim/bufferline.lua
:luafile ~/.config/vim/nvim-tree.lua
:luafile ~/.config/vim/lsp_signature_help.lua
" :luafile ~/.config/vim/indent_blankline.lua
" :luafile ~/.config/vim/one_dark.lua
:luafile ~/.config/vim/treesitter.lua
:luafile ~/.config/vim/x-ray_go.lua
" :luafile ~/.config/vim/vgit.lua
:luafile ~/.config/vim/gitsigns.lua
:source ~/.config/vim/translator.vim
:luafile ~/.config/vim/diffview.lua
" :source ~/.config/vim/tagbar.vim
:source ~/.config/vim/vista.vim
:source ~/.config/vim/lightline.vim

nnoremap <silent><leader>t <Cmd>exe v:count1 . "ToggleTerm  size=15 dir=. direction=horizontal"<CR>
"  vim-bookmarks 
source ~/.config/vim/vim_bookmark.vim
" vim-go
" source ~/.config/vim/vim_go.vim
"
:luafile ~/.config/vim/nvim_catppuccin.lua
:luafile ~/.config/vim/symbol_outline.lua
:luafile ~/.config/vim/barbar.lua
