local lsp_cfg = require("plug_cfgs.nvim_lsp_server")


require('go').setup({
  goimport = 'gopls',        -- goimport command, can be gopls[default] or goimport
  gofmt = 'gopls',           --gofmt cmd,
  max_line_len = 120,        -- max line length in goline format
  tag_transform = false,     -- tag_transfer  check gomodifytags for details
  test_template = '',        -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
  test_template_dir = '',    -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
  comment_placeholder = 'ﳑ', -- comment_placeholder your cool placeholder e.g.      
  icons = { breakpoint = '', currentpos = '🏃' },
  verbose = false,           -- output loginf in messages
  log_path = "/tmp/x-ray_go.log",
  lsp_cfg = {
    capabilities = lsp_cfg.capabilities,
    handlers = lsp_cfg.handlers,
    settings = {
      gopls = {
        directoryFilters = {
          "-**/protobuf/go/",
          "-protobuf/go",
        },
        -- see https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
        analyses = {
          shadow = false,
        }
      }
    }
  },                                 -- true: apply go.nvim non-default gopls setup, if it is a list, will merge with gopls setup e.g.
  -- lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
  lsp_gofumpt = false,               -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = lsp_cfg.on_attach, -- if a on_attach function provided:  attach on_attach function to gopls
  -- true: will use go.nvim on_attach if true
  -- nil/false do nothing
  lsp_fmt_async = true,
  diagnostic = { -- set diagnostic to false to disable vim.diagnostic setup
    hdlr = true, -- hook lsp diag handler
    underline = false,
    -- virtual text setup
    virtual_text = { space = 4, prefix = '■' },
    signs = true,
    update_in_insert = false,
  },
  lsp_codelens = true, -- set to false to disable codelens, true by default
  lsp_diag_update_in_insert = false,
  lsp_inlay_hints = {
    enable = true,
    -- Only show inlay hints for the current line
    only_current_line = true,
    -- Event which triggers a refersh of the inlay hints.
    -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
    -- not that this may cause higher CPU usage.
    -- This option is only respected when only_current_line and
    -- autoSetHints both are true.
    only_current_line_autocmd = "CursorHold",
    -- whether to show variable name before type hints with the inlay hints or not
    -- default: false
    show_variable_name = false,
    -- prefix for parameter hints
    parameter_hints_prefix = "ƒ ",
    show_parameter_hints = true,
    -- prefix for all the other hints (type, chaining)
    other_hints_prefix = "=> ",
    -- whether to align to the lenght of the longest line in the file
    max_len_align = false,
    -- padding from the left if max_len_align is true
    max_len_align_padding = 1,
    -- whether to align to the extreme right or not
    right_align = false,
    -- padding from the right if right_align is true
    right_align_padding = 6,
    -- The color of the hints
    highlight = "Comment",
  },

  luasnip = true,                                      -- set true to enable included luasnip
  gopls_remote_auto = false,                             -- add -remote=auto to gopls
  gopls_cmd = { vim.env.GOBIN .. "/gopls", "-logfile", "/tmp/gopls.log" }, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
  fillstruct = 'gopls',                                                    -- can be nil (use fillstruct, slower) and gopls

  dap_debug = true,                                                        -- set to false to disable dap
  --float term recommand if you use richgo/ginkgo with terminal color
  dap_debug_keymap = true,                                                 -- set keymaps for debugger
  dap_debug_gui = true,                                                    -- set to tru to enable dap gui, highly recommand
  dap_debug_vt = true,                                                     -- set to true to enable dap virtual text
  dap_retries = 20,
  dap_timeout = 15,                                                        --  see dap option initialize_timeout_sec = 15,
  dap_port = 38697,


  run_in_floaterm = false, -- set to true to run in float window.
  textobjects = true,      -- enable default text jobects through treesittter-text-objects
  test_runner = 'go',      -- richgo, go test, richgo, dlv, ginkgo
  build_tags = "kyc"       -- set default build tags
})

local function setTimeout(callback, ms)
  local timer = uv.new_timer()
  timer:start(ms, 0, function()
    timer:close()
    callback()
  end)
  return timer
end

-- Format/GoImport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    -- local promise = require('promise')
    -- promise(function(resolve, reject)
    require('go.format').goimport()
    --
    -- vim.lsp.buf.format { async = true }
  end,
  group = format_sync_grp,
})

-- local lsp_installer_servers = require'nvim-lsp-installer.servers'
-- local server_available, requested_server = lsp_installer_servers.get_server("gopls")
-- if server_available then
--     requested_server:on_ready(function ()
--         local opts = require'go.lsp'.config() -- config() return the go.nvim gopls setup
--         requested_server:setup(opts)
--     end)
--     if not requested_server:is_installed() then
--         -- Queue the server to be installed
--         requested_server:install()
--     end
-- end
--
