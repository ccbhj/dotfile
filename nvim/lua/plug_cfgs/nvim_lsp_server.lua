  -- For example, a handler override for the `rust_analyzer`:
require("mason").setup({
  providers = {
    "mason.providers.client",
    "mason.providers.registry-api",
  },

  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- config for hover because of the ColorScheme
vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1c1e24]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1c1e24]]

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

-- config diagnostic display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = {
    severity = vim.diagnostic.severity.ERROR,
  },
  update_in_insert = false,
  severity_sort = false,
  float = {
    source = "always",  -- Or "if_many"
  },
})

local signs = { Error = "", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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


local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  ["textDocument/definition"] = goto_definition('split'),
}

require('vim.lsp.protocol').CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '了', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

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
  require('nvim-navbuddy').attach(client, bufnr)

end

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.

  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      handlers = handlers,
      on_attach = on_attach,
    }
  end,
}

-- local util = require('lspconfig/util')
-- local lastRootPath = nil
-- local gopath = os.getenv("GOPATH")
-- if gopath == nil then
--   gopath = ""
-- end
-- local gopathmod = gopath..'/pkg/mod'

-- require('lspconfig')['gopls'].setup{
--   root_dir = function(fname)
--     local fullpath = vim.fn.expand(fname, ':p')
--     if string.find(fullpath, gopathmod) and lastRootPath ~= nil then
--         return lastRootPath
--     end
--     lastRootPath = util.root_pattern("go.mod", ".git")(fname)
--     return lastRootPath
--   end,
--   capabilities = require('cmp_nvim_lsp').default_capabilities(),
--   handlers = handlers,
--   on_attach = on_attach,
-- }
