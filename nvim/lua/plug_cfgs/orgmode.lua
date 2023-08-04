
require('orgmode').setup_ts_grammar()

require('orgmode').setup({
  org_agenda_files = { '~/org/note/*.org', '~/org/agenda/*.org', '~/org/capture/*.org' },
  org_default_notes_file = '~/org/capture/refile.org',
  win_split_mode = 'split',
  mappings = {
    global = {
      org_agenda = '<F9>',
      org_capture = '<F10>'
    },
  },

  -- agenda
  org_deadline_warning_days = 1,
  org_todo_keywords = {'TODO(t)', 'WAITING(w)', 'DOING(i)', '|', 'DONE(d)', 'ICEBOX(x)'},


  notifications = {
    enabled = true,
    cron_enabled = true,
    repeater_reminder_time = false,
    deadline_warning_reminder_time = false,
    reminder_time = 10,
    deadline_reminder = true,
    scheduled_reminder = true,
    notifier = function(tasks)
      local result = {}
      for _, task in ipairs(tasks) do
        require('orgmode.utils').concat(result, {
          string.format('# %s (%s)', task.category, task.humanized_duration),
          string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
          string.format('%s: <%s>', task.type, task.time:to_string())
        })
      end
      -- if not vim.tbl_isempty(result) then
      --   require('orgmode.notifications.notification_popup'):new({ content = result })
      -- end
      if not vim.tbl_isempty(result) then
        require("noice").notify(result, "info", {
          title = "orgmode"
        })
      end
    end,
    cron_notifier = function(tasks)
      for _, task in ipairs(tasks) do
        local title = string.format('%s (%s)', task.category, task.humanized_duration)
        local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
        local date = string.format('%s: %s', task.type, task.time:to_string())
        -- MacOS
        if vim.fn.executable('terminal-notifier') == 1 then
          vim.loop.spawn('terminal-notifier', { args = { '-title', title, '-subtitle', subtitle, '-message', date }})
        end
      end
    end
  },
})


local set_map = function (key, cmd) 
    vim.api.nvim_set_keymap(
        '',
        key,
        cmd,
        {}
    )
end

-- F11 to open the TODO agenda in a tab
set_map("<F11>", ":tabedit ~/org/agenda/TODO.org <cr>")
