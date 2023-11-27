local mocha = require("catppuccin.palettes").get_palette "mocha"

vim.opt.termguicolors = true
require('bufferline').setup {
  options = {
    mode = "buffers",
    numbers = "ordinal",
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    indicator = {
      icon = "▎",                      -- this should be omitted if indicator style is not 'icon'
      style = 'icon'
    },

    highlights = require("catppuccin.groups.integrations.bufferline").get { },

    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    truncate_names = true,    -- whether or not tab names should be truncated
    max_name_length = 30,
    max_prefix_length = 20,   -- prefix used when a buffer is de-duplicated
    tab_size = 25,
    diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
    diagnostics_updae_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "(" .. count .. ")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
      }
    },
    color_icons = true,
    show_buffer_icons = true,       -- | false, -- disable filetype icons for buffers
    show_buffer_close_icons = true, -- | false,
    show_close_icon = true,         -- | false,
    show_tab_indicators = false,    -- | false,
    show_duplicate_prefix = true,
    persist_buffer_sort = false,    -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin",       -- "thin" |"slant" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,   -- false | true,
    always_show_bufferline = false, -- true | false,
    sort_by = "relative_directory", --| 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' }
    },
    -- add custom logic
    -- return buffer_a.modified > buffer_b.modified
    -- end
  },
}

vim.api.nvim_set_keymap("n", "gb", ":BufferLinePick <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gc", ":BufferLinePickClose <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gn", ":BufferLineCycleNext <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gp", ":BufferLineCyclePrev <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[b", ":BufferLineCloseLeft <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]b", ":BufferLineCloseRight <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gs", ":BufferLineSortByTabs <CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
