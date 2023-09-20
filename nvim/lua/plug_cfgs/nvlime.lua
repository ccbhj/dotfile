vim.g.nvlime_config = {
  leader = ",",
  implementation = "sbcl",
  address = {
    host = "127.0.0.1",
    port = 7002
  },
  contribs = {"SWANK-ASDF", "SWANK-PACKAGE-FU",
    "SWANK-PRESENTATIONS", "SWANK-FANCY-INSPECTOR",
    "SWANK-C-P-C", "SWANK-ARGLISTS",
    "SWANK-REPL", "SWANK-FUZZY"},
  connect_timeout = -1,
  compiler_policy = nil,
  -- full table of indent keywords is provided in the
  -- options description section
  indent_keywords = { defun = 2, },
  input_history_limit = 100,
  -- full list of contribs is provided in the
  -- options description section
  -- configured with vimscript
  user_contrib_initializers = nil,
  autodoc = {
    enabled = false,
    max_level = 5,
    max_lines = 50
  },
  main_window = {
    position = "right",
    size = ""
  },
  floating_window = {
    border = "single",
    scroll_step = 3
  },
  cmp = { enabled = true },
  arglist = { enabled = true }
}
