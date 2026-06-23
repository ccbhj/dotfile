local diagnostics_cfg = {
  underline = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    }
  }
}
vim.diagnostic.config(diagnostics_cfg)

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
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
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

      appearance = {
        use_nvim_cmp_as_default = true,
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },
      -- experimental auto-brackets support
      -- accept = { auto_brackets = { enabled = true } }
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = { " ", "\n", "\t" },
          show_on_insert_on_trigger_character = true,
        },
        documentation = {
          auto_show = true,
        },
      },
      cmdline = {
        completion = {
          menu = { auto_show = false },
          ghost_text = { enabled = false },
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

      vim.lsp.config("ruff", {
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

      vim.lsp.config("basedpyright", {
        capabilities = cfg.capabilities,
        handlers = cfg.handlers,
        on_attach = cfg.on_attach,
        flags = cfg.lsp_flags,
        init_options = {
          settings = {
            disableLanguageServices = true,
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            },
          },
        },
      })


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
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          -- "gopls",
          "ruff",
          "elixirls",
        },
        automatic_enable = true,
      })
    end,
  },
  -- {
  -- 	"neovim/nvim-lspconfig",
  -- 	lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
  --   opts = function()
  --     return {
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
    },
    config = function()
      -- local go_lsp_cfg = vim.tbl_deep_extend("force", lsp_config, {
      --   capabilities = vim.tbl_deep_extend(
      --     "force",
      --     lsp_config.capabilities,
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
