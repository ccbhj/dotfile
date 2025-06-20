
_G.dd = function(...)
	require("util.debug").dump(...)
end
_G.bt = function(...)
	require("util.debug").bt(...)
end
vim.print = _G.dd

-- require("util.profiler").startup()

require("config.options")

-- pcall(require, "config.autocmds")

require("config.lazy")({
	-- debug = false,
	profiling = {
		loader = false,
		require = false,
	},
})

require("config.keymaps")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
    vim.cmd("")
	end,
})

-- 生成一个print
