local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "tpope/vim-commentary" -- Comment lines
  use "tpope/vim-surround" -- Add, change and delete surrounding text
  use "tpope/vim-sleuth" -- Indent autodetection
  use "tpope/vim-repeat" -- Allow command repeat
  use('tpope/vim-unimpaired') -- Pairs of handy bracket mappings, like [b and ]b.
  use "sheerun/vim-polyglot" -- Add more Language
  use "christoomey/vim-tmux-navigator" -- Navigate seamlessly between Vim windows and Tmux panes
  use "farmergreg/vim-lastplace" -- Jump to the last location when opening a file
  use "nelstrom/vim-visual-star-search" -- Enables * search on selected text.
  use "jessarcher/vim-heritage" -- Creates parent dirs on save.

  -- Automatically add closing brackets
  -- use {"windwp/nvim-autopairs", config = function ()
  --     require("nvim-autopairs").setup()
  --   end,
  -- }
  
  -- Add smoth scrolling
  use {"karb94/neoscroll.nvim", config = function ()
      require("neoscroll").setup()
    end,
  }

  -- Add indent when pasting
  use {"sickill/vim-pasta", config = function ()
      vim.g.pasta_disabled_filetypes = {"fuitive"}
    end,
  }

  -- Colorschemes
  use {"folke/tokyonight.nvim",
    config = function()
      vim.cmd("colorscheme tokyonight-night")

      vim.api.nvim_set_hl(0, 'StatusLineNonText', {
      fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
      bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
    })

    vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
    end,
  }
  -- cmp plugins
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
    },
    config = function()
      require('user/plugins/cmp')
    end,
  })

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
   use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
  },
  config = function()
    require('user/plugins/lspconfig')
  end,
})

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-live-grep-args.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      require('user/plugins/telescope')
    end,
  }) 

  -- File tree sidebar
  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user/plugins/file-tree')
    end,
  })

  -- A Status line.
  use({
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user/plugins/lualine')
    end,
  })

  -- Display buffers as tabs.
  use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    after = 'tokyonight.nvim',
    config = function()
      require('user/plugins/bufferline')
    end,
  })

  -- Display indentation lines.
  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('user/plugins/indent-blankline')
    end,
  })

-- Add a dashboard.
use({
  'glepnir/dashboard-nvim',
  config = function()
    require('user/plugins/dashboard-nvim')
  end,
})

  -- Floating terminal.
  use({
    'voldikss/vim-floaterm',
    config = function()
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.keymap.set('n', '<F1>', ':FloatermToggle<CR>')
      vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
      vim.cmd([[
        highlight link Floaterm CursorLine
        highlight link FloatermBorder CursorLineBg
      ]])
    end
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
