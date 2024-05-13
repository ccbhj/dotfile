-- Setup nvim-cmp.
local cmp = require 'cmp'
local compare = require('cmp.config.compare')
local types = require('cmp.types')
local luasnip = require 'luasnip'

local WIDE_HEIGHT = 40

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


cmp.setup({
  performance = {
    async_budget            = 100,
    throttle                = 20,
    debounce                = 20,
    fetching_timeout        = 20,
    confirm_resolve_timeout = 20,
    max_view_entries        = 20,
  },
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

      -- For `luasnip` user.
      require('luasnip').lsp_expand(args.body)
      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

  preselect = types.cmp.PreselectMode.None,

  window = {
  },
  -- confirmation = {
  --   default_behavior = types.cmp.ConfirmBehavior.Insert,
  --   get_commit_characters = function(commit_characters)
  --     return commit_characters
  --   end,
  -- },

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
  },
  sources = {
    { name = 'nvim_lsp', },

    { name = 'path' },
    { name = 'cmdline' },

    -- For vsnip user.
    -- { name = 'vsnip' },

    -- For luasnip user.
    { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },

    { name = 'buffer' },
    { name = 'cmdline' }
  }
})

require 'cmp'.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
