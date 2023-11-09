require('lualine').setup {
  options = {
    -- theme = "seoul256",
    theme = "catppuccin",

    -- theme = 'auto',
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
    icons_enabled = true,
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {
      { "fancy_mode", width = 3 }
    },
    lualine_b = {
      { "fancy_branch" },
      { "fancy_diff" },
    },
    lualine_c = {
      { "fancy_cwd", substitute_home = true }
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
      { "fancy_filetype", ts_icon = "" }
    },
    lualine_z = {
      { "fancy_lsp_servers" }
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
