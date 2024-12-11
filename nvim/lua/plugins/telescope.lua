local get_cursor_opt = {
  jump_type = "never",
  layout_config = {
    preview_width = 0.6,
    width = 0.8,
    height = 0.5,
  },
}

return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "folke/noice.nvim",
      "folke/which-key.nvim",
      "folke/flash.nvim",
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "nvim-orgmode/telescope-orgmode.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "tom-anders/telescope-vim-bookmarks.nvim",
      "AckslD/nvim-neoclip.lua",
      'nvim-telescope/telescope-ui-select.nvim'
    },
    config = function()
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end

      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.6,
            },
            width = 0.8,
            height = 0.8,
            preview_cutoff = 120,
          },
          path_display = { "truncate", "smart" },
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<esc><esc>"] = actions.close,
              ["<C-S>"] = flash,
              ["<C-c>"] = fb_actions.goto_home_dir,
            },
            n = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<esc><esc>"] = actions.close,
              ["s"] = flash,
            },
          },
          pickers = { tail_path = true },
        },
        extensions = {
          project = {
            base_dirs = {
              { "~/go/src/", max_depth = 1 },
            },
          },
          orgmode = {
            max_depth = 3,
          },
          file_browser = {},
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("vim_bookmarks")
      require("telescope").load_extension("project")
      require("telescope").load_extension("noice")
      require("telescope").load_extension("orgmode")
      require("telescope").load_extension("ui-select")
    end,
    keys = function()
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      local org = require("telescope").extensions.orgmode
      return {
        {
          "<space>p",
          require("telescope").extensions.project.project,
        },
        {
          "<space>F",
          require("telescope").extensions.file_browser.file_browser,
        },
        {
          "<space>f",
          builtin.find_files,
          desc = "find files in current dir",
        },
        {
          "<space>g",
          builtin.grep_string,
          desc = "find string in current dir",
        },
        {
          "<space>G",
          builtin.live_grep,
          desc = "find string in root dir",
        },
        {
          "<space>j",
          builtin.jumplist,
          desc = "list the jump list",
        },
        {
          "<space>r",
          builtin.registers,
          desc = "list all the registers",
        },
        {
          "<space>q",
          ":lua require'telescope.builtin'.quickfix{}<cr>",
          desc = "list quickfix list",
        },

        {
          "<space>m",
          ":lua require'telescope.builtin'.marks{}<cr>",
          desc = "list all marks",
        },
        {
          "<space>M",
          ":lua require('telescope').extensions.vim_bookmarks.all() <cr>",
          desc = "list all the bookmarks",
        },

        -- git
        {
          "<space>B",
          ":lua require'telescope.builtin'.git_branches{}<cr>",
          desc = "list git branches",
        },
        {
          "<space>v",
          ":lua require'telescope.builtin'.git_files{}<cr>",
          desc = "list git files",
        },
        {
          "<space>c",
          ":lua require'telescope.builtin'.git_commits{}<cr>",
          desc =
          "Lists git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h",
        },
        {
          "<space>C",
          ":lua require'telescope.builtin'.git_bcommits{}<cr>",
          desc = "buffer's git commits with diff preview and checks them out on",
        },
        {
          "<space>k",
          ":lua require'telescope.builtin'.git_stash{}<cr>",
          desc = "Lists current changes per file with diff preview and add action",
        },

        {
          "<space>b",
          ":lua require'telescope.builtin'.buffers{}<cr>",
          desc = "Lists open buffers in current neovim instance",
        },
        {
          "<space>l",
          ":lua require'telescope.builtin'.current_buffer_fuzzy_find{}<cr>",
          desc = "Live fuzzy search inside of the currently open buffer",
        },
        {
          "<space>L",
          ":lua require'telescope.builtin'.loclist{}<cr>",
          desc = "Lists items from the current window's location list",
        },
        {
          "<space><cr>",
          ":lua require'telescope.builtin'.commands{}<cr>",
          desc = "Lists available plugin/user commands and runs them on <cr>",
        },
        {
          "<space>H",
          ":lua require'telescope.builtin'.search_history{}<cr>",
          desc = "Lists searches that were executed recently, and reruns them on <cr>",
        },
        {
          "<space>h",
          ":lua require'telescope.builtin'.command_history{}<cr>",
          desc = "Lists commands that were executed recently, and reruns them on <cr>",
        },
        {
          "<space>?",
          "<cmd>lua require'telescope.builtin'.keymaps{}<cr>",
          desc = "Lists normal mode keymappings",
        },
        {
          "<space>+",
          ":lua require'telescope.builtin'.pickers{}<cr>",
          desc = "Lists the previous pickers incl. multi-selections",
        },

        -- lsp
        {
          "gD",
          function()
            builtin.lsp_definitions(themes.get_cursor(get_cursor_opt))
          end,
          desc = "preview the definition of the word under the cursor",
        },
        {
          "gd",
          function()
            builtin.lsp_definitions()
          end,
          desc = "Goto the definition of the word under the cursor",
        },
        {
          "gy",
          function()
            builtin.lsp_type_definitions(themes.get_cursor(get_cursor_opt))
          end,
          desc = "Goto the definition of the type of the word under the cursor",
        },
        {
          "gi",
          builtin.lsp_implementations,
          desc = "Goto the implementation of the word under the cursor",
        },
        {
          "gr",
          function()
            builtin.lsp_references({ jump_type = "never" })
          end,
          desc = "Lists LSP references for word under the cursor",
        },

        {
          "<space>s",
          function()
            builtin.lsp_document_symbols({ symbol_width = 60 })
          end,
          desc = "Lists LSP document symbols in the current buffer",
        },
        {
          "<space>S",
          ":lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<cr>",
          desc = "Dynamically Lists LSP for all workspace symbols",
        },
        {
          "<space>d",
          ":lua require'telescope.builtin'.diagnostics({bufnr = 0})<cr>",
          desc = "Lists Diagnostics for current buffer",
        },
        {
          "<space>D",
          builtin.diagnostics,
          desc = "Lists Diagnostics for all open buffers",
        },
        {
          "<space>i",
          builtin.lsp_incomming_calls,
          desc = "Lists LSP incoming calls for word under the cursor",
        },
        {
          "<space>o",
          builtin.lsp_outgoing_calls,
          desc = "Lists LSP outgoing calls for word under the cursor",
        },

        {
          "<space>O",
          org.search_headings,
          desc = "list all orgmode headings",
        },
      }
    end,
  },
}
