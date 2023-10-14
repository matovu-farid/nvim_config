local luasnip = require 'luasnip'
-- check if there's a text to be expanded or if the cursor is at a snippet's tabstop
_G.expand_or_jump = function()
  if luasnip.expand_or_jumpable() then
    return "<Plug>luasnip-expand-or-jump"
  else
    return "<Tab>"
  end
end
-- set keybinds for both INSERT and VISUAL.
-- set keybinds for both INSERT and VISUAL.
-- add the mappings
local function luasnip_mappings()
  local imap = vim.api.nvim_set_keymap
  local opts = { silent = true, expr = true }

  -- expanding or jumping forward in a snippet
  imap('i', '<Tab>', "v:lua.expand_or_jump()", opts)

  -- jumping backward in a snippet
  imap('i', '<S-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true })


  local smap = vim.api.nvim_set_keymap

  -- jumping forward in a snippet
  smap('s', '<Tab>', "<cmd>lua require'luasnip'.jump(2)<Cr>", { silent = true })

  -- jumping backward in a snippet
  smap('s', '<S-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true })

  -- changing choices in a choiceNode
  smap('s', '<C-E>', "v:lua.choice()", opts)
end

require("luasnip.loaders.from_vscode").lazy_load({
  paths = { "/Users/faridmatovu/.config/nvim/lua/snips/snippets.lua" } })
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
luasnip_mappings()

-- will exclude all javascript snippets


-- local paths = vim.api.nvim_get_runtime_file('snippets/**/*.snippets', true)
-- for _, path in ipairs(paths) do
--   luasnip.snippets = vim.tbl_extend('force', luasnip.snippets, luasnip.loaders.load_file(path))
-- end

