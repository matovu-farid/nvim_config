-- Change the appearance of the completion menu
vim.cmd([[highlight Pmenu guifg=#ffffff guibg=#4b5263]])
vim.cmd([[highlight PmenuSel guifg=#ffffff guibg=#61afef]])
vim.cmd([[highlight PmenuSbar guifg=#ffffff guibg=#3e4451]])
vim.cmd([[highlight PmenuThumb guifg=#ffffff guibg=#61afef]])

vim.cmd('filetype plugin indent on')
vim.cmd [[
  let g:closetag_filetypes = 'jsx'
  let g:closetag_xhtml_filetypes = 'jsx'
  let g:closetag_regions = {'jsx': 'javascript.jsx'}
  let g:closetag_filenames = '*.jsx,*.js'
]]
