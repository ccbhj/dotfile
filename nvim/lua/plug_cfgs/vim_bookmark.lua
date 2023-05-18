vim.g.bookmark_auto_save = 1
vim.g.bookmark_sign = '♥'
vim.g.bookmark_highlight_lines = 1
vim.g.bookmark_no_default_key_mappings = 1
vim.g.bookmark_display_annotation = 1
vim.g.bookmark_disable_ctrlp = 1

local set_nmap = function (key, cmd) 
    vim.api.nvim_set_keymap(
        'n',
        key,
        cmd,
        {noremap = true, silent = true}
    )
end


set_nmap('<leader>m', '<Plug>BookmarkToggle')
set_nmap('<leader>i', '<Plug>BookmarkAnnotate')
set_nmap('<leader>j', '<Plug>BookmarkNext')
set_nmap('<leader>k', '<Plug>BookmarkPrev')
set_nmap('<leader>kk', '<Plug>BookmarkMoveUp')
set_nmap('<leader>jj', '<Plug>BookmarkMoveDown')

