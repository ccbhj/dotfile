local set_nmap = function (key, cmd) 
  vim.api.nvim_set_keymap(
      'n',
      key,
      cmd,
      {noremap = true, silent = true}
  )
end


vim.b.surround_indent=1
-- inoremap <buffer> <silent> <BS> <C-R>=AutoPairsDelete()<CR>

vim.g.AutoPairsShortcutFastWrap='<C-e>'
vim.g.AutoPairsShortcutJump='<leader>j'
vim.g.AutoPairsShortcutToggle='<leader>p'
-- vim.g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
