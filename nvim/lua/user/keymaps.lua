local opts = { noremap = true, silent = true }

local map = vim.keymap.set

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------------------------------------------------

-- Normal --

-- Change splits
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
map("n", "<S-k>", ":resize -2<CR>", opts)
map("n", "<S-j>", ":resize +2<CR>", opts)
map("n", "<S-h>", ":vertical resize -2<CR>", opts)
map("n", "<S-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<leader>l", ":bnext<CR>", opts)
map("n", "<leader>h", ":bprevious<CR>", opts)

-- When text is wrapped move by terminal row
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection
vim.keymap.set('v', 'y', 'myy`y')

vim.keymap.set('n', 'q;', ';q')

-- map("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)

vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>')

-------------------------------------------------------

-- Insert --

-- Press jk to exit
map("i", "jk", "<ESC>", opts)

-- Add ; or , at the end of the line
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-------------------------------------------------------

-- Visual --

-- Paste replace visual selection without copying it
vim.keymap.set('v', 'p', '"_dp')

-- Move text up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv")
