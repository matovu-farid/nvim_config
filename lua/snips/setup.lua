local luasnip = require 'luasnip'
-- check if there's a text to be expanded or if the cursor is at a snippet's tabstop

-- set keybinds for both INSERT and VISUAL.
-- set keybinds for both INSERT and VISUAL.
-- add the mappings
local function luasnip_mappings()
  local imap = vim.api.nvim_set_keymap
  local opts = { silent = true, expr = true }

  -- expanding or jumping forward in a snippet

  
  
  -- jumping backward in a snippet
  imap('i', '<S-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true })
  vim.keymap.set({'i','n'}, '<C-k>', function()
    if luasnip.expand_or_jumpable() then
      return "<Plug>luasnip-expand-or-jump"
    end
  end, { silent = true, expr = true, desc = "Expand snippet" })
  vim.keymap.set({'i','n'}, '<C-j>', function()
    if luasnip.jumpable(-1) then
      return luasnip.jump(-1)
    end
  end, { silent = true, expr = true, desc = "Jump back" })
  vim.keymap.set({'i','n'}, '<C-l>', function()
    if luasnip.choice_active() then
      print("choice active")
      return "<cmd>lua require'luasnip'.change_choice(1)<Cr>"
    end
  end, { silent = true, expr = true, desc = "Jump forward" })

end

luasnip.filetype_extend("javascript", { "javascript" })
require("luasnip.loaders.from_vscode").lazy_load({
  paths = { "/Users/faridmatovu/.config/nvim/lua/snips/snippets.lua",
    "/Users/faridmatovu/.config/nvim/lua/snips/snips.json" }
})

require("luasnip.loaders.from_vscode").lazy_load()
luasnip_mappings()

-- will exclude all javascript snippets


-- local paths = vim.api.nvim_get_runtime_file('snippets/**/*.snippets', true)
-- for _, path in ipairs(paths) do
--   luasnip.snippets = vim.tbl_extend('force', luasnip.snippets, luasnip.loaders.load_file(path))
-- end
