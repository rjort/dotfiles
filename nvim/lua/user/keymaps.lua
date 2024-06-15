local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

-- leader
vim.g.mapleader = ';'

-- save with crtl+s
keymap('n', '<C-s>', ':w<CR>', {noremap = true})

-- move text with J and K
keymap('x', 'J', ":move '>+1gv-gv", opts)
keymap('x', 'K', ":move '<-2gv-gv", opts)

-- copy relative path with F4
keymap('n', '<F4>', ':let @+ = fnamemodify(expand("%"), ":~:.")<CR>', opts)

-- improve navigations in nvim windows with ctrl + nvim navigation keys
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- insert mode go to normal mode with jk
keymap('i', 'jk', '<ESC>', opts)

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
vim.keymap.set('n', '<leader>gf', builtin.git_files, opts)

-- nvim-tree
vim.keymap.set('n', '<leader>tr', ':NvimTreeToggle<CR>', opts)

-- bbye
keymap('n', '<leader>ww', ':Bdelete<CR>', opts)

-- bufferline
keymap('n', '<leader>1', ':BufferLineGoToBuffer1<CR>', opts)
keymap('n', '<leader>2', ':BufferLineGoToBuffer2<CR>', opts)
keymap('n', '<leader>3', ':BufferLineGoToBuffer3<CR>', opts)
keymap('n', '<leader>4', ':BufferLineGoToBuffer4<CR>', opts)
keymap('n', ']b', ':BufferLineCycleNext<CR>', opts)
keymap('n', 'b]', ':BufferLineCyclePrev<CR>', opts)
