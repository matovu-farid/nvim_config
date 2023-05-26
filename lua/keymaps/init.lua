require("telescope_config.keymaps")
require("keymaps.diagnostics")
require("keymaps.functions")
require("keymaps.persist")

-- [[ Basic Keymaps ]]
-- A shortcut for the :Format command
vim.keymap.set('n', '<Leader>lf', ':Format<CR>', { silent = true })
vim.keymap.set('n', '<Leader>b', ':Neotree toggle filesystem right <CR>', { silent = true })
vim.keymap.set('n', '<Leader>x', ':so ~/.config/nvim/init.lua',{})

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<C-k>", ":cnext<CR>")
vim.keymap.set("n", "<C-j>", ":cprevious<CR>")
vim.keymap.set('n', '<Leader>c', 'win_gettype() ==# "quickfix" ? ":cclose<CR>" : ":copen<CR>"', { expr = true, silent = true })

vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-l>", ":bnext<CR>")
vim.keymap.set("n", "<C-h>", ":bprevious<CR>")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


vim.keymap.set('n', '<C-Space>', 'a<C-Space>', { noremap = true, silent = true })
