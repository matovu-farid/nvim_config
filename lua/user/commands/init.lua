require('user.commands.algorithm')
require('user.commands.open')
-- Change the appearance of the completion menu

-- vim.cmd [[highlight LineNr guibg=NONE]]
-- vim.cmd [[highlight CursorLineNr guibg=NONE]]
-- vim.cmd [[highlight SignColumn guibg=NONE]]
-- vim.cmd [[highlight VertSplit guifg=NONE guibg=NONE]]

vim.cmd('filetype plugin indent on')
vim.cmd [[
  let g:closetag_filetypes = 'jsx'
  let g:closetag_xhtml_filetypes = 'jsx'
  let g:closetag_regions = {'jsx': 'javascript.jsx'}
  let g:closetag_filenames = '*.jsx,*.js'
]]

vim.api.nvim_create_augroup("PrintToOutput", {
  clear = false
})

vim.cmd.colorscheme 'tokyonight-storm'

vim.api.nvim_create_augroup("user_commands", {
  clear = false
})

local function ensure_dir_for_file()
  -- Get the full path of the current file
  local file_path = vim.fn.expand('%:p')
  -- Extract the directory part of the path
  local dir_path = vim.fn.fnamemodify(file_path, ':h')
  -- Check if the directory exists, if not, create it
  if vim.fn.isdirectory(dir_path) == 0 then
    vim.fn.mkdir(dir_path, 'p')
    print("Created directory: " .. dir_path)
  end
end

-- Use Vim's autocommands to hook into the BufWritePre event
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*", -- This applies to all files
    callback = ensure_dir_for_file,
})

local function ensure_dir_for_file()
  -- Get the full path of the current file
  local file_path = vim.fn.expand('%:p')
  -- Extract the directory part of the path
  local dir_path = vim.fn.fnamemodify(file_path, ':h')
  -- Check if the directory exists, if not, create it
  if vim.fn.isdirectory(dir_path) == 0 then
    vim.fn.mkdir(dir_path, 'p')
    print("Created directory: " .. dir_path)
  end
end

-- Use Vim's autocommands to hook into the BufWritePre event
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*", -- This applies to all files
    callback = ensure_dir_for_file,
})

