vim.g.lightline = {
  enable = {tabline = 0},
  colorscheme = 'catppuccin',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'gitbranch', 'readonly', 'filename', 'modified' }
    }
  },
  component_function = { gitbranch = 'FugitiveHead' },
  mode_map = {
    n = 'N',
    i = 'I',
    R = 'R',
    v = 'V',
    V = 'VL',
    c = 'C',
    s = 'S',
    S = 'SL',
  },
  component = {
    lineinfo = '%3l:%-2v%<'
  }
}
