lua << EOF

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
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader><", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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

-- config that activates keymaps and enables snippet support
EOF

nnoremap <silent> gr :lua require'telescope.builtin'.lsp_references()<cr>
nnoremap <silent> gd  :<C-u>:Telescope lsp_definitions theme=dropdown<cr>
nnoremap <silent> gy  :<C-u>:Telescope lsp_type_definitions<cr>
" nnoremap <silent> gr  :<C-u>:Telescope lsp_references theme=dropdown<cr>
nnoremap <silent> gi  :<C-u>:Telescope lsp_implementations<cr>

nnoremap <silent> <space>s  :<C-u>:Telescope lsp_document_symbols<cr>
nnoremap <space>S  :Telescope lsp_workspace_symbols query=
nnoremap <silent> <space>d  :<C-u>:Telescope diagnostics bufnr=0<cr>
nnoremap <silent> <space>D  :<C-u>:Telescope lsp_workspace_diagnostics<cr>
nnoremap <silent> K  :<C-u>:lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>rn  :<C-u>:lua vim.lsp.buf.rename()<CR>

nnoremap <silent> [d  :<C-u>:lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d  :<C-u>:lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>M  :<C-u>:lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <C-k> :<C-u>:lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <space>wa :<C-u>:lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> <space>wr :<C-u>:lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <silent> <space>ca :<C-u>:Telescope lsp_code_actions<CR>
nnoremap <silent> <space>e :<C-u>:lua vim.lsp.diagnostic.open_float()<CR>
nnoremap <silent> <space>q :<C-u>:lua vim.lsp.diagnostic.setloclist()<CR>
nnoremap <silent> <leader>> :<C-u>:lua vim.lsp.buf.formatting()<CR> 
nnoremap <silent> <leader>< :<C-u>:lua vim.lsp.buf.range_formatting()<CR> 
