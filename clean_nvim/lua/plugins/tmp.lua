return {
	{
		"fei6409/log-highlight.nvim",
		event = "BufRead *.log",
		opts = {},
	},
	{
		"2kabhishek/nerdy.nvim",
		cmd = "Nerdy",
		keys = {
			{ "<leader>ci", "<cmd>Nerdy<cr>", desc = "Pick Icon" },
		},
	},

	{ "folke/neodev.nvim", opts = {} },
}
