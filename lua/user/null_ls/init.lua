local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.prismaFmt,
        null_ls.builtins.diagnostics.erb_lint,
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.diagnostics.standardrb,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.erb_format
    },
})
