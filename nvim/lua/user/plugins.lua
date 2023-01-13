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
  -- use "tpope/vim-sleuth" -- Indent autodetection
  use "tpope/vim-repeat" -- Allow command repeat
  use "sheerun/vim-polyglot" -- Add more Language
  use "christoomey/vim-tmux-navigator" -- Navigate seamlessly between Vim windows and Tmux panes
  use "farmergreg/vim-lastplace" -- Jump to the last location when opening a file
  use "nelstrom/vim-visual-star-search" -- Enables * search on selected text.
  use "jessarcher/vim-heritage" -- Creates parent dirs on save.

  -- Automatically add closing brackets
  use {"windwp/nvim-autopairs", config = function ()
      require("nvim-autopairs").setup()
    end,
  }

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

  --use "kyazdani42/nvim-web-devicons"
  --use "kyazdani42/nvim-tree.lua"
  --use "akinsho/bufferline.nvim"
  --use "moll/vim-bbye"
  --use "nvim-lualine/lualine.nvim"
  --use "akinsho/toggleterm.nvim"
  --use "ahmedkhalf/project.nvim"
  --use "lewis6991/impatient.nvim"
  --use "lukas-reineke/indent-blankline.nvim"
  --use "goolord/alpha-nvim"
  --use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  --use "folke/which-key.nvim"

  -- Colorschemes
  -- use {"jessarcher/onedark.nvim",
  --   config = function()
  --     vim.cmd("colorscheme onedark")
  --   end,
  -- }
  use {"folke/tokyonight.nvim",
    config = function()
      vim.cmd("colorscheme tokyonight-night")
    end,
  }
  -- cmp plugins
  -- use "hrsh7th/nvim-cmp"
  -- use {"hrsh7th/cmp-buffer", requires = { "hrsh7th/nvim-cmp" }} -- buffer completions
  -- use {"hrsh7th/cmp-path", requires = { "hrsh7th/nvim-cmp" }} -- path completions
  -- use {"hrsh7th/cmp-cmdline", requires = { "hrsh7th/nvim-cmp" }} -- cmdline completions
  -- use {"saadparwaiz1/cmp_luasnip", requires = { "hrsh7th/nvim-cmp" }} -- snippet completions
  -- use {"hrsh7th/cmp-nvim-lsp", requires = { "hrsh7th/nvim-cmp" }}
  -- use {"hrsh7th/cmp-nvim-lua", requires = { "hrsh7th/nvim-cmp" }}

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  ---- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  ---- Telescope
  use "nvim-telescope/telescope.nvim"

  ---- Treesitter
  --use {
  --  "nvim-treesitter/nvim-treesitter",
  --  run = ":TSUpdate",
  --}
  --use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  --use "lewis6991/gitsigns.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
