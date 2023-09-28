local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.





  -- CtrlSF configuration


  -- add shortcut to toggle neo tree
  -- vim.keymap.set('n','<leader>b', ":Neotree float toggle", 'Toggle NeoTree')
  vim.keymap.set('n',"[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", {silent = true, desc = 'diagnostic jump prev'})
  vim.keymap.set('n',"]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", {silent = true, desc = 'diagnostic jump next'})

  -- Diagnostic jump with filters such as only jumping to an error
  vim.keymap.set("n", "[E", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true, desc = 'diagnostic jump prev' })
  vim.keymap.set("n", "]E", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true, desc = 'diagnostic jump next' })
  vim.keymap.set('n','<leader>rn', "<cmd>Lspsaga rename<CR>", { silent = true, desc = 'Rename' })

  vim.keymap.set('n', '<leader>ca', "<cmd>Lspsaga code_action<CR>", { silent = true, desc = '[C]ode [A]ction' })
  vim.keymap.set('n','gd', "<cmd>Lspsaga goto_definition<CR>", { silent = true, desc = '[G]oto [D]efinition' })
  vim.keymap.set('n','gT', "<cmd>Lspsaga peek_type_definition<CR>" , { silent = true, desc = '[G]oto [T]ype' })
  vim.keymap.set('n','gr', "<cmd>Lspsaga rename ++project<CR>",  { silent = true, desc = '[G]oto [R]eferences' })
  vim.keymap.set('n','gI', vim.lsp.buf.implementation, { silent = true, desc = '[G]oto [I]mplementation' })
  vim.keymap.set('n','<leader>D', vim.lsp.buf.type_definition, { silent = true, desc = '[D]efinition' })
  vim.keymap.set('n','<leader>ds', require('telescope.builtin').lsp_document_symbols, { silent = true, desc = '[D]ocument [S]ymbols' })
  vim.keymap.set('n','<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { silent = true, desc = '[W]orkspace [S]ymbols' })
  vim.keymap.set('n',"gp", "<cmd>Lspsaga peek_definition<CR>", { silent = true, desc = '[G]oto [P]eek' })
  -- See `:help K` for why this keymap
  vim.keymap.set('n','K', "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = '[K] [D]ocumentation' })
  vim.keymap.set('n','<Tab>', vim.lsp.buf.signature_help, { silent = true, desc = '[S]ignature [H]elp' })

  -- Lesser used LSP functionality
  vim.keymap.set('n','gD', vim.lsp.buf.declaration, { silent = true, desc = '[G]oto [D]eclaration' })
  vim.keymap.set('n','<leader>wa', vim.lsp.buf.add_workspace_folder, { silent = true, desc = '[W]orkspace [A]dd Folder'})
  vim.keymap.set('n','<leader>wr', vim.lsp.buf.remove_workspace_folder, { silent = true, desc = '[W]orkspace [R]emove Folder'})
  vim.keymap.set('n','<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { silent = true, desc = '[W]orkspace [L]ist Folders'})

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end
return on_attach
