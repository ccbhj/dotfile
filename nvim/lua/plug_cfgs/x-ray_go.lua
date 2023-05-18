local on_attach = function(client, bufnr)

  local opts = { noremap = true, silent = true}

  vim.keymap.set('n', '<space>e',  vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<space>q',  vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  -- Mappings.
  local opts = { noremap = true, silent = true, buffer = bufnr }
  -- telescope

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>M', vim.lsp.buf.formatting, opts)
  vim.keymap.set('n', '<C-k>',     vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

  -- Set some keybinds conditional on server capabilities
  vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, opts)

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --
  require("nvim-navbuddy").attach(client, bufnr)
end
--
-- Go-to definition in a split window
local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command("copen")
        api.nvim_command("wincmd p")
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end


local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" }
}

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  ["textDocument/definition"] = goto_definition('split'),
}

require('go').setup({
  goimport='gopls', -- goimport command, can be gopls[default] or goimport
  gofmt = 'gopls', --gofmt cmd,
  max_line_len = 120, -- max line length in goline format
  tag_transform = false, -- tag_transfer  check gomodifytags for details
  test_template = '', -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
  test_template_dir = '', -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
  comment_placeholder = 'ﳑ' ,  -- comment_placeholder your cool placeholder e.g.        
  icons = {breakpoint = '', currentpos = '🏃'},
  verbose = false,  -- output loginf in messages
  lsp_cfg = {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    handlers = handlers,
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
  }, -- true: apply go.nvim non-default gopls setup, if it is a list, will merge with gopls setup e.g.
                   -- lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
  lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = on_attach, -- if a on_attach function provided:  attach on_attach function to gopls
                       -- true: will use go.nvim on_attach if true
                       -- nil/false do nothing
  lsp_codelens = true, -- set to false to disable codelens, true by default
  lsp_diag_hdlr = true, -- hook lsp diag handler
  lsp_diag_underline = true,
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
    parameter_hints_prefix = " ",
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

  gopls_remote_auto = true, -- add -remote=auto to gopls
  gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
  fillstruct = 'gopls', -- can be nil (use fillstruct, slower) and gopls

  dap_debug = true, -- set to false to disable dap
  --float term recommand if you use richgo/ginkgo with terminal color
  dap_debug_keymap = true, -- set keymaps for debugger
  dap_debug_gui = true, -- set to tru to enable dap gui, highly recommand
  dap_debug_vt = true, -- set to true to enable dap virtual text
  dap_retries = 20,
  dap_timeout = 15, --  see dap option initialize_timeout_sec = 15,
  dap_port = 38697,


  run_in_floaterm = false, -- set to true to run in float window.
  textobjects = true, -- enable default text jobects through treesittter-text-objects
  test_runner = 'go', -- richgo, go test, richgo, dlv, ginkgo
  build_tags = "" -- set default build tags
})

-- Format/GoImport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

vim.cmd("autocmd FileType go nmap <Leader><Leader>l GoLint")
vim.cmd("autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()")


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
