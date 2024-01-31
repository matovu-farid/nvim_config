local setup = require("user.telescope_config.setup")
pcall(require('telescope').load_extension, 'fzf')
require("telescope").load_extension "file_browser"

