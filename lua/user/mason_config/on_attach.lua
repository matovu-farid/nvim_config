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
  
end
return on_attach
