require("notify").setup{
  background_colour = "NotifyBackground",
  fps = 50,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 50,
  render = "default", -- "minimal"|"simple"
  stages = "slide", -- "static"
  timeout = 4000,
  top_down = true
}
