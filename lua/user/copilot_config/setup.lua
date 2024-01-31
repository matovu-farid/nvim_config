require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<C-y>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<C-y>",
      accept_word = false,
      accept_line = false,
      dismiss = "<Esc>",

      next = "<C-]>",
      prev = "<C-[>",

    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},
})
-- function get_api_key()
--   local handle = io.popen("ansible-vault view --vault-pass-file=~/.password.txt ~/.chatgpt_key.txt")
--   local result = handle:read("*a")
--   print(result)
--   handle:close()
--   return result
-- end
--
require("chatgpt").setup({
  api_key_cmd = "bash /usr/local/bin/get_openai_key",
})
