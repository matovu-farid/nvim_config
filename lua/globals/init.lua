--Autocompletion settings
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
vim.g.neo_tree_layout = 'nerd'

vim.g.fzf_command_prefix = 'Rg'
vim.g.fzf_rg_option = '--hidden --smart-case'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- init.lua
vim.g.lsc_server_commands = { dart = 'dart_language_server' }
vim.g.lsc_auto_map = { defaults = true, GoToDefinition = 'gd' }
-- vim.g.fugitive_diff_split_cmd = 'vertical diffsplit'
vim.g.nvim_tree_side = 'right'

