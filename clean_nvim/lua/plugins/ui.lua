local if_nil = vim.F.if_nil
local api, keymap, uv = vim.api, vim.keymap, vim.loop
local utils = require("util.utils")

local leader = "SPC"
---
--- @param sc string
--- @param hl string?
--- @param txt string
--- @param keybind function? optional
--- @param keybind_opts table? optional
local function button(sc, hl, txt, keybind, keybind_opts)
	local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 3,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
	}
	if hl then
		opts.hl = hl
	end
	if keybind then
		keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end

	local function on_press()
		-- local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
		-- vim.api.nvim_feedkeys(key, "t", false)
		if keybind then
			keybind()
		end
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

local org_todos = function()
	local todos = {}
	for _, orgfile in ipairs(require("orgmode.api").load()) do
		if not orgfile.is_archive_file then
			for _, item in ipairs(orgfile.headlines) do
				if not item.is_archived and item.level == 1 and item.todo_type == "TODO" and item.todo_value then
					table.insert(todos, item.title)
				end
			end
		end
	end
	return todos
end

-- local function mru_list(config)
--   local config_mru = vim.tbl_extend("force", {
--     icon = " ",
--     limit = 10,
--     icon_hl = "DashboardMruIcon",
--     label = " Most Recent Files:",
--     cwd_only = false,
--   }, config or {})
--
--   local list = {}
--
--   local groups = {}
--   local mlist = utils.get_mru_list()
--
--   if config_mru.cwd_only then
--     local cwd = uv.cwd()
--     -- get separator from the first file
--     local sep = mlist[1]:match("[\\/]")
--     local cwd_with_sep = cwd:gsub("[\\/]", sep) .. sep
--     mlist = vim.tbl_filter(function(file)
--       local file_dir = vim.fn.fnamemodify(file, ":p:h")
--       if file_dir and cwd_with_sep then
--         return file_dir:sub(1, #cwd_with_sep) == cwd_with_sep
--       end
--     end, mlist)
--   end
--
--   for _, file in pairs(vim.list_slice(mlist, 1, config_mru.limit)) do
--     local filename = vim.fn.fnamemodify(file, ":t")
--     local icon, group = utils.get_icon(filename)
--     icon = icon or ""
--     if config_mru.cwd_only then
--       file = vim.fn.fnamemodify(file, ":.")
--     elseif not utils.is_win then
--       file = vim.fn.fnamemodify(file, ":~")
--     end
--     file = icon .. " " .. file
--     table.insert(list, file)
--   end
--
--   if #list == 1 then
--     table.insert(list, (" "):rep(3) .. " empty files")
--   end
--
--   return list, groups
-- end

return {
	{
		"folke/noice.nvim",
		tag = "v4.4.7",
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
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
			},
			messages = {
				enabled = true, -- enables the Noice messages UI
				view = "mini", -- default view for messages
				view_error = "mini", -- view for errors
				-- view_warn = "notify", -- view for warnings
				view_history = "split", -- view for :messages
				-- view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
			},
			redirect = {
				view = "split",
				opts = {
					size = "40%",
				},
				-- filter = { min_height = 20 },
			},

			popupmenu = {
				enabled = true, -- enables the Noice popupmenu UI
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
						throttle = 50, -- Debounce lsp signature help request by 50ms
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
					stages = "slide",
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						find = "Select",
					},
					view = "popup",
					close = {
						events = { "BufLeave" },
						keys = { "q", "<ESC>" },
					},
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
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "mini.align" },
						},
					},
					view = "mini",
				},
			},
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
					-- theme = "tokyonight",
					theme = "nordic",
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
						text_align = "left",
					},
				},
				name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr" remove extension from markdown files for example
					if buf.name:match("%.md") then
						return vim.fn.fnamemodify(buf.name, ":t:r")
					end
				end,
				color_icons = true,
				show_buffer_icons = true, -- | false, -- disable filetype icons for buffers
				show_buffer_close_icons = true, -- | false,
				show_close_icon = true, -- | false,
				show_tab_indicators = false, -- | false,
				show_duplicate_prefix = true,
				persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
				-- can also be a table containing 2 custom separators
				-- [focused and unfocused]. eg: { '|', '|' }
				separator_style = "thin", -- "thin" |"slant" | "thick" | "thin" | { 'any', 'any' },
				enforce_regular_tabs = false, -- false | true,
				always_show_bufferline = false, -- true | false,
				sort_by = "relative_directory", --| 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
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

	{
		"startup-nvim/startup.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		lazy = false,
		enabled = false,
		config = function()
			require("startup").setup({
				options = {
					mapping_keys = true,
				},

				header = {
					type = "text",
					oldfiles_directory = false,
					align = "center",
					fold_section = false,
					title = "Header",
					margin = 5,
					content = utils.week_header(),
					-- content = {
					-- 	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
					-- 	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
					-- 	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
					-- 	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
					-- 	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
					-- 	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
					-- },
					highlight = "Statement",
					default_color = "",
					oldfiles_amount = 0,
				},

				body = {
					type = "mapping",
					align = "center",
					content = {
						{ " Recent Files", "Telescope oldfiles", "f" },
						{ " File Browser", "Telescope file_browser", "F" },
						{ " Project", "Telescope project", "p" },
						{ " TODO", "Telescope orgmode search_headings", "t" },
					},
					oldfiles_directory = false,
					fold_section = false,
					title = "Basic Commands",
					margin = 5,
					highlight = "String",
					default_color = "",
					oldfiles_amount = 0,
				},

				mru = {
					margin = 0.5,
					type = "text",
					align = "center",
					content = org_todos(),
					highlight = "Type",
				},

				parts = { "header", "body", "mru" }, -- all sections in order
			})
		end,
	},

	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			local telescope = require("telescope")
			local header = {
				type = "text",
				val = utils.week_header(),
				opts = {
					position = "center",
					hl = "Type",
					-- wrap = "overflow";
				},
			}

			local time = {
				type = "text",
				-- val = { os.date("%Y-%m-%d %H:%M:%S ") },
				val = function()
					return { os.date("%Y-%m-%d %H:%M:%S ") }
				end,
				opts = {
					position = "center",
					hl = "Type",
					-- wrap = "overflow";
				},
			}

			local todos = {
				type = "group",
				val = {
					{ type = "padding", val = 1 },
					{ type = "text", val = " TODO", opts = { position = "center", hl = "Error" } },
					{
						type = "text",
						val = org_todos(),
						opts = {
							position = "center",
							hl = "Character",
							-- wrap = "overflow";
						},
					},
				},
			}

			local buttons = {
				type = "group",
				val = {
					button("f", "Statement", "󰈞  Find file", builtin.find_files),
					button("r", "Function", "  Frecency/MRU", builtin.oldfiles),
					button("p", "Field", "  Project", telescope.extensions.project.project),
					button("t", "Number", "  TODO", telescope.extensions.orgmode.search_headings),
				},
			}

			require("alpha").setup({
				layout = {
					header,
					time,
					{ type = "padding", val = 1 },
					buttons,
					todos,
				},
				opts = {
					margin = 5,
				},
			})
		end,
	},
}
