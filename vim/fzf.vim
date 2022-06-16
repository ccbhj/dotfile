
" fzf.vim
[Buffers] Jump to the existing window if possible

let g:fzf_buffers_jump = 1
" Want a preview window?
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

nnoremap <space>f :Files<CR>
nnoremap <space>F :GFiles<CR>
nnoremap <leader>s :GFiles?<CR>
nnoremap <space>t :Tags<CR>
nnoremap <space>T :BTags<CR>

