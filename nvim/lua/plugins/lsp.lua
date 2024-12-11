local CMP_PLUGIN = "blink" -- "cmp" | "coq" | "blink"
local diagnositc_signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(diagnositc_signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function get_lsp_config()
  local lsp_config = {
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
    -- Be aware that you also will need to properly configure your LSP server to
    -- provide the code lenses.
    codelens = {
      enabled = false,
    },
    -- Enable lsp cursor word highlighting
    document_highlight = {
      enable = true,
    },

    -- use "rachartier/tiny-inline-diagnostic.nvim" instead
    diagnostics = {
      virtual_text = false,
      underline = false,
      update_in_insert = false,
    },
    -- diagnostics = {
    --   underline = false,
    --   update_in_insert = false,
    --   signs = diagnositc_signs,
    --   virtual_text = {
    --     spacing = 4,
    --     source = "if_many",
    --     prefix = "●",
    --     -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    --     -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
    --     -- prefix = "icons",
    --   },
    --   severity_sort = true,
    -- },
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
  }
  if CMP_PLUGIN == "coq" then
    lsp_config = require("coq").lsp_ensure_capabilities(lsp_config)
  elseif CMP_PLUGIN == "cmp" then
    lsp_config.capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )
    lsp_config.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
  end

  function lsp_config.on_attach(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    -- Mappings.
    opts = { noremap = true, silent = true, buffer = bufnr }
    -- telescope

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>M", function()
      vim.lsp.buf.format({ async = true })
    end, opts)

    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- -- Set autocommands conditional on server_capabilities
    -- if client.server_capabilities.document_highlight then
    -- 	vim.api.nvim_exec(
    -- 		[[
    --   augroup lsp_document_highlight
    --   autocmd! * <buffer>
    --   autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --   augroup END
    --   ]],
    -- 		false
    -- 	)
    -- end
  end

  return lsp_config
end

return {
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    enabled = CMP_PLUGIN == "cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip", lazy = true },
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      -- "ray-x/cmp-treesitter",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- "petertriho/cmp-git",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
    },
    config = function(LazyPlugin, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        performance = {
          async_budget = 100,
          throttle = 20,
          debounce = 20,
          fetching_timeout = 20,
          confirm_resolve_timeout = 20,
          max_view_entries = 10,
        },

        formatting = {
          expandable_indicator = false,
          deprecated = true,
          fields = { "abbr", "menu", "kind" },
          format = require("lspkind").cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        preselect = cmp.PreselectMode.None,

        window = {
          completion = cmp.config.window.bordered({
            -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
            -- scrollbar = nil,
            --  "none": No border (default).
            --  "single": A single line box.
            --  "double": A double line box.
            --  "rounded": Like "single", but with rounded corners ("╭"
            --  etc.).
            --  "solid": Adds padding by a single whitespace cell.
            --  "shadow": A drop shadow effect by blending with the
            border = "single",
            noautocmd = true,
            scrollbar = false,
            -- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
          }),
          documentation = {
            border = "single",
            scrollbar = true,
            -- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
          },
        },

        confirmation = {
          default_behavior = require("cmp.types").cmp.ConfirmBehavior.Insert,
          get_commit_characters = function(commit_characters)
            return commit_characters
          end,
        },

        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
          { name = "buffer" },
          { name = "luasnip" },
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        entries = { name = "wildmenu", separator = "|" },
        sources = {
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return { vim.api.nvim_get_current_buf() }
              end,
            },
          },
          { name = "nvim_lsp_document_symbol" },
        },
      })

      -- `:` cmdline setup.
      --   -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },

  -- coq
  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    event = "InsertEnter",
    enabled = CMP_PLUGIN == "coq",
    dependencies = {
      -- main one

      -- 9000+ Snippets
      { "ms-jpq/coq.artifacts",  branch = "artifacts" },

      -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- Need to **configure separately**
      { "ms-jpq/coq.thirdparty", branch = "3p" },
      -- - shell repl
      -- - nvim lua api
      -- - scientific calculator
      -- - comment banner
      -- - etc
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = "shut-up", -- if you want to start COQ at startup
        keymap = {
          recommended = true,
          pre_select = true,
        },
        limits = {
          completion_auto_timeout = 0.02,
        },
        display = {
          ghost_text = {
            enabled = false,
          },
          preview = {
            positions = { ["north"] = 1, ["south"] = 2, ["west"] = 3, ["east"] = 4 },
            border = "rounded",
          },
          pum = {
            fast_close = false,
          },
        },
        completion = {
          skip_after = { "{", "}", "[", "]", "(", ")", ":" },
        },
      }

      -- Keybindings
      vim.api.nvim_set_keymap(
        "i",
        "<Esc>",
        [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]],
        { expr = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "i",
        "<C-c>",
        [[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]],
        { expr = true, silent = true }
      )
      -- vim.api.nvim_set_keymap('i', '<BS>', [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]], { expr = true, silent = true })
      -- vim.api.nvim_set_keymap(
      --   "i",
      --   "<c-h>",
      --   [[<C-\><C-N> lua COQ.Nav_mark()]],
      --   { expr = true, silent = true }
      -- )
      -- vim.api.nvim_set_keymap(
      --   "i",
      --   "<CR>",
      --   [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
      --   { expr = true, silent = true }
      -- )
      vim.api.nvim_set_keymap(
        "i",
        "<Tab>",
        [[pumvisible() ? "\<C-n>" : "\<Tab>"]],
        { expr = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "i",
        "<S-Tab>",
        [[pumvisible() ? "\<C-p>" : "\<BS>"]],
        { expr = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "i",
        "<C-l>",
        [[pumvisible() ? (complete_info().selected == -1 ? "\<C-n>\<C-n>\<C-p>\<C-y>" : "\<C-y>") : "\<CR>"]],
        { expr = true, silent = true }
      )

      _G.MUtils = {}
      MUtils.CR = function()
        if vim.fn.pumvisible() ~= 0 then
          if vim.fn.complete_info({ "selected" }).selected ~= -1 then
            return npairs.esc("<c-y>")
          else
            return npairs.esc("<c-e>") .. npairs.autopairs_cr()
          end
        else
          return npairs.autopairs_cr()
        end
      end
      vim.api.nvim_set_keymap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

      MUtils.BS = function()
        if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
          return npairs.esc("<c-e>") .. npairs.autopairs_bs()
        else
          return npairs.autopairs_bs()
        end
      end
      vim.api.nvim_set_keymap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })
    end,
  },

  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    enabled = CMP_PLUGIN == "blink",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",
    -- use a release tag to download pre-built binaries
    version = "v0.*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = "cargo build --release",

    opts = {
      keymap = {
        preset = "default",
        ['<CR>'] = { 'accept', 'fallback' },
        ["<Tab>"] = { 'select_next' },
        ["<S-Tab>"] = { 'select_prev' },
        ["<C-b>"] = { 'scroll_documentation_up' },
        ["<C-f>"] = { 'scroll_documentation_down' },
        ["<C-l>"] = { 'snippet_forward' },
        ["<C-h>"] = { 'snippet_backward' },
      },
      highlight = {
        use_nvim_cmp_as_default = true,
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "normal",
      -- experimental auto-brackets support
      -- accept = { auto_brackets = { enabled = true } }
      trigger = {
        completion = {
          -- regex used to get the text when fuzzy matching
          -- changing this may break some sources, so please report if you run into issues
          -- todo: shouldnt this also affect the accept command? should this also be per language?
          keyword_regex = "[%w_\\-]",
          -- LSPs can indicate when to show the completion window via trigger characters
          -- however, some LSPs (*cough* tsserver *cough*) return characters that would essentially
          -- always show the window. We block these by default
          blocked_trigger_characters = { " ", "\n", "\t" },
          -- when true, will show the completion window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,
        },
        signature_help = {
          enabled = false,
          show_on_insert_on_trigger_character = false,
        },
      },

      windows = {
        documentation = {
          auto_show = true,
        },
      },
    },
  },
  -- lsp servers
  {
    "williamboman/mason.nvim",
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
    config = function()
      require("mason").setup({
        providers = {
          "mason.providers.client",
          "mason.providers.registry-api",
        },

        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      -- "ms-jpq/coq_nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "folke/neodev.nvim",
        ft = { "lua" },
        opts = {},
        event = "VeryLazy",
      },
    },
    config = function()
      local cfg = get_lsp_config()
      local util = require("lspconfig.util")

      require("lspconfig")["racket_langserver"].setup({
        capabilities = cfg.capabilities,
        on_attach = cfg.on_attach,
        flags = cfg.lsp_flags,
        -- root_dir = function(fname)
        -- 	return util.find_git_ancestor(fname) or vim.fn.getcwd()
        -- end,

        cmd = { "racket", "--lib", "racket-langserver" },
      })

      -- require("lspconfig")["scheme_langserver"].setup({
      -- require("lspconfig")["scheme_langserver"].setup({
      -- 	capabilities = cfg.capabilities,
      -- 	handlers = cfg.handlers,
      -- 	on_attach = cfg.on_attach,
      -- 	flags = cfg.lsp_flags,
      -- 	root_dir = function(v)
      -- 		return require("lspconfig.util").root_pattern(unpack({ "Akku.manifest", ".git" }))(v)
      -- 			or vim.fn.getcwd()
      -- 	end,
      -- 	setttings = {
      -- 		dialyzerEnabled = true,
      -- 		root_dir = function(v)
      -- 			return require("lspconfig.util").root_pattern(unpack({ "Akku.manifest", ".git" }))(v)
      -- 				or vim.fn.getcwd()
      -- 		end,
      -- 		fetchDeps = false,
      -- 		enableTestLenses = false,
      -- 		suggestSpecs = false,
      -- 	},
      -- })
      --
      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup(cfg)
        end,
        ["elixirls"] = function()
          require("lspconfig")["elixirls"].setup({
            capabilities = cfg.capabilities,
            handlers = cfg.handlers,
            on_attach = cfg.on_attach,
            flags = cfg.lsp_flags,
            cmd = { "/usr/local/bin/elixir-ls" },
            setttings = {
              dialyzerEnabled = true,
              fetchDeps = false,
              enableTestLenses = false,
              suggestSpecs = false,
            },
          })
        end,

        ["ruff_lsp"] = function()
          require("lspconfig").ruff_lsp.setup({
            capabilities = cfg.capabilities,
            handlers = cfg.handlers,
            on_attach = cfg.on_attach,
            flags = cfg.lsp_flags,
            init_options = {
              settings = {
                -- Any extra CLI arguments for `ruff` go here.
                args = {},
              },
            },
          })
        end,

        ["lua_ls"] = function()
          require("lspconfig")["lua_ls"].setup({
            capabilities = cfg.capabilities,
            handlers = cfg.handlers,
            on_attach = cfg.on_attach,
            flags = cfg.lsp_flags,
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      })
    end,
  },
  -- {
  -- 	"neovim/nvim-lspconfig",
  -- 	lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
  --   opts = function()
  --     return require('coq').lsp_ensure_capabilities({
  --         -- options for vim.diagnostic.config()
  --         ---@type vim.diagnostic.Opts
  --         diagnostics = {
  --           underline = true,
  --           update_in_insert = false,
  --           virtual_text = {
  --             spacing = 4,
  --             source = "if_many",
  --             prefix = "●",
  --             -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
  --             -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
  --             -- prefix = "icons",
  --           },
  --           severity_sort = true,
  --           signs = {
  --             text = {
  --               [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
  --               [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
  --               [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
  --               [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
  --             },
  --           },
  --         },
  --         -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
  --         -- Be aware that you also will need to properly configure your LSP server to
  --         -- provide the inlay hints.
  --         inlay_hints = {
  --           enabled = true,
  --           exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
  --         },
  --         capabilities = {
  --           workspace = {
  --             didChangeWatchedFiles = {
  --               dynamicRegistration = false,
  --             },
  --           },
  --         },
  --         ---@type lspconfig.options
  --         servers = {
  --           lua_ls = {
  --             -- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
  --             -- single_file_support = true,
  --             settings = {
  --               Lua = {
  --                 misc = {
  --                   -- parameters = { "--loglevel=trace" },
  --                 },
  --                 -- hover = { expandAlias = false },
  --                 type = {
  --                   castNumberToInteger = true,
  --                 },
  --                 diagnostics = {
  --                   disable = { "incomplete-signature-doc", "trailing-space" },
  --                   -- enable = false,
  --                   groupSeverity = {
  --                     strong = "Warning",
  --                     strict = "Warning",
  --                   },
  --                   groupFileStatus = {
  --                     ["ambiguity"] = "Opened",
  --                     ["await"] = "Opened",
  --                     ["codestyle"] = "None",
  --                     ["duplicate"] = "Opened",
  --                     ["global"] = "Opened",
  --                     ["luadoc"] = "Opened",
  --                     ["redefined"] = "Opened",
  --                     ["strict"] = "Opened",
  --                     ["strong"] = "Opened",
  --                     ["type-check"] = "Opened",
  --                     ["unbalanced"] = "Opened",
  --                     ["unused"] = "Opened",
  --                   },
  --                   unusedLocalExclude = { "_*" },
  --                 },
  --               },
  --             },
  --           },
  --         },
  --       })
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = "BufReadPre",
  --   config = function()
  --     require('lint').linters.raco = {
  --       name = "raco",
  --       cmd = 'raco',
  --       args = {"fmt",},
  --       stdin = true,
  --       stream = "stdout",
  --       ignore_exitcode = true,
  --       parser = require("lint.parser").from_errorformat("%f:%l:%m", {
  --         source = "source",
  --         severity = vim.diagnostic.severity.ERROR,
  --       }),
  --     }
  --     require("lint").linters_by_ft = {
  --       text = {'vale',},
  --       json = {'jsonlint',},
  --       markdown = {'vale',},
  --       rst = {'vale',},
  --       ruby = {'ruby',},
  --       janet = {'janet',},
  --       inko = {'inko',},
  --       clojure = {'clj-kondo',},
  --       dockerfile = {'hadolint',},
  --       terraform = {'tflint'},
  --
  --       lua = { "stylua", "luacheck" },
  --       go = { "golangcilint" },
  --       proto = { "protolint" },
  --       python = { "ruff" },
  --       racket = {"raco"},
  --       sql = {"sqlfluff"},
  --     }
  --   end,
  --   keys = {
  --     {
  --       "<leader>M",
  --       function()
  --         require("lint").try_lint()
  --       end,
  --       desc = "nvim lint buffer",
  --     },
  --     -- vim.keymap.set("n", "<leader>M", function()
  --     --   vim.lsp.buf.format({ async = true })
  --     -- end, opts)
  --
  --   }
  -- },
  -- {
  --   "ray-x/lsp_signature.nvim",
  -- },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      modes = {
        diagnostics = {
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.4,
          },
          filter = function(items)
            return vim.tbl_filter(function(item)
              if vim.bo.filetype == "go" then
                return string.find(item.basename, "_test.go") == nil
              end
              return true
            end, items)
          end,
        },
      },
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- go.nvim
  {
    "ray-x/go.nvim",
    cmd = {
      "Go",
      "GoFillStruct",
      "GoModInit",
      "GoModTidy",
      "GoNew",
      "GoFmt",
      "GoBuild",
      "GoAlt",
      "GoBreakToggle",
      "GoImpl",
      "GoRun",
      "GoInstall",
      "GoTest",
      "GoTestFunc",
      "GoTestCompile",
      "GoCoverage",
      "GoCoverageToggle",
      "GoCoverag",
      "GoGet",
      "GoModifyTags",
    },
    ft = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    -- build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    main = "go",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      -- "ms-jpq/coq_nvim",
    },
    config = function()
      -- local go_lsp_cfg = vim.tbl_deep_extend("force", lsp_config, {
      --   capabilities = vim.tbl_deep_extend(
      --     "force",
      --     require("coq").lsp_ensure_capabilities(lsp_config).capabilities,
      --     {
      --       textDocument = {
      --         completion = {
      --           completionItem = {
      --             commitCharactersSupport = true,
      --             deprecatedSupport = true,
      --             documentationFormat = { "markdown", "plaintext" },
      --             preselectSupport = true,
      --             insertReplaceSupport = true,
      --             labelDetailsSupport = true,
      --             snippetSupport = true,
      --             resolveSupport = {
      --               properties = {
      --                 "documentation",
      --                 "details",
      --                 "additionalTextEdits",
      --               },
      --             },
      --           },
      --           contextSupport = true,
      --           dynamicRegistration = true,
      --         },
      --       },
      --     }
      --   ),
      -- })

      local lsp_config = get_lsp_config()
      local opts = {
        max_line_line = 10000,
        lsp_on_attach = lsp_config.on_attach,
        lsp_codelens = false,
        lsp_inlay_hints = {
          enable = false,
          only_current_line_autocmd = "CursorHold",
          only_current_line = true,
        },
        -- diagnostic =  lsp_config.diagnostics, -- use  "rachartier/tiny-inline-diagnostic.nvim" instead
        diagnostic = get_lsp_config().diagnostics,
        gopls_remote_auto = true,
        textobjects = true,
        lsp_fmt_async = true,
        lsp_cfg = {
          handlers = lsp_config.handlers,
          on_attach = lsp_config.on_attach,
          flags = lsp_config.lsp_flags,
          capabilities = lsp_config.capabilities,
          settings = {
            gopls = {
              -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
              -- not supported
              analyses = {
                unreachable = true,
                nilness = true,
                unusedparams = true,
                useany = true,
                unusedwrite = true,
                ST1003 = true,
                undeclaredname = true,
                fillreturns = true,
                nonewvars = true,
                fieldalignment = false,
                shadow = true,
              },
              codelenses = {
                generate = true,   -- show the `go generate` lens.
                gc_details = true, -- Show a code lens toggling the display of gc's choices.
                test = true,
                tidy = true,
                vendor = true,
                regenerate_cgo = true,
                upgrade_dependency = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              matcher = "Fuzzy",
              diagnosticsDelay = "500ms",
              symbolMatcher = "fuzzy",
              semanticTokens = true,

              buildFlags = { "-tags", "integration" },
            },
          },
        },
      }
      -- Run gofmt + goimports on save
      -- local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      -- 	pattern = "*.go",
      -- 	callback = function()
      -- 		require("go.format").goimports()
      -- 	end,
      -- 	group = format_sync_grp,
      -- })

      require("go").setup(opts)
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = "modern", -- Can be: "modern", "classic", "minimal", "ghost", "simple", "nonerdfont"
      })
    end
  }

  -- formatter
  -- {
  -- 	"stevearc/conform.nvim",
  -- 	opts = {
  -- 		formatters_by_ft = {
  -- 			lua = { "stylua" },
  -- 			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
  -- 			rust = { "rustfmt", lsp_format = "fallback" },
  -- 			bash = { "shfmt" },
  -- 			sql = { "sleek" },
  -- 			go = { "gofmt" },
  -- 		},
  -- 	},
  -- 	keys = {
  -- 		{
  -- 			"<leader>M",
  -- 			function()
  -- 				require("conform").format()
  -- 			end,
  -- 		},
  -- 	},
  -- },
}
