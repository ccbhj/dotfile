lua << EOF
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

vim.api.nvim_set_keymap(
    'n',
    '<space>y',
    ':Telescope neoclip<CR>',
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    'n',
    '<space>p',
    ":lua require'telescope'.extensions.project.project{}<CR>",
    {noremap = true, silent = true}
)

EOF


nnoremap <silent> <space>t :lua require'telescope.builtin'.tags({only_current_buffer = true, preview_width=0.5})<cr>
nnoremap <silent> <space>T :lua require'telescope.builtin'.tags{}<cr>
nnoremap <silent> <space>F :lua require'telescope.builtin'.file_browser{}<cr>
nnoremap <silent> <space>f :lua require'telescope.builtin'.find_files{}<cr>
nnoremap <silent> <space>g :lua require'telescope.builtin'.grep_string{}<cr>
nnoremap <silent> <space>G :lua require'telescope.builtin'.live_grep{}<cr>

nnoremap <silent> <space>j :lua require'telescope.builtin'.jumplist{}<cr>
nnoremap <silent> <space>r :lua require'telescope.builtin'.registers{}<cr>
nnoremap <silent> <space>h :lua require'telescope.builtin'.search_history{}<cr>
nnoremap <silent> <space>H :lua require'telescope.builtin'.command_history{}<cr>
nnoremap <silent> <space>m :lua require'telescope.builtin'.marks{}<cr>

nnoremap <silent> <space>B :lua require'telescope.builtin'.git_branches{}<cr>
nnoremap <silent> <space>v :lua require'telescope.builtin'.git_files{}<cr>
nnoremap <silent> <space>c :lua require'telescope.builtin'.git_commits{}<cr>
nnoremap <silent> <space>C :lua require'telescope.builtin'.git_bcommits{}<cr>
nnoremap <silent> <space>k :lua require'telescope.builtin'.git_stash{}<cr>


nnoremap <silent> <space>a :lua require('telescope').extensions.vim_bookmarks.current_file() <cr>
nnoremap <silent> <space>A :lua require('telescope').extensions.vim_bookmarks.all() <cr>

" buffers
"
nnoremap <silent> <space>b :lua require'telescope.builtin'.buffers{}<cr>
nnoremap <silent> <space>l :lua require'telescope.builtin'.current_buffer_fuzzy_find{}<cr>

