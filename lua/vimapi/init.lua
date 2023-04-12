
vim.api.nvim_set_hl(0,"Normal",{bg="none"})
vim.api.nvim_set_hl(0,"NormalFloat",{bg="none"})
-- Remap 'jj' to Escape in Insert mode
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})
