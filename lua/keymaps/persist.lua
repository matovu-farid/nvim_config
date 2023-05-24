vim.api.nvim_set_keymap('n', '<leader>Ss', ":lua require('persistence').save()<CR>", {noremap = true, silent = true, desc='Save session'});
vim.api.nvim_set_keymap('n', '<leader>Sl', ":lua require('persistence').load({last = true})<CR>", {noremap = true, silent = true, desc='Load last seession'});

