-- local util = require("util")
--
-- util.cowboy()
-- util.wezterm()

-- change word with <c-c>
-- vim.keymap.set({ "n", "x" }, "<C-c>", "<cmd>normal! ciw<cr>a")


-- unmap the evil F1
vim.keymap.set("n", "<F1>", ":echo<CR>", { silent = true })
vim.keymap.set("i", "<F1>", "<C-o>:echo<CR>", { silent = true })
vim.keymap.set("i", "<leader>rr", ":source $XDG_CONFIG_HOME/nvim/init.lua<cr>", { silent = true })

-- tab
vim.keymap.set("n", "<C-t>n", ":tabnext<cr>", { silent = true })
vim.keymap.set("n", "<C-t>p", ":tabprevious<cr>", { silent = true })
vim.keymap.set("n", "<C-t>d", ":tabnew <cr>", { silent = true })
vim.keymap.set("n", "<C-t>e", ":tabedit ", { silent = true })
vim.keymap.set("n", "<C-t>c", ":tabclose<cr>", { silent = true })

-- buffer
vim.keymap.set("n", "vs", ":vs", { silent = true })
vim.keymap.set("n", "hs", ":split", { silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

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

vim.keymap.set("n", "<F9>", ":set spell!<CR>", { silent = true })
vim.keymap.set("n", "<F3>", ":setlocal relativenumber!<CR>", { silent = true })
