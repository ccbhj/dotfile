local npairs = require("nvim-autopairs")

npairs.setup({
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  disable_in_macro = true,        -- disable when recording or executing a macro
  disable_in_visualblock = false, -- disable when insert after visual block mode
  disable_in_replace_mode = true,
  ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
  enable_moveright = true,
  enable_afterquote = true,         -- add bracket pairs after quote
  enable_check_bracket_line = true, --- check bracket in same line
  enable_bracket_in_quote = true,   --
  enable_abbr = false,              -- trigger abbreviation
  break_undo = true,                -- switch for basic rule break undo sequence
  check_ts = false,
  map_cr = true,
  map_bs = true,   -- map the <BS> key
  map_c_h = false, -- Map the <C-h> key to delete a pair
  map_c_w = false, -- map <c-w> to delete a pair if possible

  fast_wrap = {
    map = '<C-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    manual_position = true,
    highlight = 'Search',
    highlight_grey = 'Comment'
  },
})

npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "racket"}
