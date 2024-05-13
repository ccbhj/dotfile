local catppuccin = require("catppuccin")

catppuccin.setup({
  -- floating_border = "auto" | "on" | "off"
  floating_border = "off",
  flavour = "frappe", -- latte, frappe, macchiato, mocha
  transparent_background = false,
  term_colors = true,
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  custom_highlights = function(colors)
    local u = require("catppuccin.utils.colors")
    return {
      CursorColumn = {
        bg = u.darken(colors.surface0, 0.64, colors.base),
      },
      -- Comment = { fg = colors.flamingo },
      TabLineSel   = { bg = colors.pink },
      CmpBorder    = { fg = colors.surface2 },
      Pmenu        = { bg = colors.base },
    }
  end,
  integrations = {
    cmp                = true,
    gitsigns           = true,
    nvimtree           = true,
    telescope          = {
      enabled = true,
      -- style = "nvchad"
    },
    indent_blankline   = true,
    bufferline         = true,
    markdown           = true,
    noice              = true,
    mason              = true,
    flash              = true,
    treesitter_context = true,
    treesitter         = true,
    notify             = true,
    symbols_outline    = true,
    dashboard = true,

    native_lsp         = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  }
})
vim.cmd.colorscheme "catppuccin"
