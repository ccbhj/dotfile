return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd [[colorscheme tokyonight]]
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
}
