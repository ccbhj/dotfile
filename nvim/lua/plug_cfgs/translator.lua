local set_nmap = function (key, cmd) 
    vim.api.nvim_set_keymap(
        'n',
        key,
        cmd,
        {noremap = true, silent = true}
    )
end

set_nmap('<leader>v', '<Plug>Translate')
set_nmap('<leader>R', '<Plug>TranslateR')
set_nmap('<leader>x', '<Plug>TranslateX')
set_nmap('<leader>w', '<Plug>TranslateW')
vim.g.translator_default_engines={'bing', 'google', 'haici', 'youdao'}
