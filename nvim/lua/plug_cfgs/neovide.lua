if !vim.g.neovide then
  return
end

vim.o.guifont = "IntoneMono Nerd Font:h14" -- text below applies for VimScript

-- Sets how long the scroll animation takes to complete, measured in seconds. Note that the timing is not completely accurate and might depend slightly on have far you scroll, so experimenting is encouraged in order to tune it to your liking.
vim.g.neovide_scroll_animation_length = 0.3
-- When scrolling more than one screen at a time, only this many lines at the end of the scroll action will be animated. Set it to 0 to snap to the final position without any animation, or to something big like 9999 to always scroll the whole screen, much like Neovide <= 0.10.4 did.
vim.g.neovide_scroll_animation_far_lines = 1

vim.g.neovide_hide_mouse_when_typing = false


vim.g.neovide_theme = 'auto'

vim.g.neovide_refresh_rate_idle = 5


-- Cursor Settings

-- Setting g:neovide_cursor_animation_length determines the time it takes for the cursor to complete it's animation in seconds. Set to 0 to disable.
vim.g.neovide_cursor_animation_length = 0.13
-- Setting g:neovide_cursor_trail_size determines how much the trail of the cursor lags behind the front edge.
vim.g.neovide_cursor_trail_size = 0.8

-- Enables or disables antialiasing of the cursor quad. Disabling may fix some cursor visual issues.
vim.g.neovide_cursor_antialiasing = true


-- If disabled, when in insert mode (mostly through i or a), the cursor will move like in other programs and immediately jump to its new position.
vim.g.neovide_cursor_animate_in_insert_mode = true

-- If disabled, the switch from editor window to command line is non-animated, and the cursor jumps between command line and editor window immediately. Does not influence animation inside of the command line.
vim.g.neovide_cursor_animate_command_line = true
