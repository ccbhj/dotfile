local diagnositc_signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(diagnositc_signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lsp_config = {
	inlay_hints = {
		enabled = false,
		exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
	},
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
	diagnostics = {
		underline = false,
		update_in_insert = true,
		signs = diagnositc_signs,
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = "●",
			-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
			-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
			-- prefix = "icons",
		},
		severity_sort = true,
	},
	capabilities = {
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		},
	},
}

lsp_config.handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
}

function lsp_config.on_attach(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }
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

	-- Set some keybinds conditional on server capabilities
	vim.keymap.set("n", "<leader>F", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
	vim.keymap.set("v", "<leader>F", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
			false
		)
	end
end

---@diagnostic disable: missing-fields
return {
	-- cmp
	{
		"ms-jpq/coq_nvim",
		branch = "coq",
		lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
		dependencies = {
			-- main one

			-- 9000+ Snippets
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },

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
			"ms-jpq/coq_nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"folke/neodev.nvim",
				ft = { "lua" },
				opts = {},
				event = "VeryLazy",
			},
		},
		config = function()
			local cfg = require("coq").lsp_ensure_capabilities(lsp_config)

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
	--   lazy = false,
	--   opts = {
	--     linters_by_ft = {
	--       lua = { "selene", "luacheck" },
	--       go = { "golangcilint" },
	--       proto = { "protolint" },
	--     },
	--   },
	--   config = function()
	--     vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	--       callback = function()
	--         -- try_lint without arguments runs the linters defined in `linters_by_ft`
	--         -- for the current filetype
	--         require("lint").try_lint()
	--       end,
	--     })
	--   end
	-- },
	{
		"folke/trouble.nvim",
		opts = {
			debug = true,
			-- preview = {
			--   type = "split",
			--   relative = "win",
			--   position = "right",
			--   size = 0.5,
			-- },
		},
	},

	{
		"ray-x/lsp_signature.nvim",
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
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
		lazy = true,
		ft = { "go", "gomod" },
		-- build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		main = "go",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
			"ms-jpq/coq_nvim",
		},
		config = function(_, opts)
			opts = vim.tbl_deep_extend("force", {
				max_line_line = 20000,
				lsp_on_attach = lsp_config.on_attach,
				lsp_inlay_hints = {
					enable = false,
					only_current_line = true,
				},
				diagnostic = { -- set diagnostic to false to disable vim.diagnostic.config setup,
					-- true: default nvim setup
					hdlr = true, -- hook lsp diag handler and send diag to quickfix
					underline = false,
					virtual_text = { spacing = 2, prefix = "" }, -- virtual text setup
					signs = { "", "", "", "" },
					update_in_insert = false,
				},
				trouble = true,
				luasnip = false,
				lsp_fmt_async = true,
				lsp_cfg = {
					capabilities = require("coq").lsp_ensure_capabilities(lsp_config).capabilities,
					handlers = lsp_config.handlers,
					settings = {
						gopls = {
							diagnosticsTrigger = "Edit",
							directoryFilters = {
								"-**/protobuf/go/",
								"-protobuf/go",
							},
							analyses = {
								shadow = false,
							},
						},
					},
				},
			}, opts)
			-- Run gofmt + goimports on save
			-- local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			--   pattern = "*.go",
			--   callback = function()
			--     require('go.format').goimports()
			--   end,
			--   group = format_sync_grp,
			-- })

			require("go").setup(opts)
		end,
	},
}
