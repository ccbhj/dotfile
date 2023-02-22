require('telescope').load_extension('fzf')
require('telescope').load_extension('project')
-- require('telescope').load_extension('coc')
require('telescope').load_extension('neoclip')
require('telescope').load_extension('vim_bookmarks')
require("telescope").load_extension("file_browser")

local themes = require('telescope.themes')
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

local _bad = { ".*%.csv", ".*%.lua" } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end

  return true
end

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
    -- layout_strategy = 'bottom_pane',
    layout_config = {
      preview_width = 0.6,
      width = 0.90,
      height = 0.90,
    },
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
    layout_strategy = 'vertical',
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    -- },
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    tail_path = true,
  },
  extensions = {
    project = {
      base_dirs = {
        '~/org/',
        '~/c/',
        {'~/go/src/', max_depth=1},
      },
      hidden_files = false, -- default: false
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {},
      buffer_previewer_maker = new_maker,
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

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local set_nmap = function (key, cmd) 
    vim.keymap.set(
        'n',
        key,
        cmd,
        {}
    )
end


local theme_dict = {
  ['ivy'] = themes.get_ivy,
  ['cursor'] = themes.get_cursor,
  ['dropdown'] = themes.get_dropdown,
}

local with_theme = function(fn, theme, args) 
  return function ()
    fn(theme_dict[theme](args))
  end
end

set_nmap('<space>y', ':telescope neoclip<cr>')
set_nmap('<space>p', ":lua require'telescope'.extensions.project.project{}<cr>")
set_nmap('<space>t', ":lua require'telescope.builtin'.tags({only_current_buffer = true, preview_width=0.5})<cr>")
set_nmap('<space>T', ":lua require'telescope.builtin'.tags{}<cr>")

-- file
set_nmap('<space>F', ":lua require'telescope'.extensions.file_browser.file_browser{}<cr>")
set_nmap('<space>f', builtin.find_files)
set_nmap('<space>g', builtin.grep_string)
set_nmap('<space>G', builtin.live_grep)
set_nmap('<space>j', builtin.jumplist)
set_nmap('<space>r', builtin.registers)
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


-- lsp
set_nmap('gD', ":lua vim.lsp.buf.declaration()<cr>")
set_nmap('gd', ":lua require'telescope.builtin'.lsp_definitions(require('telescope.themes').get_dropdown({}))<cr>")
set_nmap('gy', ":lua require'telescope.builtin'.lsp_type_definitions(require('telescope.themes').get_dropdown({}))<cr>")
set_nmap('gi', builtin.lsp_implementations)
set_nmap('gr', builtin.lsp_references)

set_nmap('<space>s', builtin.lsp_document_symbols)
set_nmap('<space>S', ":lua require'telescope.builtin'.lsp_workspace_symbols query=")
set_nmap('<space>d', ":lua require'telescope.builtin'.diagnostics({bufnr=0})<cr>")
set_nmap('<space>D', builtin.diagnostics)
