require("bigfile").config {
  filesize = 200, -- size of the file in KB, the plugin round file sizes to the closest MiB
  maxline = 3000,
  pattern = { "*" }, -- autocmd pattern
  features = {  -- features to disable
    "indent_blankline",
    "lsp",
    "treesitter",
  }
}
