require('glow').setup({
  style = "dark",
})

local set_nmap = function (key, cmd) 
    vim.api.nvim_set_keymap(
        'n',
        key,
        cmd,
        {noremap = true, silent = true}
    )
end

set_nmap('<F7>', ":Glow!<cr>")
