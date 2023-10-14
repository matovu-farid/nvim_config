require('commands.algorithm')
require('commands.open')
-- Change the appearance of the completion menu
vim.cmd([[highlight Pmenu guifg=#ffffff ]])
vim.cmd([[highlight PmenuSel guifg=#ffffff ]])
vim.cmd([[highlight PmenuSbar guifg=#ffffff ]])
vim.cmd([[highlight PmenuThumb guifg=#ffffff ]])

-- vim.cmd [[highlight LineNr guibg=NONE]]
-- vim.cmd [[highlight CursorLineNr guibg=NONE]]
-- vim.cmd [[highlight SignColumn guibg=NONE]]
-- vim.cmd [[highlight VertSplit guifg=NONE guibg=NONE]]
--
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

vim.cmd [[
  autocmd VimLeave * mksession! ~/.vim/session.vim
  if argc() == 0 && filereadable("~/.vim/session.vim")
    execute 'source ~/.vim/session.vim'
  endif
]]
-- vim.cmd [[autocmd VimEnter,WinEnter * setlocal fillchars+=vert:\ ]]
vim.cmd.colorscheme 'tokyonight-storm'
