require("user.telescope_config.keymaps")
require("user.keymaps.diagnostics")
require("user.keymaps.functions")
require("user.keymaps.persist")
local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc, noremap = true, silent = true })
end


-- [[ Basic Keymaps ]]
-- A shortcut for the :Format command
vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, { silent = true })
local function open_sidebar()
  local manager = require("neo-tree.sources.manager")
  local renderer = require("neo-tree.ui.renderer")

  local state = manager.get_state("filesystem")
  local window_exists = renderer.window_exists(state)

   if  window_exists == false  then
     vim.cmd("only")
   end
   vim.cmd("Neotree right toggle")
end
vim.keymap.set('n', '<Leader>b', open_sidebar, { silent = true })
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- greatest remap ever


vim.keymap.set('n', '<leader>ob', ':only<CR>', {})


vim.keymap.set('n', ']q', ':cnext<CR>', { silent = true, desc = "Jump forward" })
vim.keymap.set('n', '[q', ':cprevious<CR>', { silent = true, desc = "Jump back" })
vim.keymap.set('n', ']b', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '[b', ':bprevious<CR>', { silent = true })

vim.keymap.set('n', '<F2>', 'win_gettype() ==# "quickfix" ? ":cclose<CR>" : ":copen<CR>"',
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
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'zp', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.fn.CocActionAsync('definitionHover') -- coc.nvim
        vim.lsp.buf.hover()
    end
end)
vim.keymap.set('n', '<Leader>sf', '<Plug>CtrlSFPrompt', {})
vim.keymap.set('v', '<Leader>sf', '<Plug>CtrlSFVwordPath', {})
vim.keymap.set('v', '<Leader>F', '<Plug>CtrlSFVwordExec', {})
vim.keymap.set('n', '<Leader>sp', '<Plug>CtrlSFCwordPath<CR>', {})
vim.keymap.set('n', '<Leader>so', ':CtrlSFOpen<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>st', ':CtrlSFToggle<CR>', { noremap = true, silent = true })
-- vim.keymap.set('i', '<Leader>ft', '<Esc>:CtrlSFToggle<CR>', { noremap = true, silent = true })


vim.keymap.set('n', '<C-w>|', ":vertical split right<CR>", { silent = true, noremap = true, desc = "vertical split" })
vim.keymap.set('n', '<C-w>_', ":split<CR>", { silent = true, noremap = true, desc = "horzontal split" })
-- max out vetical split
vim.keymap.set('n', '<C-w><Right>', ":vertical resize<CR>", { silent = true, noremap = true, desc = "vertical resize" })
vim.keymap.set('n', 'gl', ":vertical wincmd L<CR>", { silent = true, noremap = true, desc = "Put buffer on the right" })
-- max out horizontal split
vim.keymap.set('n', '<C-w><Down>', ":resize<CR>", { silent = true, noremap = true, desc = "horizontal resize" })

local chatgpt = {
    h = { "<cmd>ChatGPT<CR>", "ChatGPT" },
    e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
    g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
    t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
    k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
    d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
    u = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
    o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
    s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
    f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
    x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
    r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
    l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
  },
-- convert the 'c' table above to use the vim.keymap.set() function

vim.keymap.set('n', '<leader>ch', ':ChatGPT<CR>', { silent = true })
vim.keymap.set('n', '<leader>ce', ':ChatGPTEditWithInstruction<CR>', { silent = true })
vim.keymap.set('n', '<leader>cg', ':ChatGPTRun grammar_correction<CR>', { silent = true })
vim.keymap.set('n', '<leader>ct', ':ChatGPTRun translate<CR>', { silent = true })
vim.keymap.set('n', '<leader>ck', ':ChatGPTRun keywords<CR>', { silent = true })
vim.keymap.set('n', '<leader>cd', ':ChatGPTRun docstring<CR>', { silent = true })
vim.keymap.set('n', '<leader>cu', ':ChatGPTRun add_tests<CR>', { silent = true })
vim.keymap.set('n', '<leader>co', ':ChatGPTRun optimize_code<CR>', { silent = true })
vim.keymap.set('n', '<leader>cs', ':ChatGPTRun summarize<CR>', { silent = true })
vim.keymap.set('n', '<leader>cf', ':ChatGPTRun fix_bugs<CR>', { silent = true })
vim.keymap.set('n', '<leader>cx', ':ChatGPTRun explain_code<CR>', { silent = true })
vim.keymap.set('n', '<leader>cr', ':ChatGPTRun roxygen_edit<CR>', { silent = true })
vim.keymap.set('n', '<leader>cl', ':ChatGPTRun code_readability_analysis<CR>', { silent = true })

vim.keymap.set('n', '<leader>q', ':bw<CR>', { desc = "Exit a buffer" })
vim.keymap.set('n', '<C-q>', ':qa<CR>', { desc = "Exit Neovim" })
nmap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

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


