local opt = vim.opt

-- Autocommand that reloads neovim whenever you save the options.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost options.lua source <afile> 
  augroup end
]]

-- Tab settings
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.smartindent = true

opt.number = true
opt.relativenumber = true

opt.wildmode= 'longest:full,full'
opt.completeopt = 'menuone,longest,preview'

opt.title = true

opt.termguicolors = true

opt.spell = true

opt.ignorecase = true
opt.smartcase = true

opt.list = true -- enable the below listchars
opt.listchars = { tab = '▸ ', trail = '·' }
opt.fillchars:append({ eob = ' ' })

opt.splitbelow = true
opt.splitright = true

opt.scrolloff = 10
opt.sidescrolloff = 10

opt.confirm = true

opt.undofile = true
