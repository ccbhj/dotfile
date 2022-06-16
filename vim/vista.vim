" plugin - vista

let g:vista_default_executive  = 'ctags'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_fzf_preview = ["right:40%"]
let g:vista#renderer#icons = {'subroutine': '羚'
            \ , 'method': ''
            \ , 'func': '',
            \ 'variables': ''
            \ , 'constructor': '略'
            \ , 'field': ''
            \ , 'interface': ''
            \ , 'type': ''
            \ , 'packages': ''
            \ , 'property': '襁'
            \ , 'implementation': ''
            \ , 'default': ''
            \ , 'augroup': 'פּ'
            \ , 'macro': ''
            \ , 'enumerator': ''
            \ , 'const': ''
            \ , 'macros': ''
            \ , 'map': 'פּ'
            \ , 'fields': ''
            \ , 'functions': '',
            \ 'enum': ''
            \ , 'function': ''
            \ , 'target': '',
            \ 'typedef': '',
            \ 'namespace': ''
            \ , 'enummember': ''
            \ , 'variable': '',
            \ 'modules': ''
            \ , 'constant': ''
            \ , 'struct': '',
            \ 'types': ''
            \ , 'module': ''
            \ , 'typeParameter': ''
            \ , 'package': ''
            \ , 'class': '',
            \ 'member': '',
            \ 'var': '',
            \ 'union': '鬒'}
" " 
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_width = 50
nmap <F8> :Vista!! <CR>
" let g:vista_executive_for = {
"    \ 'go': 'nvim_lsp',
"    \ 'cpp': 'nvim_lsp',
"    \ 'c': 'nvim_lsp',
"    \ 'python': 'nvim_lsp'
"    \ }
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
" 
" set statusline+=%{NearestMethodOrFunction()}
" 
" " By default vista.vim never run if you don't call it explicitly.
" " 
" " If you want to show the nearest function in your statusline automatically,
" " you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" 
