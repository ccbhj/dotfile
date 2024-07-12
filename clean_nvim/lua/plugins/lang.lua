return {
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  {
    "iamcco/markdown-preview.nvim",
    build  = "cd app && npm install",
    ft     = { "markdown" },
    cmd    = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    config = function()
      vim.g.mkdp_browser = "firefox"
    end,
  },
  {
    "OXY2DEV/markview.nvim",

    dependencies = {
      -- You may not need this if you don't lazy load
      -- Or if the parsers are in your $RUNTIMEPATH
      "nvim-treesitter/nvim-treesitter",

      "nvim-tree/nvim-web-devicons"
    },
  },

  -- symbols-outline
  {
    'simrat39/symbols-outline.nvim',
    cmd = "SymbolsOutline",
    opts = {
      width = 30,
    },
    keys = { { "<F8>", "<cmd>SymbolsOutline<cr>", desc = "toggle symbols-outline" } },
  },

}
