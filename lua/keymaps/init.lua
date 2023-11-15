require("telescope_config.keymaps")
require("keymaps.diagnostics")
require("keymaps.functions")
require("keymaps.persist")
local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc, noremap = true, silent = true })
end
-- [[ Basic Keymaps ]]
-- A shortcut for the :Format command
vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, { silent = true })
vim.keymap.set('n', '<Leader>b', ':Neotree float toggle<CR>', { silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
local function cnext_wrap()
  local qflist = vim.fn.getqflist()
  local qfindex = vim.fn.getqflist({ idx = 0 }).idx
  if #qflist > 0 and qfindex < #qflist then
    vim.cmd('cnext')
  end
end

local function cprev_wrap()
  local qflist = vim.fn.getqflist()
  local qfindex = vim.fn.getqflist({ idx = 0 }).idx
  if #qflist > 0 and qfindex > 1 then
    vim.cmd('cprevious')
  end
end

vim.keymap.set('n', '<C-k>', cnext_wrap, { silent = true, desc = "Jump forward" })
vim.keymap.set('n', '<C-j>', cprev_wrap, { silent = true, desc = "Jump back" })
vim.keymap.set('n', '<C-c>', 'win_gettype() ==# "quickfix" ? ":cclose<CR>" : ":copen<CR>"',
  { expr = true, silent = true })

-- Telescope keymaps
vim.keymap.set('n', '<Leader>Tk', ':Telescope keymaps<CR>', { silent = true })
-- nmap( "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })

local keymap = vim.keymap.set
-- create a shortcut to :ToggleTerm
nmap('<leader>t', "<cmd>Lspsaga term_toggle<CR>", 'Toggle terminal')

-- Install CtrlSF plugin with the 'lazy' package manager

-- CtrlSF key mappings


vim.keymap.set('n', '<Leader>sf', '<Plug>CtrlSFPrompt', {})
vim.keymap.set('v', '<Leader>sf', '<Plug>CtrlSFVwordPath', {})
vim.keymap.set('v', '<Leader>F', '<Plug>CtrlSFVwordExec', {})
vim.keymap.set('n', '<Leader>sn', '<Plug>CtrlSFCwordPath', {})
vim.keymap.set('n', '<Leader>sp', '<Plug>CtrlSFPwordPath', {})
vim.keymap.set('n', '<Leader>so', ':CtrlSFOpen<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>st', ':CtrlSFToggle<CR>', { noremap = true, silent = true })
-- vim.keymap.set('i', '<Leader>ft', '<Esc>:CtrlSFToggle<CR>', { noremap = true, silent = true })



nmap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
nmap("<C-l>", ":bnext<CR>")
nmap("<C-h>", ":bprevious<CR>")

nmap("<leader>z", ":qa<CR>", { silent = true })
-- Remap for dealing with word wrap

local function source()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":source ~/.config/nvim/lua/", true, false, true), "n", true)
end


vim.keymap.set('n', '<S-s>', source, { silent = true })

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
