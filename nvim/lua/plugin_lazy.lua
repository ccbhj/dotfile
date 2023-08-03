local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

  'wbthomason/packer.nvim',

  'AndrewRadev/splitjoin.vim',
  'jiangmiao/auto-pairs',
  --  'mdempsky/gocode' { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh', 'for': 'go'}
  -- 'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-fugitive',

  {'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async'},
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" }, 
    cmd = "MarkdownPreview",
  },

  --
  --  {
  --   'nvim-lualine/lualine.nvim',
  --   requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  -- }
  'itchyny/lightline.vim',

  --   {
  --    'liuchengxu/vista.vim',
  --    opt = true,
  --  }
  {
    'simrat39/symbols-outline.nvim',
    cmd = "SymbolsOutline",
  },
  -- 'stevearc/aerial.nvim',
  -- 'preservim/tagbar',
  'lukas-reineke/indent-blankline.nvim',
  -- 'cespare/vim-toml',

  --  'olimorris/onedarkpro.nvim'

  {
    'vim-scripts/AnsiEsc.vim',
    cmd = "AnsiEsc",
  },

  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  'theHamsta/nvim-dap-virtual-text',
  'ray-x/guihua.lua',
  'mfussenegger/nvim-dap-python',


  'ray-x/lsp_signature.nvim',
  'BurntSushi/ripgrep',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  'matveyt/neoclip',
  'nvim-telescope/telescope-project.nvim',
  'tom-anders/telescope-vim-bookmarks.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
  'AckslD/nvim-neoclip.lua',
  'kyazdani42/nvim-web-devicons',
  'mortepau/codicons.nvim',
  'MattesGroeger/vim-bookmarks',
  'akinsho/toggleterm.nvim',
  'folke/twilight.nvim',

  'sindrets/diffview.nvim',


  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  'neovim/nvim-lspconfig',

  {
   'L3MON4D3/LuaSnip',
   lazy = false,
   dependencies = {
    -- 'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
    'quangnguyen30192/cmp-nvim-tags',
    'onsails/lspkind.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'ray-x/cmp-treesitter',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'petertriho/cmp-git',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
  }
},


  'kyazdani42/nvim-tree.lua',
  'lewis6991/gitsigns.nvim',

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  'Wansmer/treesj',
  'nvim-treesitter/nvim-treesitter-refactor',
  'romgrk/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'p00f/nvim-ts-rainbow',
  'windwp/nvim-autopairs',

  {
    'voldikss/vim-translator',
    cmd = {"Translate", "TranslateH", "TranslateL", "TranslateW", "TranslateR", "TranslateX"}
  },

  
  {
    'ray-x/go.nvim',
    ft = {"go", "gomod"},
    dependencies = {
      { 'kevinhwang91/promise-async'},
    }
  },

  {
    'simrat39/rust-tools.nvim',
    ft = {"rust"},
  },

  'catppuccin/nvim',
  'akinsho/bufferline.nvim',
  "jbyuki/venn.nvim",
  {'nvim-orgmode/orgmode', ft = {"org"}},

  "folke/which-key.nvim",
  'willchao612/vim-diagon',

  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
    }
  },

  { "stevearc/oil.nvim"},
  "LunarVim/bigfile.nvim",

  { 'michaelb/sniprun', build = 'sh ./install.sh', cmd = "SnipRun"},
  {
    "folke/flash.nvim",
    event = "VeryLazy",
  }
}

local opts = {

}

require("lazy").setup(plugins, opts)
