local lspconfig = require('lspconfig')

lspconfig.dartls.setup {
  cmd = { "dart",
    "/usr/local/Caskroom/flutter/3.3.10/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
      filetypes = { "dart" },
    root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
}

