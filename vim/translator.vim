""" Configuration example
" Echo translation in the cmdline
nmap <silent> <Leader>v <Plug>Translate
" Display translation in a window
" Replace the text with translation
nmap <silent> <Leader>R <Plug>TranslateR
" Translate the text in clipboard
nmap <silent> <Leader>x <Plug>TranslateX
nmap <silent> <Leader>T <Plug>TranslateW

nnoremap <silent><expr> <M-f> translator#window#float#has_scroll() ?
                            \ translator#window#float#scroll(1) : "\<M-f>"
nnoremap <silent><expr> <M-b> translator#window#float#has_scroll() ?
                            \ translator#window#float#scroll(0) : "\<M-f>"
let g:translator_default_engines=['bing', 'google', 'haici', 'youdao']
