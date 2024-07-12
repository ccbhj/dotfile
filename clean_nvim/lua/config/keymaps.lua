-- local util = require("util")
--
-- util.cowboy()
-- util.wezterm()

-- change word with <c-c>
-- vim.keymap.set({ "n", "x" }, "<C-c>", "<cmd>normal! ciw<cr>a")


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
set_map("<C-t>n", ":tabnext<cr>")
set_map("<C-t>p", ":tabprevious<cr>")
set_map("<C-t>d", ":tabnew <cr>")
set_map("<C-t>e", ":tabedit ")
set_map("<C-t>c", ":tabclose<cr>")

-- buffer
set_map("vs", ":vs")
set_map("hs", ":split")
set_map("<C-h>", "<C-w>h")
set_map("<C-j>", "<C-w>j")
set_map("<C-k>", "<C-w>k")
set_map("<C-l>", "<C-w>l")

-- function _G.compile_and_run()
--   local ft = vim.bo.filetype
--   if ft == 'go' then
--     vim.api.nvim_command('!go run %')
--   elseif ft == 'c' then
--     vim.api.nvim_command('!gcc -Wall -g % -o /tmp/%<')
--     vim.api.nvim_command('! /tmp/%<')
--   elseif ft == 'python' then
--     vim.api.nvim_command('!python3 %')
--   elseif ft == 'sh' then
--     vim.api.nvim_command('!./%')
--   elseif ft == 'rust' then
--     vim.api.nvim_command('!cargo run')
--   elseif ft == 'lua' then
--     vim.api.nvim_command('!lua ./%')
--   elseif ft == 'elixir' then
--     vim.api.nvim_command('!elixir ./%')
--   end
-- end
-- 
-- set_map('<F6>', [[
-- :lua require('noice').redirect(compile_and_run, { view = "split" } ) <CR>
-- ]])

set_map('<F9>', ":set spell!<CR>")
set_nmap('<F3>', [[ :setlocal relativenumber! <CR> ]])
