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
  -- remap Escape in to jk
  vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })

  local keymap = vim.keymap.set


  -- Install CtrlSF plugin with the 'lazy' package manager

  -- CtrlSF key mappings


  vim.keymap.set('n', '<Leader>sf', '<Plug>CtrlSFPrompt', {})
  vim.keymap.set('v', '<Leader>sf', '<Plug>CtrlSFVwordPath', {})
  vim.keymap.set('v', '<Leader>F', '<Plug>CtrlSFVwordExec', {})
  vim.keymap.set('n', '<Leader>sn', '<Plug>CtrlSFCwordPath', {})
  vim.keymap.set('n', '<Leader>sp', '<Plug>CtrlSFPwordPath', {})
  vim.keymap.set('n', '<Leader>so', ':CtrlSFOpen<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<Leader>st', ':CtrlSFToggle<CR>', { noremap = true, silent = true })
  -- vim.keymap.set('i', '<Leader>ft', '<Esc>:CtrlSFToggle<CR>', { noremap = true, silent = true })





  -- CtrlSF configuration
  -- create a shortcut to :ToggleTerm
  nmap('<leader>t', "<cmd>Lspsaga term_toggle<CR>", 'Toggle terminal')

  -- add shortcut to toggle neo tree
  nmap('<leader>b', ":Neotree toggle filesystem right<CR>", 'Toggle NeoTree')
  nmap("[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "diagnostic jump prev")
  nmap("]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", "diagnostic jump next")

  -- Diagnostic jump with filters such as only jumping to an error
  keymap("n", "[E", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end)
  keymap("n", "]E", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end)
  nmap('<leader>rn', "<cmd>Lspsaga rename<CR>", '[R]e[n]ame')
  nmap('<leader>ca', "<cmd>Lspsaga code_action<CR>", '[C]ode [A]ction')

  nmap('gd', "<cmd>Lspsaga goto_definition<CR>", '[G]oto [D]efinition')
  nmap('gt', "<cmd>Lspsaga peek_type_definition<CR>", '[G]oto [T]ype')
  nmap('gr', "<cmd>Lspsaga rename ++project<CR>", '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap("gp", "<cmd>Lspsaga peek_definition<CR>", "Peek definition")
  -- See `:help K` for why this keymap
  nmap('K', "<cmd>Lspsaga hover_doc<CR>", 'Hover Documentation')
  nmap('<Tab>', vim.lsp.buf.signature_help, 'Signature Documentation')

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
