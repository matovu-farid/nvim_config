-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local telescope = require('telescope')
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw',builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })


function _G.import_based_on_word()
  local word = vim.fn.expand("<cword>")
  if word ~= "" then
    builtin.find_files({
      search_dirs = {vim.fn.getcwd()},
      prompt_title = 'Import based on word: ' .. word,
      search = word,
      file_ignore_patterns = {"node_modules"}
    })
  else
    print("No word under cursor")
  end
end
vim.api.nvim_set_keymap('n', '<leader>i', ':lua import_based_on_word()<CR>', {noremap = true, silent = true})

