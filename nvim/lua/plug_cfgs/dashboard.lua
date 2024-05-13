local db = require('dashboard')

db.setup({
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      {
        desc = '󰊳 Update',
        group = 'Number',
        action = 'Lazy update',
        key = 'u',
      },
      {
        desc = ' Files',
        group = 'Function',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Project',
        group = 'Keyword',
        action = 'Telescope project',
        key = 'p',
      },
      {
        desc = '󱁉 Dotfiles',
        group = 'Character',
        action = function()
          require('telescope.builtin').find_files({ cwd = '~/dotfile' })
        end,
        key = 'd',
      },
    },
  },
  hide = {
    statusline = true, -- hide statusline default is true
    -- tabline,    -- hide the tabline
    -- winbar     -- hide winbar
  },
})


vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    if
        vim.fn.argc() == 0
        and vim.api.nvim_buf_get_name(0) == ''
        and vim.g.read_from_stdin == nil
    then
      vim.cmd('IBLDisable')
    end
  end,
})
