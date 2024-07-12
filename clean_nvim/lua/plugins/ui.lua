return {
  {
    "folke/noice.nvim",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    opts = {
      presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true,            -- enables an input dialog for inc-rename.nvim
      },
      messages = {
        enabled = true,         -- enables the Noice messages UI
        view = "mini",          -- default view for messages
        view_error = "mini",    -- view for errors
        -- view_warn = "notify", -- view for warnings
        view_history = "split", -- view for :messages
        -- view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      redirect = {
        view = "split",
        opts = {
          size = "40%",
        }
        -- filter = { min_height = 20 },
      },

      popupmenu = {
        enabled = true,  -- enables the Noice popupmenu UI
        backend = "nui", -- backend to use to show regular cmdline completions
        relative = "editor",
        position = {
          row = 8,
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },


      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        hover = {
          enabled = true,
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50,  -- Debounce lsp signature help request by 50ms
          },
        },
        -- defaults for hover and signature help
        documentation = {
          view = "hover",
          ---@type NoiceViewOptions
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 3 },
          },
        },
      },
      notify = {
        enabled = true,
        view = "mini",
        opts = {
          stages = "slide"
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            find = "Select"
          },
          view = "popup",
          close = {
            events = { "BufLeave" },
            keys = { 'q', '<ESC>' },
          }
        },
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      }
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
    end,
  },

  -- auto-resize windows
  -- {
  --   "anuvyklack/windows.nvim",
  --   enabled = false,
  --   event = "WinNew",
  --   dependencies = {
  --     { "anuvyklack/middleclass" },
  --     { "anuvyklack/animation.nvim", enabled = false },
  --   },
  --   keys = { { "<leader>m", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
  --   config = function()
  --     vim.o.winwidth = 5
  --     vim.o.equalalways = false
  --     require("windows").setup({
  --       animation = { enable = false, duration = 150 },
  --     })
  --   end,
  -- },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "meuter/lualine-so-fancy.nvim",
    },
    opts = function(_, opts)
      return {
        options = {
          theme = "tokyonight",
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          icons_enabled = true,
          always_divide_middle = true,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          },
        },
        sections = {
          lualine_a = {
            { "fancy_mode", width = 3 },
          },
          lualine_b = {
            { "fancy_branch" },
            { "fancy_diff" },
          },
          lualine_c = {
            { "fancy_cwd", substitute_home = true },
          },
          lualine_x = {
            {
              require("noice").api.status.message.get_hl,
              cond = require("noice").api.status.message.has,
            },
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              color = { fg = "#ff9e64" },
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = { fg = "#ff9e64" },
            },
            {
              require("noice").api.status.search.get,
              cond = require("noice").api.status.search.has,
              color = { fg = "#ff9e64" },
            },
            { "fancy_macro" },
            { "fancy_diagnostics" },
            { "fancy_searchcount" },
            { "fancy_location" },
          },
          lualine_y = {
            { "filename", ts_icon = "" },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },

  -- zen mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        alacritty = {
          enabled = true,
          font = "16", -- font size
        },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  "kyazdani42/nvim-web-devicons",
  "mortepau/codicons.nvim",
  "folke/twilight.nvim",

  {
    "lukas-reineke/indent-blankline.nvim",
    -- event = "LazyFile",
    lazy = false,
    opts = {
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        numbers = "ordinal",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
          }
        },
        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr" remove extension from markdown files for example
          if buf.name:match('%.md') then
            return vim.fn.fnamemodify(buf.name, ':t:r')
          end
        end,
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
      },
    },
    init = function()
      vim.opt.termguicolors = true
    end,
    keys = {
      {
        "gb",
        "<cmd>BufferLinePick <CR>",
        desc = "bufferline pick buffer",
      },
      {
        "gC",
        "<cmd>BufferLinePickClose <CR>",
        desc = "bufferline pick close buffer",
      },
      {
        "gn",
        ":BufferLineCycleNext <CR>",
        desc = "bufferline go to next buffer",
      },
      {
        "gp",
        ":BufferLineCyclePrev <CR>",
        desc = "bufferline go to prev buffer",
      },
      {
        "[b",
        ":BufferLineCloseLeft <CR>",
        desc = "bufferline close buffer on the left",
      },
      {
        "]b",
        ":BufferLineCloseRight <CR>",
        desc = "bufferline close buffer on the right",
      },
      {
        "gs",
        ":BufferLineSortByTabs <CR>",
        desc = "bufferline sort buffers",
      },
      {
        "<leader>1",
        "<cmd>BufferLineGoToBuffer 1<CR>",
        desc = "",
      },
      {
        "<leader>2",
        "<cmd>BufferLineGoToBuffer 2<CR>",
        desc = "",
      },
      {
        "<leader>3",
        "<cmd>BufferLineGoToBuffer 3<CR>",
      },
      {
        "<leader>4",
        "<cmd>BufferLineGoToBuffer 4<CR>",
        desc = "",
      },
      {
        "<leader>5",
        "<cmd>BufferLineGoToBuffer 5<CR>",
        desc = "",
      },
      {
        "<leader>6",
        "<cmd>BufferLineGoToBuffer 6<CR>",
        desc = "",
      },
      {
        "<leader>7",
        "<cmd>BufferLineGoToBuffer 7<CR>",
        desc = "",
      },
      {
        "<leader>8",
        "<cmd>BufferLineGoToBuffer 8<CR>",
        desc = "",
      },
      {
        "<leader>9",
        "<cmd>BufferLineGoToBuffer 9<CR>",
        desc = "",
      },
    },
  },
}
