local onedarkpro = require('onedarkpro')
-- vim.o.background = "dark" -- to load onelight
onedarkpro.setup({
  theme = "onedark", -- Override with "onedark" or "onelight". Alternatively, remove the option and the theme uses `vim.o.background` to determine
  colors = {
    cursorline = "#3d4148",
    -- fg = "#dcdfe4",
    bg = "#282c34"
  }, -- Override default colors. Can specify colors for "onelight" or "onedark" themes
  hlgroups = {}, -- Override default highlight groups
  styles = {
      strings = "NONE", -- Style that is applied to strings
      comments = "NONE", -- Style that is applied to comments
      keywords = "NONE", -- Style that is applied to keywords
      functions = "NONE", -- Style that is applied to functions
      variables = "NONE", -- Style that is applied to variables
  },
  options = {
      bold = true, -- Use the themes opinionated bold styles?
      italic = false, -- Use the themes opinionated italic styles?
      underline = true, -- Use the themes opinionated underline styles?
      undercurl = true, -- Use the themes opinionated undercurl styles?
      cursorline = true, -- Use cursorline highlighting?
      transparency = false, -- Use a transparent background?
      terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
      window_unfocussed_color = true, -- When the window is out of focus, change the normal background?
  }
})

vim.g.onedark_style = 'cool'
vim.g.onedark_italic_comment = true
onedarkpro.load()
require('onedarkpro').load()
