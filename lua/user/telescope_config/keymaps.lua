-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>oe', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', ':Telescope current_buffer_fuzzy_find<CR>',
  { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader><space>', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>st', builtin.lsp_document_symbols, { desc = '[S]earch [T]ags' })
vim.keymap.set('n', '<leader>sr', builtin.lsp_references, { desc = '[S]earch [R]eferences' })
vim.keymap.set('n', '<leader>ss', builtin.lsp_dynamic_workspace_symbols,
  { desc = '[S]earch [S]ymbols in workspace' })
vim.keymap.set('n', '<leader>en', ':Telescope find_files cwd=~/.config/nvim/lua/user<CR>',
  { desc = '[E]dit neovim' })
vim.keymap.set('n', '<leader>sn', ':Telescope live_grep cwd=~/.config/nvim/lua/user<CR>',
  { desc = '[E]dit neovim' })


-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
  "n",
  "<space>sb",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)

function _G.import_based_on_word()
  local word = vim.fn.expand("<cword>")
  if word ~= "" then
    builtin.find_files({
      search_dirs = { vim.fn.getcwd() },
      prompt_title = 'Import based on word: ' .. word,
      search = word,
      file_ignore_patterns = { "node_modules" }
    })
  else
    print("No word under cursor")
  end
end

vim.api.nvim_set_keymap('n', '<leader>i', ':lua import_based_on_word()<CR>', { noremap = true, silent = true })
