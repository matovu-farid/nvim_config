local lspconfig = require('lspconfig')

lspconfig.dartls.setup {
  cmd = { "dart",
    "/usr/local/Caskroom/flutter/3.3.10/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
      filetypes = { "dart" },
    root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
    on_attach = function(client, bufnr)
    -- Add key mapping for GoToDefinition
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    -- Map 'gd' to GoToDefinition
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- Map 'gr' to GoToReferences
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Map 'K' to Hover
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- Map '<C-k>' to SignatureHelp
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- Map '<leader>rn' to Rename
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  end
}

