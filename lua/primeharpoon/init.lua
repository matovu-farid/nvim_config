
local map = vim.api.nvim_set_keymap
local hp = require("harpoon")


-- Set up some basic key mappings
-- Marks the current file in Harpoon
map('n', '<Leader>ha', ':lua require("harpoon.mark").add_file()<CR>', {noremap = true, silent = true})

-- Navigates to the next file in Harpoon
map('n', '<Leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', {noremap = true, silent = true})

-- Navigates to the previous file in Harpoon
map('n', '<Leader>hp', ':lua require("harpoon.ui").nav_prev()<CR>', {noremap = true, silent = true})

-- Opens the Harpoon menu
map('n', '<Leader>hm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', {noremap = true, silent = true})

-- Sets up Harpoon terminal
require('harpoon.term').gotoTerminal(1)

require("telescope").load_extension('harpoon')
