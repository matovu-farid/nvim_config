local telescope = require('telescope')
telescope.setup {
  defaults = {
    prompt_prefix = '🔍 ',
    selection_caret = '👉 ',
    file_ignore_patterns = { 'node_modules', '.git' },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      theme = 'dropdown',
      previewer = false,
    },
    buffers = {
      theme = 'dropdown',
      previewer = false,
    },
    oldfiles = {
      theme = 'dropdown',
      previewer = false,
    },
  },
}
