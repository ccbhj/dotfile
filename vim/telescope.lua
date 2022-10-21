require('telescope').load_extension('fzf')
require('telescope').load_extension('project')
-- require('telescope').load_extension('coc')
require('telescope').load_extension('neoclip')
require('telescope').load_extension('vim_bookmarks')

local actions = require('telescope.actions')
local previewers = require('telescope.previewers')

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {};
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}


local previewers = require('telescope.previewers')

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require('telescope').setup{
defaults = {
    path_display = {"truncate"},
    buffer_previewer_maker = new_maker,
    mappings = {
        i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close
            },
        n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close
            },
    }, 
    },
pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
        -- },
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        tail_path = true,
        layout_config = {
            width = 0.75,
            height = 0.75,
            }
        },
    extensions = {
        project = {
            base_dirs = {
                '~/c/',
                '~/go/src/',
                },
            hidden_files = true -- default: false
            }, 
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
            },
        }
    }
require('neoclip').setup({
history = 1000,
filter = nil,
preview = true,
default_register = '"',
content_spec_column = false,
on_paste = {
    set_reg = false,
    },
keys = {
    telescope = {
        i = {
            select = '<cr>',
            paste = '<c-p>',
            paste_behind = '<c-k>',
            custom = {},
            },
        n = {
            select = '<cr>',
            paste = 'p',
            paste_behind = 'P',
            custom = {},
            },
        },
   },
})

local set_nmap = function (key, cmd) 
    vim.api.nvim_set_keymap(
        'n',
        key,
        cmd,
        {noremap = true, silent = true}
    )
end

set_nmap('<space>y', ':telescope neoclip<cr>')
set_nmap('<space>p', ":lua require'telescope'.extensions.project.project{}<cr>")
set_nmap('<space>t', ":lua require'telescope.builtin'.tags({only_current_buffer = true, preview_width=0.5})<cr>")
set_nmap('<space>T', ":lua require'telescope.builtin'.tags{}<cr>")

-- file
set_nmap('<space>F', ":lua require'telescope.builtin'.file_browser{}<cr>")
set_nmap('<space>F', ":lua require'telescope.builtin'.find_files{}<cr>")
set_nmap('<space>g', ":lua require'telescope.builtin'.grep_string{}<cr>")
set_nmap('<space>G', ":lua require'telescope.builtin'.live_grep{}<cr>")
set_nmap('<space>j', ":lua require'telescope.builtin'.jumplist{}<cr>")
set_nmap('<space>r', ":lua require'telescope.builtin'.registers{}<cr>")
set_nmap('<space>a', ":lua require('telescope').extensions.vim_bookmarks.current_file() <cr>")
set_nmap('<space>A', ":lua require('telescope').extensions.vim_bookmarks.all() <cr>")
set_nmap('<space>q', ":lua require'telescope.builtin'.quickfix{}<cr>")


-- git 
set_nmap('<space>m', ":lua require'telescope.builtin'.marks{}<cr>")
set_nmap('<space>B', ":lua require'telescope.builtin'.git_branches{}<cr>")
set_nmap('<space>v', ":lua require'telescope.builtin'.git_files{}<cr>")
set_nmap('<space>c', ":lua require'telescope.builtin'.git_commits{}<cr>")
set_nmap('<space>C', ":lua require'telescope.builtin'.git_bcommits{}<cr>")
set_nmap('<space>k', ":lua require'telescope.builtin'.git_stash{}<cr>")
-- buffer
set_nmap('<space>b', ":lua require'telescope.builtin'.buffers{}<cr>")
set_nmap('<space>l', ":lua require'telescope.builtin'.current_buffer_fuzzy_find{}<cr>")
set_nmap('<space>L', ":lua require'telescope.builtin'.loclist{}<cr>")

-- command
set_nmap('<space><cr>', ":lua require'telescope.builtin'.commands{}<cr>")
set_nmap('<space>h', ":lua require'telescope.builtin'.search_history{}<cr>")
set_nmap('<space>H', ":lua require'telescope.builtin'.command_history{}<cr>")
set_nmap('<space>?', ":lua require'telescope.builtin'.keymaps{}<cr>")
set_nmap('<space>+', ":lua require'telescope.builtin'.pickers{}<cr>")

