
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  -- remap Escape in to jj
  vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })


  -- rempmap j and k to navigate through completion menu
  vim.keymap.set('i', 'C-j', 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true })
  vim.keymap.set('i', 'C-k', 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true })

  -- Install CtrlSF plugin with the 'lazy' package manager

  -- CtrlSF key mappings


  vim.keymap.set('n', '<Leader>ff', '<Plug>CtrlSFPrompt', {})
  vim.keymap.set('v', '<Leader>ff', '<Plug>CtrlSFVwordPath', {})
  vim.keymap.set('v', '<Leader>F', '<Plug>CtrlSFVwordExec', {})
  vim.keymap.set('n', '<Leader>fn', '<Plug>CtrlSFCwordPath', {})
  vim.keymap.set('n', '<Leader>fp', '<Plug>CtrlSFPwordPath', {})
  vim.keymap.set('n', '<Leader>fo', ':CtrlSFOpen<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<Leader>ft', ':CtrlSFToggle<CR>', { noremap = true, silent = true })
  -- vim.keymap.set('i', '<Leader>ft', '<Esc>:CtrlSFToggle<CR>', { noremap = true, silent = true })





  -- CtrlSF configuration
  -- create a shortcut to :ToggleTerm
  nmap('<leader>t', require('toggleterm').toggle, 'Toggle terminal')

  -- add shortcut to toggle neo tree
  nmap('<leader>b', ":Neotree toggle filesystem right<CR>", 'Toggle NeoTree')


  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end
return on_attach       
