local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end


  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- telescope
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  
  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.server_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader><", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

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
end


local set_nmap = function (key, cmd) 
    vim.api.nvim_set_keymap(
        'n',
        key,
        cmd,
        {}
    )
end


set_nmap('K', ":lua vim.lsp.buf.hover()<CR>")
set_nmap('<leader>rn', ":lua vim.lsp.buf.rename()<CR>")
set_nmap('[d', ":lua vim.diagnostic.goto_prev()<CR>")
set_nmap(']d', ":lua vim.diagnostic.goto_next()<CR>")
set_nmap('<leader>M', ":lua vim.lsp.buf.formatting()<CR>")
set_nmap('<C-k>', ":lua vim.lsp.buf.signature_help()<CR>")
set_nmap('<space>wa', ":lua vim.lsp.buf.add_workspace_folder()<CR>")
set_nmap('<space>wr', ":lua vim.lsp.buf.remove_workspace_folder()<CR>")
set_nmap('<space>ca', ":Telescope lsp_code_actions<CR>")
set_nmap('<space>e', ":<C-u>:lua vim.lsp.diagnostic.get_line_diagnostics()<CR>")
set_nmap('<space>q', ":<C-u>:lua vim.lsp.diagnostic.setloclist()<CR>")
set_nmap('<leader>>', ":<C-u>:lua vim.lsp.diagnostic.formatting()<CR>")
set_nmap('<leader><', ":<C-u>:lua vim.lsp.diagnostic.range_formatting()<CR>")
