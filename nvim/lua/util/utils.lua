local uv = vim.loop
local utils = {}
--- return the most recently files list
function utils.get_mru_list()
	local mru = {}
	for _, file in pairs(vim.v.oldfiles or {}) do
		if file and vim.fn.filereadable(file) == 1 then
			table.insert(mru, file)
		end
	end
	return mru
end

function utils.get_icon(filename)
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		return nil
	end
	return devicons.get_icon(filename, nil, { default = true })
end

---return longest line length
---@param lines table
---@return number longest
function utils.longest_line(lines)
	local longest = 0
	for _, line in ipairs(lines) do
		if vim.fn.strdisplaywidth(line) > longest then
			longest = vim.fn.strdisplaywidth(line)
		end
	end
	return longest
end

---returns string with specified amount of spaces
---@param amount number the amount of space to return
---@return string
function utils.spaces(amount)
	return string.rep(" ", amount)
end

utils.is_win = uv.os_uname().version:match("Windows")

local function week_ascii_text()
	return {
		["Monday"] = {
			"",
			"███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗",
			"████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝",
			"██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ ",
			"██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  ",
			"██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   ",
			"╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
			"",
		},
		["Tuesday"] = {
			"",
			"████████╗██╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗",
			"╚══██╔══╝██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝",
			"   ██║   ██║   ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝ ",
			"   ██║   ██║   ██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝  ",
			"   ██║   ╚██████╔╝███████╗███████║██████╔╝██║  ██║   ██║   ",
			"   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
			"",
		},
		["Wednesday"] = {
			"",
			"██╗    ██╗███████╗██████╗ ███╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗",
			"██║    ██║██╔════╝██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝",
			"██║ █╗ ██║█████╗  ██║  ██║██╔██╗ ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝ ",
			"██║███╗██║██╔══╝  ██║  ██║██║╚██╗██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝  ",
			"╚███╔███╔╝███████╗██████╔╝██║ ╚████║███████╗███████║██████╔╝██║  ██║   ██║   ",
			" ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
			"",
		},
		["Thursday"] = {
			"",
			"████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  █████╗ ██╗   ██╗",
			"╚══██╔══╝██║  ██║██║   ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝",
			"   ██║   ███████║██║   ██║██████╔╝███████╗██║  ██║███████║ ╚████╔╝ ",
			"   ██║   ██╔══██║██║   ██║██╔══██╗╚════██║██║  ██║██╔══██║  ╚██╔╝  ",
			"   ██║   ██║  ██║╚██████╔╝██║  ██║███████║██████╔╝██║  ██║   ██║   ",
			"   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
			"",
		},
		["Friday"] = {
			"",
			"███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗",
			"██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝",
			"█████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝ ",
			"██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝  ",
			"██║     ██║  ██║██║██████╔╝██║  ██║   ██║   ",
			"╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
			"",
		},
		["Saturday"] = {
			"",
			"███████╗ █████╗ ████████╗██╗   ██╗██████╗ ██████╗  █████╗ ██╗   ██╗",
			"██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝",
			"███████╗███████║   ██║   ██║   ██║██████╔╝██║  ██║███████║ ╚████╔╝ ",
			"╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║  ██║██╔══██║  ╚██╔╝  ",
			"███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██████╔╝██║  ██║   ██║   ",
			"╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
			"",
		},
		["Sunday"] = {
			"",
			"███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗",
			"██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝",
			"███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ ",
			"╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  ",
			"███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   ",
			"╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
			"",
		},
	}
end

function utils.week_header(concat, append)
	local week = week_ascii_text()
	local daysoftheweek = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
	local day = daysoftheweek[os.date("*t").wday]
	local tbl = week[day]
	-- table.insert(tbl, os.date("%Y-%m-%d %H:%M:%S ") .. (concat or ""))
	if append then
		vim.list_extend(tbl, append)
	end
	-- table.insert(tbl, "")
	return tbl
end

return utils
