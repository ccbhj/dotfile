local wk = require("which-key")

local set_nmap = function(key, cmd)
  vim.api.nvim_set_keymap(
    'n',
    key,
    cmd,
    { noremap = true, silent = true }
  )
end

local set_imap = function(key, cmd)
  vim.api.nvim_set_keymap(
    'i',
    key,
    cmd,
    { noremap = true, silent = true }
  )
end

local set_map = function(key, cmd)
  vim.api.nvim_set_keymap(
    '',
    key,
    cmd,
    {}
  )
end




-- unmap the evil F1
set_nmap("<F1>", ":echo<CR>")
set_imap("<F1>", "<C-o>:echo<CR>")
-- <F5> to reload the config
set_imap("<F5>", ":source $XDG_CONFIG_HOME/nvim/init.lua<cr>")

-- tab
set_map("tn", ":tabnext<cr>")
set_map("tp", ":tabprevious<cr>")
set_map("td", ":tabnew <cr>")
set_map("te", ":tabedit")
set_map("tc", ":tabclose<cr>")

-- buffer
set_map("vs", ":vs")
set_map("hs", ":split")
set_map("<C-h>", "<C-w>h")
set_map("<C-j>", "<C-w>j")
set_map("<C-k>", "<C-w>k")
set_map("<C-l>", "<C-w>l")


set_map("<leader>1", ":tabn 1<cr>")
set_map("<leader>2", ":tabn 2<cr>")
set_map("<leader>3", ":tabn 3<cr>")
set_map("<leader>4", ":tabn 4<cr>")
set_map("<leader>5", ":tabn 5<cr>")
set_map("<leader>6", ":tabn 6<cr>")
set_map("<leader>7", ":tabn 7<cr>")
set_map("<leader>8", ":tabn 8<cr>")
set_map("<leader>9", ":tabn 9<cr>")
set_map("<leader>0", ":tabn 10<cr>")


function compile_and_run()
  local ft = vim.bo.filetype
  if ft == 'go' then
    vim.api.nvim_command('!go run %')
  elseif ft == 'c' then
    vim.api.nvim_command('!gcc -Wall -g % -o /tmp/%<')
    vim.api.nvim_command('! /tmp/%<')
  elseif ft == 'python' then
    vim.api.nvim_command('!python3 %')
  elseif ft == 'sh' then
    vim.api.nvim_command('!./%')
  elseif ft == 'rust' then
    vim.api.nvim_command('!cargo run')
  elseif ft == 'lua' then
    vim.api.nvim_command('!lua ./%')
  elseif ft == 'elixir' then
    vim.api.nvim_command('!elixir ./%')
  end
end

set_map('<F6>', ":lua compile_and_run()<CR>")
set_map('<F6>', [[
:lua require('noice').redirect(compile_and_run) <CR>
]])

set_map('<F9>', ":set spell!<CR>")
