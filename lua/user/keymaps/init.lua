require("user.telescope_config.keymaps")
require("user.keymaps.diagnostics")
require("user.keymaps.functions")
require("user.keymaps.persist")
local wk = require("which-key")

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

  if window_exists == false then
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

-- Install CtrlSF plugin with the 'lazy' package manager

-- CtrlSF key mappings
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself


vim.keymap.set('n', '<C-w>|', ":vertical split right<CR>", { silent = true, noremap = true, desc = "vertical split" })
vim.keymap.set('n', '<C-w>_', ":split<CR>", { silent = true, noremap = true, desc = "horzontal split" })
-- max out vetical split
vim.keymap.set('n', '<C-w><Right>', ":vertical resize<CR>", { silent = true, noremap = true, desc = "vertical resize" })
vim.keymap.set('n', 'gl', ":vertical wincmd L<CR>", { silent = true, noremap = true, desc = "Put buffer on the right" })
-- max out horizontal split
vim.keymap.set('n', '<C-w><Down>', ":resize<CR>", { silent = true, noremap = true, desc = "horizontal resize" })




vim.keymap.set('n', '<leader>q', ':bw<CR>', { desc = "Exit a buffer" })
vim.keymap.set('n', '<leader>z', ':wall | qa<CR>', { desc = "Exit a Neovim" })
nmap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.api.nvim_create_augroup("keymap_autocmds", {
  clear = false
})
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

vim.keymap.set('n', "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, desc = 'diagnostic jump prev' })
vim.keymap.set('n', "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, desc = 'diagnostic jump next' })

-- Diagnostic jump with filters such as only jumping to an error
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, desc = 'diagnostic jump prev' })
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true, desc = 'diagnostic jump next' })
vim.keymap.set('n', '<leader>rn', "<cmd>Lspsaga rename<CR>", { silent = true, desc = 'Rename' })

vim.keymap.set('n', '<leader>ca', "<cmd>Lspsaga code_action<CR>", { silent = true, desc = '[C]ode [A]ction' })

vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, { silent = true, desc = '[D]efinition' })
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
  { silent = true, desc = '[D]ocument [S]ymbols' })
vim.keymap.set('n', "gp", "<cmd>Lspsaga peek_definition<CR>", { silent = true, desc = '[G]oto [P]eek' })
-- See `:help K` for why this keymap
vim.keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = '[K] [D]ocumentation' })

-- Save the buffer
vim.keymap.set('n', '<leader>sa', ':wall<CR>', { silent = true, desc = 'Save' })


wk.register({
    w = {
      name = "Workspace",
      a = { vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder" },
      r = { vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder" },
      l = { function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders" },

    },
    f = {
      name = "Find",
      f = { "<cmd>Telescope find_files<CR>", "Find Files" },
      g = { "<cmd>Telescope live_grep<CR>", "Search" },
      h = { "<cmd>Telescope help_tags<CR>", "Help" },
      w = { "<cmd>Telescope grep_string<CR>", "Search Word" },
      r = { "<cmd>Telescope lsp_references<CR>", "References" },
      t = { "<cmd>Telescope lsp_document_symbols<CR>", "Tags" },
      d = { "<cmd>Telescope lsp_document_diagnostics<CR>", "Diagnostics" },
      l = { "<cmd>Telescope lsp_code_actions<CR>", "Code Actions" },
      c = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
      p = { "<cmd>Telescope lsp_workspace_diagnostics<CR>", "Workspace Diagnostics" },
      b = { "<cmd>Telescope buffers<CR>", "Buffers" },
      s = { "<cmd>Telescope lsp_workspace_symbols<CR>", "Workspace Symbols" },
    },
    c = {
      name = "ChatGPT",
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
    }
   
  },
  { prefix = "<leader>" }

)

wk.register({
  z = {
    name = "Fold",
    r = { "<cmd>lua require('ufo').openFoldsExceptKinds()<CR>", "Open Folds" },
    m = { "<cmd>lua require('ufo').closeFoldsWith()<CR>", "Close Folds" },
    R = { "<cmd>lua require('ufo').openAllFolds()<CR>", "Open All Folds" },
    M = { "<cmd>lua require('ufo').closeAllFolds()<CR>", "Close All Folds" },
    p = { "<cmd>lua require('ufo').peekFoldedLinesUnderCursor()<CR>", "Peek Folded Lines" },
  },
  g = {
    name = "Goto",
    d = { "<cmd>Lspsaga goto_definition<CR>", "Goto Definition" },
    p = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek Definition" },
    i = { vim.lsp.buf.implementation, "Goto Implementation" },
    t = { "<cmd>Lspsaga goto<CR>", "Goto Definition" }



  }
})



