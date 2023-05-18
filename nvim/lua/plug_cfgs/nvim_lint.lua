-- require('lint').linters_by_ft = {
--   go = {'golangcilint'}
-- }
-- 
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

-- config diagnostic display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  -- underline = {
  --   severity = vim.diagnostic.severity.ERROR,
  -- },
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
