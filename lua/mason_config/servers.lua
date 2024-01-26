local servers = {
  clangd = {},
  ruby_ls = {},
  -- rubocop = {cmd={ "rubocop", "--lsp" }, filetypes={"ruby", "eruby"}},
  solargraph = {},
  vimls = {},
  -- sqls = {},
  -- gopls = {},
  pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  bashls = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },

}

return servers
