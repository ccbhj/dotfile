local is_git_project = function()
  local ret = vim.fn.matchstr(vim.fn.system("git rev-parse --show-toplevel"), "fatal")
  return ret == ""
end

return {
  {
    "echasnovski/mini.align",
    version = "*",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" } },
      { "gA", mode = { "n", "v" } },
    },
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    ft = { "markdown" },
    opts = {},
    name = "render-markdown",                                                                                     -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim", "nvim-tree/nvim-web-devicons" }, -- if you use the mini.nvim suite
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    config = function()
      vim.g.mkdp_browser = "firefox"
    end,
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   dependencies = {
  --     -- You may not need this if you don't lazy load
  --     -- Or if the parsers are in your $RUNTIMEPATH
  --     "nvim-treesitter/nvim-treesitter",
  --
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },

  -- symbols-outline
  {
    "hedyhli/outline.nvim",
    cmd = "Outline",
    opts = {
      width = 30,
    },
    keys = { { "<F8>", "<cmd>Outline<cr>", desc = "toggle outline" } },
  },

  {
    "stevearc/profile.nvim",
    enabled = os.getenv("NVIM_PROFILE") ~= nil,
    keys = function()
      local function toggle_profile()
        local prof = require("profile")
        if prof.is_recording() then
          prof.stop()
          vim.ui.input(
            { prompt = "Save profile to:", completion = "file", default = "profile.json" },
            function(filename)
              if filename then
                prof.export(filename)
                vim.notify(string.format("Wrote %s", filename))
              end
            end
          )
        else
          prof.start("*")
        end
      end

      return {
        { "<F2>", toggle_profile },
      }
    end,
    init = function()
      local should_profile = os.getenv("NVIM_PROFILE")
      if should_profile then
        require("profile").instrument_autocmds()
        if should_profile:lower():match("^start") then
          require("profile").start("*")
        else
          require("profile").instrument(should_profile:lower())
        end
      end
    end,
  },

  -- {
  -- 	"t-troebst/perfanno.nvim",
  -- 	enable = true,
  -- 	lazy = false,
  -- 	config = function()
  -- 		require("perfanno").setup({})
  -- 	end,
  -- },
  -- { "pwntester/octo.nvim", opts = {}, cmd = "Octo" },
  { "folke/which-key.nvim",  lazy = false },
  {
    "voldikss/vim-translator",
    cmd = { "Translate", "TranslateH", "TranslateL", "TranslateW", "TranslateR", "TranslateX" },
  },
  {
    "stevearc/oil.nvim",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      columns = {
        "icon",
        "type",
      },
    },
    keys = {
      {
        "--",
        "<cmd>Oil<cr>",
        desc = "Open parent directory with oil",
      },
      {
        "-f",
        "<cmd>Oil --float<cr>",
        desc = "Open parent directory with oil in float window",
      },
    },
  },
  {
    "kyazdani42/nvim-tree.lua",
    opts = function(p, opts)
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)
        -- custom mappings

        vim.keymap.set("n", "<C-f>", function()
          api.tree.find_file({ update_root = true, open = true, focus = true })
        end, opts("Find and focus a file or folder in the tree."))
      end
      opts.on_attach = my_on_attach
      return opts
    end,
    keys = {
      {
        "<leader>ft",
        "<cmd>NvimTreeToggle<cr>",
        desc = "toggle nvim-tree",
      },
      {
        "<leader>ff",
        "<cmd>NvimTreeFindFileToggle<cr>",
        desc = "toggle nvim-tree",
      },
    },
  },

  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim", -- Optional
    },
    keys = {
      {
        "<leader>b",
        function()
          require("nvim-navbuddy").open()
        end,
      },
    },
    opts = {
      window = {
        border = "single", -- "rounded", "double", "solid", "none"
        size = "80%",      -- Or table format example: { height = "40%", width = "100%"}
        position = "50%",  -- Or table format example: { row = "100%", col = "0%"}
        scrolloff = nil,   -- scrolloff value within navbuddy window
        sections = {
          left = {
            size = "15%",
          },
          mid = {
            size = "40%",
          },
        },
      },
      lsp = {
        auto_attach = true, -- If set to true, you don't need to manually use attach function
        preference = nil,   -- list of lsp server names in order of preference
      },
    },
  },

  -- term
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<F5>]],
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = true,
      direction = "float",    -- 'vertical'| 'horizontal' | 'window' | 'float',
    },
    keys = function()
      local Terminal = require("toggleterm.terminal").Terminal
      local function _lazygit_toggle(term)
        return function()
          term:toggle()
        end
      end

      return {
        {
          "<leader>G",
          _lazygit_toggle(Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })),
          desc = "open lazygit in float window",
        },
        {
          "<leader>g",
          _lazygit_toggle(Terminal:new({ cmd = "lazygit", hidden = true, direction = "tab" })),
          desc = "open lazygit in tab",
        },
        {
          "<leader>T",
          "<cmd>ToggleTerm size=15 dir=. direction=horizontal<CR>",
          desc = "open split terminal",
        },
      }
    end,

    -- config = function(_, opts)
    --   function _G.set_terminal_keymaps()
    --     local o = { noremap = true }
    --     vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], o)
    --     vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], o)
    --     vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], o)
    --     vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], o)
    --     vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], o)
    --     vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], o)
    --   end

    --   -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    --   vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    -- end,
  },

  -- git related
  {
    "tpope/vim-fugitive",
    event = "BufReadPre",
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    -- cond = is_git_project,
    main = "gitsigns",
    -- enabled = false,
    opts = {
      signs_staged_enable = true,
      auto_attach = true,
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use dfault
      max_file_length = 2000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Actions
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.nav_hunk("next", { foldopen = true, preview = true })
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.nav_hunk("prev", { foldopen = true, preview = true })
          end)
          return "<Ignore>"
        end, { expr = true })
        -- Actions
        map("n", "<leader>hs", gs.stage_hunk)
        map("n", "<leader>hr", gs.reset_hunk)
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end)
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end)
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    cond = is_git_project,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {
      enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
      use_icons = true,        -- Requires nvim-web-devicons
      view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts:
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see |diffview-config-view.x.layout|.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
        },
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_mixed",
          disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        },
        file_history = {
          -- Config for changed files in file history views.
          layout = "diff2_horizontal",
        },
      },
    },
    keys = {

      {
        "<leader>dO",
        "<cmd>DiffviewOpen <CR>",
        desc = "open Diffview",
      },
      {
        "<leader>dc",
        "<cmd>DiffviewClose<CR>",
        desc = "close Diffview",
      },
      {
        "<leader>do",
        "<cmd>DiffviewOpen -uno <CR>",
        desc = "open Diffview but hide untracked files",
      },
      {
        "<leader>dh",
        "<cmd>DiffviewFileHistory",
        desc = "open diffview for file history",
      },
      {
        "<leader>df",
        "<cmd>DiffviewToggleFile<CR>",
        desc = "open diffview file panel",
      },
    },
  },
  {
    "michaelb/sniprun",
    build = "sh install.sh",
    cmd = "SnipRun",
    config = function()
      require("sniprun").setup({
        --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
        --# to filter only sucessful runs (or errored-out runs respectively)
        display = {
          "Classic",                --# display results in the command-line  area
          "LongTempFloatingWindow", --# same as above, but only long results. To use with VirtualText[Ok/Err]
          "VirtualTextOk",          --# display ok results as virtual text (multiline is shortened)

          -- "VirtualText",             --# display results as virtual text
          -- "TempFloatingWindow",      --# display results in a floating window
          -- "Terminal", --# display results in a vertical split
          -- "TerminalWithCode",        --# display results and code history in a vertical split
          -- "NvimNotify",              --# display with the nvim-notify plugin
          -- "Api"                      --# return output to a programming interface
        },

        display_options = {
          terminal_scrollback = vim.o.scrollback, --# change terminal display scrollback lines
          terminal_line_number = false,           --# whether show line number in terminal window
          terminal_signcolumn = false,            --# whether show signcolumn in terminal window
          terminal_position = "vertical",         --# or "horizontal", to open as horizontal split instead of vertical split
          terminal_width = 45,                    --# change the terminal display option width (if vertical)
          terminal_height = 20,                   --# change the terminal display option height (if horizontal)
          notification_timeout = 5,               --# timeout for nvim_notify output
        },

        --# You can use the same keys to customize whether a sniprun producing
        --# no output should display nothing or '(no output)'
        show_no_output = {
          "Classic",
          "TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
        },
      })
    end,
    keys = {
      {
        "<F6>",
        function()
          local sa = require("sniprun.api")
          local last = vim.api.nvim_buf_line_count(0)
          sa.run_range(1, last, vim.bo.filetype, { display = { "Terminal" } })
        end,
        -- mode = { "v" },
        -- "<Plug>SnipRun"
      },
    },
  },

  {
    "MattesGroeger/vim-bookmarks",
    init = function()
      vim.g.bookmark_auto_save = 1
      vim.g.bookmark_sign = "♥"
      vim.g.bookmark_annotation_sign = "󱥬"
      vim.g.bookmark_highlight_lines = 1
      vim.g.bookmark_no_default_key_mappings = 1
      vim.g.bookmark_display_annotation = 1
      vim.g.bookmark_disable_ctrlp = 1
    end,
    keys = {
      {
        "<leader>m",
        "<cmd>BookmarkToggle<cr>",
        desc = "toggle bookmark",
      },
      {
        "<leader>i",
        "<cmd>BookmarkAnnotate<cr>",
        desc = "toggle bookmark and add annotate",
      },
      {
        "<space>M",
        ":lua require('telescope').extensions.vim_bookmarks.all() <cr>",
        desc = "list all the bookmarks",
      },
    },
  },

  -- {
  -- 	"mhartington/formatter.nvim",
  -- 	cmd = { "Format", "FormatWrite" },
  -- 	opts = function()
  -- 		return {
  -- 			log = true,
  -- 			filetype = {
  -- 				sh = require("formatter.filetypes.sh").shfmt,
  -- 				lua = require("formatter.filetypes.lua").stylua,
  -- 				proto = require("formatter.filetypes.proto").buf_format,
  -- 				toml = require("formatter.filetypes.toml").taplo,
  -- 				go = {
  -- 					require("formatter.filetypes.go").gofmt,
  -- 					require("formatter.filetypes.go").goimports,
  -- 				},
  -- 			},
  -- 		}
  -- 	end,
  -- 	init = function()
  -- 		local augroup = vim.api.nvim_create_augroup
  -- 		local autocmd = vim.api.nvim_create_autocmd
  -- 		augroup("__formatter__", { clear = true })
  -- 		autocmd("BufWritePost", {
  -- 			group = "__formatter__",
  -- 			command = ":FormatWrite",
  -- 		})
  -- 	end,
  -- },

  {
    "nvim-orgmode/orgmode",
    -- event = "VeryLazy",
    lazy = false,
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = { "~/org/note/*.org", "~/org/agenda/*.org", "~/org/capture/*.org" },
        org_default_notes_file = "~/org/capture/refile.org",
        win_split_mode = "split",
        mappings = {
          global = {
            org_agenda = "<F10>",
            org_capture = "<F11>",
          },
        },

        -- agenda
        org_deadline_warning_days = 1,
        org_todo_keywords = { "TODO(t)", "WAITING(w)", "DOING(i)", "|", "DONE(d)", "ICEBOX(x)" },
      })
    end,
  },

  {
    "atiladefreitas/lazyclip",
    config = function()
      require("lazyclip").setup({})
    end,
    keys = {
      { "Cw", desc = "Open Clipboard Manager" },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      zen = { enabled = true, },
      toggle = {
        enabled = true,
        which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
        notify = true,    -- show a notification when toggling
        -- icons for enabled/disabled states
        icon = {
          enabled = " ",
          disabled = " ",
        },
      }
    },
    keys = {
      { "<leader>.", function() require("snacks").scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S", function() require("snacks").select() end,  desc = "Select Scratch Buffer" },
    },
  }

}
