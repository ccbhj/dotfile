return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		init = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
		opts = function()
			return {
				plugins = {
					auto = true,
				},
				style = "moon",
				transparent = true,
				terminal_colors = true,
				-- styles = {
				--   sidebars = "transparent",
				--   floats = "transparent",
				-- },
				sidebars = {
					"qf",
					"vista_kind",
					"terminal",
					"spectre_panel",
					"startuptime",
					"Outline",
				},
				on_highlights = function(hl, c)
					local bg = "#24283b"
					local set_bg_hl = {
						"TelescopeBorder",
						"TelescopeNormal",
						"FloatBorder",
						"NormalFloat",
						"TelescopePromptNormal",
						"TelescopePromptBorder",
						"TelescopeResultsTitle",
						"TelescopePreviewTitle",
					}
					for _, g in ipairs(set_bg_hl) do
						hl[g] = { bg = bg }
					end
				end,
			}
		end,
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1001, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
         -- background = "medium",
			})
			vim.cmd([[colorscheme everforest]])
		end,
	},
	-- {
	-- 	"uloco/bluloco.nvim",
	-- 	lazy = false,
	-- 	priority = 1001,
	-- 	dependencies = { "rktjmp/lush.nvim" },
	-- 	config = function()
	-- 		-- your optional config goes here, see below.
	-- 		require("bluloco").setup({
	-- 			style = "auto", -- "auto" | "dark" | "light"
	-- 			transparent = false,
	-- 			italics = true,
	-- 			terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
	-- 			guicursor = true,
	-- 		})
	--      vim.cmd([[colorscheme bluloco-dark]])
	-- 	end,
	-- },

	-- {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	dependencies = {
	-- 		"fcancelinha/nordern.nvim",
	-- 	},
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		local N = require("nordic.colors.nordic")
	-- 		local C = require("nordern.colors")
	-- 		local opts = {
	-- 			cursorline = {
	-- 				-- Bold font in cursorline.
	-- 				bold = false,
	-- 				-- Bold cursorline number.
	-- 				bold_number = true,
	-- 				-- Available styles: 'dark', 'light'.
	-- 				theme = "light",
	-- 				-- Blending the cursorline bg with the buffer bg.
	-- 				blend = 2,
	-- 			},
	-- 			override = {
	-- 				TelescopeSelection = { bg = N.gray3 },
	-- 				PmenuSel = { bg = N.gray3 },
	--
	-- 				-- nvimtree
	-- 				--
	-- 				-- File Text
	-- 				NvimTreeSymlink = { fg = C.aurora.green, bg = C.none },
	-- 				NvimTreeExecFile = { fg = C.aurora.red, bg = C.none },
	-- 				NvimTreeOpenedFile = { fg = C.fg, bg = C.none },
	-- 				NvimTreeModifiedFile = { fg = C.aurora.yellow, bg = C.none },
	-- 				NvimTreeSpecialFile = { fg = C.fg, bg = C.none },
	-- 				NvimTreeImageFile = { fg = C.fg, bg = C.none },
	-- 				-- Folder Text
	-- 				NvimTreeFolderName = { fg = C.frost.turquoise, bg = C.none },
	-- 				NvimTreeEmptyFolderName = { fg = C.frost.turquoise, bg = C.none },
	-- 				NvimTreeOpenedFolderName = { fg = C.frost.turquoise, bg = C.none },
	-- 				NvimTreeSymlinkFolderName = { fg = C.aurora.green, bg = C.none },
	-- 				NvimTreeRootFolder = { fg = C.frost.turquoise, bg = C.none },
	-- 				-- Icon
	-- 				NvimTreeFileIcon = { fg = C.frost.turquoise, bg = C.none },
	-- 				NvimTreeOpenedFileIcon = { fg = C.frost.turquoise, bg = C.none }, --NvimTreeOpenedFile
	-- 				NvimTreeSymlinkIcon = { fg = C.aurora.green, bg = C.none },
	-- 				NvimTreeFolderIcon = { fg = C.frost.turquoise, bg = C.none },
	-- 				NvimTreeOpenedFolderIcon = { fg = C.frost.turquoise, bg = C.none }, --NvimTreeFolderIcon
	-- 				NvimTreeClosedFolderIcon = { fg = C.frost.turquoise, bg = C.none }, --NvimTreeFolderIcon
	-- 				NvimTreeFolderArrowClosed = { fg = C.night.c3, bg = C.none }, --NvimTreeIndentMarker
	-- 				NvimTreeFolderArrowOpen = { fg = C.night.c3, bg = C.none }, --NvimTreeIndentMarker
	-- 				-- Indent
	-- 				NvimTreeIndentMarker = { fg = C.night.c1, bg = C.none },
	-- 				-- Standard
	-- 				NvimTreeNormal = { fg = C.snow.c0, bg = C.none }, --Normal
	-- 				NvimTreeNormalFloat = { fg = C.snow.c0, bg = C.none }, --NormalFloat
	-- 				NvimTreeNormalNC = { fg = C.snow.c0, bg = C.none }, --NormalFloat
	-- 				NvimTreeLineNr = { fg = C.bg, bg = C.none }, --LineNr
	-- 				NvimTreeWinSeparator = { fg = C.bg, bg = C.none }, --WinSeparator
	-- 				NvimTreeEndOfBuffer = { fg = C.bg, bg = C.none }, --EndOfBuffer
	-- 				NvimTreePopup = { fg = C.snow.c0, bg = C.none }, --Normal
	-- 				NvimTreeSignColumn = { link = "SignColumn" }, --NvimTreeNormal
	-- 				NvimTreeCursorColumn = { link = "CursorColumn" }, --CursorColumn
	-- 				NvimTreeCursorLine = { link = "CursorLine" }, --CursorLine
	-- 				NvimTreeCursorLineNr = { link = "CursorLineNr" }, --CursorLineNr
	-- 				NvimTreeStatusLine = { link = "StatusLine" }, --StatusLine
	-- 				NvimTreeStatusLineNC = { link = "StatusLineNC" }, --StatusLineNC
	-- 				-- Clipboard
	-- 				NvimTreeCopiedHL = { fg = C.frost.blue, bg = C.none }, --SpellRare
	-- 				NvimTreeCutHL = { fg = C.aurora.red, bg = C.none }, --SpellBad
	-- 				-- Bookmark Icon
	-- 				NvimTreeBookmark = { fg = C.aurora.purple, bg = C.none },
	-- 				-- Bookmark Highlight
	-- 				NvimTreeBookmarkHL = { fg = C.aurora.purple, bg = C.none }, --SpellLocal
	-- 				-- Picker: >
	-- 				NvimTreeWindowPicker = { fg = C.frost.light_blue, bg = C.none },
	-- 				-- Live Filter
	-- 				NvimTreeLiveFilterPrefix = { fg = C.aurora.yellow, bg = C.none },
	-- 				NvimTreeLiveFilterValue = { fg = C.fg, bg = C.none },
	-- 				-- Git Icon
	-- 				NvimTreeGitDirty = { fg = C.aurora.red, bg = C.none },
	-- 				NvimTreeGitStaged = { fg = C.aurora.green, bg = C.none },
	-- 				NvimTreeGitMerge = { fg = C.frost.sea, bg = C.none },
	-- 				NvimTreeGitRenamed = { fg = C.aurora.yellow, bg = C.none },
	-- 				NvimTreeGitNew = { fg = C.aurora.green, bg = C.none },
	-- 				NvimTreeGitDeleted = { fg = C.aurora.red, bg = C.none },
	-- 				NvimTreeGitIgnored = { fg = C.night.c3, bg = C.none }, --     Comment
	-- 				-- Git File Text
	-- 				NvimTreeFileDirty = { fg = C.aurora.red, bg = C.none }, --     NvimTreeGitDirty
	-- 				NvimTreeFileStaged = { fg = C.aurora.green, bg = C.none }, --     NvimTreeGitStaged
	-- 				NvimTreeFileMerge = { fg = C.frost.sea, bg = C.none }, --     NvimTreeGitMerge
	-- 				NvimTreeFileRenamed = { fg = C.aurora.yellow, bg = C.none }, --     NvimTreeGitRenamed
	-- 				NvimTreeFileNew = { fg = C.aurora.green, bg = C.none }, --     NvimTreeGitNew
	-- 				NvimTreeFileDeleted = { fg = C.aurora.red, bg = C.none }, --     NvimTreeGitDeleted
	-- 				NvimTreeFileIgnored = { fg = C.night.c3, bg = C.none }, --     NvimTreeGitIgnored
	-- 				-- Git Folder Text
	-- 				NvimTreeFolderDirty = { fg = C.aurora.red, bg = C.none }, --     NvimTreeFileDirty
	-- 				NvimTreeFolderStaged = { fg = C.aurora.green, bg = C.none }, --     NvimTreeFileStaged
	-- 				NvimTreeFolderMerge = { fg = C.frost.sea, bg = C.none }, --     NvimTreeFileMerge
	-- 				NvimTreeFolderRenamed = { fg = C.aurora.yellow, bg = C.none }, --     NvimTreeFileRenamed
	-- 				NvimTreeFolderNew = { fg = C.aurora.green, bg = C.none }, --     NvimTreeFileNew
	-- 				NvimTreeFolderDeleted = { fg = C.aurora.red, bg = C.none }, --     NvimTreeFileDeleted
	-- 				NvimTreeFolderIgnored = { fg = C.night.c3, bg = C.none }, --     NvimTreeFileIgnored
	-- 				-- Diagnostics Icon
	-- 				NvimTreeLspDiagnosticsError = { fg = C.aurora.red, bg = C.blend.red }, --DiagnosticError
	-- 				NvimTreeLspDiagnosticsWarning = { fg = C.blend.yellow, bg = C.blend.yellow }, --DiagnosticWarn
	-- 				NvimTreeLspDiagnosticsInformation = { fg = C.frost.turquoise, bg = C.blend.turquoise }, --DiagnosticInfo
	-- 				NvimTreeLspDiagnosticsHint = { fg = C.frost.turquoise, bg = C.blend.turquoise }, --DiagnosticHint
	-- 				-- Diagnostics File Text
	-- 				NvimTreeLspDiagnosticsErrorText = { fg = C.aurora.red, bg = C.none }, --NvimTreeLspDiagnosticsError
	-- 				NvimTreeLspDiagnosticsWarningText = { fg = C.aurora.yellow, bg = C.none }, --NvimTreeLspDiagnosticsWarning
	-- 				NvimTreeLspDiagnosticsInfoText = { fg = C.frost.turquoise, bg = C.none }, --NvimTreeLspDiagnosticsInformation
	-- 				NvimTreeLspDiagnosticsHintText = { fg = C.frost.turquoise, bg = C.none }, --NvimTreeLspDiagnosticsHint
	-- 				-- Diagnostics Folder Text
	-- 				NvimTreeLspDiagnosticsErrorFolderText = { fg = C.aurora.red, bg = C.none }, --NvimTreeLspDiagnosticsErrorText
	-- 				NvimTreeLspDiagnosticsWarningFolderText = { fg = C.aurora.yellow, bg = C.none }, --NvimTreeLspDiagnosticsWarningText
	-- 				NvimTreeLspDiagnosticsInfoFolderText = { fg = C.frost.turquoise, bg = C.none }, --NvimTreeLspDiagnosticsInfoText
	-- 				NvimTreeLspDiagnosticsHintFolderText = { fg = C.frost.turquoise, bg = C.none }, --NvimTreeLspDiagnosticsHintText
	--
	-- 				--illuminate
	-- 				IlluminatedWordText = { bg = C.blend.turquoise, fg = C.frost.turquoise },
	-- 				IlluminatedWordRead = { bg = C.blend.turquoise, fg = C.frost.turquoise },
	-- 				IlluminatedWordWrite = { bg = C.blend.turquoise, fg = C.frost.turquoise },
	--
	-- 				-- diffview
	-- 				DiffviewFilePanelTitle = { fg = C.frost.turquoise, bg = C.none },
	-- 				DiffviewFilePanelCounter = { fg = C.aurora.yellow, bg = C.none },
	-- 				DiffviewFilePanelInsertions = { fg = C.aurora.green, bg = C.none },
	-- 				DiffviewFilePanelDeletions = { fg = C.aurora.red, bg = C.none },
	-- 				DiffviewFilePanelRootPath = { fg = C.frost.sea, bg = C.none },
	-- 				DiffviewPrimary = { fg = C.frost.turquoise, bg = C.none },
	-- 				DiffviewSecondary = { fg = C.aurora.yellow, bg = C.none },
	-- 				DiffviewDiffAddAsDelete = { fg = C.frost.blue, bg = C.blend.blue },
	-- 				DiffviewStatusUntracked = { fg = C.frost.sea, bg = C.none },
	-- 				DiffviewStatusUnmerged = { fg = C.frost.sea, bg = C.none },
	-- 				DiffviewStatusModified = { fg = C.aurora.yellow, bg = C.none },
	-- 				DiffviewStatusDeleted = { fg = C.aurora.red, bg = C.none },
	-- 				DiffviewStatusAdded = { fg = C.aurora.green, bg = C.none },
	--
	-- 				-- cmp
	-- 				CmpItemAbbr = { fg = C.fg, bg = C.none },
	-- 				CmpItemAbbrDeprecated = { fg = C.night.c3, bg = C.none },
	-- 				CmpItemAbbrMatch = { fg = C.frost.turquoise, bg = C.none },
	-- 				CmpItemAbbrMatchFuzzy = { fg = C.frost.turquoise, bg = C.none },
	-- 				CmpItemKind = { fg = C.aurora.red, bg = C.none },
	-- 				CmpItemKindClass = { fg = C.aurora.red, bg = C.none },
	-- 				CmpItemKindColor = { fg = C.frost.turquoise, bg = C.none },
	-- 				CmpItemKindConstant = { fg = C.aurora.yellow, bg = C.none },
	-- 				CmpItemKindConstructor = { fg = C.frost.light_blue, bg = C.none },
	-- 				CmpItemKindCopilot = { fg = C.aurora.orange, bg = C.none },
	-- 				CmpItemKindEnum = { fg = C.aurora.yellow, bg = C.none },
	-- 				CmpItemKindEnumMember = { fg = C.aurora.yellow, bg = C.none },
	-- 				CmpItemKindEvent = { fg = C.aurora.green, bg = C.none },
	-- 				CmpItemKindField = { fg = C.frost.turquoise, bg = C.none },
	-- 				CmpItemKindFile = { fg = C.aurora.red, bg = C.none },
	-- 				CmpItemKindFolder = { fg = C.aurora.red, bg = C.none },
	-- 				CmpItemKindFunction = { fg = C.frost.light_blue, bg = C.none },
	-- 				CmpItemKindInterface = { fg = C.frost.sea, bg = C.none },
	-- 				CmpItemKindKeyword = { fg = C.aurora.red, bg = C.none },
	-- 				CmpItemKindMethod = { fg = C.aurora.purple, bg = C.none },
	-- 				CmpItemKindModule = { fg = C.frost.light_blue, bg = C.none },
	-- 				CmpItemKindOperator = { fg = C.aurora.red, bg = C.none },
	-- 				CmpItemKindProperty = { fg = C.frost.turquoise, bg = C.none },
	-- 				CmpItemKindReference = { fg = C.aurora.yellow, bg = C.none },
	-- 				CmpItemKindSnippet = { fg = C.aurora.green, bg = C.none },
	-- 				CmpItemKindStruct = { fg = C.frost.sea, bg = C.none },
	-- 				CmpItemKindText = { fg = C.aurora.purple, bg = C.none },
	-- 				CmpItemKindTypeParameter = { fg = C.frost.turquoise, bg = C.none },
	-- 				CmpItemKindUnit = { fg = C.aurora.green, bg = C.none },
	-- 				CmpItemKindValue = { fg = C.frost.turquoise, bg = C.none },
	-- 				CmpItemKindVariable = { fg = C.frost.turquoise, bg = C.none },
	-- 				CmpItemMenu = { fg = C.night.c3, bg = C.none, italic = true },
	-- 			},
	-- 		}
	--
	-- 		require("nordic").setup(opts)
	-- 		require("nordic").load()
	-- 		vim.cmd([[colorscheme nordic]])
	-- 	end,
	-- },
}
