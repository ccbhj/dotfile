require('packer').init({
  -- snapshot = nil, -- Name of the snapshot you would like to load at startup
  -- snapshot_path = "/Users/bingjia.chen/dotfile/nvim/packer.snapshot"
})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'AndrewRadev/splitjoin.vim'
  use 'jiangmiao/auto-pairs'
  -- use 'mdempsky/gocode' { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh', 'for': 'go'}
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use {
    'plasticboy/vim-markdown',
    ft = { 'md' },
  }
  use {
    'instant-markdown/vim-instant-markdown',
    ft = { 'md' },
    run = 'yarn install'
  }
  -- use {
  --   'nvim-lualine/lualine.nvim',
  --   requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  -- }
  use 'itchyny/lightline.vim'

  --  use {
  --    'liuchengxu/vista.vim',
  --    opt = true,
  --  }
  use 'simrat39/symbols-outline.nvim'
  use 'stevearc/aerial.nvim'
  use 'preservim/tagbar'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'cespare/vim-toml'

  -- use 'olimorris/onedarkpro.nvim'

  use 'vim-scripts/AnsiEsc.vim'
  use 'rafamadriz/friendly-snippets'


  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'ray-x/guihua.lua'
  use 'mfussenegger/nvim-dap-python'


  use 'ray-x/lsp_signature.nvim'
  use 'BurntSushi/ripgrep'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }
  use 'matveyt/neoclip'
  use 'nvim-telescope/telescope-project.nvim'
  use 'tom-anders/telescope-vim-bookmarks.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'AckslD/nvim-neoclip.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'mortepau/codicons.nvim'
  use 'MattesGroeger/vim-bookmarks'
  use 'akinsho/toggleterm.nvim'
  use 'folke/twilight.nvim'

  use 'sindrets/diffview.nvim'


  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use 'neovim/nvim-lspconfig'

  use 'onsails/lspkind.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'ray-x/cmp-treesitter'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'petertriho/cmp-git'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'quangnguyen30192/cmp-nvim-tags'


  use 'kyazdani42/nvim-tree.lua'
  use 'lewis6991/gitsigns.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'Wansmer/treesj'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'romgrk/nvim-treesitter-context'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'p00f/nvim-ts-rainbow'
  use 'windwp/nvim-autopairs'

  use 'voldikss/vim-translator'
  use 'ray-x/go.nvim'
  use 'simrat39/rust-tools.nvim'

  use 'catppuccin/nvim'
  use 'akinsho/bufferline.nvim'
  use "jbyuki/venn.nvim"
  use 'nvim-orgmode/orgmode'

  use "folke/which-key.nvim"
  use 'willchao612/vim-diagon'

  use {
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
    }
  }

  use { "stevearc/oil.nvim"}
  use "LunarVim/bigfile.nvim"

  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

end)
